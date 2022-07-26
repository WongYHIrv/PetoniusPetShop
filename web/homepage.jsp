<%-- 
    Document   : homepage + banners and information
    Author     : Vivian / Abigail
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
    String pageName = "Homepage";
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

            <div class="advertisement">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active m"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="d-block w-100" src="image/Ads 1.png" alt="First slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="image/Ads 2.png" alt="Second slide">
                        </div>
                        <div class="carousel-item">
                            <img class="d-block w-100" src="image/Ads 3.png" alt="Third slide">
                        </div>
                    </div>
                </div>
            </div>

            <!--Featured Items -->
            <div class="page-header">
                <div class="title">
                    <h3>Featured Items</h3>
                </div>
            </div>
            <div class="layout-spacing">
                <div class="featured-container">
                    <div class="container-1">
                        <div class="row">

                            <% String retrieveStr = "SELECT * FROM PRODUCT WHERE STATUS = '1' AND QUANTITY > 0 fetch first 3 rows only"; %>
                            <% stmt = conn.prepareStatement(retrieveStr);%>
                            <% ResultSet rs = stmt.executeQuery(); %>
                            <% while (rs.next()) {%>
                            <div class="col-sm">
                                <div class="card component-card_2">
                                    <img class="d-block w-100" src="itemImage/<%=rs.getString("IMAGE")%>" width="250px" height="350px">
                                    <div class="card-body">
                                        <h4><%=rs.getString("NAME")%></h4>
                                        <h5 class="card-title"><% String z = String.format("RM %.2f", rs.getDouble("price"));%>
                                            <%=z%>
                                        </h5>
                                        <form method="post" action="AddCart">
                                            <input type="hidden" name="id" value="<%=rs.getString("ID")%>">
                                            <input type="hidden" name="username" value="<%=sessionName%>">
                                            <input type="submit" class="btn btn-primary btn-block mb-4 mr-2" value="Add to Cart">
                                        </form>
                             
                                    </div>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>

                <!--About Us -->
                <div class="page-header">
                    <div class="title">
                        <h3>About Us</h3>
                    </div>
                </div>

                <div class="message-container">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm">
                                <h5>We started out as a small local pet shop of 2 staff back in 2015, has evolved
                                    into a huge family of over 16 dedicated team players!
                                    With over 7 incredible years of experience under our belt, it's no wonder
                                    Petonius is recognised as one of the top pet food suppliers.</h5>
                                <a href="aboutUs.jsp"><button class="btn btn-primary">Learn more</button></a>

                                <br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 