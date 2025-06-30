package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;
import utils.HashUtil;

public class AccountDAO extends DBContext {

    public Accounts login(String user, String pass) {
        String sql = "SELECT * FROM Accounts WHERE [username] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");
                String hashedInputPassword = HashUtil.hashPassword(pass); 
                
                if (hashedInputPassword.equals(storedHashedPassword)) { 
                    return new Accounts(rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getInt(5),
                            rs.getInt(6));
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    

    public Accounts checkMailExist(String mail) {
        String sql = "SELECT * FROM Accounts WHERE [mail] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, mail);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Accounts checkUsernameExist(String user) {
        String sql = "SELECT * FROM Accounts WHERE [username] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.trim());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getInt(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void signUp(String mail, String user, String pass) {
        String hashedPassword = HashUtil.hashPassword(pass); 
        String sql = "INSERT INTO [Accounts] ([mail], [username], [password], [isStaff], [isAdmin]) VALUES (?, ?, ?, 0, 0)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, mail);
            ps.setString(2, user);
            ps.setString(3, hashedPassword);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getTotalAccountCount() {
        String sql = "SELECT COUNT(*) FROM Accounts";
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

    public List<Accounts> getAccountsByPage(int page, int pageSize) {
        List<Accounts> list = new ArrayList<>();
        String sql = "SELECT * FROM Accounts ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String mail = rs.getString("mail");
                String username = rs.getString("username");
                String password = rs.getString("password");
                int isStaff = rs.getByte("isStaff");
                int isAdmin = rs.getByte("isAdmin");

                Accounts a = new Accounts(id, mail, username, password, isStaff, isAdmin);
                list.add(a);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean updateProfile(int id, String mail, String username) {
        String sql = "UPDATE Accounts SET mail = ?, username = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, mail);
            ps.setString(2, username);
            ps.setInt(3, id);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu có bản ghi được cập nhật
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Accounts getAccountByEmail(String email) {
        String sql = "SELECT * FROM [Accounts] WHERE mail = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getByte(5),
                        rs.getByte(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Accounts getAccountById(int id) {
        String sql = "SELECT * FROM [Accounts] WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Accounts(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getByte(5),
                        rs.getByte(6));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updatePassword(String email, String password) {
        String hashedPassword = HashUtil.hashPassword(password);
        String sql = "UPDATE [Accounts] SET [password] = ? WHERE [mail] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
             ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void editAccount(int id, String mail, String username, int isStaff, int isAdmin) {
        String sql = "UPDATE Accounts\n"
                + "SET [mail] = ?, [username] = ?, [isStaff] = ?, [isAdmin] = ?\n"
                + "WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, mail);
            ps.setString(2, username);
            ps.setInt(3, isStaff);
            ps.setInt(4, isAdmin);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void deleteAccountById(int id) {
        String sql = "DELETE FROM [Accounts] WHERE id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
