/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Accounts;
import model.Cart;
import model.CartItems;
import model.DailySale;
import model.Order;
import model.ProductDistribution;
import model.ProductRevenue;
import model.Revenue;

/**
 *
 * @author Admin
 */
public class OrderDAO extends DBContext {

    private static String INSERT_ORDER = "INSERT INTO [Orders]\n"
            + "           ([Account_Id]\n"
            + "           ,[Date]\n"
            + "           ,[Total]\n"
            + ", Status, name, phone, address)\n"
            + "     VALUES\n"
            + "           (?\n"
            + "           ,GETDATE()\n"
            + "           ,?\n"
            + ",'PENDING', ?, ?, ?)";

    private static String INSERT_ORDER_DETAIL = "INSERT INTO .[OrderDetail]\n"
            + "           ([OrderId]\n"
            + "           ,[ProductId]\n"
            + "           ,[Price]\n"
            + "           ,[Quantity])\n"
            + "     VALUES\n"
            + "           (?\n"
            + "           ,?\n"
            + "           ,?\n"
            + "           ,?)";

    public void insertOrder(Accounts u, Cart cart, String name, String phone, String address) throws ClassNotFoundException, SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = INSERT_ORDER;
            ps = connection.prepareStatement(sql);
            ps.setInt(1, u.getId());
            ps.setBigDecimal(2, cart.getTotalPrice());
            ps.setString(3, name);
            ps.setString(4, phone);
            ps.setString(5, address);

            ps.executeUpdate();
            String sql1 = "select top 1 [Id] from [Orders] order by [Id] desc";
            ps = connection.prepareStatement(sql1);
            rs = ps.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt(1);
                for (CartItems item : cart.getItems()) {
                    String sql2 = INSERT_ORDER_DETAIL;
                    ps = connection.prepareStatement(sql2);
                    ps.setInt(1, oid);
                    ps.setInt(2, item.getProductId());
                    ps.setBigDecimal(3, item.getPrice());
                    ps.setInt(4, item.getQuantity());
                    ps.executeUpdate();
                }
            }

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.Id, o.Account_Id, o.Date, o.Total, o.Status, a.Mail, o.Name, o.Phone, o.Address "
                + "FROM Orders o "
                + "JOIN Accounts a ON o.Account_Id = a.Id "
                + "ORDER BY o.Id ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("Id"));
                order.setEmail(rs.getString("Mail"));
                order.setOrderDate(rs.getString("Date"));
                order.setTotal(rs.getString("Total"));
                order.setStatus(rs.getString("Status"));
                order.setName(rs.getString("Name"));
                order.setPhone(rs.getString("Phone"));
                order.setAddress(rs.getString("Address"));

                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public void UpdateOrderStatus(String id, String status) {
        String sql = "UPDATE [Orders]\n"
                + "   SET [Status] = ?\n"
                + " WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(2, id);
            ps.setString(1, status);

            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public List<Revenue> getRevenueByDay() {

        List<Revenue> list = new ArrayList<>();

        String sql = "SELECT \n"
                + "    date,\n"
                + "    SUM(Total) AS TotalRevenue\n"
                + "FROM \n"
                + "    [Orders]\n"
                + "WHERE [Status] = 'CLOSE'\n"
                + "GROUP BY \n"
                + "    date\n"
                + "ORDER BY \n"
                + "    date;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Revenue(rs.getString("date"), rs.getDouble("TotalRevenue")));
            }

            ps.executeUpdate();
        } catch (Exception e) {
        }

        return list;
    }

    public List<ProductRevenue> getTop10BestSellingProducts() {
        List<ProductRevenue> list = new ArrayList<>();

        String sql = "SELECT TOP 10 P.name  as name, SUM(O.Quantity) AS TotalSold "
                + "FROM OrderDetail O "
                + "JOIN Products P ON O.ProductId = P.product_id "
                + "GROUP BY P.name "
                + "ORDER BY TotalSold DESC;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ProductRevenue(
                        rs.getString("name"), // Lấy tên sản phẩm
                        rs.getInt("TotalSold")
                ));
            }

            ps.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductRevenue> getTop5LeastSellingProducts() {
        List<ProductRevenue> list = new ArrayList<>();

        String sql = "WITH ProductSales AS (\n"
                + "    SELECT P.name AS name, SUM(O.Quantity) AS TotalSold\n"
                + "    FROM OrderDetail O \n"
                + "    JOIN Products P ON O.ProductId = P.product_id \n"
                + "    GROUP BY P.name\n"
                + ")\n"
                + "SELECT name, TotalSold\n"
                + "FROM ProductSales\n"
                + "WHERE TotalSold = (SELECT MIN(TotalSold) FROM ProductSales);";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new ProductRevenue(
                        rs.getString("name"), // Lấy tên sản phẩm
                        rs.getInt("TotalSold")
                ));
            }

            ps.close();
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProfit() {
        String sql = "SELECT SUM(Total) FROM [Orders]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalCustomer() {
        String sql = "SELECT COUNT(DISTINCT Account_Id) FROM [Orders];";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getTotalProduct() {
        String sql = "SELECT SUM(OD.Quantity) AS TotalBowlsSold\n"
                + "FROM [RamenHut].[dbo].[OrderDetail] OD\n"
                + "JOIN [RamenHut].[dbo].[Orders] O ON OD.OrderId = O.Id\n"
                + "WHERE O.Status = 'CLOSE';";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getAvgProfit() {
        String sql = "SELECT \n"
                + "    SUM(OD.[Quantity] * OD.[Price]) AS TotalRevenue, \n"
                + "    COUNT(DISTINCT CONVERT(DATE, O.[Date])) AS DaysCount,\n"
                + "    CASE \n"
                + "        WHEN COUNT(DISTINCT CONVERT(DATE, O.[Date])) > 0 \n"
                + "        THEN SUM(OD.[Quantity] * OD.[Price]) / COUNT(DISTINCT CONVERT(DATE, O.[Date])) \n"
                + "        ELSE 0 \n"
                + "    END AS AvgRevenuePerDay\n"
                + "FROM [RamenHut].[dbo].[OrderDetail] OD\n"
                + "JOIN [RamenHut].[dbo].[Orders] O ON OD.[OrderId] = O.[Id]\n"
                + "WHERE O.[Status] = 'CLOSE'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("AvgRevenuePerDay");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Order> getOrderByPage(int page, int pageSize) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("Id"));
                order.setEmail(rs.getString("Mail"));
                order.setOrderDate(rs.getString("Date"));
                order.setTotal(rs.getString("Total"));
                order.setStatus(rs.getString("Status"));
                order.setName(rs.getString("Name"));
                order.setPhone(rs.getString("Phone"));
                order.setAddress(rs.getString("Address"));

                orders.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orders;
    }

    public List<DailySale> getDailySales() {
        List<DailySale> list = new ArrayList<>();
        String sql = "SELECT\n"
                + "    CONVERT(DATE, O.[Date]) AS SaleDate, \n"
                + "    SUM(OD.[Quantity]) AS TotalBowls\n"
                + "FROM [RamenHut].[dbo].[OrderDetail] OD\n"
                + "JOIN [RamenHut].[dbo].[Orders] O ON OD.[OrderId] = O.[Id]\n"
                + "WHERE O.[Status] = 'CLOSE'\n"
                + "GROUP BY CONVERT(DATE, O.[Date])\n"
                + "ORDER BY SaleDate ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new DailySale(
                        rs.getDate("SaleDate"),
                        rs.getInt("TotalBowls")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ProductDistribution> getProductDistribution() {
        List<ProductDistribution> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    P.[Category] AS RamenType, \n"
                + "    SUM(OD.[Quantity]) AS TotalSold\n"
                + "FROM [RamenHut].[dbo].[OrderDetail] OD\n"
                + "JOIN [RamenHut].[dbo].[Products] P ON OD.[ProductId] = P.[Product_Id]\n"
                + "JOIN [RamenHut].[dbo].[Orders] O ON OD.[OrderId] = O.[Id]\n"
                + "WHERE P.[Category] IN ('Miso', 'Shoyu', 'Tonkotsu', 'Special') \n"
                + "AND O.[Status] = 'CLOSE'\n"
                + "GROUP BY P.[Category];";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductDistribution(
                        rs.getString("RamenType"),
                        rs.getInt("TotalSold")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
