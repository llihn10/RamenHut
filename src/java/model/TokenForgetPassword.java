package model;

import java.time.LocalDateTime;

public class TokenForgetPassword {

    private int id;
    private int accountId;
    private String token;
    private boolean isUsed;
    private LocalDateTime expiryTime;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int accountId, String token, boolean isUsed, LocalDateTime expiryTime) {
        this.accountId = accountId;
        this.token = token;
        this.isUsed = isUsed;
        this.expiryTime = expiryTime;
    }

    public TokenForgetPassword(int id, int accountId, String token, boolean isUsed, LocalDateTime expiryTime) {
        this.id = id;
        this.accountId = accountId;
        this.token = token;
        this.isUsed = isUsed;
        this.expiryTime = expiryTime;
    }

    public int getId() {
        return id;
    }

    public int getAccountId() {
        return accountId;
    }

    public String getToken() {
        return token;
    }

    public boolean isIsUsed() {
        return isUsed;
    }

    public LocalDateTime getExpiryTime() {
        return expiryTime;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    public void setExpiryTime(LocalDateTime expiryTime) {
        this.expiryTime = expiryTime;
    }

}
