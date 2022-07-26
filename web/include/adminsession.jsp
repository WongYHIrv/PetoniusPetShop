<%
    String username = (String)request.getAttribute("username");
    session.setAttribute("session", username);
    String manager = (String)request.getAttribute("manager");
    session.setAttribute("manager", manager);
    String admin = (String)request.getAttribute("admin");
    session.setAttribute("admin", admin);
    String redirectURL = "homepage.jsp";
    response.sendRedirect(redirectURL);
%> 