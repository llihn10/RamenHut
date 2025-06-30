package controller;

import dal.RamenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Accounts;
import model.Cart;
import model.CartItems;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
        RamenDAO ramenDAO = new RamenDAO();
        HttpSession session = request.getSession();
        Accounts user = (Accounts) session.getAttribute("acc");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        String action = request.getParameter("action");

        // Lấy giỏ hàng từ database
        Cart cart = ramenDAO.getCartByUserId(userId);

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            ramenDAO.addToCart(userId, productId, 1);
        }

        else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));

            if (cart != null) {
                int cartId = cart.getCartId();
                ramenDAO.removeFromCart(cartId, productId);
                session.setAttribute("cart", cart); // Cập nhật lại cart trong session
            }
            
        }

        else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));

            if (cart != null) {
                int cartId = cart.getCartId();

                // 🛑 Đảm bảo số lượng không nhỏ hơn 1
                if (newQuantity < 1) {
                    newQuantity = 1;
                }

                ramenDAO.updateCartItem(cartId, productId, newQuantity);
            }
        }

        // 🟢 Cập nhật giỏ hàng trong session
        Cart updatedCart = ramenDAO.getCartByUserId(userId);
        session.setAttribute("cart", updatedCart);

        // 🟢 Redirect về cart1.jsp để cập nhật giỏ hàng đúng
        response.sendRedirect(request.getHeader("Referer"));
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
