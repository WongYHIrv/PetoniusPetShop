<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.io.*"%>

<%
    String username = (String)request.getAttribute("username");
    session.setAttribute("username", username);
    
    String firstName = (String)request.getAttribute("firstName");
    session.setAttribute("firstName", firstName);
    
    String lastName = (String)request.getAttribute("lastName");
    session.setAttribute("lastName", lastName);
    
    String email = (String)request.getAttribute("email");
    session.setAttribute("email", email);
    
    String phoneNumber = (String)request.getAttribute("phoneNumber");
    session.setAttribute("phoneNumber", phoneNumber);
    
    String dob = (String)request.getAttribute("dob");
    session.setAttribute("dob", dob);
    
    String position = (String)request.getAttribute("position");
    session.setAttribute("position", position);
    
    String image = (String)request.getAttribute("image");
    session.setAttribute("image", image);
    
    Date d = new Date();
    int year = d.getYear() + 1900;
    
    String redirect = (String)request.getAttribute("redirect");
    String redirectURL = "homepage.jsp";
    if (redirect.equals("admin")) {
        redirectURL = "dashboard.jsp?year="+year;
    } else {
        redirectURL = "homepage.jsp";
    }
    
    response.sendRedirect(redirectURL);
%> 