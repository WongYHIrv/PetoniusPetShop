/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import da.ItemDA;

/**
 *
 * @author IrvineWYH
 */
public class UpdateItem extends HttpServlet {
    
    private ItemDA itemDA;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String itemName = request.getParameter("itemName");
        String itemCategory = request.getParameter("itemCategory");
        String itemPrice = request.getParameter("itemPrice");
        String itemQuantity = request.getParameter("itemQuantity");
        String itemDescription = request.getParameter("itemDescription");
        String itemID = request.getParameter("id");
        
        itemDA = new ItemDA();
        itemDA.updateItemDetails(itemName, itemCategory, Double.parseDouble(itemPrice), Integer.parseInt(itemQuantity), itemDescription, Integer.parseInt(itemID));
        
        
        response.sendRedirect("manageItem.jsp?searchResult=&category=&status=itemUpdated&name="+itemName);
    }


}
