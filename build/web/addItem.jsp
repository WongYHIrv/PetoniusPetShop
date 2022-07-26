<%-- 
    Document   : addItem.jsp (admin/manager)
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

<jsp:include page="include/header.jsp" /> 

<div class="main-container" id="container">

    <!--  BEGIN CONTENT AREA  -->
    <div id="content" class="main-content">
        <div class="layout-px-spacing">

            <div class="page-header">
                <div class="title">
                    <h3>Add Item</h3>
                </div>
            </div>

            <div class="row layout-spacing">

                <!-- Content -->
                <div class="col-xl-4 col-lg-6 col-md-5 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing">
                        <div class="widget-content widget-content-area">
                            <div class="d-flex justify-content-between">
                                <h3 class="">Item picture</h3>
                            </div>

                            <div class="text-center user-info">
                                <img src="itemImage/unknown.png" id="blah" alt="avatar" width="250px" height="250px">
                                <h5><br>Upload item image below</h5><br>

                                
<form action="AddItem" method="post" enctype="multipart/form-data">
                                <input type="file" name="file" onchange="readURL(this);" class="form-control-file" id="exampleFormControlFile1" accept="image/*" required>
                                
 
                                
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
                                                    <label for="address">Item Name</label>
                                                    <input type="text" class="form-control mb-4" id="firstName" name="itemName"
                                                           placeholder="" value="" required maxlength="100">
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Category</label>
                                                    <select name="itemCategory  " class="form-control" required>
                                                        <option></option>
                                                        <option value="FOOD">Food & Treats</option>
                                                        <option value="TOY">Toys</option>
                                                        <option value="CLOTH">Clothes</option>
                                                        <option value="CAGE">Cage & Aquarium</option>
                                                        <option value="OTHER">Others</option>
                                                    </select>
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Price</label>
                                                    <input type="number" class="form-control mb-4" id="firstName" name="itemPrice"
                                                           placeholder="" value="" step="0.01" min="0.01" required maxlength="100">
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="address">Item Quantity</label>
                                                    <input type="number" class="form-control mb-4" id="firstName" name="itemQuantity"
                                                           placeholder="" value="" step="1" min="1" required maxlength="100">
                                                    <div style="color: red;"></div>
                                                </div>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
                                            <div class="form-group mb-4">
                                                <label for="exampleFormControlTextarea1">Item Description</label>
                                                <textarea name="itemDescription" required class="form-control" id="exampleFormControlTextarea1" rows="5" cols="120" maxlength="100"></textarea>
                                            </div>
                                            <!------------------------------------------------------------------------------------------>
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
                                <button class="mb-4 btn btn-primary" type="submit">Add Item</button>
</form>
                                <button class="mb-4 btn btn-primary" onclick="window.location.href = 'manageItem.jsp?searchResult=&category=&status=&name='">Cancel</button>
                            </td>
                        </tr>
                    </thead>
                </table>
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