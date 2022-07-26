<%-- 
    Document   : sales record listing
    Author     : AbigailSA
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
    }

    String pageName = "Sales Record";
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
    PreparedStatement pstmt;
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
                            <form method="get" action="salesRecord.jsp">
                                <div class="input-group mb-4">
                                    <input type="hidden" name="criteria" value="">
                                    <input type="text" id="searchResult" name="searchResult" value="<%=request.getParameter("searchResult")%>" class="form-control" placeholder="Search name, username, tracking id here">
                                    <input type="hidden" name="orderBy" value="<%=request.getParameter("orderBy")%>">
                                    <input type="hidden" name="sorting" value="<%=request.getParameter("sorting")%>">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="button" onclick="ClearFields();">X</button>
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <table width="100%"  class="table table-bordered mb-4">
                                <tr>
                                    <td align="center" width="5%" >
                                        <h5 style="color: blue">No.</h5>
                                    </td>
                                    <td>
                                        <h5 style="color: blue">
                                            Name
                                            <% if (request.getParameter("orderBy").equals("firstname") && request.getParameter("sorting").equals("ASC")) {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=firstname&sorting=DESC">
                                                <img src="image/down.png" width="10px" height="10px">
                                            </a>
                                            <%} else {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=firstname&sorting=ASC">
                                                <img src="image/top.png" width="10px" height="10px">
                                            </a>
                                            <%}%>
                                        </h5>
                                    </td>
                                    <td width="25%">
                                        <h5 style="color: blue">
                                            Tracking ID
                                            <% if (request.getParameter("orderBy").equals("trackingid") && request.getParameter("sorting").equals("ASC")) {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=trackingid&sorting=DESC">
                                                <img src="image/down.png" width="10px" height="10px">
                                            </a>
                                            <%} else {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=trackingid&sorting=ASC">
                                                <img src="image/top.png" width="10px" height="10px">
                                            </a>
                                            <%}%>
                                        </h5>
                                    </td>
                                    <td align="center" width="15%">
                                        <h5 style="color: blue">
                                            Date Purchased
                                            <% if (request.getParameter("orderBy").equals("datepurchased") && request.getParameter("sorting").equals("ASC")) {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=datepurchased&sorting=DESC">
                                                <img src="image/down.png" width="10px" height="10px">
                                            </a>
                                            <%} else {%>
                                            <a href="salesRecord.jsp?&searchResult=<%=request.getParameter("searchResult")%>&orderBy=datepurchased&sorting=ASC">
                                                <img src="image/top.png" width="10px" height="10px">
                                            </a>
                                            <%}%>
                                        </h5>
                                    </td>
                                    <td align="center" width="15%">
                                        <h5 style="color: blue">Total</h5>
                                    </td>
                                    <td align="center" width="15%">
                                        <h5 style="color: blue">Status</h5>
                                    </td>
                                </tr>
                                <% int i = 0; %>
                                <% String trackStr = "SELECT DISTINCT A.IMAGE, A.FIRSTNAME, A.LASTNAME, T.USERNAME, T.TRACKINGID, T.DATEPURCHASED, T.STATUS FROM TRANSACTIONS T,"
                                            + " ACCOUNT A WHERE T.USERNAME = A.USERNAME "
                                            + "AND (UPPER(A.FIRSTNAME) LIKE ? OR UPPER(A.LASTNAME) LIKE ? OR UPPER(T.USERNAME) LIKE ? OR UPPER(T.TRACKINGID) = ?) ORDER BY " + request.getParameter("orderBy") + " " + request.getParameter("sorting"); %>
                                <% stmt = conn.prepareStatement(trackStr); %>
                                <% stmt.setString(1, "%" + request.getParameter("searchResult").toUpperCase() + "%"); %>
                                <% stmt.setString(2, "%" + request.getParameter("searchResult").toUpperCase() + "%"); %>
                                <% stmt.setString(3, "%" + request.getParameter("searchResult").toUpperCase() + "%"); %>
                                <% stmt.setString(4, request.getParameter("searchResult").toUpperCase()); %>
                                <% ResultSet rs = stmt.executeQuery();%>

                                <% while (rs.next()) {
                                        i++;%>

                                <tr>
                                    <td align="center">
                                        <h5><%=i%>.</h5>

                                    </td>
                                    <td>
                                        <h5>
                                            <a href="viewProfile.jsp?username=<%=rs.getString("USERNAME")%>" style="color: blue">
                                                <img src="profileImage/<%=rs.getString("IMAGE")%>" width="50px" height="50px">&nbsp;&nbsp;
                                                <%=rs.getString("FIRSTNAME")%> <%=rs.getString("LASTNAME")%>
                                            </a>
                                        </h5>
                                    </td>
                                    <td>
                                        <h5>
                                            <a href="manageItemStatus.jsp?transactionid=<%=rs.getString("TRACKINGID")%>&status=" style="color: blue">
                                                <%=rs.getString("TRACKINGID")%>
                                            </a>
                                        </h5>
                                    </td>
                                    <td align="center">
                                        <h5>
                                            <%=rs.getString("DATEPURCHASED")%>
                                        </h5>
                                    </td>
                                    <td align="center">
                                        <h5>
                                            <% String priceStr = "SELECT SUM(SUBTOTAL) AS TOTAL FROM TRANSACTIONS WHERE TRACKINGID = ?";%>
                                            <% pstmt = conn.prepareStatement(priceStr); %>
                                            <% pstmt.setString(1, rs.getString("TRACKINGID")); %>
                                            <% ResultSet rrs = pstmt.executeQuery(); %>
                                            <% if (rrs.next()) {%>
                                            <%
                                                String sf1 = String.format("RM %.2f", rrs.getDouble("TOTAL"));
                                            %>
                                            <%=sf1%>
                                            <%}%>
                                        </h5>
                                    </td>
                                    <td align="center">
                                        <h5>
                                            <%=rs.getString("STATUS")%>
                                        </h5>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
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