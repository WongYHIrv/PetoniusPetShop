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
import da.TransactionsDA;
import java.util.UUID;

/**
 *
 * @author IrvineWYH
 */
public class Transaction extends HttpServlet {

    private CartDA cartDA;
    private TransactionsDA transactionsDA;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        
        String recipientName = request.getParameter("recipientName");
        String recipientContact = request.getParameter("recipientContact");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String state = request.getParameter("state");
        String city = request.getParameter("city");
        String zipCode = request.getParameter("zipCode");

        String cardNumber = request.getParameter("cardNumber");
        String expMonth = request.getParameter("expMonth");
        String expYear = request.getParameter("expYear");
        String cvv = request.getParameter("cvv");

        int errorCount = 0;

        request.setAttribute("address1", address1);
        request.setAttribute("address2", address2);
        request.setAttribute("state", state);
        request.setAttribute("city", city);
        request.setAttribute("zipCode", zipCode);

        request.setAttribute("cardNumber", cardNumber);
        request.setAttribute("expMonth", expMonth);
        request.setAttribute("expYear", expYear);
        request.setAttribute("cvv", cvv);

        // Detecting error for phone
        if (recipientContact.charAt(0) != '0') {
            request.setAttribute("recipientContantError", "Invalid phone number");
            errorCount++;
        }
        if (recipientContact.length() < 10 || recipientContact.length() > 11) {
            request.setAttribute("recipientContantError", "Invalid phone number");
            errorCount++;
        }
        for (int i = 0; i < recipientContact.length(); i++) {
            if (recipientContact.charAt(i) < 48 || recipientContact.charAt(i) > 57) {
                request.setAttribute("recipientContantError", "Invalid phone number");
                errorCount++;
            }
        }
        if (!state.equals("Johor") && !state.equals("Kedah") && !state.equals("Kelantan") && !state.equals("Malacca") && !state.equals("Negeri Sembilan") && !state.equals("Pahang")
                && !state.equals("Penang") && !state.equals("Perak") && !state.equals("Perlis") && !state.equals("Sabah") && !state.equals("Sarawak") && !state.equals("Selangor")
                && !state.equals("Terengganu") && !state.equals("Kuala Lumpur") && !state.equals("Labuan") && !state.equals("Putrajaya")) {
            request.setAttribute("stateError", "State is not existed");
            errorCount++;
        }
        
        for (int i = 0; i < zipCode.length(); i++) {
            if (zipCode.charAt(i) < 48 || zipCode.charAt(i) > 57) {
                request.setAttribute("zipCodeError", "Invalid Zip Code");
                errorCount++;
            }
        }
        
        if (zipCode.length() < 5) {
            request.setAttribute("zipCodeError", "Invalid Zip Code");
            errorCount++;
        }
        
        if (cardNumber.length() < 19 || cardNumber.length() > 19) {
            request.setAttribute("cardNumberError", "Invalid Card Number");
            request.getRequestDispatcher("checkOut.jsp").forward(request, response);
            errorCount++;
        }
        
        for (int i = 0; i < 4; i++) {
            if (cardNumber.charAt(i) < 48 || cardNumber.charAt(i) > 57) {
                request.setAttribute("cardNumberError", "Invalid Card Number");
                errorCount++;
            }
        }
        
        for (int i = 5; i < 9; i++) {
            if (cardNumber.charAt(i) < 48 || cardNumber.charAt(i) > 57) {
                request.setAttribute("cardNumberError", "Invalid Card Number");
                errorCount++;
            }
        }
        
        for (int i = 10; i < 14; i++) {
            if (cardNumber.charAt(i) < 48 || cardNumber.charAt(i) > 57) {
                request.setAttribute("cardNumberError", "Invalid Card Number");
                errorCount++;
            }
        }
        
        for (int i = 15; i < 19; i++) {
            if (cardNumber.charAt(i) < 48 || cardNumber.charAt(i) > 57) {
                request.setAttribute("cardNumberError", "Invalid Card Number");
                errorCount++;
            }
        }
        
        if (cardNumber.charAt(4) != '-') {
            request.setAttribute("cardNumberError", "Invalid Card Number");
            errorCount++;
        }
        
        if (cardNumber.charAt(9) != '-') {
            request.setAttribute("cardNumberError", "Invalid Card Number");
            errorCount++;
        }
        
        if (cardNumber.charAt(14) != '-') {
            request.setAttribute("cardNumberError", "Invalid Card Number");
            errorCount++;
        }
        
        if (!expMonth.equals("January") && !expMonth.equals("February") && !expMonth.equals("March") && !expMonth.equals("May") && !expMonth.equals("June") &&
                !expMonth.equals("July") && !expMonth.equals("August") && !expMonth.equals("September") && !expMonth.equals("October") && !expMonth.equals("November") && !expMonth.equals("December")) {
            request.setAttribute("expMonthError", "Invalid Month");
            errorCount++;
        }
        
        if (Integer.parseInt(expYear) < 2022) {
            request.setAttribute("expYearError", "Card is expired");
            errorCount++;
        }
        
        if (Integer.parseInt(cvv) < 100 || Integer.parseInt(cvv) > 999) {
            request.setAttribute("cvvError", "Invalid CVV");
            errorCount++;
        }
        
        if (errorCount > 0) {
            request.getRequestDispatcher("checkOut.jsp").forward(request, response);
            return;
        }

        
        
        transactionsDA = new TransactionsDA();
        
        transactionsDA.addRecord(username, recipientName, recipientContact, address1, address2, state, city, zipCode, cardNumber, expYear, expMonth, cvv, UUID.randomUUID().toString().replace("-", ""));
        response.sendRedirect("itemStatus.jsp?status=PACKAGING");

    }

}
