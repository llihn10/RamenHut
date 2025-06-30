package model;


public class Accounts {
    private int id;
    private String mail;
    private String username;
    private String password;
    private int isStaff;
    private int isAdmin;

    public Accounts() {
    }

    public Accounts(String mail, String username, String password, int isStaff, int isAdmin) {
        this.mail = mail;
        this.username = username;
        this.password = password;
        this.isStaff = isStaff;
        this.isAdmin = isAdmin;
    }

    public Accounts(int id, String mail, String username, String password, int isStaff, int isAdmin) {
        this.id = id;
        this.mail = mail;
        this.username = username;
        this.password = password;
        this.isStaff = isStaff;
        this.isAdmin = isAdmin;
    }

    public int getId() {
        return id;
    }

    public String getMail() {
        return mail;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public int getIsStaff() {
        return isStaff;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setIsStaff(int isStaff) {
        this.isStaff = isStaff;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }
    
    
}
