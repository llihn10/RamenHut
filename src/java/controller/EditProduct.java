package controller;

import dal.RamenDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet(name="EditProduct", urlPatterns={"/edit"})
public class EditProduct extends HttpServlet {
   
    
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
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String ingredient = request.getParameter("ingredient");
        String category = request.getParameter("category");
        
        RamenDAO dao = new RamenDAO();
        dao.editProduct(id, name, description, ingredient, price, category, image);
        response.sendRedirect("manage-product");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
