<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập - Ramen Hut</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css"/>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #5b3b27;
                color: #000;
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .container {
                width: 100%;
                max-width: 400px;
                padding: 20px;
            }

            .auth-card {
                width: 100%;
                text-align: center;
                padding: 20px;
            }

            h1 {
                font-size: 28px;
                font-weight: 600;
                margin-bottom: 24px;
                color: #fff;
            }

            .input-group {
                margin-bottom: 16px;
            }

            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 12px 16px;
                border: 1px solid #e5e5e5;
                border-radius: 6px;
                font-size: 16px;
                transition: border-color 0.2s;
            }

            input[type="email"]:focus,
            input[type="password"]:focus {
                outline: none;
                border-color: #000;
            }

            .btn-primary {
                width: 100%;
                padding: 12px 16px;
                background-color: #e67e22;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background-color 0.2s;
            }

            .btn-primary:hover {
                background-color: #333;
            }

            .icon {
                margin-right: 8px;
            }

            .other-options {
                margin-top: 24px;
                display: flex;
                justify-content: center;
            }

            .back-link {
                color: #fff;
                text-decoration: none;
                font-size: 14px;
                display: flex;
                align-items: center;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="auth-card">
                <h1>Nhập email của bạn</h1>
                <form action="email" method="POST">
                    <div class="input-group">
                        <input type="email" id="email" name="email" placeholder="Email" required>
                    </div>
                    
                    <c:if test="${not empty ms}">
                        <div class="alert alert-danger" role="alert">
                            ${ms}
                        </div>
                    </c:if>
                    
                    <button type="submit" class="btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                        <rect width="20" height="16" x="2" y="4" rx="2"></rect>
                        <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
                        </svg>
                        Tiếp tục
                    </button>
                    <div class="other-options">
                        <a href="login.jsp" class="back-link">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                            <path d="m15 18-6-6 6-6"></path>
                            </svg>
                            Quay lại trang đăng nhập
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
