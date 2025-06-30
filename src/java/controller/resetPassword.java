package controller;

import dal.AccountDAO;
import dal.DAOTokenForget;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.TokenForgetPassword;

@WebServlet(name = "resetPassword", urlPatterns = {"/resetPassword"})
public class resetPassword extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet resetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        DAOTokenForget dao = new DAOTokenForget();
        HttpSession session = request.getSession();

        if (token != null) {
            TokenForgetPassword tokenForgetPassword = dao.getTokenPassword(token);
            resetPass rs = new resetPass();
            if (tokenForgetPassword == null) {
                request.setAttribute("ms", "Không hợp lệ!");
                request.getRequestDispatcher("email.jsp").forward(request, response);
                return;
            }
            if (tokenForgetPassword.isIsUsed()) {
                request.setAttribute("ms", "Đã được sử dụng!");
                request.getRequestDispatcher("email.jsp").forward(request, response);
                return;
            }
            if (rs.isExpireTime(tokenForgetPassword.getExpiryTime())) {
                request.setAttribute("ms", "Đã hết hạn!");
                request.getRequestDispatcher("email.jsp").forward(request, response);
                return;
            }
            AccountDAO accDAO = new AccountDAO();
            Accounts acc = accDAO.getAccountById(tokenForgetPassword.getAccountId());
            request.setAttribute("email", acc.getMail());
            session.setAttribute("token", tokenForgetPassword.getToken());
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        } else {
            request.getRequestDispatcher("email.jsp").forward(request, response);
        }
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String repass = request.getParameter("confirm-password");
        DAOTokenForget dao = new DAOTokenForget();
        AccountDAO accDAO = new AccountDAO();
        
        if (pass == null || repass == null || !pass.equals(repass)) {
            request.setAttribute("ms", "Mật khẩu không trùng nhau!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        
        else if (pass.trim().isEmpty() || pass.trim().isEmpty()) {
            request.setAttribute("ms", "Vui lòng nhập vào mật khẩu mới!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }
        
        
        HttpSession session = request.getSession();
        TokenForgetPassword tokenForgetPassword = new TokenForgetPassword();
        tokenForgetPassword.setToken((String)session.getAttribute("token"));
        tokenForgetPassword.setIsUsed(true);
        accDAO.updatePassword(email, pass);
        
        dao.updateStatus(tokenForgetPassword);

        response.sendRedirect("login.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
