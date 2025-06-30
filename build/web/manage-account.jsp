<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý tài khoản - Ramen Hut</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <link rel="stylesheet" href="style.css"/>

        <style>
            body {
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 20px auto;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h2 {
                margin-top: 30px;
                font-size: 34px;
                text-align: center;
                color: #5b3b27;
                margin-bottom: 50px;
            }

            .header {
                width: 100%;
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 20px;
                margin-bottom: 15px;
            }

            .add-btn, .delete-btn {
                padding: 10px 15px;
                border: none;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            .add-btn {
                background-color: #f3961c;
                margin-left: 0; /* Đảm bảo không bị lệch */
            }


            .delete-btn {
                background-color: #dc3545;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            th, td {
                padding: 10px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                padding: 20px;
                background-color: #5b3b27;
                color: white;
                font-size: 18px;
            }

            td {
                font-size: 18px;
            }
            td img {
                width: 150px;
                border-radius: 5px;
            }

            .edit-btn, .delete-btn {
                background: none;
                border: none;
                cursor: pointer;
                font-size: 18px;
            }

            .edit-btn i {
                color: #ffc107;
            }

            .delete-btn i {
                color: #dc3545;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Popup form */
            .popup {
                display: none; /* Ẩn mặc định */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            /* Nội dung form */
            .popup-content {
                display: flex;
                flex-direction: column; /* Ép các phần tử xếp dọc */
                background: white;
                padding: 60px;
                border-radius: 8px;
                width: 30%;
                height: 80%;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                position: relative;
            }
            .popup-content h3 {
                text-align: left !important;
            }

            /* Nút đóng */
            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 30px;
                cursor: pointer;
            }

            /* Input, select, textarea */
            input, select {
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            /* Button */

            .popup-button {
                margin-top: 15px;
            }

            .btn-submit {
                background: #28a745;
                color: white;
                padding: 10px;
                border: none;
                width: 100%;
                border-radius: 5px;
                cursor: pointer;
                margin-bottom: 3px;
            }

            .btn-cancel {
                margin-top: 15px;
                background: #dc3545;
                color: white;
                padding: 10px;
                border: none;
                width: 100%;
                border-radius: 5px;
                margin-top: 5px;
                cursor: pointer;
            }

            .btn-home {
                display: inline-block;
                background-color: #f3961c;
                color: white;
                padding: 9px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-align: center;
                text-decoration: none;
                font-size: 16px;
                width: auto;
                margin-left: 150px;
                margin-bottom: 30px;
            }

            .pagination {
                display: flex;
                justify-content: flex-end;
                margin-top: 20px;
                margin-right: 142px;
                padding-right: 10px;
            }

            .pagination a {
                display: inline-block;
                padding: 10px 15px;
                margin: 0 0 0 5px;
                text-decoration: none;
                font-weight: 600;
                color: #333;
                background-color: #fff;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #a49898;
                color: white;
                border-color: #f9a825;
            }

            .pagination a.active {
                background-color: #f3961c;
                color: white;
                font-weight: bold;
                border-color: #d32f2f;
            }

            .pagination a:first-child,
            .pagination a:last-child {
                font-weight: 600;
            }

        </style>

    </head>
    <body>
        <div class="container">
            <h2><b>Quản lý tài khoản</b></h2>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Mail</th>
                        <th>Tên người dùng</th>
                        <th>Staff</th>
                        <th>Admin</th> <!<!-- chức năng -->
                        <th>Chức năng</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dùng JSTL để hiển thị danh sách sản phẩm -->
                    <c:forEach var="o" items="${list}">
                        <tr>
                            <td>${o.getId()}</td>
                            <td>${o.getMail()}</td>
                            <td>${o.getUsername()}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.getIsStaff() == 1}">
                                        <input type="checkbox" name="" value="ON" checked="checked" disabled/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="checkbox" name="" value="ON" disabled/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>                               
                                <c:choose>
                                    <c:when test="${o.getIsAdmin() == 1}">
                                        <input type="checkbox" name="" value="ON" checked="checked" disabled/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="checkbox" name="" value="ON" disabled/>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="load-account?pid=${o.getId()}">
                                    <button class="edit-btn"><i class="fas fa-edit"></i></button>
                                </a>

                                <a href="delete-account?pid=${o.getId()}" onclick="return confirmDelete(event, '${o.getUsername()}')">
                                    <button class="delete-btn"><i class="fas fa-trash"></i></button>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>


        <c:set var="totalPages" value="${totalPages}" />
        <c:set var="totalAccounts" value="${totalAccounts}" />
        <c:set var="currentPage" value="${currentPage}" />
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Nút Previous -->
                <c:if test="${currentPage > 1}">
                    <a href="manage-account?page=${currentPage - 1}">Trang trước</a>
                </c:if>

                <!-- Các số trang -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="manage-account?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${currentPage < totalPages}">
                    <a href="manage-account?page=${currentPage + 1}">Trang sau</a>
                </c:if>
            </div>
        </c:if>

        <a href="home">
            <button class="btn-home">Quay lại trang chủ</button>
        </a>


        <script>
            function openPopup() {
                document.getElementById("popupForm").style.display = "flex";
            }

            function closePopup() {
                document.getElementById("popupForm").style.display = "none";
            }

        </script>

        <script>
            function confirmDelete(event, username) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>
                let confirmation = confirm("Bạn có chắc chắn muốn xóa tài khoản '" + username + "' không?");
                if (confirmation) {
                    window.location.href = event.currentTarget.href; // Chuyển hướng nếu xác nhận
                }
            }
        </script>

    </body>
</html>

