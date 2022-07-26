<%
    session.invalidate(); 
    String redirectURL = "../login.jsp";
    response.sendRedirect(redirectURL);
%> 