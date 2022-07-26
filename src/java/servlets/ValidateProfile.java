/**
 *
 * @author rexko
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
import javax.servlet.http.HttpSession;

public class ValidateProfile extends HttpServlet {

    private AccountDA accDA;
    private Account domainAccount;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtain parameters from the client html page
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");

        HttpSession session = request.getSession();
        String username = (String)session.getAttribute("username");  
        
        
        
        // Check empty field
        int emptyField = 0;
        if (firstName.equals("")) {
            request.setAttribute("firstNameError", "First name cannot be empty.");
            emptyField++;
        }
        if (lastName.equals("")) {
            request.setAttribute("lastNameError", "Last name cannot be empty.");
            emptyField++;
        }
        if (email.equals("")) {
            request.setAttribute("emailError", "Email cannot be empty.");
            emptyField++;
        }
        if (phoneNumber.equals("")) {
            request.setAttribute("phoneNumberError", "Phone number cannot be empty.");
            emptyField++;
        }
        if (emptyField > 0) {
            request.getRequestDispatcher("userProfileSetting.jsp").forward(request, response);
        }

        // Create da object
        accDA = new AccountDA();
        domainAccount = new Account();
        domainAccount.setUsername(username);
        domainAccount.setFirstName(firstName);
        domainAccount.setLastName(lastName);
        domainAccount.setEmail(email);
        domainAccount.setPhoneNumber(phoneNumber);

        // Error variables
        int errorCount = 0;
        String emailError = "";
        String phoneNumberError = "";
        if (accDA.retrieveEmail(domainAccount) == 1) {
            if (accDA.retrieveEmailUser(domainAccount) != 1) {
                emailError = "Email is taken.";
                errorCount++;
            }
        }
        if (phoneNumber.charAt(0) != '0') {
            phoneNumberError = "Invalid phone number.";
            errorCount++;
        }
        if (phoneNumber.length() < 10 || phoneNumber.length() > 11) {
            phoneNumberError = "Invalid phone number.";
            errorCount++;
        }
        for (int i = 0; i < phoneNumber.length(); i++) {
            if (phoneNumber.charAt(i) < 48 || phoneNumber.charAt(i) > 57) {
                phoneNumberError = "Invalid phone number.";
                errorCount++;
            }
        }

        if (errorCount == 0) { // If no error add into database  
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);

            // Connect to database and update record
            accDA.updateProfile(domainAccount);
            request.getRequestDispatcher("include/updateProfileSession.jsp").forward(request, response);

        } else {
            request.setAttribute("emailError", emailError);
            request.setAttribute("phoneNumberError", phoneNumberError);
            request.getRequestDispatcher("userProfileSetting.jsp").forward(request, response);
        }

    }
}
