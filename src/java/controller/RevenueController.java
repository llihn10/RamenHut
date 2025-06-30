package controller;

import dal.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.DailySale;
import model.ProductDistribution;
import model.ProductRevenue;
import model.Revenue;


public class RevenueController extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        OrderDAO d = new OrderDAO();

        List<Revenue> revenueList = d.getRevenueByDay();
        List<ProductRevenue> list = d.getTop10BestSellingProducts();
        List<ProductRevenue> list1 = d.getTop5LeastSellingProducts();
        int totalOrder = d.getTotalOrderCount();
        int totalProfit = d.getTotalProfit();
        int totalCustomer = d.getTotalCustomer();
        int totalProduct = d.getTotalProduct();
        int avgProfit = d.getAvgProfit();
        List<DailySale> list2 = d.getDailySales();
        List<ProductDistribution> list3 = d.getProductDistribution();

        request.setAttribute("r", revenueList);
        request.setAttribute("list", list);
        request.setAttribute("list1", list1);
        request.setAttribute("list2", list2);
        request.setAttribute("list3", list3);
        request.setAttribute("avgProfit", avgProfit);
        request.setAttribute("totalProduct", totalProduct);
        request.setAttribute("totalOrder", totalOrder);
        request.setAttribute("totalProfit", totalProfit);
        request.setAttribute("totalCustomer", totalCustomer);

        request.getRequestDispatcher("revenue.jsp").forward(request, response);
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
