<%-- 
    Document   : checkout.jsp / checkout module (shipping, cc detail)
    Author     : IrvineWYH
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

<%
    String host = "jdbc:derby://localhost:1527/pet";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "Product";
    String tableName2 = "Cart";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement stmt2;

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
                    <h3>Check out</h3>
                </div>
            </div>

            <div class="row layout-spacing">

                <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h4 style="color: blue">Shopping Cart</h4><br>
                            <table width="100%"  class="table table-bordered mb-4">

                                <tr>
                                    <th width="40%"><h5 style="color: blue; text-align: left">Name</h5></th>
                                    <th width="25%"><h5 style="color: blue" align="center">Price for each item</h5></th>
                                    <th width="25%"><h5 style="color: blue" align="center">Quantity</h5></th>
                                    <th><h5 style="color: blue" align="center">Action</h5></th>
                                </tr>

                                <% int i = 0; %>
                                <% int error = 0;%>
                                <% double pricing = 0; %>
                                <% String str = "SELECT P.NAME, P.PRICE, P.QUANTITY AS REMAINING, P.IMAGE, C.* FROM PRODUCT P, CART C WHERE C.USERNAME = ? AND P.ID = C.ID"; %>
                                <% stmt = conn.prepareStatement(str); %>
                                <% stmt.setString(1, sessionName); %>
                                <% ResultSet rss = stmt.executeQuery();%>
                                <% while (rss.next()) {%>
                                <%  i = 1;%>
                                <tr>
                                    <td align="left">
                                        <h5>
                                            <img src="itemImage/<%=rss.getString("IMAGE")%>" height="75px" width="75px" style="border: 2px solid black">
                                            <%=rss.getString("NAME")%>

                                        </h5>
                                        <%if (rss.getInt("REMAINING") == 0) {%>
                                        <h6 style="color: red">This item has no stock, please remove to proceed checkout.</h6>
                                        <%error = 1;%>
                                        <%} else if (rss.getInt("REMAINING") < rss.getInt("QUANTITY")) {%>
                                        <h6 style="color: red">This item has not enough stock, please reduce the quantity to <b><%=rss.getString("remaining")%></b>.</h6>
                                        <%error = 1;%>
                                        <%}%>
                                    </td>
                                    <td align="center">
                                        <h5>
                                            <% String z = String.format("RM %.2f", rss.getDouble("price"));%>
                                            <%=z%>
                                        </h5>
                                    </td>
                                    <td align="center">
                                        <table>
                                            <tr>
                                                <td>

                                                    <form method="post" action="DecreaseOneCart">
                                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                                        <input type="hidden" name="id" value="<%=rss.getString("id")%>">
                                                        <input type="hidden" name="location"  value="checkOut">
                                                        <input type="submit" class="btn btn-primary" value="-">
                                                    </form>

                                                </td>
                                                <td>
                                                    <h5>
                                                        <%=rss.getString("QUANTITY")%>
                                                        <%
                                                            pricing = pricing + (rss.getDouble("QUANTITY") * rss.getDouble("PRICE"));
                                                        %>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <% if (rss.getInt("REMAINING") > rss.getInt("QUANTITY")) {%>
                                                    <form method="post" action="IncreaseOneCart">
                                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                                        <input type="hidden" name="id" value="<%=rss.getString("id")%>">
                                                        <input type="hidden" name="location"  value="checkOut">
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
                                            <input type="hidden" name="location"  value="checkOut">
                                            <button type="submit" class="btn btn-danger">X</button>
                                        </form>
                                    </td>
                                </tr>

                                <% }%>
                                <%
                                    if (i
                                            == 0) {
                                        response.sendRedirect("shop.jsp?searchResult=&category=");
                                        return;
                                    }
                                %>
                                <tr>
                                    <td colspan="4" align="left"><a href="shop.jsp?searchResult=&category="><h5 style="color: blue">+ Click here to add more item</h5></a></td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="left">
                                        <h5>Total:</h5>
                                    </td>
                                    <td colspan="2" align="center">
                                        <h5>
                                            <%
                                                String sf1=String.format("RM %.2f",pricing);  
                                            %>
                                            <%=sf1%>
                                        </h5>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <form method="post" action="Transaction">
                    <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                        <div class="bio layout-spacing ">
                            <div class="widget-content widget-content-area">
                                <h4 style="color: blue">Shipping Details</h4><br>
                                <div class="row">
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Recipient Name</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="recipientName"
                                                   placeholder="Recipient Name" value="<%=(String) session.getAttribute("firstName")%> <%=(String) session.getAttribute("lastName")%>" 
                                                   required maxlength="99">
                                            <div style="color: red">${recipientNameError}</div>
                                        </div>

                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Contact</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="recipientContact"
                                                   placeholder="01XXXXXXXX" value="<%=(String) session.getAttribute("phoneNumber")%>" 
                                                   required maxlength="99">
                                            <div style="color: red">${recipientContantError}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Address Line 1</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="address1"
                                                   placeholder="Address Line 1" value="${address1}" 
                                                   required maxlength="99">
                                            <div style="color: red">${address1Error}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Address Line 2</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="address2"
                                                   placeholder="Address Line 2" value="${address2}" 
                                                   required maxlength="99">
                                            <div style="color: red">${address2Error}</div>
                                        </div>
                                    </div>

                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>ZIP Code</b></label>
                                            <input type="number" class="form-control mb-4" id="firstName" name="zipCode"
                                                   placeholder="33300" value="${zipCode}" 
                                                   required onKeyPress="if (this.value.length == 5)
                                                               return false;">
                                            <div style="color: red">${zipCodeError}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>City</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="city"
                                                   placeholder="City" value="${city}" 
                                                   required maxlength="99">
                                            <div style="color: red">${cityError}</div>
                                        </div>
                                    </div>

                                    <!------------------------------------------------------------------->

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>State</b></label>
                                            <select id="state" name="state" class="form-control" required>
                                                <option value="">Select state here</option>
                                                <option value="Johor">Johor</option>
                                                <option value="Kedah">Kedah</option>
                                                <option value="Kelantan">Kelantan</option>
                                                <option value="Malacca">Malacca</option>
                                                <option value="Negeri Sembilan">Negeri Sembilan</option>
                                                <option value="Pahang">Pahang</option>
                                                <option value="Penang">Penang</option>
                                                <option value="Perak">Perak</option>
                                                <option value="Perlis">Perlis</option>
                                                <option value="Sabah">Sabah</option>
                                                <option value="Sarawak">Sarawak</option>
                                                <option value="Selangor">Selangor</option>
                                                <option value="Terengganu">Terengganu</option>

                                            </select>
                                        </div>
                                    </div>

                                    <!------------------------------------------------------------------->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-12 col-lg-6 col-md-7 col-sm-12 ">
                        <div class="bio layout-spacing ">
                            <div class="widget-content widget-content-area">
                                <h4 style="color: blue">Payment Details</h4><br>
                                <div class="row">
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Credit Card Number</b></label>
                                            <input type="text" class="form-control mb-4" id="firstName" name="cardNumber"
                                                   placeholder="1111-2222-3333-4444" value="${cardNumber}"
                                                   required maxlength="19">
                                            <div style="color: red">${cardNumberError}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Exp Month</b></label>
                                            <select id="state" name="expMonth" class="form-control" required>
                                                <option value="">Select month here</option>
                                                <option value="January">January</option>
                                                <option value="February">February</option>
                                                <option value="March">March</option>
                                                <option value="April">April</option>
                                                <option value="May">May</option>
                                                <option value="June">June</option>
                                                <option value="July">July</option>
                                                <option value="August">August</option>
                                                <option value="September">September</option>
                                                <option value="October">October</option>
                                                <option value="November">November</option>
                                                <option value="December">December</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>Exp Year</b></label>
                                            <input type="number" class="form-control mb-4" id="firstName" name="expYear"
                                                   placeholder="2025" value="${expYear}" 
                                                   required onKeyPress="if (this.value.length == 4)
                                                               return false;">
                                            <div style="color: red">${expYearError}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="address"><b>CVV</b></label>
                                            <input type="number" class="form-control mb-4" id="firstName" name="cvv"
                                                   placeholder="346" value="${cvv}" 
                                                   required onKeyPress="if (this.value.length == 3)
                                                               return false;">
                                            <div style="color: red">${cvvError}</div>
                                        </div>
                                    </div>
                                    <!------------------------------------------------------------------->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table mb-4">
                            <thead>
                                <tr>
                                    <td align="center">
                                        <input type="hidden" name="username" value="<%=sessionName%>">
                                        <%if (error
                                                    == 0) {%>
                                        <input type="submit" name="submit" class="btn btn-primary" value="Check out"> &nbsp;&nbsp;&nbsp;
                                        <% } else {%>
                                        <input type="button" name="submit" class="btn btn-default" value="Check out"> &nbsp;&nbsp;&nbsp;
                                        <%}%>
                                        <button type="button" class="btn btn-primary" onclick="window.location.href = 'shop.jsp?searchResult=&category='">Cancel</button>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<jsp:include page="include/footer.jsp" /> 