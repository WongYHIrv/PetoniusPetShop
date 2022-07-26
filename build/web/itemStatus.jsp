<%-- 
    Document   : itemStatus (view item status)
    Author     : AbigailSA
--%>

<%
    String sessionName = (String) session.getAttribute("username");
    if (sessionName == null) {
        String redirectURL = "login.jsp";
        response.sendRedirect(redirectURL);
        return;
    }
%>
<%
    String pageName = "Item Status";
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
    String tableName = "Transaction";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement tstmt;
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

            <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">

                <div class="bio layout-spacing ">
                    <div class="widget-content widget-content-area">
                        <div><h4 style="color: blue">Filter status here</h4></div><br>
                        <form method="get" action="itemStatus.jsp">
                            <div class="input-group mb-4">
                                <select id="status" name="status" class="form-control">
                                    <option value="">Select category here</option>
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

            <div class="row layout-spacing">
                <% int found = 0;%>
                <% String trackStr = "SELECT DISTINCT TRACKINGID, STATUS, ADDRESSLINE1, ADDRESSLINE2, STATE, CITY, ZIP, CONTACT, RECIPIENTNAME, DATEPURCHASED FROM TRANSACTIONS WHERE USERNAME = ? AND STATUS LIKE '%" + request.getParameter("status") + "%' ORDER BY DATEPURCHASED DESC"; %>
                <% tstmt = conn.prepareStatement(trackStr); %>
                <% tstmt.setString(1, sessionName); %>
                <% ResultSet rs = tstmt.executeQuery(); %>
                <%while (rs.next()) {%>
                <% found = 1;%>
                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <table width="100%"  class="table table-bordered mb-4">
                                <tr>
                                    <td width="15%"> <h5 style="color: blue">Date Ordered</h5></td>
                                    <td>
                                        <h5>
                                            <%=rs.getString("DATEPURCHASED")%>
                                        </h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="15%"> <h5 style="color: blue">Shipping address</h5></td>
                                    <td>
                                        <h5>
                                            <%=rs.getString("RECIPIENTNAME")%> | <%=rs.getString("CONTACT")%><br><br>
                                            <%=rs.getString("ADDRESSLINE1")%><br>
                                            <%=rs.getString("ADDRESSLINE2")%><br>
                                            <%=rs.getString("ZIP")%> <%=rs.getString("city")%> <%=rs.getString("STATE")%>
                                        </h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="15%"> <h5 style="color: blue">Tracking ID</h5></td>
                                    <td>
                                        <h5>
                                            <%=rs.getString("TRACKINGID")%>
                                        </h5>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="15%"> <h5 style="color: blue">Total</h5></td>
                                    <td>
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
                                        <h5>Price</h5>
                                    </td>
                                    <td align="center">
                                        <h5>Status</h5>
                                    </td>
                                </tr>
                                <% String str = "SELECT T.*, P.IMAGE, P.NAME FROM TRANSACTIONS T, PRODUCT P WHERE USERNAME = ? AND P.ID = T.PRODUCTID AND TRACKINGID = ?"; %>
                                <% stmt = conn.prepareStatement(str); %>
                                <% stmt.setString(1, sessionName); %>
                                <% stmt.setString(2, rs.getString("TRACKINGID")); %>
                                <% ResultSet rss = stmt.executeQuery(); %>

                                <%while (rss.next()) {%>
                                <tr>
                                    <td>
                                        <h6 style="color: blue">
                                            <a href="viewItem.jsp?id=<%=rss.getString("PRODUCTID")%>" style="color: blue">
                                                <img src="itemImage/<%=rss.getString("IMAGE")%>" width="50px" height="50px">
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
                                            <%String sf2 = String.format("RM %.2f", rss.getDouble("SUBTOTAL"));%>
                                            <%=sf2%>
                                        </h6>
                                    </td>
                                    <td align="center">
                                        <h6 style="color: blue">
                                            <%=rss.getString("STATUS")%>
                                        </h6>
                                    </td>
                                </tr>
                                <% if (rss.getDouble("RATING") == 0.0) {%>
                                <% if (rss.getString("STATUS").equals("DELIVERED")) {%>
                                <form action="UpdateComment" method="post">
                                    <tr>
                                        <td colspan="3">
                                            <h6>Feedback:</h6><br>
                                            <div class="form-group col-md-2">
                                                <label><h6>Rating: 1-5</h6></label>

                                                <input type="number" class="form-control" name="rating" min="1" max="5" onKeyPress="if (this.value.length == 1)
                                                            return false;" required>

                                            </div>
                                            <div class="form-group col-md-12">
                                                <label><h6>Comment:</h6></label>
                                                <input type="hidden" name="id" value="<%=rss.getString("ID")%>">
                                                <textarea class="form-control" maxlength="500" name="comment"  maxlength="500" rows="4" cols="100"></textarea>
                                                <br><input type="submit" class="btn btn-primary" value="Add Feedback">

                                            </div>
                                        </td>

                                    </tr>
                                </form>
                                <%}%><%}%>
                                <% if (rss.getString("COMMENT") != null) {%>
                                <tr>
                                    <td colspan="4"><h6>Rating: 
                                            <%for (int i = 0; i < (int) rss.getDouble("RATING"); i++) {%>
                                            <img src="image/star.png" width="20px">
                                            <%}%>
                                            <br><br><%=rss.getString("COMMENT")%></h6></td>
                                </tr>
                                <%} else if (rss.getDouble("RATING") != 0.0) {%>
                                <tr>
                                    <td colspan="4"><h6>Rating: <%for (int i = 0; i < (int) rss.getDouble("RATING"); i++) {%>
                                            <img src="image/star.png" width="20px">
                                            <%}%></h6></td>
                                </tr>
                                <%}%>
                                <%
                                    if (rss.getString("REPLYCOMMENT") != null) {
                                %>
                                <tr>
                                    <td colspan="4">
                                        <h6 style="color: BLUE">SELLER REPLY:</h6><h6><%=rss.getString("REPLYCOMMENT")%></h6>
                                    </td>
                                </tr>
                                <%}%>


                                <%}%>
                            </table>
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

        document.getElementById("status").value = "";
    }
</script>