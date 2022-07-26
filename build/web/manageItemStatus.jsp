<%-- 
    Document   : itemStatus management (3 status)
    Author     : rexko
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

    String pageName = "Manage Status";
    request.setAttribute("pageName", pageName);
%>

<%
    String query = "";
    if (!request.getParameter("transactionid").equals("")) {
        query = "TRACKINGID = '" + request.getParameter("transactionid") + "'";
    } else {
        query = "STATUS LIKE '%" + request.getParameter("status") + "%' ";

    }
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
    String tableName = "Transaction";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement tstmt;
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
                            <div><h4 style="color: blue">Search transaction id or status here</h4></div><br>
                            <form method="get" action="manageItemStatus.jsp">
                                <div class="input-group mb-4">
                                    <input type="text" id="searchResult" name="transactionid" value="<%=request.getParameter("transactionid")%>" class="form-control" placeholder="Search transaction id here">
                                    <select id="category" name="status" class="form-control">
                                        <option value="">Select status</option>
                                        <option value="PACKAGING" <%if (request.getParameter("status").equals("PACKAGING")) {
                                                out.print("selected");
                                            }%>>PACKAGING</option>
                                        <option value="SHIPPING" <%if (request.getParameter("status").equals("SHIPPING")) {
                                                out.print("selected");
                                            }%>>SHIPPING</option>
                                        <option value="DELIVERED" <%if (request.getParameter("status").equals("DELIVERED")) {
                                                out.print("selected");
                                            }%>>DELIVERED</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="button" onclick="ClearFields();">X</button>
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


                <%int found = 0;%>
                <% String trackStr = "SELECT DISTINCT USERNAME, TRACKINGID, STATUS, ADDRESSLINE1, ADDRESSLINE2, STATE, CITY, ZIP, CONTACT, RECIPIENTNAME, DATEPURCHASED FROM TRANSACTIONS WHERE 1=1 AND (" + query + " ) ORDER BY DATEPURCHASED DESC"; %>
                <% tstmt = conn.prepareStatement(trackStr); %>
                <% ResultSet rs = tstmt.executeQuery(); %>
                <%while (rs.next()) {%>
                <%found = 1;%>

                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <table width="100%"  class="table table-bordered mb-4">
                                <tr>
                                    <td width="25%"><h5 style="color: blue">Order by</h5></td>
                                    <td><a href="viewProfile.jsp?username=<%=rs.getString("USERNAME")%>"><h5 style="color: blue"><%=rs.getString("USERNAME")%></h5></a></td>
                                </tr>
                                <tr>
                                    <td><h5 style="color: blue">Tracking ID</h5></td>
                                    <td><h5><%=rs.getString("TRACKINGID")%></h5></td>
                                </tr>
                                <tr>
                                    <td><h5 style="color: blue">Shipping address</h5></td>
                                    <td>
                                        <h5>
                                            <%=rs.getString("RECIPIENTNAME")%> | <%=rs.getString("CONTACT")%><br><br>
                                            <%=rs.getString("ADDRESSLINE1")%><br>
                                            <%=rs.getString("ADDRESSLINE2")%><br>
                                            <%=rs.getString("ZIP")%> <%=rs.getString("city")%> <%=rs.getString("STATE")%>
                                        </h5>
                                    </td>
                                </tr>

                            </table>
                            <table width="100%"  class="table table-bordered mb-4">
                                <tr>
                                    <td width="50%">
                                        <h5>Product Name</h5>
                                    </td>
                                    <td align="center">
                                        <h5>Quantity Ordered</h5>
                                    </td>
                                    <td align="center">
                                        <h5>Date Ordered</h5>
                                    </td>
                                    <td align="center">
                                        <h5>Status</h5>
                                    </td>
                                </tr>
                                <% String str = "SELECT T.*, P.IMAGE, P.NAME FROM TRANSACTIONS T, PRODUCT P WHERE P.ID = T.PRODUCTID  AND TRACKINGID = ? ORDER BY T.DATEPURCHASED DESC"; %>
                                <% stmt = conn.prepareStatement(str); %>
                                <% stmt.setString(1, rs.getString("TRACKINGID")); %>
                                <% ResultSet rss = stmt.executeQuery();%>
                                <%while (rss.next()) {%>

                                <tr>
                                    <td>
                                        <h6 style="color: blue">
                                            <a href="viewItem.jsp?id=<%=rss.getString("PRODUCTID")%>" style="color: blue">
                                                <img src="itemImage/<%=rss.getString("IMAGE")%>" width="75px">
                                                <%=rss.getString("NAME")%>
                                            </a>
                                        </h6>
                                    </td>
                                    <td align="center">
                                        <h6 style="color: blue">
                                            <%=rss.getString("QUANTITY")%>
                                        </h6>
                                    </td>
                                    <td align="center">
                                        <h6 style="color: blue">
                                            <%=rss.getString("DATEPURCHASED")%>
                                        </h6>
                                    </td>
                                    <td align="center">
                                        <h6 style="color: blue">
                                            <%=rss.getString("STATUS")%>
                                        </h6>
                                    </td>
                                </tr>



                                <%}%>   
                            </table>
                            <% if (rs.getString("STATUS").equals("PACKAGING")) {%>
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <form action="UpdateTransactionShipping" method="post">
                                            <input type="hidden" name="id" value="<%=rs.getString("TRACKINGID")%>">
                                            <input type="submit" class="btn btn-primary" value="Mark as Shipping"><br>&nbsp;
                                        </form>
                                    </td>
                                </tr>
                            </table>


                            <%} else if (rs.getString("STATUS").equals("SHIPPING")) {%>
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <form action="UpdateTransactionDelivered" method="post">
                                            <input type="hidden" name="id" value="<%=rs.getString("TRACKINGID")%>">
                                            <input type="submit" class="btn btn-primary" value="Mark as Delivered"><br>&nbsp;
                                        </form>
                                    </td>
                                </tr>
                            </table>


                            <%}%>
                        </div>
                    </div>
                </div>

                <%}%>
                <%if (found == 0) {%>
                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h5>No record found.<br>&nbsp;</h5>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 

<script>
    function ClearFields() {

        document.getElementById("searchResult").value = "";

        document.getElementById("category").selectedIndex = null;
    }
</script>