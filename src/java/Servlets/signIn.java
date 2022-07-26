package Servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Base64;

public class signIn extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String accountid = request.getParameter("username");
        String password = request.getParameter("pass");

        ResultSet rs = null;
        try {
            //loading drivers for mysql
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            //creating connection with the database
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/hackathondb", "nbuser", "nbuser");
            PreparedStatement ps = con.prepareStatement("select * from account where accountid=? and password=?");
            ps.setString(1, accountid);
            ps.setString(2, password);
            rs = ps.executeQuery();
            Blob photo = null;
            String base64Image = "";

            if (rs.next()) { 
                if(rs.getString("type").charAt(0) == 'U' && rs.getString("status").charAt(0) != 'B') {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("accountid", accountid);
                    httpSession.setAttribute("name", rs.getString("name"));
                    httpSession.setAttribute("email", rs.getString("email"));
                    httpSession.setAttribute("area", rs.getString("area"));
                     
                    photo = rs.getBlob("photo");

                    if (photo != null) {

                        InputStream inputStream = photo.getBinaryStream();

                        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        byte[] imageBytes = outputStream.toByteArray();
                        base64Image = Base64.getEncoder().encodeToString(imageBytes);

                        httpSession.setAttribute("photo", base64Image);
                    }
                    
                    response.sendRedirect("customer/home.jsp"); 
                }   
                
                else if(rs.getString("type").charAt(0) == 'V' && rs.getString("status").charAt(0) != 'B') {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("accountid", accountid);
                    httpSession.setAttribute("name", rs.getString("name"));
                    httpSession.setAttribute("email", rs.getString("email"));
                    httpSession.setAttribute("area", rs.getString("area"));
                    
                    response.sendRedirect("vendor/home.jsp"); 
                }
                
                else if(rs.getString("type").charAt(0) == 'A') {
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("accountid", accountid);
                    httpSession.setAttribute("name", rs.getString("name"));
                    httpSession.setAttribute("email", rs.getString("email"));
                    httpSession.setAttribute("area", rs.getString("area"));
                    
                    response.sendRedirect("admin/home.jsp"); 
                }
                
                else {
                    response.sendRedirect("login.jsp?error=Account banned!");
                }

            } else {
                out.println("Username or Password incorrect");
                response.sendRedirect("main/login.jsp?error=Invalid username or password!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
