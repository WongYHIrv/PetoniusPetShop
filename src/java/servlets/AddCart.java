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
import da.CartDA;

/**
 *
 * @author Vivian
 */
public class AddCart extends HttpServlet {
    
    private CartDA cartDA;
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        
        cartDA = new CartDA();
        
        if (cartDA.findDuplicate(username, Integer.parseInt(id)) == 1) {
            
        } else {
            cartDA.addRecord(username, Integer.parseInt(id), 1);
        }

        response.sendRedirect("shop.jsp?searchResult=&category=");

    }


}
