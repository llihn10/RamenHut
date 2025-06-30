/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Order {
    private int id;
    private Accounts user;
    private String total; 
    private String orderDate;
    private String status;
    private String email;
    private String name;
    private String phone;
    private String address;
    
    public Order() {
    }

    public Order(int id, Accounts user, String total, String orderDate, String status) {
        this.id = id;
        this.user = user;
        this.total = total;
        this.orderDate = orderDate;
        this.status = status;
    }

    public Order(int id, Accounts user, String total, String orderDate, String status, String email) {
        this.id = id;
        this.user = user;
        this.total = total;
        this.orderDate = orderDate;
        this.status = status;
        this.email = email;
    }

    public Order(int id, Accounts user, String total, String orderDate, String status, String email, String name, String phone, String address) {
        this.id = id;
        this.user = user;
        this.total = total;
        this.orderDate = orderDate;
        this.status = status;
        this.email = email;
        this.name = name;
        this.phone = phone;
        this.address = address;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    
    

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Accounts getUser() {
        return user;
    }

    public void setUser(Accounts user) {
        this.user = user;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
