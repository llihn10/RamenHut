<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>
<%@page import="java.util.List" %>
<%@page import="model.Products" %>
<%@page import="dal.RamenDAO" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý sản phẩm - Ramen Hut</title>
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
            <h2><b>Quản lý sản phẩm</b></h2>
            <div class="header">
                <button class="add-btn" onclick="openPopup()">Thêm sản phẩm</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Ảnh</th>
                        <th>Giá</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dùng JSTL để hiển thị danh sách sản phẩm -->
                    <c:forEach var="p" items="${list}">
                        <tr>
                            <td>${p.getProduct_id()}</td>
                            <td class="pname">${p.getName()}</td>
                            <td><img src="${p.getImageUrl()}" alt="Product Image" width="100"></td>
                            <td><fmt:formatNumber value="${p.getPrice()}" type="number" groupingUsed="true" pattern="#,###"/>₫</td>
                            <td>
                                <a href="load?pid=${p.getProduct_id()}">
                                    <button class="edit-btn"><i class="fas fa-edit"></i></button>
                                </a>

                                <a href="delete?pid=${p.getProduct_id()}" onclick="return confirmDelete(event, '${p.getName()}')">
                                    <button class="delete-btn"><i class="fas fa-trash"></i></button>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <form action="add" method="POST">
            <div id="popupForm" class="popup">
                <div class="popup-content">
                    <span class="close-btn" onclick="closePopup()">&times;</span>
                    <h3>Thêm sản phẩm</h3>
                    <label for="name">Tên</label>
                    <input type="text" id="name" name="name" required>

                    <label for="image">URL ảnh</label>
                    <input type="text" id="image" name="image" required>

                    <label for="price">Giá</label>
                    <input type="number" id="price" name="price" required>

                    <label for="title">Mô tả</label>
                    <input type="text" id="description" name="description" required>

                    <label for="description">Thành phần</label>
                    <input type="text" id="ingredient" name="ingredient" required>

                    <label for="category">Danh mục</label>
                    <select id="category" name="category">
                        <option value="Miso">Nước dùng Miso</option>
                        <option value="Tonkotsu">Nước dùng Tonkotsu</option>
                        <option value="Shoyu">Nước dùng Shoyu</option>
                        <option value="Special">Đặc biệt</option>
                    </select>
                    <div class="popup-button">
                        <button type="submit" class="btn-submit">Thêm</button>
                        <button type="button" class="btn-cancel" onclick="closePopup()">Hủy</button>
                    </div>
                    <c:if test="${not empty sessionScope.ms}">
                        <p id="error-message">${sessionScope.ms}</p>
                        <c:remove var="ms" scope="session"/>
                    </c:if>


                </div>
            </div>
        </form>

        <c:set var="totalPages" value="${totalPages}" />
        <c:set var="totalProducts" value="${totalProducts}" />
        <c:set var="currentPage" value="${currentPage}" />
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Nút Previous -->
                <c:if test="${currentPage > 1}">
                    <a href="manage-product?page=${currentPage - 1}">Trang trước</a>
                </c:if>

                <!-- Các số trang -->
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="manage-product?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${currentPage < totalPages}">
                    <a href="manage-product?page=${currentPage + 1}">Trang sau</a>
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
            function confirmDelete(event, productName) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của thẻ <a>
                let confirmation = confirm("Bạn có chắc chắn muốn xóa sản phẩm '" + productName + "' không?");
                if (confirmation) {
                    window.location.href = event.currentTarget.href; // Chuyển hướng nếu xác nhận
                }
            }
        </script>

        <script>
            window.onload = function () {
                var errorMessage = document.querySelector("#error-message")?.innerText;
                if (errorMessage && errorMessage.trim() !== "") {
                    document.getElementById("popupForm").style.display = "flex";
                }
            };
        </script>
    </body>
</html>

<!--        <form id="deleteForm" action="DeleteProductServlet" method="post">
            <input type="hidden" name="id" id="deleteId">
        </form>
        <form id="editForm" action="edit_product.jsp" method="get">
            <input type="hidden" name="id" id="editId">
        </form>

        <script>
            function deleteProduct(id) {
                if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này?")) {
                    document.getElementById("deleteId").value = id;
                    document.getElementById("deleteForm").submit();
                }
            }

            function editProduct(id) {
                document.getElementById("editId").value = id;
                document.getElementById("editForm").submit();
            }
        </script>-->
