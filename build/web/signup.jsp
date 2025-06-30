<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            .signup-page * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .signup-page .page-background {
                width: 100vw;
                height: 100vh;
                overflow: hidden;
                position: absolute;
                top: 0;
                left: 0;
            }

            .signup-page .page-background img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                top: 0;
                left: 0;
            }

            .signup-page .logo-container {
                position: absolute;
                top: 20px;
                left: 100px;
                z-index: 100;
            }

            .signup-page .logo-container .logo {
                width: 220px;
                height: auto;
                cursor: pointer;
            }

            .signup-page .button-container {
                background: rgba(0, 0, 0, 0.8);
                padding: 50px;
                border-radius: 9px;
                box-shadow: 0 4px 10px rgba(255, 255, 255, 0.1);
                text-align: center;
                width: 475px;
                height: 700px;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            .signup-page .tabs {
                display: flex;
                justify-content: center;
                margin-top: -7px;
                margin-bottom: 40px;
                gap: 10px;
            }

            .signup-page .tab-button {
                border: none;
                background: none;
                color: white;
                font-size: 24px;
                padding: 10px;
                cursor: pointer;
                font-weight: bold;
                opacity: 1;
                margin-top: 28px;
            }

            .signup-page .btn-active::after {
                content: "";
                width: 100px;
                height: 5px;
                display: block;
                margin: 10px auto 0;
                border-radius: var(--border-radius-s);
                background: var(--secondary-color);
            }

            .signup-page .form-container {
                text-align: left;
            }

            .signup-page .form-container .alert {
                position: relative;
                border: 1px solid transparent;
                border-radius: .25rem;
                color: red;
                background-color: var(--light-pink-color);
                padding: 15px 20px;
            }
            .signup-page .input-group {
                margin: 10px 0;
            }

            .signup-page input {
                width: 100%;
                height: 50px;
                padding: 12px;
                border: 1px solid gray;
                border-radius: 5px;
                background: #333;
                color: white;
                font-size: 16px;
                margin-bottom: 5px;
            }

            .signup-page input::placeholder {
                color: rgba(255, 255, 255, 0.7);
                font-weight: 500;
            }

            .signup-page .submit-button {
                width: 100%;
                padding: 12px;
                background: #f3961c;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 18px;
                font-weight: 500;
                margin-top: 10px;
            }

            .signup-page .submit-button:hover {
                background: #333;
            }

            input[type="text"],
            input[type="email"],
            input[type="username"],
            input[type="password"] {
                background: rgba(255, 255, 255, 0.1);
                backdrop-filter: blur(5px);
                border: 1px solid rgba(255, 255, 255, 0.3);
                color: #fff;
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                outline: none;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="username"]:focus,
            input[type="password"]:focus {
                background: rgba(255, 255, 255, 0.2);
            }

            .signup-page .checkbox-container {
                display: flex;
                align-items: center;
                font-size: 17px;
                color: white;
                cursor: pointer;
            }

            .signup-page .checkbox-container input {
                display: none;
            }

            .signup-page .checkmark {
                width: 20px;
                height: 20px;
                border-radius: 3px;
                background: transparent;
                border: 2px solid white;
                display: inline-block;
                position: relative;
                margin-right: 8px;
            }

            .signup-page .checkbox-container input:checked + .checkmark::after {
                content: "";
                position: absolute;
                left: 4px;
                top: 1px;
                width: 6px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }

            .signup-page .switch-text {
                font-size: 17px;
                margin-top: 32px;
                color: #fff;
            }

            .signup-page .switch-text a {
                color: white;
                font-weight: bold;
            }

            .signup-page .switch-text a {
                color: white;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .signup-page .switch-text a:hover {
                color: #f3961c;
            }

            .signup-page .form-container {
                transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
                opacity: 1;
                transform: translateY(0);
            }

            .signup-page .hidden {
                opacity: 0;
                transform: translateY(20px);
                pointer-events: none;
                position: absolute;
            }
        </style>

    </head>
    <body class="signup-page">
        <div class="logo-container">
            <a href="home">
                <img src="img/logo-login.png" alt="Logo" class="logo">
            </a>
        </div>

        <div class="page-background">
            <img src="img/bg12.jpg" alt="background">
        </div>

        <div class="button-container">
            <div class="tabs">
                <a href="login.jsp">
                    <button class="tab-button">Đăng nhập</button>
                </a>
                <a href="signup.jsp">
                    <button class="tab-button btn-active">Đăng ký</button>
                </a>
            </div>

            <form action="signup" method="POST">
                <!-- Signup Form -->
                <div class="form-container" id="signup-form">
                    <div class="input-group">
                        <input name="mail" type="text" placeholder="email" value="${sessionScope.mailInput}" required>
                    </div>

                    <div class="input-group">
                        <input name="user" type="text" placeholder="username" value="${sessionScope.userInput}" required>
                    </div>

                    <div class="input-group">
                        <input name="pass" type="password" placeholder="password" value="${sessionScope.passInput}" required>
                    </div>

                    <div class="input-group">
                        <input name="repass" type="password" placeholder="confirm password" value="${sessionScope.repassInput}" required>
                    </div>

                    <%-- Lấy thông báo lỗi từ Session --%>
                    <c:if test="${not empty sessionScope.ms}">
                        <div class="alert alert-danger" role="alert">
                            ${sessionScope.ms}
                        </div>
                        <%-- Xóa lỗi sau khi hiển thị --%>
                        <c:remove var="ms" scope="session"/>
                    </c:if>
                    <%-- Xóa dữ liệu nhập sau khi hiển thị --%>
                    <c:remove var="mailInput" scope="session"/>   
                    <c:remove var="userInput" scope="session"/>
                    <c:remove var="passInput" scope="session"/>
                    <c:remove var="repassInput" scope="session"/>

                    <button type="submit" class="submit-button">Đăng ký</button>

                    <div class="switch-text">
                        Đã có tài khoản? 
                        <a href="login.jsp">Đăng nhập</a>
                    </div>
                </div>
            </form>




        </div>

    </body>
</html>
