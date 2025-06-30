/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.time.LocalDateTime;
import java.util.Properties;
import java.util.UUID;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class resetPass {

    private final int LIMIT_MINS = 10;
    private final String from = "nblinggg10@gmail.com";
    private final String password = "mkry tztu tyko mdji";

    public String generateToken() {
        return UUID.randomUUID().toString();
    }

    public LocalDateTime expireDateTime() {
        return LocalDateTime.now().plusMinutes(LIMIT_MINS);
    }

    public boolean isExpireTime(LocalDateTime time) {
        return LocalDateTime.now().isAfter(time);
    }

    public boolean sendEmail(String to, String link, String name) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(from, password);
            }
        });

        try {
            MimeMessage ms = new MimeMessage(session);
            ms.addHeader("Content-type", "text/html; charset=UTF-8");
            ms.setFrom(new InternetAddress(from));
            ms.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            ms.setSubject("Đặt lại mật khẩu của bạn - Ramen Hut", "UTF-8");
            String content = "<h1>Hello " + name + "</h1>"
                    + "<p>Nhấn vào link dưới để đặt lại mật khẩu: "
                    + "<a href='" + link + "'>Nhấn vào đây</a></p>";
            ms.setContent(content, "text/html; charset=UTF-8");

            Transport.send(ms);
            System.out.println("Send successfully");
            return true;
        } catch (Exception e) {
            System.out.println("Send error: " + e.getMessage());
            return false;
        }
    }

}
