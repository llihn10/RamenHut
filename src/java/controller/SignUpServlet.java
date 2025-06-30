/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import model.Accounts;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class SignUpServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String mail = request.getParameter("mail");
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");

        if (pass == null || repass == null || !pass.equals(repass)) {
            session.setAttribute("ms", "Mật khẩu không trùng nhau!");
            response.sendRedirect("signup.jsp");

        } else {
            AccountDAO dao = new AccountDAO();
            Accounts a = dao.checkMailExist(mail);
            Accounts b = dao.checkUsernameExist(user);

            if (a == null && b == null) {
                dao.signUp(mail, user, pass);
                Accounts acc = dao.login(user, pass);
                session.setAttribute("acc", acc);
                session.setMaxInactiveInterval(900);
                response.sendRedirect("home");
            } else if (a != null && b == null) {
                session.setAttribute("ms", "Mail đã tồn tại!");
                session.setAttribute("mailInput", mail);
                session.setAttribute("userInput", user);
                session.setAttribute("passInput", pass);
                session.setAttribute("repassInput", repass);
                response.sendRedirect("signup.jsp");
            } else if (a == null && b != null) {
                session.setAttribute("ms", "Tài khoản đã tồn tại! Vui lòng đăng nhập");
                session.setAttribute("mailInput", mail);
                session.setAttribute("userInput", user);
                session.setAttribute("passInput", pass);
                session.setAttribute("repassInput", repass);
                response.sendRedirect("signup.jsp");

            } else {
                if (a.getId() == b.getId()) {
                    session.setAttribute("ms", "Mail và tài khoản đã tồn tại! Vui lòng đăng nhập");
                    session.setAttribute("mailInput", mail);
                    session.setAttribute("userInput", user);
                    session.setAttribute("passInput", pass);
                    session.setAttribute("repassInput", repass);
                    response.sendRedirect("signup.jsp");
                } else {
                    session.setAttribute("ms", "Mail và tài khoản đã tồn tại!");
                    session.setAttribute("mailInput", mail);
                    session.setAttribute("userInput", user);
                    session.setAttribute("passInput", pass);
                    session.setAttribute("repassInput", repass);
                    response.sendRedirect("signup.jsp");
                }
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
