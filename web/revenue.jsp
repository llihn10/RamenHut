<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN"/>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê - Ramen Hut</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-brands/css/uicons-brands.css'>
        <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-straight/css/uicons-regular-straight.css'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

            .stat-info {
                margin-left: 30px;
            }

            .stat-div {
                display: flex;
                gap: 10px;
            }

            .stat-div {
                font-size: 20px;
                font-weight: 500;
            }

            #myChart {
                width: 500px; /* Đặt chiều rộng tối đa */
                height: 500px; /* Đặt chiều cao tối đa */
                margin: auto; /* Canh giữa */
            }
        </style>

    </head>
    <body>
        <div class="container">
            <div class="stat-info">
                <h2><b>Thống kê chung</b></h2>
                <div class="stat-div">
                    <p>Tổng số đơn hàng:</p>
                    <p>${totalOrder}</p>
                </div>
                <div class="stat-div">
                    <p>Số sản phẩm đã bán:</p>
                    <p>${totalProduct}</p>
                </div>
                <div class="stat-div">
                    <p>Tổng doanh thu:</p>
                    <p><fmt:formatNumber value="${totalProfit}" type="number" groupingUsed="true" pattern="#,###"/>₫</p>
                </div>
                <div class="stat-div">
                    <p>Trung bình doanh thu/ngày:</p>
                    <p><fmt:formatNumber value="${avgProfit}" type="number" groupingUsed="true" pattern="#,###"/>₫</p>
                </div>
                <div class="stat-div">
                    <p>Đã tiếp cận được:</p>
                    <p>${totalCustomer} khách hàng</p>
                </div>
            </div>


            <h2><b>Thống kê số sản phẩm đã bán theo ngày</b></h2>
            <canvas id="dailySalesChart"></canvas>

            <h2><b>Tỷ lệ sản phẩm đã bán theo phân loại</b></h2>
            <canvas id="myChart"></canvas>


            <h2><b>Top 10 sản phẩm bán chạy</b></h2>
            <canvas id="top10Chart"></canvas>

            <h2><b>Top sản phẩm ít phổ biến nhất</b></h2>
            <canvas id="top5Chart"></canvas>



            <h2><b>Doanh thu theo ngày</b></h2>

            <table>
                <thead>
                    <tr>
                        <th>Ngày</th>
                        <th>Doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dùng JSTL để hiển thị danh sách sản phẩm -->
                    <c:forEach var="o" items="${r}">
                        <tr>
                            <td>${o.orderDate}</td>
                            <td><fmt:formatNumber value="${o.total}" type="number" groupingUsed="true" pattern="#,###"/>₫</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>


        <a href="home">
            <button class="btn-home">Quay lại trang chủ</button>
        </a>



    </body>
    <script>
        // Lấy dữ liệu từ JSP và chuyển sang JS
        var productNames = [];
        var productSales = [];

        <c:forEach var="p" items="${list}">
        productNames.push("${p.productName}");
        productSales.push(${p.totalSold});
        </c:forEach>

        // Top 10 best seller
        var ctx = document.getElementById("top10Chart").getContext("2d");
        new Chart(ctx, {
            type: "bar",
            data: {
                labels: productNames, // Tên sản phẩm
                datasets: [{
                        label: "Số lượng bán",
                        data: productSales, // Số lượng bán
                        backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56", "#4CAF50", "#8E44AD", "#ff8708", "#94d1f1", "#ff4646", "#1f6822", "#c03fd1"],
                        borderColor: "#333",
                        borderWidth: 1
                    }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // Top 5 least sell
        var productNames1 = [];
        var productSales1 = [];
        <c:forEach var="p" items="${list1}">
        productNames1.push("${p.productName}");
        productSales1.push(${p.totalSold});
        </c:forEach>

        var backgroundColors = "rgba(54, 162, 235, 0.8)"; // Màu xanh dương
        var ctx = document.getElementById("top5Chart").getContext("2d");
        new Chart(ctx, {
            type: "bar",
            data: {
                labels: productNames1,
                datasets: [{
                        label: "Số lượng bán",
                        data: productSales1,
                        backgroundColor: backgroundColors,
                        borderColor: "#333",
                        borderWidth: 1
                    }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });


        // total product by day
        var saleDate = [];
        var totalProduct = [];
        <c:forEach var="sale" items="${list2}">
        saleDate.push("${sale.saleDate}"); // Ngày bán
        totalProduct.push(${sale.totalBowls}); // Số tô bán
        </c:forEach>
        // Vẽ biểu đồ Line Chart số tô ramen bán theo ngày
        var ctx = document.getElementById("dailySalesChart").getContext("2d");
        new Chart(ctx, {
            type: "line",
            data: {
                labels: saleDate, // Gán danh sách ngày bán
                datasets: [{
                        label: "Số tô bán theo ngày",
                        data: totalProduct, // Gán danh sách số tô bán
                        borderColor: "rgba(54, 162, 235, 1)",
                        backgroundColor: "rgba(54, 162, 235, 0.2)",
                        borderWidth: 2,
                        fill: true
                    }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {display: true}
                },
                scales: {
                    y: {beginAtZero: true}
                }
            }
        });

        // category distribution
        var ramenCategories = [];
        var ramenSales = [];
        var totalProduct = Number("${totalProduct}");

        var barColors = ["#FF6384", "#36A2EB", "#FFCE56", "#4CAF50"]; // Màu sắc cho từng loại

        <c:forEach var="sale" items="${list3}">
        ramenCategories.push("${sale.ramenType}"); // Loại ramen
        ramenSales.push(${sale.totalSold}); // Số lượng bán
        </c:forEach>

        var ramenPercentage = ramenSales.map(value => ((value / totalProduct) * 100).toFixed(2));

        new Chart("myChart", {
            type: "pie",
            data: {
                labels: ramenCategories, // Gán danh sách loại ramen
                datasets: [{
                        backgroundColor: barColors, // Màu cho từng loại ramen
                        data: ramenSales // Gán số lượng bán theo loại
                    }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {display: true},
                    title: {
                        display: true,
                        text: "Tỷ lệ sản phẩm đã bán theo phân loại"
                    },
                    tooltip: {
                        callbacks: {
                            label: function (tooltipItem) {
                                let index = tooltipItem.dataIndex;
                                return ramenCategories[index] + ": " + ramenPercentage[index] + "%";
                            }
                        }
                    }
                }
            }
        });



    </script>

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
