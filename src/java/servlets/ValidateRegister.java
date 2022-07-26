/**
 *
 * @author VivianSSH
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
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class ValidateRegister extends HttpServlet {

    private AccountDA accDA;
    private Account domainAccount;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtain parameters from the client html page
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String stringDOB = request.getParameter("DOB");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Sticky form
        request.setAttribute("fname", firstName);
        request.setAttribute("lname", lastName);
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("DOB", stringDOB);
        request.setAttribute("phoneNumber", phoneNumber);

        // Check empty field
        int emptyField = 0;
        if (firstName.equals("")) {
            request.setAttribute("firstNameError", "First name is empty.");
            emptyField++;
        }
        if (lastName.equals("")) {
            request.setAttribute("lastNameError", "Last name is empty.");
            emptyField++;
        }
        if (username.equals("")) {
            request.setAttribute("usernameError", "Username is empty.");
            emptyField++;
        }
        if (email.equals("")) {
            request.setAttribute("emailError", "Email is empty.");
            emptyField++;
        }
        if (stringDOB.equals("")) {
            request.setAttribute("DOBError", "Date of birth is empty.");
            emptyField++;
        }
        if (phoneNumber.equals("")) {
            request.setAttribute("phoneNumberError", "Phone number is empty.");
            emptyField++;
        }
        if (password.equals("")) {
            request.setAttribute("passwordError", "Password is empty.");
            emptyField++;
        }
        if (confirmPassword.equals("")) {
            request.setAttribute("confirmPasswordError", "Confirm password is empty.");
            emptyField++;
        }
        if (emptyField > 0) {
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
        
        // Date converter
        DateTimeFormatter f = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate what = LocalDate.parse(stringDOB, f);
        Date dateDOB = Date.from(what.atStartOfDay(ZoneId.systemDefault()).toInstant());
        
        // Create da object
        accDA = new AccountDA();
        domainAccount = new Account();
        domainAccount.setFirstName(firstName);
        domainAccount.setLastName(lastName);
        domainAccount.setUsername(username);
        domainAccount.setEmail(email);
        domainAccount.setPhoneNumber(phoneNumber);
        domainAccount.setDateOfBirth(dateDOB);
        domainAccount.setPassword(password);
        
        // Error variables
        int errorCount = 0;
        String usernameError = "";
        String emailError = "";
        String DOBError = "";
        String phoneNumberError = "";
        String passwordError = "";

        // Detecting error for username
        if (accDA.retrieveUsername(domainAccount) == 1) {
            usernameError = "Username is taken.";
            errorCount++;
        }

        // Detecting error for email
        if (accDA.retrieveEmail(domainAccount) == 1) {
            emailError = "Email is taken.";
            errorCount++;
        }

        // Detecting error for phone
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

        // Detecting error for password
        if (!password.equals(confirmPassword)) {
            passwordError = "Password is not match with confirm password.";
            errorCount++;
        }

        // See if create successful or need to re enter data
        if (errorCount == 0) { // If no error add into database

            // Connect to database and add record
            accDA.addRecord(domainAccount);
            request.setAttribute("username", username);
            request.setAttribute("registerSuccess", "Register successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else { // If got error back to the register page.
            request.setAttribute("usernameError", usernameError);
            request.setAttribute("emailError", emailError);
            request.setAttribute("DOBError", DOBError);
            request.setAttribute("phoneNumberError", phoneNumberError);
            request.setAttribute("passwordError", passwordError);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
