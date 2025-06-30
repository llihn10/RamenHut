<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>

<fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" pattern="###" var="formattedPrice"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sửa thông tin sản phẩm</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="style.css"/>

        <style>
            .body {
                max-height: 100vh;
            }

            .row {
                background-color: #5b3b27;
                color: white;
                padding-bottom: 10px;
            }

            .modal-dialog {
                display: flex;
            }

            .modal-header h4 {
                text-align: left;
            }

            .modal-content {
                margin: auto;
                width: 100%;
                max-width: 500px; 
            }

            .form-group label {
                text-align: left;
                display: block;
                font-weight: bold; 
            }

            .form-group .category {
                width: 200px;
            }

            img{
                width: 200px;
                height: 120px;
            }

            #category {
                width: 100%;
                height: 40px; 
                font-size: 16px; 
                padding: 8px; 
                border-radius: 5px;
                border: 1px solid #ccc; 
                background-color: #fff; 
            }

            #category:hover, #category:focus {
                border-color: #007bff;
                outline: none;
            }

            .modal-footer .btn-success {
                padding: 10px 20px;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2><b>Sửa thông tin sản phẩm</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editProductModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="edit" method="POST">
                            <div class="modal-header">						
                                <h4 class="modal-title">Sửa sản phẩm</h4>
                                <button type="button" class="close" onclick="window.history.back();" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">		
                                <div class="form-group">
                                    <label>ID</label>
                                    <input value="${detail.product_id}" name="id" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Tên sản phẩm</label>
                                    <input value="${detail.name}" name="name" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>URL ảnh</label>
                                    <input value="${detail.imageUrl}" name="image" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Giá</label>
                                    <input value="${formattedPrice}" name="price" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Mô tả</label>
                                    <input value="${detail.description}" name="description" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Thành phần</label>
                                    <input value="${detail.ingredient}" name="ingredient" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Category</label>

                                    <select id="category" name="category">
                                        <option value="Miso" ${detail.category eq 'Miso' ? 'selected' : ''}>Nước dùng Miso</option>
                                        <option value="Tonkotsu" ${detail.category eq 'Tonkotsu' ? 'selected' : ''}>Nước dùng Tonkotsu</option>
                                        <option value="Shoyu" ${detail.category eq 'Shoyu' ? 'selected' : ''}>Nước dùng Shoyu</option>
                                        <option value="Special" ${detail.category eq 'Special' ? 'selected' : ''}>Đặc biệt</option>
                                    </select>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-success" value="Sửa">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>


        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>
