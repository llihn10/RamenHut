/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ProductDistribution {
    private String ramenType;
    private int totalSold;

    public ProductDistribution() {
    }

    public ProductDistribution(String ramenType, int totalSold) {
        this.ramenType = ramenType;
        this.totalSold = totalSold;
    }

    public String getRamenType() {
        return ramenType;
    }

    public void setRamenType(String ramenType) {
        this.ramenType = ramenType;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }
    
    
}
