<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - Ramen Hut</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            .login-page * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            .login-page .page-background {
                width: 100vw;
                height: 100vh;
                overflow: hidden;
                position: absolute;
                top: 0;
                left: 0;
            }

            .login-page .page-background img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                top: 0;
                left: 0;
            }

            .login-page .logo-container {
                position: absolute;
                top: 20px;
                left: 100px;
                z-index: 100;
            }

            .login-page .logo-container .logo {
                width: 220px;
                height: auto;
                cursor: pointer;
            }

            .login-page .button-container {
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

            .login-page .tabs {
                display: flex;
                justify-content: center;
                margin-top: -7px;
                margin-bottom: 40px;
                gap: 10px;
            }

            .login-page .tab-button {
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

            .login-page .btn-active::after {
                content: "";
                width: 100px;
                height: 5px;
                display: block;
                margin: 10px auto 0;
                border-radius: var(--border-radius-s);
                background: var(--secondary-color);
            }

            .login-page .form-container {
                text-align: left;
            }

            .login-page .hidden {
                display: none;
            }

            .login-page .input-group {
                margin: 10px 0;
            }

            .login-page input {
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

            .login-page input::placeholder {
                color: rgba(255, 255, 255, 0.7);
                font-weight: 500;
            }

            .login-page .submit-button {
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

            .login-page .submit-button:hover {
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

            .login-page .checkbox-container {
                display: flex;
                align-items: center;
                font-size: 17px;
                color: white;
                cursor: pointer;
            }

            .login-page .checkbox-container input {
                display: none;
            }

            .login-page .checkmark {
                width: 20px;
                height: 20px;
                border-radius: 3px;
                background: transparent;
                border: 2px solid white;
                display: inline-block;
                position: relative;
                margin-right: 8px;
            }

            .login-page .checkbox-container input:checked + .checkmark::after {
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

            .login-page .remember-me {
                display: flex;
                align-items: center;
                font-size: 20px;
                margin: 30px 0;
                color: #fff;
            }

            .login-page .switch-text {
                font-size: 17px;
                margin-top: 32px;
                color: #fff;
            }

            .login-page .switch-text a {
                color: white;
                font-weight: bold;
            }

            .login-page .switch-text a {
                color: white;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .login-page .switch-text a:hover {
                color: #f3961c;
            }

            .login-page .form-container {
                transition: opacity 0.3s ease-in-out, transform 0.3s ease-in-out;
                opacity: 1;
                transform: translateY(0);
            }

            .login-page .hidden {
                opacity: 0;
                transform: translateY(20px);
                pointer-events: none;
                position: absolute;
            }

            .funct {
                display: flex;
                justify-content: space-between; /* Đẩy hai phần tử về hai đầu */
                align-items: center; /* Căn giữa theo chiều dọc */
                width: 100%; /* Đảm bảo phần tử chiếm toàn bộ chiều rộng */
            }
            
            .funct .forget-pass a {
                color: white;
                text-decoration: none;
                font-size: 17px;
            }
            
            .funct .forget-pass:hover {
                color: white;
                text-decoration: underline;
            }
        </style>

    </head>
    <body class="login-page">
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
                    <button class="tab-button btn-active">Đăng nhập</button>
                </a>
                <a href="signup.jsp">
                    <button class="tab-button">Đăng ký</button>
                </a>
            </div>

            <form action="login" method="POST">
                <!-- Login Form -->
                <div class="form-container" id="login-form">
                    <div class="input-group">
                        <input name="user" type="text" placeholder="username" value="${username}" required>
                    </div>

                    <div class="input-group">
                        <input name="pass" type="password" placeholder="password" value="${password}" required>
                    </div>

                    <%-- Lấy thông báo lỗi từ Session --%>
                    <c:if test="${not empty sessionScope.ms}">
                        <div class="alert alert-danger" role="alert">
                            ${sessionScope.ms}
                        </div>
                        <%-- Xóa lỗi sau khi hiển thị --%>
                        <c:remove var="ms" scope="session"/>
                    </c:if>

                    <button type="submit" class="submit-button">Đăng nhập</button>
                    <div class="funct">
                        <div class="remember-me">
                            <label class="checkbox-container">
                                <input name="remember" type="checkbox">
                                <span class="checkmark"></span>
                                Ghi nhớ tôi
                            </label>
                        </div>
                        <div class="forget-pass">
                            <a href="email.jsp">Quên mật khẩu</a>
                        </div>
                    </div>
                    <div class="switch-text">
                        Bạn chưa có tài khoản? 
                        <a href="signup.jsp">Đăng ký ngay</a>
                    </div>
                </div>
            </form>




        </div>

    </body>
</html>
