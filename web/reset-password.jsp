<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng nhập - Ramen Hut</title>
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

            .verification-text {
                color: #fff;
                margin-bottom: 24px;
                font-size: 14px;
                line-height: 1.5;
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

            .otp-container {
                display: flex;
                justify-content: center;
                gap: 8px;
                margin-bottom: 24px;
            }

            .otp-input {
                width: 40px;
                height: 48px;
                border: 1px solid #e5e5e5;
                border-radius: 6px;
                text-align: center;
                font-size: 18px;
                font-weight: 500;
            }

            .otp-input:focus {
                outline: none;
                border-color: #000;
            }

            .error-message {
                color: #e00;
                font-size: 14px;
                margin-bottom: 16px;
                min-height: 20px;
            }
            
            .alert {
                color: white;
            }
            
        </style>
    </head>
    <body>
        <div class="container">
            <div class="auth-card">
                <h1>Đặt lại mật khẩu</h1>
                <p class="verification-text">
                    Vui lòng nhập mật khẩu mới của bạn
                </p>
                <form id="resetPassword" method="POST">
                    <div class="input-group">
                        <input type="email" id="email" name="email" placeholder="email" value="${email}" readonly>
                    </div>
                    <div class="input-group">
                        <input type="password" id="password" name="password" placeholder="New Password" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm Password" required>
                    </div>
                    
                    <c:if test="${not empty ms}">
                        <div class="alert alert-danger" role="alert">
                            ${ms}
                        </div>
                    </c:if>
                    
                    <div id="password-error" class="error-message"></div>
                    <button type="submit" class="btn-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10"></path>
                        </svg>
                        Đặt lại mật khẩu
                    </button>
                    <div class="other-options">
                        <a href="email.jsp" class="back-link">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon">
                            <path d="m15 18-6-6 6-6"></path>
                            </svg>
                            Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>

<!--        <script>
            function validateForm() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirm-password').value;
                const errorElement = document.getElementById('password-error');

                if (password !== confirmPassword) {
                    errorElement.textContent = 'Passwords do not match';
                    return false;
                }

                // Trong thực tế, bạn sẽ gửi form đến server
                alert('Password reset successfully!');
                return false; // Ngăn form submit trong demo
            }
        </script>-->
    </body>
</html>
