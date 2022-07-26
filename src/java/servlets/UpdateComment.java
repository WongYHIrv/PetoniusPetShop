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
import da.TransactionsDA;

/**
 *
 * @author IrvineWYH
 */
public class UpdateComment extends HttpServlet {

    private TransactionsDA transactionsDA;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String transactionID = request.getParameter("id");
        String comment = request.getParameter("comment");
        String rating = request.getParameter("rating");

        transactionsDA = new TransactionsDA();
        
        if (comment.equals("")) {
            transactionsDA.updateRating(Double.parseDouble(rating), Integer.parseInt(transactionID));
        } else {
            transactionsDA.updateComment(Double.parseDouble(rating), comment, Integer.parseInt(transactionID));
        }
        response.sendRedirect("itemStatus.jsp?status=DELIVERED");
    }

}
