<%-- 
    Document   : Shop (catalog viewing)
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
    String pageName = "Shop";
    request.setAttribute("pageName", pageName);
%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="da.AccountDA"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>


<%
    String host = "jdbc:derby://localhost:1527/pet";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "Product";
    String tableName2 = "Cart";
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

                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">

                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <div><h4 style="color: blue">Search item or category here</h4></div><br>
                            <form method="get" action="shop.jsp">
                                <div class="input-group mb-4">
                                    <input type="text" id="searchResult" name="searchResult" value="<%=request.getParameter("searchResult")%>" class="form-control" placeholder="Search item name here">
                                    <select id="category" name="category" class="form-control">
                                        <option value="">Select category here</option>
                                        <option value="FOOD" <%if (request.getParameter("category").equals("FOOD")) {
                                                out.print("selected");
                                            }%>>Food & Treats</option>
                                        <option value="TOY" <%if (request.getParameter("category").equals("TOY")) {
                                                out.print("selected");
                                            }%>>Toys</option>
                                        <option value="CLOTH" <%if (request.getParameter("category").equals("CLOTH")) {
                                                out.print("selected");
                                            }%>>Clothes</option>
                                        <option value="CAGE" <%if (request.getParameter("category").equals("CAGE")) {
                                                out.print("selected");
                                            }%>>Cage & Aquarium</option>
                                        <option value="OTHER" <%if (request.getParameter("category").equals("OTHER")) {
                                                out.print("selected");
                                            }%>>Others</option>
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


                <% int i = 0; %>

                <% String str = "SELECT P.NAME, P.PRICE, P.QUANTITY AS REMAINING, C.* FROM PRODUCT P, CART C WHERE C.USERNAME = ? AND P.ID = C.ID"; %>
                <% stmt = conn.prepareStatement(str); %>
                <% stmt.setString(1, sessionName); %>
                <% ResultSet rss = stmt.executeQuery(); %>

                <% while (rss.next()) {%>
                <% if (i == 0) { %>
                <div class="col-xl-6 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div style="text-align: center" class="widget-content widget-content-area">
                            <h4 style="color: blue">Shopping Cart</h4>
                            <table width="100%"  class="table table-bordered mb-4">
                                <tr>
                                    <th width="40%"><h5 style="color: blue; text-align: left">Name</h5></th>
                                    <th width="25%"><h5 style="color: blue">Price for each item</h5></th>
                                    <th width="25%"><h5 style="color: blue">Quantity</h5></th>
                                    <th><h5 style="color: blue">Action</h5></th>
                                </tr>
                                <% }
                                    i = 1;%>
                                <tr>
                                    <td align="left">
                                        <h5><%=rss.getString("NAME")%></h5>
                                    </td>
                                    <td align="center">
                                        <h5>
                                            <% String y = String.format("RM %.2f", rss.getDouble("price"));%>
                                            <%=y%>
                                        </h5>
                                    </td>
                                    <td align="center">
                                        <table>
                                            <tr>
                                                <td>
                                                    <form method="post" action="DecreaseOneCart">
                                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                                        <input type="hidden" name="id" value="<%=rss.getString("id")%>">
                                                        <input type="hidden" name="location"  value="shop">
                                                        <input type="submit" class="btn btn-primary" value="-">

                                                    </form>
                                                </td>
                                                <td>
                                                    <h5>
                                                        <% String s = String.format("%2s", rss.getInt("QUANTITY"));%>
                                                        <%=s%>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <% if (rss.getInt("REMAINING") > rss.getInt("QUANTITY")) {%>
                                                    <form method="post" action="IncreaseOneCart">
                                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                                        <input type="hidden" name="id" value="<%=rss.getString("id")%>">
                                                        <input type="hidden" name="location"  value="shop">
                                                        <input type="submit" class="btn btn-primary" value="+">
                                                    </form>
                                                    <%} else {%>
                                                    <input type="submit" class="btn btn-default" value="+">
                                                    <%}%>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td align="center">
                                        <form method="post" action="DeleteOneCart">
                                            <input type="hidden" name="username" value="<%=sessionName%>">
                                            <input type="hidden" name="id" value="<%=rss.getString("id")%>">
                                            <input type="hidden" name="location"  value="shop">
                                            <button type="submit" class="btn btn-danger">X</button>
                                        </form>
                                    </td>
                                </tr>
                                <%}%>
                                <% if (i == 1) { %>
                                <tr>
                                    <td colspan="4"><button type="button" class="btn btn-primary" onclick="window.location.href = 'checkOut.jsp'">Check out</button></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <%}%>

                <!------------------------------------------------------------------------------------------------->
                <% int c = 0;%>
                <% int searchID = 0;
                    int error = 0;%>
                <% String searchResult = request.getParameter("searchResult"); %>
                <%
                    for (int j = 0; j < searchResult.length(); j++) {
                        if (searchResult.charAt(j) < 48 || searchResult.charAt(j) > 57) {
                            error++;
                        }
                        if (error == 0) {
                            searchID = Integer.parseInt(searchResult);
                        }
                    }
                %>

                <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE ID = ? OR UPPER(NAME) LIKE ? AND (UPPER(CATEGORY) LIKE ? AND STATUS = '1')"; %>
                <% stmt = conn.prepareStatement(retrieveStr); %>
                <% stmt.setInt(1, searchID); %>
                <% stmt.setString(2, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
                <% stmt.setString(3, "%" + (request.getParameter("category").toUpperCase()) + "%"); %>
                <% ResultSet rs = stmt.executeQuery(); %>
                <% while (rs.next()) {%>

                <div class="col-xl-3 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h4 style="color: blue">
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
                            </h4>
                            
                                <img style="border: 2px solid black" src="itemImage/<%=rs.getString("IMAGE")%>" width="100%" height="315px">


                                <div class="card-body">
                                    <h4><%=rs.getString("NAME")%></h4>
                                    <h5 class="card-title"><% String z = String.format("RM %.2f", rs.getDouble("price"));%>
                                        <%=z%></h5>
                                        <% if (rs.getInt("QUANTITY") > 0) {%>
                                    <form method="post" action="AddCart">
                                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'viewItem.jsp?id=<%=rs.getString("ID")%>'">View Details</button> &nbsp;&nbsp;&nbsp;
                                        <input type="hidden" name="id" value="<%=rs.getString("ID")%>">
                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                        <input type="submit" class="btn btn-primary" value="Add to cart">
                                    </form>
                                    <%} else {%>
                                    <button type="button" class="btn btn-primary" onclick="window.location.href = 'viewItem.jsp?id=<%=rs.getString("ID")%>'">View Details</button> &nbsp;&nbsp;&nbsp;
                                    <input type="button" class="btn btn-default" value="Sold Out">
                                    <%}%>
                                </div>
                          
                        </div>
                    </div>
                </div>

                <% c = 1;
                    }%>
                <% if (c == 0) { %>
                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h5>No product found.<br>&nbsp;</h5>
                        </div>
                    </div>
                </div>
                <%}%>
                <!------------------------------------------------------------------------------------------------->
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