package controller;

import dal.RamenDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Products;

@WebServlet(name = "ManageProductServlet", urlPatterns = {"/manage-product"})
public class ManageProductServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        RamenDAO dao = new RamenDAO();
//        List<Products> list = dao.getAllProduct();
//        
//        request.setAttribute("list", list);
//        request.getRequestDispatcher("manage-product.jsp").forward(request, response);

        RamenDAO dao = new RamenDAO();

        // Xác định số sản phẩm trên mỗi trang
        int pageSize = 10;

        // Lấy tham số "page" từ request (nếu không có thì mặc định là trang 1)
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam == null) ? 1 : Integer.parseInt(pageParam);

        // Lấy tổng số sản phẩm để tính tổng số trang
        int totalProducts = dao.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Lấy danh sách sản phẩm của trang hiện tại
        List<Products> list = dao.getProductsByPage(currentPage, pageSize);

        // Đặt dữ liệu vào request
        request.setAttribute("list", list);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("manage-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
