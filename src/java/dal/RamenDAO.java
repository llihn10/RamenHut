package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItems;
import model.Products;

public class RamenDAO extends DBContext {

    public boolean deleteCartByUserId(int userId) {
        String sqlDeleteCartItems = "DELETE FROM Cart_Items WHERE cart_id IN (SELECT cart_id FROM Cart WHERE user_id = ?)";
        String sqlDeleteCart = "DELETE FROM Cart WHERE user_id = ?";

        try (PreparedStatement stm1 = connection.prepareStatement(sqlDeleteCartItems); PreparedStatement stm2 = connection.prepareStatement(sqlDeleteCart)) {

            // Xóa các mục trong Cart_Items trước
            stm1.setInt(1, userId);
            stm1.executeUpdate();

            // Xóa giỏ hàng trong Cart
            stm2.setInt(1, userId);
            int rowsAffected = stm2.executeUpdate();

            return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Products> getAllProduct() {
        String sql = "select * from Products";
        List<Products> list = new ArrayList<>();

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Products> getProduct(int offset, int limit) {
        String sql = "SELECT * FROM Products ORDER BY [product_id] OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<Products> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Products> getProductsByPage(int page, int pageSize) {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY product_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (page - 1) * pageSize);
            stm.setInt(2, pageSize);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM Products";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Products> getProductByCategory(String cid) {
        String sql = "SELECT * FROM Products";
        if (cid != null && !cid.isEmpty()) {
            sql += " WHERE category = ?";
        }

        List<Products> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (cid != null && !cid.isEmpty()) {
                ps.setString(1, cid);
            }

            System.out.println("🔵 Query: " + ps.toString()); // Debug SQL query

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return list;
    }

    public int getTotalProductCountByCategory(String category) {
        String sql;
        if (category == null || category.isEmpty()) {
            sql = "SELECT COUNT(*) FROM Products"; // Đếm tất cả sản phẩm nếu không lọc
        } else {
            sql = "SELECT COUNT(*) FROM Products WHERE category = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            if (category != null && !category.isEmpty()) {
                ps.setString(1, category);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return 0;
    }

    public Products getProductById(String id) {
        String sql = "select * from Products where product_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Products(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getBigDecimal(5),
                        rs.getString(6),
                        rs.getString(7));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Products> searchByName(String txt) {
        String sql = "SELECT * FROM Products WHERE [name] LIKE ? OR [ingredient] LIKE ? OR [description] LIKE ?";
        List<Products> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + txt + "%");
            ps.setString(2, "%" + txt + "%");
            ps.setString(3, "%" + txt + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return list;
    }

    public void deleteProductById(int id) {
        String sql = "DELETE FROM [Products] WHERE product_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addProduct(String name, String image, int price, String description, String ingredient, String category) {
        String sql = "INSERT INTO [Products] ([name], [description], [ingredient], [price], [category], [imageUrl])\n"
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, ingredient);
            ps.setInt(4, price);
            ps.setString(5, category);
            ps.setString(6, image);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void editProduct(int id, String name, String description, String ingredient, int price, String category, String image) {
        String sql = "UPDATE Products\n"
                + "SET [name] = ?, [description] = ?, [ingredient] = ?, [price] = ?, [category] = ?, [imageUrl] = ?\n"
                + "WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, ingredient);
            ps.setInt(4, price);
            ps.setString(5, category);
            ps.setString(6, image);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Cart getCartByUserId(int userId) {
        String sql = "SELECT c.cart_id, ci.product_id, p.name, p.price, p.imageUrl, p.description, ci.quantity "
                + "FROM Cart c "
                + "LEFT JOIN Cart_Items ci ON c.cart_id = ci.cart_id "
                + "LEFT JOIN Products p ON ci.product_id = p.product_id "
                + "WHERE c.user_id = ?";

        List<CartItems> items = new ArrayList<>();
        Cart cart = null;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try (ResultSet rs = stm.executeQuery()) {
                int cartId = -1;
                while (rs.next()) {
                    if (cartId == -1) {
                        cartId = rs.getInt("cart_id");
                    }

                    int productId = rs.getInt("product_id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    String imageUrl = rs.getString("imageUrl");
                    String description = rs.getString("description");
                    int quantity = rs.getInt("quantity");

                    if (productId != 0) {
                        items.add(new CartItems(cartId, productId, name, price, imageUrl, description, quantity));
                    }
                }

                if (cartId != -1) {
                    cart = new Cart(cartId, userId, items);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cart;
    }

    public void addToCart(int userId, int productId, int quantity) {
        String checkCartSql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        String insertCartSql = "INSERT INTO Cart (user_id) OUTPUT INSERTED.cart_id VALUES (?)"; // Dùng OUTPUT để lấy cart_id
        String insertCartItemSql = "INSERT INTO Cart_Items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        String updateCartItemSql = "UPDATE Cart_Items SET quantity = quantity + ? WHERE cart_id = ? AND product_id = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            int cartId = -1;
            // 1️⃣ Kiểm tra giỏ hàng có tồn tại chưa
            try (PreparedStatement checkCartStm = connection.prepareStatement(checkCartSql)) {
                checkCartStm.setInt(1, userId);
                try (ResultSet rs = checkCartStm.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("cart_id");
                    }
                }
            }

            // 2️⃣ Nếu chưa có giỏ hàng, tạo mới và lấy cart_id
            if (cartId == -1) {
                try (PreparedStatement insertCartStm = connection.prepareStatement(insertCartSql)) {
                    insertCartStm.setInt(1, userId);
                    try (ResultSet rs = insertCartStm.executeQuery()) {
                        if (rs.next()) {
                            cartId = rs.getInt(1); // Lấy giá trị cart_id từ OUTPUT INSERTED
                        } else {
                            throw new SQLException("Không thể lấy cart_id sau khi INSERT");
                        }
                    }
                }
            }

            // 3️⃣ Kiểm tra sản phẩm đã có trong giỏ hàng chưa
            try (PreparedStatement updateCartItemStm = connection.prepareStatement(updateCartItemSql)) {
                updateCartItemStm.setInt(1, quantity);
                updateCartItemStm.setInt(2, cartId);
                updateCartItemStm.setInt(3, productId);
                int rowsUpdated = updateCartItemStm.executeUpdate();

                if (rowsUpdated == 0) {
                    // Nếu chưa có thì thêm mới
                    try (PreparedStatement insertCartItemStm = connection.prepareStatement(insertCartItemSql)) {
                        insertCartItemStm.setInt(1, cartId);
                        insertCartItemStm.setInt(2, productId);
                        insertCartItemStm.setInt(3, quantity);
                        insertCartItemStm.executeUpdate();
                    }
                }
            }

            connection.commit(); // Xác nhận transaction
        } catch (SQLException e) {
            try {
                connection.rollback(); // Nếu lỗi thì rollback
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void removeFromCart(int cartId, int productId) {
        String sql = "DELETE FROM Cart_Items WHERE cart_id = ? AND product_id = ?";

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cartId);
            stm.setInt(2, productId);
            int rowsDeleted = stm.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("🔥 Xóa thành công sản phẩm ID: " + productId + " khỏi giỏ hàng " + cartId);
            } else {
                System.out.println("⚠ Không tìm thấy sản phẩm ID: " + productId + " trong giỏ hàng " + cartId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CartItems> getCartItems(int userId) {
        String sql = "SELECT c.cart_id, ci.product_id, p.name, p.price, p.imageUrl, p.description, ci.quantity "
                + "FROM Cart_Items ci "
                + "JOIN Cart c ON ci.cart_id = c.cart_id "
                + "JOIN Products p ON ci.product_id = p.product_id "
                + "WHERE c.user_id = ?";
        List<CartItems> cartItems = new ArrayList<>();

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    int cartId = rs.getInt("cart_id");
                    int productId = rs.getInt("product_id");
                    String name = rs.getString("name");
                    BigDecimal price = rs.getBigDecimal("price");
                    String imageUrl = rs.getString("imageUrl");
                    String description = rs.getString("description");
                    int quantity = rs.getInt("quantity");

                    cartItems.add(new CartItems(cartId, productId, name, price, imageUrl, description, quantity));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public void updateCartItem(int cartId, int productId, int newQuantity) {
        String sql = "UPDATE Cart_Items SET quantity = ? WHERE cart_id = ? AND product_id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, newQuantity);
            stm.setInt(2, cartId);
            stm.setInt(3, productId);
            int rowsUpdated = stm.executeUpdate();

            if (rowsUpdated == 0) {
                System.out.println("Không tìm thấy sản phẩm trong giỏ hàng để cập nhật.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Products> getLatestProduct() {
        String sql = "public List<Products> getAllProduct() {\n"
                + "        String sql = \"select * from Products\";\n"
                + "        List<Products> list = new ArrayList<>();\n"
                + "\n"
                + "        try {\n"
                + "            PreparedStatement stm = connection.prepareStatement(sql);\n"
                + "            ResultSet rs = stm.executeQuery();\n"
                + "            while (rs.next()) {\n"
                + "                int product_id = rs.getInt(\"product_id\");\n"
                + "                String name = rs.getString(\"name\");\n"
                + "                String description = rs.getString(\"description\");\n"
                + "                String ingredient = rs.getString(\"ingredient\");\n"
                + "                BigDecimal price = rs.getBigDecimal(\"price\");\n"
                + "                String category = rs.getString(\"category\");\n"
                + "                String imageUrl = rs.getString(\"imageUrl\");\n"
                + "\n"
                + "                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);\n"
                + "                list.add(p);\n"
                + "            }\n"
                + "        } catch (SQLException e) {\n"
                + "            System.out.println(e);\n"
                + "        }\n"
                + "        return list;\n"
                + "    }";
        List<Products> list = new ArrayList<>();

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String ingredient = rs.getString("ingredient");
                BigDecimal price = rs.getBigDecimal("price");
                String category = rs.getString("category");
                String imageUrl = rs.getString("imageUrl");

                Products p = new Products(product_id, name, description, ingredient, price, category, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Products> getSimilarProducts(String categoryId, String excludeProductId) {
        List<Products> list = new ArrayList<>();
        String query = "SELECT TOP 5 * FROM Products WHERE category = ? AND product_id <> ? ORDER BY NEWID()";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, categoryId);
            ps.setString(2, excludeProductId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Products(rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("ingredient"),
                        rs.getBigDecimal("price"),
                        rs.getString("category"),
                        rs.getString("imageUrl")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Products checkNameExist(String name) {
        String sql = "SELECT * FROM Products WHERE [name] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Products(rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("ingredient"),
                        rs.getBigDecimal("price"),
                        rs.getString("category"),
                        rs.getString("imageUrl"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

}
