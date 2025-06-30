<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu - Ramen Hut</title>
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

        <%
    System.out.println("Session ID: " + session.getId());
    System.out.println("Session acc: " + session.getAttribute("acc"));
        %>


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

        <main>
            <div class="menu-content">
                <h1 class="menu-title quicksand">✿ Menu nhà Ramen Hut ✿</h1>
                <div class="menu-image">
                    <img src="img/menu.png" alt="Menu" class="menu-img" id="menu-thumbnail">
                </div>
            </div>
        </main>

        <!-- Pop-up menu -->
        <div id="menu-popup" class="popup-container">
            <div class="popup-content">
                <img src="img/menu.png" alt="Full Menu" class="popup-img" id="popup-image">
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const menuThumbnail = document.getElementById("menu-thumbnail");
                const menuPopup = document.getElementById("menu-popup");
                const popupImage = document.getElementById("popup-image");

                if (!menuThumbnail || !menuPopup || !popupImage) {
                    console.error("Lỗi: Không tìm thấy phần tử cần thiết.");
                    return;
                }

                console.log("Script đã chạy!");

                // Khi click vào ảnh menu, hiển thị pop-up
                menuThumbnail.addEventListener("click", function () {
                    console.log("Menu được click!");
                    menuPopup.classList.add("active");
                });

                // Khi click ra ngoài ảnh, ẩn pop-up
                menuPopup.addEventListener("click", function (event) {
                    if (event.target !== popupImage) {
                        console.log("Click ra ngoài, đóng pop-up.");
                        menuPopup.classList.remove("active");
                    }
                });
            });
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