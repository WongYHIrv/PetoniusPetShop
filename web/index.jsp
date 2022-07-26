<%-- 
    Document   : index
    Author     : rexko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String redirectURL = "homepage.jsp";
            response.sendRedirect(redirectURL);
        %>
       
        <div id="">
        <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAjW8GELvqC45Wan3iKJDRoPoZiwVTFlNc&sensor=false"></script>
        <script src="script.js"></script>    
        
    </body>
</html>


