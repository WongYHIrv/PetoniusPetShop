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
 * @author rexko
 */
public class DeleteOneCart extends HttpServlet {

    private CartDA cartDA;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String location = request.getParameter("location");

        cartDA = new CartDA();
        cartDA.deleteOne(username, Integer.parseInt(id));
        
        if (location.equals("shop")) {
            response.sendRedirect("shop.jsp?searchResult=&category=");
        } else {
            response.sendRedirect("checkOut.jsp");
        }
        
    }

}
