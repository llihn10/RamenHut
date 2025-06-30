/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class DailySale {
    private Date saleDate;
    private int totalBowls;

    public DailySale() {
    }

    public DailySale(Date saleDate, int totalBowls) {
        this.saleDate = saleDate;
        this.totalBowls = totalBowls;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public int getTotalBowls() {
        return totalBowls;
    }

    public void setTotalBowls(int totalBowls) {
        this.totalBowls = totalBowls;
    }
    
    
}
