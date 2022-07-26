package Servlets;

import java.time.*;
import java.util.Date;
import java.io.*;
import java.sql.*;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class signUpUser extends HttpServlet {

    private Connection conn;
    private PreparedStatement pstmt;
    private String host = "jdbc:derby://localhost:1527/hackathondb";
    private String user = "nbuser";
    private String password = "nbuser";
    private int errorCount = 0;

    // Initialize variables
    @Override
    public void init() throws ServletException {
        initializeJdbc();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Obtain parameters from the client
        String id = request.getParameter("username");
        String pass = request.getParameter("password");
        String name = request.getParameter("name");
        String pass2 = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String area = request.getParameter("area");
        char status = 'A'; //approved
        char type = 'U'; //user
        
        InputStream inputStream = null;

        Part filePart = request.getPart("photo");
        
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

            if (pass == pass2 ) {
                out.println("Please fill out all the fields!");
                response.sendRedirect("signUpUser.jsp?error=Password is not the same!");
            }

            
                try {
                    signUpUser(id, pass, name, status, type, email, area, inputStream);
                    response.sendRedirect("login.jsp");
                } catch (SQLException ex) {
                    response.sendRedirect("signUpUser.jsp?error=Username taken!");
                }

        
}

private void initializeJdbc() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
            pstmt = conn.prepareStatement("INSERT INTO Account(ACCOUNTID, PASSWORD, NAME, STATUS, TYPE, EMAIL, AREA, PHOTO) VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private void signUpUser(String id, String pass, String name, char status, char type, String email, String area, InputStream photo) throws SQLException {
        pstmt.setString(1, id);
        pstmt.setString(2, pass);
        pstmt.setString(3, name);
        pstmt.setString(4, String.valueOf(status));
        pstmt.setString(5, String.valueOf(type));
        pstmt.setString(6, email);
        pstmt.setString(7, area);
        pstmt.setBlob(8, photo);
        pstmt.executeUpdate();
    }

    public boolean equals(Object obj) {
        return (this == obj);
    }
}
