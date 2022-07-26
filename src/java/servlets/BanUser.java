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
import da.AccountDA;
import domain.Account;

/**
 *
 * @author tanKX
 */
public class BanUser extends HttpServlet {
    
    private AccountDA accDA;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String username = request.getParameter("username");
        String searchResult = request.getParameter("searchResult");
        
        accDA = new AccountDA();
        accDA.banUser(username);
        
        response.sendRedirect("manageAccount.jsp?searchResult="+searchResult+"&bannedUser="+username+"&orderBy=firstname&sorting=ASC");  
    }


}
