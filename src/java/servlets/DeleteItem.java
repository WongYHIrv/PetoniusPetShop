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
public class DeleteItem extends HttpServlet {
    
    private ItemDA itemDA;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String itemID = request.getParameter("id");
        String itemName = request.getParameter("itemName");
        
        itemDA = new ItemDA();
        itemDA.deleteItem(Integer.parseInt(itemID));
        
        response.sendRedirect("manageItem.jsp?searchResult=&category=&status=itemDeleted&name="+itemName);
    }


}
