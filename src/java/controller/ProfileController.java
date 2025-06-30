/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
import model.Accounts;
import org.apache.catalina.User;

/**
 *
 * @author Admin
 */
public class ProfileController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        AccountDAO d = new AccountDAO();
        HttpSession session = request.getSession();
        Accounts dto = (Accounts) session.getAttribute("acc");
        if (dto == null || dto.equals("")) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        Accounts user = null;
        try {
            user = d.getAccountById(dto.getId());
        } catch (Exception ex) {
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        String email = request.getParameter("email");
        String username = request.getParameter("username");

        AccountDAO d = new AccountDAO();

        HttpSession session = request.getSession();
        Accounts dto = (Accounts) session.getAttribute("acc");
        if (dto == null || dto.equals("")) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        if (username != null && !username.isEmpty()) {
            // Nếu username không thay đổi, không cần cập nhật
            if (username.equals(dto.getUsername())) {
                session.setAttribute("ms", "Bạn chưa thay đổi username!");
            } else if (d.checkUsernameExist(username) != null) {
                session.setAttribute("ms", "Username đã tồn tại, vui lòng chọn tên khác!");
            } else {
                // Cập nhật username
                d.updateProfile(dto.getId(), email, username);
                dto.setUsername(username); // Cập nhật session với username mới
                session.setAttribute("acc", dto);
                session.setAttribute("success", "Cập nhật username thành công!");
            }
        }

//        d.updateProfile(dto.getId(), email, username);
        response.sendRedirect("profile");

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
