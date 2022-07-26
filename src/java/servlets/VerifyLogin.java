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
public class VerifyLogin extends HttpServlet {

    private AccountDA accDA;
    private Account domainAccount;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check empty input fields
        if (username.equals("") || password.equals("")) {
            request.setAttribute("username", username);
            request.setAttribute("accountError", "Username or password is empty, please fill in the details.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        // Create da object
        accDA = new AccountDA();
        domainAccount = new Account();
        domainAccount.setUsername(username);
        domainAccount.setPassword(password);

        // Verify login details
        if (accDA.login(domainAccount) == 1) {
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
            String position = domainAccount.getPosition();
            request.setAttribute("position", "C");
            String image = domainAccount.getImage();
            request.setAttribute("image", image);
            String redirect = "customer";
            request.setAttribute("redirect", redirect);
            String status = domainAccount.getStatus();
            if (status.equals("1")) {
                request.getRequestDispatcher("include/session.jsp").forward(request, response);
            } else {
                request.setAttribute("accountError", "Account is banned.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("username", username);
            request.setAttribute("accountError", "Username or password is wrong.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
}
