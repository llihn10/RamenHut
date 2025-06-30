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
import java.time.LocalDateTime;
import model.Accounts;
import model.TokenForgetPassword;


@WebServlet(name="email", urlPatterns={"/email"})
public class email extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet email</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet email at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("email.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        
        // check email co ton tai trong database khong
        AccountDAO dao = new AccountDAO();
        Accounts acc = dao.getAccountByEmail(email);
        if (acc == null) {
            request.setAttribute("ms", "Email không tồn tại!");
            request.getRequestDispatcher("email.jsp").forward(request, response);
            return;
        }
        resetPass rs = new resetPass();
        String token = rs.generateToken();
        String linkReset = "http://localhost:9999/ramenhut/resetPassword?token="+token;
        TokenForgetPassword newTokenForget = new TokenForgetPassword(acc.getId(), token, false, rs.expireDateTime());
    
        DAOTokenForget daoToken = new DAOTokenForget();
        boolean isInsert = daoToken.insertTokenForget(newTokenForget);
        if (!isInsert) {
            request.setAttribute("ms", "Lỗi server!");
            request.getRequestDispatcher("email.jsp").forward(request, response);
            return;
        }
        boolean isSend = rs.sendEmail(email, linkReset, acc.getUsername());
        if (!isSend) {
            request.setAttribute("ms", "Không thể gửi!");
            request.getRequestDispatcher("email.jsp").forward(request, response);
            return;
        }
        
        // validate
        
        request.setAttribute("ms", "Đã gửi mail thành công!");
        request.getRequestDispatcher("email.jsp").forward(request, response);
    
    
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
