<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.Cart" %>
<%@ page import="model.CartItems" %>
<fmt:setLocale value="vi_VN"/>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng của tôi - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;

            }

            body {
                background-color: #f9fafb;
                color: #1f2937;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .page-title {
                display: flex;
                align-items: center;
                margin-top: 30px;
                height: 100px;
            }

            .page-title .cart-icon {
                margin-top: -20px;
                margin-right: 10px;
            }

            .pg-title {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
                position: relative;
                z-index: 1000;
            }

            .pg-title {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 20px;
                color: #5b3b27;
            }

            .pg-title h1 {
                font-size: 24px;
                font-weight: bold;
                margin-left: 10px;
            }

            .cart-icon {
                width: 24px;
                height: 24px;
                color: #5b3b27;
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px 0;
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 30px;
            }

            .logo {
                font-size: 24px;
                font-weight: bold;
                color: #111827;
            }

            .nav-links {
                display: flex;
                gap: 20px;
            }

            .nav-links a {
                text-decoration: none;
                color: #4b5563;
                font-weight: 500;
            }

            .nav-links a:hover {
                color: #111827;
            }

            .cart-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                text-align: center;
            }

            .empty-cart {
                font-size: 25px;
                font-weight: 700;
                color: #5b3b27;
            }

            .empty-cart-img {
                width: 350px;
            }

            .cart-items {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                padding: 20px;
                width: 78vw;
            }

            .cart-item {
                display: flex;
                padding: 20px 0;
                border-bottom: 1px solid #e5e7eb;
            }

            .cart-item:last-child {
                border-bottom: none;
            }

            .item-image {
                width: 100px;
                height: 100px;
                border-radius: 6px;
                object-fit: cover;
                margin-right: 20px;
            }

            .item-details {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
            }

            .item-info {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 18px;
            }

            .item-name {
                font-weight: 600;
                font-size: 19px;
            }

            .item-price {
                font-weight: 600;
                color: #111827;
                font-size: 17px;
            }

            .item-description {
                color: #6b7280;
                margin-bottom: 10px;
                font-size: 15px;
                text-align: left;
            }

            .item-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .quantity-selector {
                display: flex;
                align-items: center;
                border: 1px solid #e5e7eb;
                border-radius: 6px;
                overflow: hidden;
            }

            .quantity-btn {
                background-color: #f3f4f6;
                border: none;
                width: 30px;
                height: 30px;
                font-size: 16px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .quantity-input {
                width: 40px;
                height: 30px;
                border: none;
                text-align: center;
                font-size: 15px;
            }

            .remove-btn {
                background: none;
                border: none;
                color: #ef4444;
                font-size: 16px;
                cursor: pointer;
                font-weight: 500;
            }

            .remove-btn:hover {
                text-decoration: underline;
            }

            .cart-summary {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                padding: 20px;
                position: sticky;
                top: 20px;
            }

            .summary-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 1px solid #e5e7eb;
                text-align: left;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 12px;
            }

            .summary-item.total {
                font-weight: 600;
                font-size: 18px;
                padding-top: 12px;
                margin-top: 12px;
                border-top: 1px solid #e5e7eb;
            }

            .checkout-btn {
                display: block;
                width: 100%;
                background-color: #5b3b27;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px;
                font-size: 18px;
                font-weight: 500;
                cursor: pointer;
                margin-top: 20px;
                transition: background-color 0.2s;
            }

            .checkout-btn:hover {
                background-color: #533421;
            }

            .continue-shopping {
                display: block;
                width: 100%;
                background-color: #f3961c;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 12px;
                font-size: 18px;
                font-weight: 500;
                cursor: pointer;
                margin-top: 20px;
                transition: background-color 0.2s;
            }



            .empty-cart {
                text-align: center;
                padding: 40px 0;
            }

            .empty-cart-icon {
                font-size: 48px;
                color: #9ca3af;
                margin-bottom: 16px;
            }

            .empty-cart-message {
                font-size: 18px;
                color: #4b5563;
                margin-bottom: 20px;
            }

            .input-code {
                height: 40px;
                font-size: 15px;
                padding-left: 10px;
            }

            .dis-btn {
                font-size: 16px;
                color: #f3961c;
            }

            .shop-now-btn {
                display: inline-block;
                background-color: #4f46e5;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                text-decoration: none;
            }

            .shop-now-btn:hover {
                background-color: #4338ca;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <div class="page-title">
                <svg class="cart-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                </svg>
                <h1 class="pg-title">Giỏ hàng của tôi</h1>
            </div>

            <div class="cart-container">
                <div class="cart-items">
                    <c:choose>
                        <c:when test="${empty cart.items}">
                            <p class="empty-cart">Giỏ hàng của bạn chưa có sản phẩm nào.</p>
                            <img src="img/empty-cart.png" alt="Empty-Cart" class="empty-cart-img"/>
                        </c:when>
                        <c:otherwise>


                            <c:forEach var="item" items="${cart.items}">
                                <div class="cart-item" data-price="${item.price}">
                                    <img src="${item.imageUrl}" class="item-image">
                                    <div class="item-details">
                                        <div>
                                            <div class="item-info">
                                                <h3 class="item-name">${item.name}</h3>
                                                <span class="item-price">
                                                    <fmt:formatNumber value="${item.price * item.quantity}" type="number" groupingUsed="true" pattern="#,###" /> VND
                                                </span>
                                            </div>
                                            <p class="item-description">${item.description}</p>
                                        </div>
                                        <div class="item-actions">
                                            <div class="quantity-selector">

                                                <!-- Giảm số lượng -->
                                                <form action="cart" method="POST" style="display:inline;">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="id" value="${item.productId}">
                                                    <input type="hidden" name="quantity" value="${item.quantity - 1}">
                                                    <button type="submit" class="quantity-btn decrease"${item.quantity == 1 ? 'disabled' : ''}>-</button>
                                                </form>

                                                <input type="text" value="${item.quantity}" class="quantity-input" readonly>

                                                <!-- Tăng số lượng -->
                                                <form action="cart" method="POST" style="display:inline;">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="id" value="${item.productId}">
                                                    <input type="hidden" name="quantity" value="${item.quantity + 1}">
                                                    <button type="submit" class="quantity-btn increase">+</button>
                                                </form>
                                            </div>
                                            <form action="cart" method="POST">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="id" value="${item.productId}">
                                                <button type="submit" class="remove-btn">Xóa</button>
                                            </form>


                                        </div>
                                    </div>
                                </div>   
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                    <div class="checkout-container">
                        <!-- Phần Thanh toán -->
                        <div class="cart-summary">
                            <h2 class="summary-title">Thanh toán</h2>
                            <div class="summary-item">
                                <span>Tổng (<span id="item-count">0</span> sản phẩm)</span>
                                <span id="subtotal">0 VND</span>
                            </div>

                            <div class="summary-item">
                                <span>Mã ưu đãi</span>
                                <div>
                                    <input type="text" id="discount-code" class="input-code" placeholder="Nhập mã ưu đãi">
                                    <button class="dis-btn" onclick="applyDiscount()">Xác nhận</button>
                                </div>
                            </div>

                            <div class="summary-item">
                                <span>Giảm giá</span>
                                <span id="discount-amount">0 VND</span>
                            </div>

                            <div class="summary-item total">
                                <span>Tổng</span>
                                <span id="total">0 VND</span>
                            </div>
                        </div>

                        <!-- Phần Thông tin nhận hàng -->
                        <div class="cart-summary">
                            <form action="checkout" method="POST">
                                <h2 class="summary-title">Thông tin nhận hàng</h2>

                                <c:if test="${not empty mess}">
                                    <p class="message-box">${mess}</p>
                                </c:if>

                                <div class="form-group">
                                    <input type="text" name="name" id="name" class="input-field" placeholder="Nhập tên người nhận">
                                </div>

                                <div class="form-group">
                                    <input type="text" name="phone" id="phone" class="input-field" placeholder="Nhập số điện thoại">
                                </div>

                                <div class="form-group">
                                    <input type="text" name="address" id="address" class="input-field" placeholder="Nhập địa chỉ">
                                </div>

                                <div class="button-group">
                                    <button type="submit" class="checkout-btn">Đặt hàng</button>
                                    <a href="home" class="continue-shopping">Tiếp tục order</a>
                                    
                                </div>
                            </form>
                        </div>
                    </div>

                </div>


            </div>
        </div>
        <style>
            .form-group {
                margin-bottom: 15px;
            }
            /* Input trường nhập */
            .input-field {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease-in-out;
            }

            /* Hiệu ứng khi focus vào input */
            .input-field:focus {
                border-color: #28a745;
                outline: none;
                box-shadow: 0px 0px 8px rgba(40, 167, 69, 0.2);
            }

            /* Hộp hiển thị thông báo */
            .message-box {
                background-color: #ffcccc;
                padding: 10px;
                text-align: center;
                border-radius: 8px;
                margin-bottom: 15px;
                font-size: 14px;
                color: #d9534f;
                font-weight: bold;
            }
            .checkout-container {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                width: 100%;
                gap: 20px;
            }

            .cart-summary, .checkout-form {
                width: 48%; /* Căn 2 phần bằng nhau */
            }

            .checkout-form {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            .message-box {
                background-color: lightcoral;
                padding: 10px;
                text-align: center;
                border-radius: 5px;
                margin-bottom: 10px;
                color: white;
            }

            
            .button-group {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }



        </style>

        <script>
            // Get all quantity buttons
            const decreaseButtons = document.querySelectorAll('.quantity-btn.decrease');
            const increaseButtons = document.querySelectorAll('.quantity-btn.increase');
            const removeButtons = document.querySelectorAll('.remove-btn');

            // Add event listeners to decrease buttons
            decreaseButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const input = this.parentNode.querySelector('.quantity-input');
                    let value = parseInt(input.value);
                    if (value > 1) {
                        value--;
                        input.value = value;
                        updateCartTotals();
                    }
                });
            });

            // Add event listeners to increase buttons
            increaseButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const input = this.parentNode.querySelector('.quantity-input');
                    let value = parseInt(input.value);
                    value++;
                    input.value = value;
                    updateCartTotals();
                });
            });

            // Function to update cart totals
            // Hàm cập nhật tổng giá trị giỏ hàng
            let discountPercentage = 0; // Mặc định không giảm giá

            function updateCartTotals() {
                let subtotal = 0;
                let itemCount = 0;

                // Lặp qua từng sản phẩm trong giỏ hàng
                const cartItems = document.querySelectorAll('.cart-item');
                cartItems.forEach(item => {
                    const price = parseFloat(item.getAttribute('data-price'));
                    const quantity = parseInt(item.querySelector('.quantity-input').value);
                    subtotal += price * quantity;
                    itemCount += quantity;
                });

                // Tính giảm giá
                let discountAmount = (subtotal * discountPercentage) / 100;
                let total = subtotal - discountAmount;

                // Cập nhật giao diện
                document.getElementById('item-count').textContent = itemCount;
                document.getElementById('subtotal').textContent = subtotal.toLocaleString('vi-VN') + ' VND';
                document.getElementById('discount-amount').textContent = '-' + discountAmount.toLocaleString('vi-VN') + ' VND';
                document.getElementById('total').textContent = total.toLocaleString('vi-VN') + ' VND';
            }

            // Hàm xử lý khi nhập mã giảm giá
            function applyDiscount() {
                let code = document.getElementById('discount-code').value.trim();

                if (code === "WELCOME15") {
                    discountPercentage = 15;
                } else {
                    discountPercentage = 0;
                    alert("Mã giảm giá không hợp lệ!");
                }

                updateCartTotals();
            }

            // Gọi hàm khi trang load
            updateCartTotals();



            // Lấy tất cả input số lượng
            const quantityInputs = document.querySelectorAll('.quantity-input');

            // Cập nhật giỏ hàng khi thay đổi số lượng bằng tay
            quantityInputs.forEach(input => {
                input.addEventListener('blur', function () {
                    updateCartTotals();
                });
            });


        </script>
    </body>
</html>