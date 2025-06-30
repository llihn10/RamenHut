<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Products" %>
<%@page import="dal.RamenDAO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">

        <style>
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

            .similar-title {
                text-align: left;
                font-size: 40px;
                margin-top: 20px;
                font-weight: bold;
                color: #faf4f5;
                margin-left: 220px;
                margin-top: 50px;
                margin-bottom: 50px;
            }

            .similar-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
                margin-top: 20px;
                margin-bottom: 100px;
            }

            .similar-item {
                width: 200px;
                padding: 10px 10px;
                text-align: center;
                background-color: rgba(255, 255, 255, 0.7);
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            .similar-image {
                width: 100%;
            }

            .similar-name {
                font-size: 18px;
                margin: 10px 0;
                color: #5b3b27;
            }

            .similar-price {
                font-size: 16px;
                color: #333;

            }

            .similar-button {
                margin-top: 10px;
                background-color: #e67e22;
                color: white;
                border: none;
                padding: 8px 12px;
                cursor: pointer;
                transition: 0.3s;
                margin-bottom: 10px;
            }

            .similar-button:hover {
                background-color: #cc5500;
            }


        </style>
    </head>
    <body class="detail-page">
        <!-- Header / Navbar -->
        <header>
            <div class="navbar section-content">
                <a href="home" class="nav-logo">
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

        <div class="detail-container">
            <div class="detail-hero">
                <img src="img/product-hero.png" alt="" class="detail-image">
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-img">
                <img src="${detail.imageUrl}" alt="Ramen">
            </div>
            <div class="item-info">
                <h2 class="name">${detail.name}</h2>
                <p class="des">${detail.description}</p>
                <br>
                <p class="ingre">Thành phần: ${detail.ingredient}</p>
                <br>
                <p class="price">
                    <fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" pattern="#,###" />₫
                </p>
                <div class="buttons">
                    <button class="btn-back" onclick="goBack()">🡐 Quay lại</button>
                    <button type="button" class="btn-cart" onclick="addToCart(${detail.product_id})">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>

        <script>
            var isLoggedIn = ${sessionScope.acc != null ? "true" : "false"};

            function goBack() {
                window.history.back();
            }

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

        <hr class="detail-separator">

        <h2 class="similar-title">Sản phẩm tương tự</h2>
        <div class="similar-container">
            <c:forEach var="p" items="${similarProducts}">
                <div class="similar-item">
                    <img src="${p.imageUrl}" alt="Ramen" class="similar-image">
                    <h3 class="similar-name">${p.name}</h3>
                    <p class="similar-price">
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" pattern="#,###" />₫
                    </p>
                    <button class="similar-button" onclick="window.location.href = 'detail?pid=${p.product_id}'">Chi tiết</button>
                </div>
            </c:forEach>
        </div>


        <!-- Contact section -->
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

        <!-- Footer section -->
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
