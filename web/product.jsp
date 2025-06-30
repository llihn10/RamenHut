<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Products" %>
<%@page import="dal.RamenDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    RamenDAO ramenDAO = new RamenDAO();
    int pageSize = 7;
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);

    int totalProducts = ramenDAO.getTotalProductCount();

    int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

    List<Products> productList = ramenDAO.getProductsByPage(currentPage, pageSize);

    DecimalFormatSymbols symbols = new DecimalFormatSymbols();
    symbols.setGroupingSeparator('.');
    DecimalFormat df = new DecimalFormat("#,###", symbols);
%>

<%
    List<Products> list = (List<Products>) request.getAttribute("list");
    String selectedCategory = (String) request.getAttribute("selectedCategory");

    if (list == null) {
        pageSize = 7;
        pageParam = request.getParameter("page");
        currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);

        totalProducts = ramenDAO.getTotalProductCount();
        totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        list = ramenDAO.getProductsByPage(currentPage, pageSize);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
    }

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sản phẩm - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">
        <style>
            .pagination {
                text-align: right;
                margin-top: 20px;
            }

            .pagination a {
                display: inline-block;
                padding: 10px 15px;
                margin: 0 0 0 5px;
                text-decoration: none;
                font-weight: 600;
                color: #333;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #a49898;
                color: white;
                border-color: #f9a825;
            }

            .pagination a.active {
                background-color: #d32f2f;
                color: white;
                font-weight: bold;
                border-color: #d32f2f;
            }

            .pagination a:first-child,
            .pagination a:last-child {
                font-weight: 600;
            }

            .buttons {
                display: flex;
            }
            /* Overlay */
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 999;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .overlay.show {
                display: block;
                opacity: 1;
            }

            /* Popup styling */
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9);
                background-color: white;
                border-radius: 10px;
                padding: 20px 25px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                z-index: 1000;
                opacity: 0;
                transition: all 0.3s ease;
                min-width: 300px;
            }

            .popup.show {
                display: block;
                opacity: 1;
                transform: translate(-50%, -50%) scale(1);
            }

            .popup-content {
                max-height: 8vh;
                display: flex;
                align-items: center;
                gap: 15px;
                
            }

            .success-icon {
                width: 40px;
                height: 40px;
                background-color: green;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 20px;
            }

            .success-message {
                font-size: 16px;
                font-weight: 500;
                color: #333;
            }

            .success-details {
                margin-top: 5px;
                font-size: 14px;
                color: #666;
            }
            
            .fi {
                color: white;
            }

            .cart-icon {
                position: relative;
                display: inline-block;
                text-decoration: none;
            }

            .cart-icon::after {
                content: attr(data-tooltip);
                position: absolute;
                bottom: 100%;
                left: 50%;
                transform: translateX(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: #fff;
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 14px;
                white-space: nowrap;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.2s, visibility 0.2s;
            }

            .cart-icon:hover::after {
                opacity: 1;
                visibility: visible;
            }
        </style>
    </head>
    <body class="product-page">
        <header>
            <div class="navbar section-content">
                <a href="home" class="nav-logo">
                    <!-- <h2 class="logo-text">🍜Ramen Hut</h2> -->
                    <img src="img/logo-header.png" alt="logo" class="header-logo">
                </a>
                <ul class="nav-menu">
                    <li class="nav-item"><a href="home" class="nav-link">Trang chủ</a></li>

                    <li class="nav-item"><a href="menu.jsp" class="nav-link">Menu</a></li>
                    <li class="nav-item"><a href="product.jsp?cid=" class="nav-link">Sản phẩm</a></li>

                    <li class="nav-item"><a href="#contact" class="nav-link">Liên hệ</a></li>
                </ul>

                <div class="icons">
                    <form action="search" method="GET" onsubmit="return validateSearchInput()">
                        <div class="search-box">
                            <input value="${txtS}" type="text" id="searchInput" name="txt" placeholder="Tìm kiếm...">
                            <button type="submit" class="search-icon">
                                <i class="fi fi-rr-search"></i>
                            </button>
                        </div>
                    </form>

                    <c:if test="${sessionScope.acc == null}">
                        <a href="login.jsp" class="cart-icon" data-tooltip="Giỏ hàng của tôi">
                            <i class="fi fi-rr-shopping-cart"></i>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.acc != null}">
                        <a href="cart.jsp" class="cart-icon" data-tooltip="Giỏ hàng của tôi">
                            <i class="fi fi-rr-shopping-cart"></i>
                        </a>
                    </c:if>

                    <div class="account-container">
                        <i class="fi account-btn fi-rr-user"></i>
                        <div class="account-content">
                            <c:if test="${sessionScope.acc == null}">
                                <a href="signup.jsp">Đăng ký</a>
                                <a href="login">Đăng nhập</a>
                            </c:if>

                            <c:if test="${sessionScope.acc.isAdmin == 1}">
                                <a href="revenue">Thống kê</a>
                            </c:if>
                            <c:if test="${sessionScope.acc.isAdmin == 1}">
                                <a href="manage-account">Quản lý tài khoản</a>
                            </c:if>
                            <c:if test="${sessionScope.acc.isStaff == 1}">
                                <a href="manage-product">Quản lý sản phẩm</a>
                            </c:if>
                            <c:if test="${sessionScope.acc.isStaff == 1}">
                                <a href="manageOrder">Quản lý đơn hàng</a><hr>
                            </c:if>

                            <c:if test="${sessionScope.acc != null}"> 
                                <a href="profile">Profile</a>
                                <a href="logout">Đăng xuất</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="product-container">
            <div class="product-hero">
                <img src="img/product-hero.png" alt="">
            </div>
        </div>

        <div class="product-content">
            <div class="product-sidebar">

                <form action="category" method="GET" id="filterForm">

                    <div class="filter-group">
                        <label><h2>Bộ lọc tìm kiếm</h2></label>
                        <label><input type="radio" name="cid" value="" 
                                      onchange="document.getElementById('filterForm').submit();" 
                                      ${empty selectedCategory ? 'checked' : ''}> Tất cả sản phẩm</label>

                        <label><input type="radio" name="cid" value="Miso" 
                                      onchange="document.getElementById('filterForm').submit();" 
                                      ${selectedCategory eq 'Miso' ? 'checked' : ''}> Nước dùng Miso</label>

                        <label><input type="radio" name="cid" value="Tonkotsu" 
                                      onchange="document.getElementById('filterForm').submit();" 
                                      ${selectedCategory eq 'Tonkotsu' ? 'checked' : ''}> Nước dùng Tonkotsu</label>

                        <label><input type="radio" name="cid" value="Shoyu" 
                                      onchange="document.getElementById('filterForm').submit();" 
                                      ${selectedCategory eq 'Shoyu' ? 'checked' : ''}> Nước dùng Shoyu</label>

                        <label><input type="radio" name="cid" value="Special" 
                                      onchange="document.getElementById('filterForm').submit();" 
                                      ${selectedCategory eq 'Special' ? 'checked' : ''}> Đặc biệt</label>
                    </div>
                </form>
            </div>
            <div class="product-item">
                <% if (list != null) { %>
                <% for (Products product : list) { %>
                <div class="product-card">
                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" class="product-image">
                    <div class="product-info">
                        <div class="pro-text">
                            <h2><%= product.getName() %></h2>
                            <p class="des"><%= product.getDescription() %></p>
                            <br>
                            <p class="ingre">Thành phần: <%= product.getIngredient() %></p>
                            <br>
                            <p class="price"><%= df.format(product.getPrice()) %>₫</p>
                            <div class="buttons">
                                <a href="detail?pid=<%= product.getProduct_id() %>">
                                    <button class="btn-detail">Chi tiết</button>
                                </a>
                                <button type="button" class="btn-cart" onclick="addToCart(<%= product.getProduct_id() %>)">Thêm vào giỏ hàng</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <p>🔴 Không có sản phẩm nào phù hợp.</p>
                <% } %>

                <c:set var="totalPages" value="${totalPages}" />
                <c:set var="totalProducts" value="${totalProducts}" />
                <c:set var="currentPage" value="${currentPage}" />
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="category?cid=${selectedCategory}&page=${currentPage - 1}">Trang trước</a>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="category?cid=${selectedCategory}&page=${i}" 
                               class="${i == currentPage ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="category?cid=${selectedCategory}&page=${currentPage + 1}">Trang sau</a>
                        </c:if>
                    </div>
                </c:if>

            </div>
        </div>

        <script>
            var isLoggedIn = ${sessionScope.acc != null ? "true" : "false"};
            
            function addToCart(productId) {
                if (!isLoggedIn) {
                    if (confirm("Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng. Chuyển đến trang đăng nhập?")) {
                        window.location.href = "login.jsp";
                    }
                    return;
                }
                
                fetch("cart", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "action=add&id=" + productId
                })
                        .then(response => response.text())
                        .then(data => {
                            console.log("Sản phẩm đã được thêm vào giỏ hàng."); // Kiểm tra xem yêu cầu có thành công không

                            // Hiển thị overlay và popup
                            var overlay = document.getElementById("overlay");
                            var popup = document.getElementById("successPopup");

                            overlay.style.display = "block";
                            popup.style.display = "block";

                            setTimeout(() => {
                                overlay.classList.add("show");
                                popup.classList.add("show");
                            }, 50); // Delay nhẹ để CSS transition có hiệu ứng

                            // Ẩn popup sau 5 giây
                            setTimeout(() => {
                                popup.classList.remove("show");
                                overlay.classList.remove("show");

                                setTimeout(() => {
                                    overlay.style.display = "none";
                                    popup.style.display = "none";
                                }, 300); // Đợi hiệu ứng biến mất hoàn toàn
                            }, 1800);
                        })
                        .catch(error => console.error("Lỗi khi thêm vào giỏ hàng:", error));
            }
        </script>

        <div id="contact-placeholder">
            <script>
                fetch("contact.html")
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById("contact-placeholder").innerHTML = data;
                        })
                        .catch(error => console.error("Error loading about:", error));
            </script>
        </div>

        <div id="footer-placeholder">
            <script>
                fetch("footer.html")
                        .then(response => response.text())
                        .then(data => {
                            document.getElementById("footer-placeholder").innerHTML = data;
                        })
                        .catch(error => console.error("Error loading about:", error));
            </script>
        </div>
        
        <!-- Overlay -->
        <div id="overlay" class="overlay"></div>

        <!-- Success Popup -->
        <div id="successPopup" class="popup">
            <div class="popup-content">
                <div class="success-icon">✓</div>
                <div>
                    <div class="success-message">Đã thêm vào giỏ hàng thành công!</div>
                    <div class="success-details">Sản phẩm đã được thêm vào giỏ hàng của bạn.</div>
                </div>
            </div>
        </div>
        
        <script>
            function validateSearchInput() {
                var input = document.getElementById('searchInput').value.trim();
                if (input === "") {
                    return false; // Ngăn biểu mẫu được gửi đi
                }
                return true; // Cho phép gửi biểu mẫu
            }
        </script>
    </body>
</html>
