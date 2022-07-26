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

<table class="table table-bordered table-striped mb-4">
    <thead>
        <tr>
            <th width="3%">No</th>
            <th width="25%">
                Name
                <% if (request.getParameter("orderBy").equals("firstname") && request.getParameter("sorting").equals("ASC")) {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=firstname&sorting=DESC">
                    <img src="image/down.png" width="10px" height="10px">
                </a>
                <%} else {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=firstname&sorting=ASC">
                    <img src="image/top.png" width="10px" height="10px">
                </a>
                <%}%>
            </th>
            <th width="25%">
                Username
                <% if (request.getParameter("orderBy").equals("username") && request.getParameter("sorting").equals("ASC")) {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=username&sorting=DESC">
                    <img src="image/down.png" width="10px" height="10px">
                </a>
                <%} else {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=username&sorting=ASC">
                    <img src="image/top.png" width="10px" height="10px">
                </a>
                <%}%>
            </th>
            <th width="25%">
                Email
                <% if (request.getParameter("orderBy").equals("email") && request.getParameter("sorting").equals("ASC")) {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=email&sorting=DESC">
                    <img src="image/down.png" width="10px" height="10px">
                </a>
                <%} else {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=email&sorting=ASC">
                    <img src="image/top.png" width="10px" height="10px">
                </a>
                <%}%>
            </th>
            <th width="10%">
                Position
                <% if (request.getParameter("orderBy").equals("position") && request.getParameter("sorting").equals("ASC")) {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=position&sorting=DESC">
                    <img src="image/down.png" width="10px" height="10px">
                </a>
                <%} else {%>
                <a href="manageRole.jsp?searchResult=<%=request.getParameter("searchResult")%>&changedUser=&changedRole=&orderBy=position&sorting=ASC">
                    <img src="image/top.png" width="10px" height="10px">
                </a>
                <%}%>
            </th>
            <th class="text-center">Action</th>
        </tr>
    </thead>
    <tbody>

        <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE STATUS = TRUE AND (UPPER(USERNAME) LIKE ? OR UPPER(FIRSTNAME) LIKE ? OR UPPER(LASTNAME) LIKE ? OR UPPER(EMAIL) LIKE ?) ORDER BY " +request.getParameter("orderBy")+ " " + request.getParameter("sorting"); %>
        <% stmt = conn.prepareStatement(retrieveStr); %>
        <% stmt.setString(1, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
        <% stmt.setString(2, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
        <% stmt.setString(3, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
        <% stmt.setString(4, "%" + (request.getParameter("searchResult").toUpperCase()) + "%"); %>
        <% ResultSet rs = stmt.executeQuery(); %>
        <%  int i = 0;
            while (rs.next()) {%>
        <tr> 
            <td><h6><% i++;
                out.println(i + ".");%></h6></td>
            <td><h6>
                <div class="d-flex">
                    <div class="usr-img-frame mr-2 rounded-circle">
                        <img alt="avatar" class="img-fluid rounded-circle" src="profileImage/<%=rs.getString("IMAGE")%>"
                             height="5px" width="5px">
                    </div>
                    <p class="align-self-center mb-0"><a style="color: blue" href="viewProfile.jsp?username=<%=rs.getString("USERNAME")%>&firstname=<%=rs.getString("FIRSTNAME")%>"><%=rs.getString("FIRSTNAME")%> <%=rs.getString("LASTNAME")%></a></p>
                </div>
            </h6></td>
            <td><h6><%=rs.getString("USERNAME")%></h6></td>
            <td><h6><%=rs.getString("EMAIL")%></h6></td>
    <form method="post" action="ChangeRole">
        <td>
            <select name="role"  class="form-control form-control-sm">
                <option value="A" <%if ((rs.getString("POSITION").equals("A"))) {%>selected<%}%> ><h6>Admin</h6></option>
                <option value="M" <%if ((rs.getString("POSITION").equals("M"))) {%>selected<%}%> ><h6>Manager</h6></option>
                <option value="C" <%if ((rs.getString("POSITION").equals("C"))) {%>selected<%}%> ><h6>Customer</h6></option>
            </select>
        </td>
        <td class=" text-center">
            <input type="hidden" name="username" value="<%=rs.getString("USERNAME")%>">
            <input type="hidden" name="searchResult" value="<%=request.getParameter("searchResult")%>"/>
            <button type="submit" class="btn btn-danger">Change role</button>
        </td>
    </form>
</tr>
<%}%>
<%

    if (i == 0) { %>
<tr>
    <td colspan="6" align="center">No record found.</td>
</tr>
<%}%>
</tbody>
</table>