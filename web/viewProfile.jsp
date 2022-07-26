<%-- 
    Document   : view profile for customer
    Author     : TanKX
--%>

<%
    String sessionName = (String) session.getAttribute("username");
    if (sessionName == null) {
        String redirectURL = "login.jsp";
        response.sendRedirect(redirectURL);
        return;
    }

    String pageName = "View Profile";
    request.setAttribute("pageName", pageName);
%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="da.AccountDA"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    String host = "jdbc:derby://localhost:1527/pet";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "Account";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement ustmt;
    
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>

<jsp:include page="include/header.jsp" /> 

<div class="main-container" id="container">

    <!--  BEGIN CONTENT AREA  -->
    <div id="content" class="main-content">
        <div class="layout-px-spacing">
            <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ?"; %>
            <% stmt = conn.prepareStatement(retrieveStr); %>
            <% String username = request.getParameter("username");%>
            <% stmt.setString(1, username); %>
            <% ResultSet rs = stmt.executeQuery();%>
            <% if (rs.next()) {%>
            <div class="page-header">
                <div class="title">
                    <h3><%=rs.getString("FIRSTNAME")%>'s Profile</h3>
                </div>
            </div>

            <div class="row layout-spacing">

                <!-- Content -->
                <div class="col-xl-4 col-lg-6 col-md-5 col-sm-12 layout-top-spacing">

                    <div class="user-profile layout-spacing">
                        <div class="widget-content widget-content-area">
                            <div class="d-flex justify-content-between">
                                <h3 class="">&nbsp;&nbsp;&nbsp;Info</h3>
                                <a><br>&nbsp;</a>
                            </div>

                            <div class="text-center user-info">
                                <img src="profileImage/<%=rs.getString("IMAGE")%>" alt="avatar" width="90px" height="90px">
                                    <p class=""><%=rs.getString("FIRSTNAME")%> <%=rs.getString("LASTNAME")%></p>
                            </div>
                            <div class="user-info-list">


                                <div class="">
                                    <ul class="contacts-block list-unstyled">
                                        <li class="contacts-block__item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                 class="feather feather-calendar">
                                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                                <line x1="3" y1="10" x2="21" y2="10"></line>
                                            </svg><%=rs.getString("DOB")%>
                                        </li>
                                        <li class="contacts-block__item">
                                            <a href="mailto:example@mail.com"><svg
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                    class="feather feather-mail">
                                                    <path
                                                        d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                                                    </path>
                                                    <polyline points="22,6 12,13 2,6"></polyline>
                                                </svg><%=rs.getString("EMAIL")%></a>
                                        </li>
                                        <li class="contacts-block__item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                 stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                 class="feather feather-phone">
                                                <path
                                                    d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z">
                                                </path>
                                            </svg> <%=rs.getString("PHONENUMBER")%>
                                        </li>
                                    </ul>
                                </div>
                                <% } else {%>
                                <div class="text-center user-info">
                                    <p class="">No user found.</p>
                                </div>
                                <% }%>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 col-lg-6 col-md-7 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h3 class="">Comments</h3>

                            <div class="bio-skill-box">

                                <div class="row">
                                    <%int c = 0;%>
                                    
                                    
                                    <% String str = "SELECT T.*, P.IMAGE, P.NAME, P.ID FROM TRANSACTIONS T, PRODUCT P WHERE T.PRODUCTID = P.ID AND P.Status = '1' AND RATING > 0 AND T.USERNAME = ?"; %>
                                    <% ustmt = conn.prepareStatement(str);%>
                                    <% ustmt.setString(1, username); %>
                                    <% ResultSet rss = ustmt.executeQuery(); %>
                                    <% while (rss.next()) {%>
                                    <div class="col-12 col-xl-6 col-lg-12 mb-xl-5 mb-5 ">
                                        <div class="d-flex b-skills">
                                            <div class="">
                                                <h5><a style="color: blue" href="viewItem.jsp?id=<%=rss.getString("PRODUCTID")%>"><img src="itemImage/<%=rss.getString("IMAGE")%>" height="50px" width="50px">&nbsp;&nbsp;<%=rss.getString("NAME")%></a></h5>
                                                <h6>Rating: <%for (int i = 0; i < (int) rss.getDouble("RATING"); i++) {%>
                                                    <img src="image/star.png" width="20px">
                                                    <%}%></h6>
                                                <%if (rss.getString("COMMENT") != null) {%>
                                                <br><h6><%=rss.getString("COMMENT")%></h6>
                                                    <img src="image/white.png" width="100%">
                                                <%}%>
                                                <%if (rss.getString("REPLYCOMMENT") != null) {%>
                                                <table class="table mb-4">
                                                    <thead>
                                                        <tr>
                                                            <td align="center"></td>
                                                        </tr>
                                                    </thead>
                                                </table>
                                                <h6 style="color: BLUE">SELLER REPLY:</h6><h6><%=rss.getString("REPLYCOMMENT")%></h6>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                    <% c = 1;}%>

                                    <%if(c==0) {%>
                                    This user has no feedback.
                                    <%}%>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
                                 

<jsp:include page="include/footer.jsp" /> 