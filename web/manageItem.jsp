<%-- 
    Document   : manageItem (existing product management)
    Author     : IrvineWYH
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

    String pageName = "Manage Item";
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
                            <div><h4 style="color: blue">Search item or category here</h4></div><br>
                            <form method="get" action="manageItem.jsp">
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
                                    <input type="hidden" name="status" value="">
                                    <input type="hidden" name="name" value="">
                                    <div class="input-group-append">
                                        <button class="btn btn-danger" type="button" onclick="ClearFields();">X</button>
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <button class="btn btn-primary" type="button" onclick="window.location.href = 'addItem.jsp'">+ Add Item</button><br>&nbsp;
                    <h6 style="color: blue">
                        <%
                            if (request.getParameter("status").equals("itemAdded")) {
                                out.print("Item " + request.getParameter("name") + " is added.");
                            } else if (request.getParameter("status").equals("itemUpdated")) {
                                out.print("Item " + request.getParameter("name") + " is updated.");
                            } else if (request.getParameter("status").equals("itemDeleted")) {
                                out.print("Item " + request.getParameter("name") + " is deleted.");
                            }
                        %>
                    </h6>
                </div>

                <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE UPPER(NAME) LIKE ? AND UPPER(CATEGORY) LIKE ? AND STATUS = '1'"; %>
                <% stmt = conn.prepareStatement(retrieveStr); %>
                <% stmt.setString(1, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
                <% stmt.setString(2, "%" + (request.getParameter("category").toUpperCase()) + "%"); %>
                <% ResultSet rs = stmt.executeQuery(); %>
                <% while (rs.next()) {%>

                <div class="col-xl-3 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h6 style="color: blue">
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
                            </h6>

                            <img style="border: 2px solid black" src="itemImage/<%=rs.getString("IMAGE")%>" width="100%" height="50%">
                            <br><br>
                            <table>
                                <tr>
                                    <td><h6>Name:</h6></td>
                                    <td width="100%"><h6><%=rs.getString("NAME")%></h6></td>
                                </tr>
                                <tr>
                                    <td><h6>Price:</h6></td>
                                    <td><h6><% String z = String.format("RM %.2f", rs.getDouble("price"));%>
                                            <%=z%></h6></td>
                                </tr>
                                <tr>
                                    <td><h6>Quantity:</h6></td>
                                    <td><h6><%=rs.getString("QUANTITY")%> Left</h6></td>
                                </tr>
                                <tr>
                                    <td><h6>Description:&nbsp;</h6></td>
                                    <td><h6><%=rs.getString("DESCRIPTION")%></h6></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <form method="get" action="editItem.jsp">
                                            <button class="btn btn-primary" type="button" onclick="window.location.href = 'viewItem.jsp?id=<%=rs.getString("ID")%>'">View Details</button>

                                            <input type="hidden" name="id" value="<%=rs.getString("ID")%>">
                                            <button class="btn btn-primary" type="submit">Edit Item</button>
                                        </form>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">&nbsp;</td>
                                </tr>
                            </table>
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