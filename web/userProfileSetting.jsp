<%-- 
    Document   : User Profile Config
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
    String pageName = "Setting";
    request.setAttribute("pageName", pageName);
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String email = (String) session.getAttribute("email");
    String phoneNumber = (String) session.getAttribute("phoneNumber");
    String dob = (String) session.getAttribute("dob");
    String image = (String) session.getAttribute("image");
%>
<%@page import="domain.Account"%>
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
                <div class="col-xl-4 col-lg-6 col-md-5 col-sm-12 layout-top-spacing">

                    <div class="bio layout-spacing">
                        <div class="widget-content widget-content-area">
                            <div class="d-flex justify-content-between">
                                <h3 class="">Profile picture</h3>
                            </div>
                            <h6 style="color: blue">${uploadSuccess}</h6>
                            <div class="text-center user-info">

                                <img id="blah" src="profileImage/<%out.println(image);%>" alt="avatar" width="175px" height="175px">
                                <h5><br>Upload profile image below</h5><br>

                                <form method="post" enctype="multipart/form-data" action="UpdateProfileImage">
                                    <input onchange="readURL(this);" type="file" name="file" class="form-control-file" id="exampleFormControlFile1" accept="image/*" required>
                                    <table class="table mb-4" style="margin-top: 20px; margin-bottom: 0px;">
                                        <tr>
                                            <td align="center">
                                                <input type="submit" name="submit" class="mb-4 btn btn-primary" value="Update">
                                            </td>
                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 col-lg-6 col-md-7 col-sm-12 layout-top-spacing">
                    <div class="bio layout-spacing ">
                        <div class="widget-content widget-content-area">
                            <h3 class="">Information</h3>
                            <form id="contact" class="section contact" method="post" action="ValidateProfile">
                                <div class="info">
                                    <div class="row">
                                        <div class="col-md-11 mx-auto">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="address">First Name</label>
                                                        <input type="text" class="form-control mb-4" id="firstName" name="firstName"
                                                               placeholder="" value="<%out.println(firstName);%>" >
                                                        <div style="color: red;">${firstNameError}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="location">Last Name</label>
                                                        <input type="text" class="form-control mb-4" id="lastName" name="lastName"
                                                               placeholder="" value="<%out.println(lastName);%>" >
                                                        <div style="color: red;">${lastNameError}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="phone">Email</label>
                                                        <input type="email" class="form-control mb-4" id="email" name="email"
                                                               placeholder="" value="<%out.println(email);%>">
                                                        <div style="color: red;">${emailError}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="email">Phone Number</label>
                                                        <input type="text" class="form-control mb-4" id="phoneNumber" name="phoneNumber"
                                                               placeholder="01XXXXXXXX" value="<%out.println(phoneNumber);%>">
                                                        <div style="color: red;">${phoneNumberError}</div>
                                                    </div>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table mb-4">
                                                        <thead>
                                                            <tr>
                                                                <td align="center">
                                                                    <input type="submit" name="submit" class="mb-4 btn btn-primary" value="Update"> &nbsp;&nbsp;&nbsp;
                                                                    <input type="reset" name="reset" class="mb-4 btn btn-primary">
                                                                </td>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <table class="table mb-4">
                    <thead>
                        <tr>
                            <td align="center">
                                <button class="mb-4 btn btn-primary" onclick="window.location.href = 'userProfile.jsp'">Back to profile</button>
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
                        .width(175)
                        .height(175);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>