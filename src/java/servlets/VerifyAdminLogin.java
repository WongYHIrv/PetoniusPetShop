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
 * @author Vivian
 */
public class VerifyAdminLogin extends HttpServlet {

    private AccountDA accDA;
    private Account domainAccount;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String position = request.getParameter("position");

        request.setAttribute("username", username);
        if (position.equals("M")) {
            request.setAttribute("positionManager", "checked");
        } else if (position.equals("A")) {
            request.setAttribute("positionAdmin", "checked");
        }
        
        if (username.equals("") || password.equals("") || position.equals("")) {
            request.setAttribute("accountError", "Username or password is empty, please fill in the details.");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }

        // Create da object
        accDA = new AccountDA();
        domainAccount = new Account();
        domainAccount.setUsername(username);
        domainAccount.setPassword(password);

        if (accDA.login(domainAccount) != 1) {
            request.setAttribute("accountError", "Username or password is wrong.");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
        
        if (accDA.login(domainAccount) == 1) {
            String role = accDA.getRole(username);
            request.setAttribute("username", username);
            String firstName = domainAccount.getFirstName();
            request.setAttribute("firstName", firstName);
            String lastName = domainAccount.getLastName();
            request.setAttribute("lastName", lastName);
            String email = domainAccount.getEmail();
            request.setAttribute("email", email);
            String phoneNumber = domainAccount.getPhoneNumber();
            request.setAttribute("phoneNumber", phoneNumber);
            String dob = domainAccount.getStringDate();
            request.setAttribute("dob", dob);
            String image = domainAccount.getImage();
            request.setAttribute("image", image);
            String redirect = "admin";
            request.setAttribute("redirect", redirect);
            String status = domainAccount.getStatus();
            
            if (status.equals("0")){
                request.setAttribute("accountError", "Account is banned.");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            }
            else if (role.equals("M") && position.equals("M")) {
                request.setAttribute("position", "M");
                request.getRequestDispatcher("include/session.jsp").forward(request, response);
            } else if (role.equals("A") && position.equals("M")) {
                request.setAttribute("position", "M");
                request.getRequestDispatcher("include/session.jsp").forward(request, response);
            } else if (role.equals("A") && position.equals("A")) {
                request.setAttribute("position", "A");
                request.getRequestDispatcher("include/session.jsp").forward(request, response);
            } else if (role.equals("M") && position.equals("A")) {
                request.setAttribute("accountError", "You do not have the permission.");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            } else {
                request.setAttribute("accountError", "Dear customer, please use the customer login <a href=login.jsp>here</a>.");
                request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
            }
        }

    }

}
