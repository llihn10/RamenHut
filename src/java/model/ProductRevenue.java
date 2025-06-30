/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ProductRevenue {

    private String productName;
    private int totalSold;

    public ProductRevenue(String productName, int totalSold) {
        this.productName = productName;
        this.totalSold = totalSold;
    }

    public String getProductId() {
        return productName;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    
    
}
