package model;

import java.math.BigDecimal;

public class Products {  
    private int product_id;
    private String name;
    private String description;
    private String ingredient;
    private BigDecimal price;
    private String category;
    private String imageUrl;

    public Products() {
    }

    public Products(int product_id, String name, String description, String ingredient, BigDecimal price, String category, String imageUrl) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.ingredient = ingredient;
        this.price = price;
        this.category = category;
        this.imageUrl = imageUrl;
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getIngredient() {
        return ingredient;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public String getCategory() {
        return category;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
}
