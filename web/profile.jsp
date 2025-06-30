<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="model.Products" %>
<%@page import="dal.RamenDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.DecimalFormatSymbols" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">

        <style>

            body {
                display: flex;
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                height: 100vh; /* Chiều cao toàn màn hình */
                margin: 0; /* Loại bỏ margin mặc định */
                background-color: #f8f9fa; /* Màu nền nhẹ */
            }

            .profile-container {
                background: rgba(0, 0, 0, 0.8); /* Nền trắng */
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
                width: 450px; /* Độ rộng tối ưu */
                height: 400px;
                text-align: center; /* Căn chữ giữa */
            }
            /* Profile Form */
            .profile-container {
                max-width: 500px;
                margin: 50px auto;
                padding: 30px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .profile-container h2 {
                text-align: center;
                font-size: 24px;
                color: #333;
                margin-bottom: 50px;
                color: #5b3b27;
                margin-top: 30px;
            }

            .form-floating {
                position: relative;
                margin-bottom: 15px;
            }

            .form-floating input {
                width: 100%;
                padding: 12px 15px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            .form-floating input:focus {
                border-color: #5b3b27;
                outline: none;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
            }

            .form-floating label {
                position: absolute;
                top: 12px;
                left: 15px;
                font-size: 14px;
                color: #5b3b27;
                transition: all 0.3s ease;
            }

            .form-floating input:focus + label,
            .form-floating input:not(:placeholder-shown) + label {
                top: -8px;
                left: 10px;
                background: white;
                padding: 0 5px;
                font-size: 12px;
                color: #5b3b27;
            }

            .btn-primary {
                width: 100%;
                padding: 12px;
                background-color: #f3961c;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 20px;
            }

            .btn-primary:hover {
                background-color: #333;
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
            
            .product-page {
                display: flex;
                flex-direction: column;
            }
            .btn-home {
                display: inline-block;
                background-color: #333;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                font-size: 16px;
                width: auto;
                margin-right: 1000px;
                margin-bottom: 30px;
                width: 120px;
            }
            
            .alert {
                margin-top: 12px;
            }
        </style>
    </head>
    <body class="product-page">

        <div class="product-container">

        </div>

        
        <div class="profile-container">
            <h2>Thông Tin Cá Nhân</h2>
            <form action="profile" method="post">
                <div class="form-floating">
                    <input value="${user.mail}" readonly name="email" type="text" class="form-control" placeholder="Email">
                    <label>Email</label>
                </div>
                <div class="form-floating">
                    <input value="${user.username}" name="username" type="text" class="form-control" placeholder="Username">
                    <label>Username *</label>
                </div>
                <button class="btn btn-primary" type="submit">Lưu</button>
            </form>
            <c:if test="${not empty sessionScope.ms}">
                <div class="alert alert-danger" role="alert" style="color: red;">
                    ${sessionScope.ms}
                </div>
                <%-- Xóa lỗi sau khi hiển thị --%>
                <c:remove var="ms" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success" role="alert" style="color: green;">
                    ${sessionScope.success}
                </div>
                <%-- Xóa lỗi sau khi hiển thị --%>
                <c:remove var="success" scope="session"/>
            </c:if>

        </div>
        <a href="home">
            <button class="btn-home">Quay lại</button>
        </a>

    </body>
</html>
