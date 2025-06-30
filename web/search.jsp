<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tìm kiếm - Ramen Hut</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet'
              href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet'
              href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link rel="stylesheet" href="style.css">

        <style>
            .search-content {
                background: var(--primary-color);
                min-height: 100vh;
                padding-top: 180px;
                padding-bottom: 50px;
                background-color: var(--primary-color);
                border: 2px solid var(--primary-color);
                margin-bottom: 0;
            }

            .search-content .search-title {
                color: #fff;
                margin-left: 120px;
                font-family: "Playwrite IT Moderna", cursive;
                font-optical-sizing: auto;
                font-weight: 400;
                font-style: normal;
                font-size: 3.8rem;
            }

            .search-content .search-container {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 40px;
                max-width: 1200px;
                margin: auto;
                margin-top: 50px;


            }
            .search-content .product {
                padding: 20px;
                border: none;
                border-radius: 8px;
                text-align: center;
                background-color: rgba(255, 255, 255, 0.7);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .search-content .product h3 {
                font-size: 23px;
                color: var(--primary-color);
                margin-top: 16px;
            }

            .search-content .product p {
                font-size: 19px;
                color: black;
                margin-top: 15px;
                font-weight: 500;
            }

            .search-content .product .product-detail {
                margin-top: 20px;
                font-size: 18px;
                padding: 10px 30px;
                color: #030728;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                background: #fff;
                border: 1px solid transparent;
                transition: 0.2s ease;
            }

            .search-content .product .product-detail:hover {
                background: rgba(255, 255, 255, 0.8);
                border: 1px solid transparent;
                color: var(--secondary-color);
            }

            .search-content .search-nf {
                grid-column: 1 / -1; /* Kéo dài toàn bộ hàng */
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .search-content .search-nf .search-nf-text {
                font-size: 30px;
                font-weight: 650;
                color: white;
                margin-top: 100px;
            }

            .search-content .search-nf .search-nf-img {
                width: 550px;
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
    <body>
        <!-- Header -->
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

        <!-- Search -->
        <main>
            <div class="search-content">
                <h1 class="search-title quicksand">✿ Tìm kiếm Ramen dành cho bạn ✿</h1>

                <div class="search-container">
                    <c:choose>
                        <c:when test="${empty list}">
                            <div class="search-nf">
                                <p class="search-nf-text">Không tìm thấy kết quả phù hợp</p>
                                <img src="img/search-not-found.png" alt="alt" class="search-nf-img"/>
                            </div>

                        </c:when>
                        <c:otherwise>
                            <c:forEach var="product" items="${list}">
                                <div class="product">
                                    <img src="${product.imageUrl}" alt="${product.name}" width="100">
                                    <h3>${product.name}</h3>
                                    <p>Giá: <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" pattern="#,###"/>₫</p>
                                    <a href="detail?pid=${product.product_id}">
                                        <input class="product-detail" type="submit" value="Chi tiết" />
                                    </a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>

        <script>
            function validateSearchInput() {
                var input = document.getElementById('searchInput').value.trim();
                if (input === "") {
                    return false; // Ngăn biểu mẫu được gửi đi
                }
                return true; // Cho phép gửi biểu mẫu
            }
        </script>

        <!-- Contact -->
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

        <!-- Footer -->
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

    </body>
</html>
