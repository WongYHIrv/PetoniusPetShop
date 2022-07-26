<%
    String firstName = (String)request.getAttribute("firstName");
    session.setAttribute("firstName", firstName);
    
    String lastName = (String)request.getAttribute("lastName");
    session.setAttribute("lastName", lastName);
    
    String email = (String)request.getAttribute("email");
    session.setAttribute("email", email);
    
    String phoneNumber = (String)request.getAttribute("phoneNumber");
    session.setAttribute("phoneNumber", phoneNumber);
    
    String redirectURL = "userProfileSetting.jsp";
    response.sendRedirect(redirectURL);
%> 