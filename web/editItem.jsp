<%-- 
    Document   : editItem.jsp (edit existing items added from addItem.jsp)
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
                    <h3>Edit Item</h3>
                </div>
            </div>

            <div class="row layout-spacing">
                <%int i = Integer.parseInt(request.getParameter("id"));%>
                <% String retrieveStr = "SELECT * FROM " + tableName + " WHERE ID = ?"; %>
                <% stmt = conn.prepareStatement(retrieveStr); %>
                <% stmt.setInt(1, i); %>
                <% ResultSet rs = stmt.executeQuery(); %>
                <% if (rs.next()) {%>

                <!-- Content -->
                <div class="col-xl-4 col-lg-6 col-md-5 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing">
                        <div class="widget-content widget-content-area">
                            <div class="d-flex justify-content-between">
                                <h3 class="">Item picture</h3>
                            </div>
                            <div class="text-center user-info">
                                <img src="itemImage/<%=rs.getString("IMAGE")%>" id="blah" alt="avatar" width="250px" height="250px">
                                <h5><br>Upload item image below</h5><br>
                                <form method="post" enctype="multipart/form-data" action="UpdateItemImage">
                                    <input onchange="readURL(this);" type="file" name="file" class="form-control-file" id="exampleFormControlFile1" accept="image/*" required>
                                    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                                    <input type="hidden" name="itemName" value="<%=rs.getString("NAME")%>">
                                    <table class="table mb-4" style="margin-top: 20px; margin-bottom: 0px;">
                                        <tr>
                                            <td align="center">
                                                <input type="submit" name="submit" class="mb-4 btn btn-primary" value="Update">
                                            </td>
                                        </tr>
                                    </table>
                                </form>
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
                                    <div class="col-md-11 mx-auto">
                                        <div class="row">

                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <form method="post" action="UpdateItem">
                                                        <label for="address">Item Name</label>
                                                        <input type="text" class="form-control mb-4" id="firstName" name="itemName"
                                                               placeholder="" value="<%=rs.getString("NAME")%>" maxlength="99" required>
                                                        <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Category</label>
                                                    <select name="itemCategory" class="form-control" required>
                                                        <option></option>
                                                        <option value="FOOD" <%if (rs.getString("CATEGORY").equals("FOOD")) {
                                                                out.print("selected");
                                                            }%>>Food & Treats</option>
                                                        <option value="TOY" <%if (rs.getString("CATEGORY").equals("TOY")) {
                                                                out.print("selected");
                                                            }%>>Toys</option>
                                                        <option value="CLOTH" <%if (rs.getString("CATEGORY").equals("CLOTH")) {
                                                                out.print("selected");
                                                            }%>>Clothes</option>
                                                        <option value="CAGE" <%if (rs.getString("CATEGORY").equals("CAGE")) {
                                                                out.print("selected");
                                                            }%>>Cage & Aquarium</option>
                                                        <option value="OTHER" <%if (rs.getString("CATEGORY").equals("OTHER")) {
                                                                out.print("selected");
                                                            }%>>Others</option>
                                                    </select>
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Price</label>
                                                    <input type="number" class="form-control mb-4" id="firstName" name="itemPrice"
                                                           placeholder="" value="<%=rs.getString("PRICE")%>" step="0.01" min="0.01" required>
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Quantity</label>
                                                    <input type="number" class="form-control mb-4" id="firstName" name="itemQuantity"
                                                           placeholder="" value="<%=rs.getString("QUANTITY")%>" step="1" min="1" required>
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="form-group mb-4">
                                                <label for="exampleFormControlTextarea1">Item Description</label>
                                                <textarea maxlength="99" name="itemDescription" required class="form-control" id="exampleFormControlTextarea1" rows="5" cols="120"><%=rs.getString("DESCRIPTION")%></textarea>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <table class="table mb-4">
                                                <thead>
                                                    <tr>
                                                        <td align="center">
                                                            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                                                            <button class="mb-4 btn btn-primary" type="reset">Reset</button>
                                                            <button class="mb-4 btn btn-primary" type="submit">Update</button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </thead>
                                            </table>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <table class="table mb-4">
                    <thead>
                        <tr>
                            <td align="center">
                                <form method="post" action="DeleteItem">
                                    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                                    <input type="hidden" name="itemName" value="<%=rs.getString("NAME")%>">
                                    <button class="mb-4 btn btn-danger" type="submit">Delete Item</button>

                                    <button class="mb-4 btn btn-primary" onclick="window.location.href = 'manageItem.jsp?searchResult=&category=&status=&name='" type="button">Back</button>
                                </form>
                            </td>
                        </tr>
                    </thead>
                </table>
                <%}%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 
<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                        .attr('src', e.target.result)
                        .width(250)
                        .height(250);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

<script src="assets/js/scrollspyNav.js"></script>
<script src="plugins/input-mask/jquery.inputmask.bundle.min.js"></script>
<script src="plugins/input-mask/input-mask.js"></script>