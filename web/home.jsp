<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<%--<jsp:include page="home" />--%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ramen Hut</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
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

    </head>

    <body>
        <!-- Header / Navbar -->
        <header>
            <div class="navbar section-content">
                <a href="home" class="nav-logo">
                    <!-- <h2 class="logo-text">🍜Ramen Hut</h2> -->
                    <img src="img/logo-header.png" alt="logo" class="header-logo">
                </a>
                <ul class="nav-menu">
                    <li class="nav-item"><a href="home" class="nav-link">Trang chủ</a></li>

                    <li class="nav-item"><a href="menu" class="nav-link">Menu</a></li>
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
            <!-- Hero section -->
            <section class="hero-section">
                <div class="section-content">
                    <div class="hero-details">
                        <h2 class="title">Thiên đường Ramen</h2>
                        <h3 class="subtitle quicksand">Bạn có nghe thấy tiếng ramen gọi tên mình?</h3>
                        <p class="description">Sợi mì mềm dai, nước dùng đậm đà, hương vị<br>như một cái ôm ấm áp giữa ngày
                            đông se lạnh.</p>

                        <div class="buttons">
                            <a href="product.jsp" class="button order-now">Order</a>
                            <a href="#contact" class="button contact-us">Liên Hệ</a>
                        </div>
                    </div>
                    <div class="hero-image-wrapper">
                        <img src="img/hero2.png" alt="" class="Hero">
                    </div>
                </div>
            </section>

            <!-- About section -->
            <section id="about" class="about-section">
                <div class="section-content">
                    <div class="about-image-wrapper">
                        <img src="img/about-image.png" alt="Ramen Hut" class="about-image">
                    </div>
                    <div class="about-detail">
                        <h2 class="section-title quicksand">Về Ramen Hut</h2>
                        <p class="text">Tại <strong>Ramen Hut</strong>, mỗi bát ramen không chỉ là món ăn mà còn là câu
                            chuyện của truyền thống và đam mê. Chúng tôi chắt lọc tinh hoa ẩm thực Nhật Bản qua nước dùng
                            hầm kỹ, sợi mì thủ công và nguyên liệu hảo hạng, mang đến hương vị trọn vẹn trong từng ngụm.

                            Từ vị béo ngậy của tonkotsu, sự đậm đà của miso, đến hương thanh nhẹ của shoyu, mỗi bát ramen là
                            một cái ôm ấm áp cho tâm hồn. <strong>Hãy đến và cảm nhận ngay!</strong></p>
                    </div>
                </div>
            </section>

            <!-- All product section -->
            <div class="home-product">
                <h2 class="section-title quicksand hp-title">Sản phẩm của Ramen Hut</h2>

                <div class="product-container">
                    <!-- Duyệt danh sách sản phẩm bằng JSTL -->
                    <c:forEach var="product" items="${list}" varStatus="status">
                        <c:set var="isHidden" value="${status.index >= 6 ? 'hidden' : ''}" />
                        <div class="product ${isHidden}">
                            <img src="${product.imageUrl}" alt="${product.name}" width="100">
                            <h3>${product.name}</h3>
                            <p>Giá: <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" pattern="#,###"/>₫</p>
                            <a href="detail?pid=${product.product_id}">
                                <input class="product-detail" type="submit" value="Chi tiết" />
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <!-- Nút Xem Thêm -->
                <button id="loadMore" class="btn-load">Xem thêm</button>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        let hiddenProducts = document.querySelectorAll(".product.hidden");
                        let loadMoreBtn = document.getElementById("loadMore");
                        let itemsPerClick = 6; // Số sản phẩm hiển thị thêm mỗi lần

                        loadMoreBtn.addEventListener("click", function () {
                            let count = 0;
                            for (let i = 0; i < hiddenProducts.length; i++) {
                                if (count >= itemsPerClick)
                                    break;
                                hiddenProducts[i].classList.remove("hidden");
                                count++;
                            }
                            hiddenProducts = document.querySelectorAll(".product.hidden");

                            // Ẩn nút "Xem thêm" nếu không còn sản phẩm để hiển thị
                            if (hiddenProducts.length === 0) {
                                loadMoreBtn.style.display = "none";
                            }
                        });
                    });
                </script>
            </div>

            <!-- Best-seller section -->
            <section class="best-seller-section">
                <h2 class="section-title quicksand bs-title">Best Seller</h2>
                <div class="best-seller">
                    <div class="container swiper">
                        <div class="slider-wrapper">
                            <div class="best-seller-list swiper-wrapper">
                                <div class="best-seller-item swiper-slide">
                                    <img src="img/tonkotsu.jpg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Tonkotsu</h2>
                                    <p class="bs-detail">Tonkotsu béo ngậy, đậm đà.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=10'">Chi tiết</button>
                                </div>

                                <div class="best-seller-item swiper-slide">
                                    <img src="img/sapporo.jpg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Sapporo Miso</h2>
                                    <p class="bs-detail">Đậm đà, chuẩn vị Bắc Nhật.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=1'">Chi tiết</button>
                                </div>

                                <div class="best-seller-item swiper-slide">
                                    <img src="img/shoyu.jpeg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Shoyu</h2>
                                    <p class="bs-detail">Vị nước tương cổ điển.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=4'">Chi tiết</button>
                                </div>

                                <div class="best-seller-item swiper-slide">
                                    <img src="img/tsukemen.jpg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Tsuke-men</h2>
                                    <p class="bs-detail">Mì chấm tonkotsu đậm vị.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=12'">Chi tiết</button>
                                </div>

                                <div class="best-seller-item swiper-slide">
                                    <img src="img/hakodate.jpg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Hakodate</h2>
                                    <p class="bs-detail">Shio ramen thanh nhẹ.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=16'">Chi tiết</button>
                                </div>

                                <div class="best-seller-item swiper-slide">
                                    <img src="img/tantan.jpg" alt="Ramen" class="bs-image">
                                    <h2 class="bs-name">Tantanmen</h2>
                                    <p class="bs-detail">Mì cay sốt mè với nước hầm gà.</p>
                                    <button class="best-seller-button" onclick="window.location.href = 'detail?pid=19'">Chi tiết</button>
                                </div>
                            </div>

                            <div class="swiper-pagination"></div>
                            <div class="swiper-slide-button swiper-button-prev"></div>
                            <div class="swiper-slide-button swiper-button-next"></div>
                        </div>
                    </div>
                </div>

            </section>

            <!-- Latest Ramen section -->
            <section class="latest-section">
                <h2 class="section-title quicksand latest-title">Ramen Đặc biệt tháng 3</h2>
                <div class="latest">
                    <div class="container swiper">
                        <div class="slider-wrapper">
                            <div class="latest-list swiper-wrapper">
                                <div class="latest-item swiper-slide">
                                    <img src="img/onomichi.jpeg" alt="Ramen" class="latest-image">
                                    <h2 class="latest-name">Onomichi</h2>
                                    <p class="latest-detail">Nước dùng vị cá khô đậm đà.</p>
                                    <button class="latest-button" onclick="window.location.href = 'detail?pid=6'">Chi tiết</button>
                                </div>

                                <div class="latest-item swiper-slide">
                                    <img src="img/yakisoba.jpg" alt="Ramen" class="latest-image">
                                    <h2 class="latest-name">Yaki Soba</h2>
                                    <p class="latest-detail">Mì xào sốt đặc biệt.</p>
                                    <button class="latest-button" onclick="window.location.href = 'detail?pid=18'">Chi tiết</button>
                                </div>

                                <div class="latest-item swiper-slide">
                                    <img src="img/yamagata.jpg" alt="Ramen" class="latest-image">
                                    <h2 class="latest-name">Yamagata</h2>
                                    <p class="latest-detail">Mì lạnh với nước hầm bò đậm vị.</p>
                                    <button class="latest-button" onclick="window.location.href = 'detail?pid=21'">Chi tiết</button>
                                </div>

                                <div class="latest-item swiper-slide">
                                    <img src="img/hiyashi-chuka.jpg" alt="Ramen" class="latest-image">
                                    <h2 class="latest-name">Hiyashi Chuka</h2>
                                    <p class="latest-detail">Mì trộn lạnh, chua ngọt.</p>
                                    <button class="latest-button" onclick="window.location.href = 'detail?pid=22'">Chi tiết</button>
                                </div>

                                <div class="latest-item swiper-slide">
                                    <img src="img/susaki.jpg" alt="Ramen" class="latest-image">
                                    <h2 class="latest-name">Susaki</h2>
                                    <p class="latest-detail">Shoyu kết hợp cá ngừ khô.</p>
                                    <button class="latest-button" onclick="window.location.href = 'detail?pid=8'">Chi tiết</button>
                                </div> 

                            </div>

                            <div class="swiper-pagination"></div>
                            <div class="swiper-slide-button swiper-button-prev"></div>
                            <div class="swiper-slide-button swiper-button-next"></div>
                        </div>
                    </div>
                </div>

            </section>

            <!-- Sale section -->
            <section class="sale-section">
                <div class="sale-content">
                    <div class="sale-detail">
                        <h2 class="section-title quicksand sale-title">Ưu đãi</h2>
                        <p class="text">
                            ★ <strong>Lần đầu thử Ramen Hut?</strong> Giảm ngay <strong
                                class="orange"><i>15%</i></strong>!<br>
                            Nhập mã <strong>WELCOME15</strong> khi thanh toán để nhận ưu đãi. Hãy để chúng mình mang đến cho
                            bạn trải nghiệm ramen ngon nhất!
                            <br><br>
                            ★ <strong>Thứ Ba Vui Vẻ - Đồng Giá 99K!</strong><br>
                            Mỗi <strong>thứ Ba hàng tuần</strong>, toàn bộ menu đồng giá <strong
                                class="orange"><i>99K</i></strong>! Hãy cùng hội bạn thân thưởng thức những bát ramen nóng
                            hổi với mức giá siêu hấp dẫn!
                            <br><br>
                            ✿ <strong>Đặt ngay & tận hưởng ưu đãi nào!</strong>
                        </p>
                    </div>
                    <div class="sale-image-wrapper">
                        <img src="img/store1.jpg" alt="Ramen Hut" class="sale-image">
                    </div>
                </div>
            </section>

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

        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
        <script src="script.js"></script>
    </body>

</html>