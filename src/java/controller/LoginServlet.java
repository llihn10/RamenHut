package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;


@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie arr[] = request.getCookies();
        for (Cookie o : arr) {
            if (o.getName().equals("userC")) {
                request.setAttribute("username", o.getValue());
            }
            if (o.getName().equals("passC")) {
                request.setAttribute("password", o.getValue());
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String remember = request.getParameter("remember");
        AccountDAO dao = new AccountDAO();
        Accounts a = dao.login(username, password);

        HttpSession session = request.getSession();

        if (a == null) {
            // Lưu thông báo lỗi vào Session
            session.setAttribute("ms", "Tài khoản hoặc mật khẩu sai!");

            response.sendRedirect("login.jsp");
        } else {
            session.setAttribute("acc", a);
            session.setAttribute("userId", a.getId()); // Lưu ID của user vào session
            session.setMaxInactiveInterval(1800);

            // luu account len cookie
            Cookie u = new Cookie("userC", username);
            Cookie p = new Cookie("passC", password);

            u.setMaxAge(604800);
            if (remember != null) {
                p.setMaxAge(604800);
            } else {
                p.setMaxAge(0);
            }

            // luu u va p len browser
            response.addCookie(u);
            response.addCookie(p);

            response.sendRedirect("home");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
