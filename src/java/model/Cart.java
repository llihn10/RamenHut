/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Admin
 */
public class Cart {

    private int cartId;
    private int userId;
    private List<CartItems> items;

    public Cart() {
    }

    public Cart(int cartId, int userId, List<CartItems> items) {
        this.cartId = cartId;
        this.userId = userId;
        this.items = items;
    }

    public int getCartId() {
        return cartId;
    }

    public int getUserId() {
        return userId;
    }

    public List<CartItems> getItems() {
        return items;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setItems(List<CartItems> items) {
        this.items = items;
    }

    public BigDecimal getTotalPrice() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItems item : items) {
            total = total.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        return total;
    }

    public void removeItem(int productId) {
        if (items != null) {
            items.removeIf(item -> item.getProductId() == productId);
        }
    }
}
