<%-- 
    Document   : BANNED account management
    Author     : TanKX
--%>

<%
    String sessionName = (String) session.getAttribute("username");
    String sessionPosition = (String) session.getAttribute("position");
    if (sessionName == null) {
        String redirectURL = "adminLogin.jsp";
        response.sendRedirect(redirectURL);
        return;
    } else if (sessionPosition.equals("C")) {
        String redirectURL = "adminLogin.jsp";
        response.sendRedirect(redirectURL);
        return;
    } else if (sessionPosition.equals("M")) {
        String redirectURL = "dashboard.jsp";
        response.sendRedirect(redirectURL);
        return;
    }

    String pageName = "Manage Account";
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

            <div class="page-header">
                <div class="title">
                    <h3><%out.println(request.getAttribute("pageName"));%></h3>
                </div>
            </div>

            <div class="row layout-spacing">

                <!-- Content -->
                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <button class="btn btn-primary" onclick="window.location.href = 'manageAccount.jsp?searchResult=&bannedUser=&orderBy=firstname&sorting=ASC';">Manage Account</button>
                            <button class="btn btn-primary" onclick="window.location.href = 'manageBannedAccount.jsp?searchResult=&unbannedUser=&orderBy=firstname&sorting=ASC';">Unban Account</button>
                            <button class="btn btn-primary" onclick="window.location.href = 'manageRole.jsp?searchResult=&changedUser=&changedRole=&orderBy=firstname&sorting=ASC';">Manage Account Role</button>
                            <br>&nbsp;
                            <h3 class="">Banned table</h3>

                            <form method="get" action="manageBannedAccount.jsp">
                                <div class="input-group mb-4">
                                    <input type="text" id="searchResult" name="searchResult" value="<%=request.getParameter("searchResult")%>" class="form-control" placeholder="Search name, username and email here">
                                    <input type="hidden" name="unbannedUser" value="">
                                    <input type="hidden" name="orderBy" value="<%=request.getParameter("orderBy")%>">
                                    <input type="hidden" name="sorting" value="<%=request.getParameter("sorting")%>">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="button" onclick="ClearFields();">X</button>
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>

                            <% if (!request.getParameter("unbannedUser").equals("")) {%>
                            <h6 style="color: red"> <%=request.getParameter("unbannedUser")%> has been unbanned. </h6><br>
                            <% }%>
                            <div class="table-responsive">

                                <jsp:include page="include/bannedTable.jsp" /> 

                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 

<script>
    function ClearFields() {

        document.getElementById("searchResult").value = "";
    }
</script>