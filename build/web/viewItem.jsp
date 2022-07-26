<%-- 
    Document   : View specifics of each item
    Author     : AbigailSA
--%>

<%
    String sessionName = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("position");
    if (sessionName == null) {
        String redirectURL = "login.jsp";
        response.sendRedirect(redirectURL);
        return;
    }
%>
<%
    String pageName = "Shop";
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
    String tableName = "Product";
    String tableName2 = "Cart";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement ustmt;
    PreparedStatement rstmt;
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
                    <h3>View Item</h3>
                </div>
            </div>

            <div class="row layout-spacing">

                <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE ID = ?"; %>
                <% stmt = conn.prepareStatement(retrieveStr); %>
                <% stmt.setInt(1, Integer.parseInt(request.getParameter("id"))); %>
                <% ResultSet rs = stmt.executeQuery();%>
                <% if (rs.next()) {%>
                <div class="col-xl-4 col-lg-6 col-md-5 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing">
                        <div class="widget-content widget-content-area">
                            <div class="d-flex justify-content-between">
                                <h3 class="">Item picture</h3>
                            </div>

                            <div class="text-center user-info">
                                <img style="border: 2px solid black" src="itemImage/<%=rs.getString("IMAGE")%>" id="blah" alt="avatar" width="270px" height="270px">
                                <br>&nbsp;
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col-xl-8 col-lg-6 col-md-7 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h3 class="">Information</h3>
                            <div class="info">
                                <div class="row">
                                    <table class="table table-bordered mb-4">
                                        <tr>
                                            <td width="25%">
                                                <h5 style="color: blue">Rating</h5>
                                            </td>
                                            <td>
                                                <% String ratingStr = "SELECT AVG(RATING) AS AVERAGE, COUNT(RATING) AS COUNTING FROM transactions WHERE PRODUCTID = ? AND RATING > 0"; %>
                                                <% rstmt = conn.prepareStatement(ratingStr); %>
                                                <% rstmt.setInt(1, Integer.parseInt(request.getParameter("id"))); %>
                                                <% ResultSet rsss = rstmt.executeQuery();%>
                                                <% if (rsss.next()) {%>
                                                <h5><%for (int i = 0; i < (int) rsss.getDouble("AVERAGE"); i++) {%>
                                                    <img src="image/star.png" width="20px">
                                                    <%}%>  &nbsp;(<%=rsss.getString("COUNTING")%> rated)</h5>
                                                <%}%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><h5 style="color: blue">Category</h5></td>
                                            <td>
                                                <h5>
                                                    <%
                                                        if (rs.getString("CATEGORY").equals("FOOD")) {
                                                            out.println("Food & Treats");
                                                        } else if (rs.getString("CATEGORY").equals("TOY")) {
                                                            out.println("Toys");
                                                        } else if (rs.getString("CATEGORY").equals("CLOTH")) {
                                                            out.println("Clothes");
                                                        } else if (rs.getString("CATEGORY").equals("CAGE")) {
                                                            out.println("Cage & Aquarium");
                                                        } else {
                                                            out.println("Others");
                                                        }
                                                    %>
                                                </h5>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="25%"><h5 style="color: blue">Name</h5></td>
                                            <td><h5><%=rs.getString("NAME")%></h5></td>
                                        </tr>
                                        <tr>
                                            <td width="25%"><h5 style="color: blue">Price</h5></td>
                                            <td>
                                                <h5>
                                                    <% String z = String.format("RM %.2f", rs.getDouble("price"));%>
                                                    <%=z%>
                                                </h5>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="25%"><h5 style="color: blue">Quantity</h5></td>
                                            <td><h5><%=rs.getString("QUANTITY")%> Left</h5></td>
                                        </tr>
                                        <tr>
                                            <td width="25%"><h5 style="color: blue">Description</h5></td>
                                            <td><h5><%=rs.getString("DESCRIPTION")%></h5></td>
                                        </tr>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <table class="table mb-4">
                    <thead>
                        <tr>
                            <td align="center">
                                <form method="post" action="AddCart">
                                    <input type="hidden" name="username" value="<%=sessionName%>">
                                    <input type="hidden" name="id" value="<%=rs.getString("ID")%>">
                                    <input type="hidden" name="location" value="shop">
                                    <% if (role.equals("A") || role.equals("M")) {%>
                                    <button class="mb-4 btn btn-primary" type="button" onclick="window.location.href = 'manageItem.jsp?searchResult=&category=&status=&name='">Back</button>
                                    <%} else {%>
                                    <% if (rs.getString("STATUS").equals("1")) {%>
                                        <% if (rs.getInt("QUANTITY") > 0) {%>
                                        <button class="mb-4 btn btn-primary" type="submit">Add to cart</button>
                                        <%} else {%>
                                        <button class="mb-4 btn btn-default" type="button">Sold Out</button>
                                        <%}%>
                                    <%} else {%>
                                        <button class="mb-4 btn btn-default" type="button">Item is deleted</button>
                                    <%}%>
                                    <button class="mb-4 btn btn-primary" type="button" onclick="window.location.href = 'shop.jsp?searchResult=&category='">Back</button>
                                    <%}%>

                                </form>
                            </td>
                        </tr>
                    </thead>
                </table>
                <% int c = 0;%>
                <% String str = "SELECT T.*, A.FIRSTNAME, A.LASTNAME, A.IMAGE FROM TRANSACTIONS T, ACCOUNT A WHERE T.USERNAME = A.USERNAME AND RATING > 0 AND T.PRODUCTID = ?"; %>
                <% ustmt = conn.prepareStatement(str); %>
                <% ustmt.setString(1, request.getParameter("id")); %>
                <% ResultSet rss = ustmt.executeQuery(); %>
                <% while (rss.next()) {%>
                <% if (c == 0) {%>
                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h3 class="">Comments by users</h3>
                            <div class="bio-skill-box">
                                <div class="row">
                                    <%c = 1;
                                        }%>
                                    <% if (rss.getFloat("RATING") != 0.0) {%>
                                    <div class="col-12 col-xl-6 col-lg-12 mb-xl-5 mb-5 ">
                                        <div class="d-flex b-skills" width="100%">
                                            <div class="">
                                                <h5><a href="viewProfile.jsp?username=<%=rss.getString("USERNAME")%>" style="color: blue"><img src="profileImage/<%=rss.getString("IMAGE")%>" width="50px">&nbsp;&nbsp;<%=rss.getString("FIRSTNAME")%> <%=rss.getString("LASTNAME")%></a></h5>
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
                                                <%} else if (rss.getString("REPLYCOMMENT") == null) {%>
                                                <%if (role.equals("A") || role.equals("M")) {%>
                                                <form action="UpdateTransactionReplyComment" method="post">
                                                    <input type="hidden" name="id" value="<%=rss.getString("ID")%>">
                                                    <input type="text" class="form-control" name="replyComment" placeholder="Reply Comment.." required maxlength="500"><br>&nbsp;
                                                    <input type="submit" value="Reply" class="btn btn-primary">
                                                    <input type="hidden" name="productID" value="<%=request.getParameter("id")%>">
                                                </form>
                                                <%}%>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                    <%}%>

                                    <%}%>
                                    <%if (c == 1) {%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>

                <% } else {
                        response.sendRedirect("shop.jsp?searchResult=&category=");
                        return;
                    }%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" />