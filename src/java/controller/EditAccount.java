package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="EditAccount", urlPatterns={"/edit-account"})
public class EditAccount extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String mail = request.getParameter("mail");
        String username = request.getParameter("username");
        String role = request.getParameter("role");
        int isStaff = 0;
        int isAdmin = 0;
        
        if (role.equals("admin")) {
            isStaff = 1;
            isAdmin = 1;
        } else if (role.equals("staff")) {
            isStaff = 1;
            isAdmin = 0;
        } else {
            isStaff = 0;
            isAdmin = 0;
        }
        
        AccountDAO dao = new AccountDAO();
        dao.editAccount(id, mail, username, isStaff, isAdmin);
        response.sendRedirect("manage-account");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
