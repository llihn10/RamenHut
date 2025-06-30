<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa thông tin tài khoản</title>
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

            .role-form {
                display: flex;
                flex-direction: column;
            }
            
            .role-form .role-check {
                display: flex;
                margin-bottom: -14px;
            }
            
            .role-form .role-check label {
                font-weight: normal;
            }

            .role-form .role-check .form-check-label {
                margin-top: 14px;
                margin-left: 6px;
                margin-bottom: 9px;
            }
            
        </style>
    </head>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2><b>Sửa thông tin tài khoản</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editProductModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="edit-account" method="POST">
                            <div class="modal-header">						
                                <h4 class="modal-title">Sửa tài khoản</h4>
                                <button type="button" class="close" onclick="window.history.back();" aria-label="Close">&times;</button>
                            </div>
                            <div class="modal-body">		
                                <div class="form-group">
                                    <label>ID</label>
                                    <input value="${detail.id}" name="id" type="text" class="form-control" readonly required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input value="${detail.mail}" name="mail" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Tên tài khoản</label>
                                    <input value="${detail.username}" name="username" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Vai trò</label>
                                    <div class="role-form">
                                        <div class="role-check">
                                            <input class="form-check-input" type="radio" name="role" id="roleAdmin" value="admin">
                                            <label class="form-check-label" for="roleAdmin">Admin</label>
                                        </div>
                                        <div class="role-check">
                                            <input class="form-check-input" type="radio" name="role" id="roleStaff" value="staff">
                                            <label class="form-check-label" for="roleStaff">Staff</label>
                                        </div>
                                        <div class="role-check">
                                            <input class="form-check-input" type="radio" name="role" id="roleCus" value="customer">
                                            <label class="form-check-label" for="roleCus">Khách hàng</label>
                                        </div>
                                    </div>
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
