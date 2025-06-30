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


@WebServlet(name="AddProduct", urlPatterns={"/add"})
public class AddProduct extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProduct</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProduct at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String ingredient = request.getParameter("ingredient");
        String category = request.getParameter("category");
        String ms = "";
        
        RamenDAO dao = new RamenDAO();
        
        if (dao.checkNameExist(name) == null) {
            dao.addProduct(name, image, price, description, ingredient, category);
            
        } else {
            session.setAttribute("ms", "Tên sản phẩm đã tồn tại!");
        }
//        request.getRequestDispatcher("manage-product").forward(request, response);
        response.sendRedirect("manage-product");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
