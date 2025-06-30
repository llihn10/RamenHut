package controller;

import dal.RamenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;


@WebServlet(name="CategoryServlet", urlPatterns={"/category"})
public class CategoryServlet extends HttpServlet {
   
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String cateID = request.getParameter("cid");
        String pageParam = request.getParameter("page");
        int pageSize = 7;
        int currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);

        RamenDAO dao = new RamenDAO();

        // Lấy danh sách sản phẩm đã lọc
        List<Products> filteredList = dao.getProductByCategory(cateID);

        int totalProducts = dao.getTotalProductCountByCategory(cateID);
        int totalPages = (totalProducts <= pageSize) ? 1 : (int) Math.ceil((double) totalProducts / pageSize);
        
        // Đảm bảo currentPage không vượt quá totalPages
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalProducts);

        // Cắt danh sách sản phẩm theo trang
        List<Products> paginatedList = filteredList.subList(startIndex, endIndex);

        // Đẩy dữ liệu lên JSP
        System.out.println("Total Products after filtering: " + totalProducts);
        System.out.println("Total Pages: " + totalPages);
        System.out.println("Current Page: " + currentPage);

        request.setAttribute("list", paginatedList);
        request.setAttribute("selectedCategory", cateID);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);
        request.getRequestDispatcher("product.jsp").forward(request, response);
        
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
