<%-- 
    Document   : Registration form
    Author     : VIvianSSH, AbigailSA
--%>

<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Quicksand:400,500,600,700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/6f6d5e33e6.js" crossorigin="anonymous"></script>

        <!--CSS Link-->
        <link href="css/register.css" rel="stylesheet">

        <title>Register a New Account</title>
    </head>

    <body class="form">
        <div class="form-container outer">
            <div class="form-form">
                <div class="form-form-wrap">
                    <div class="form-container">
                        <div class="form-content">                        
                            <h1 class="">Register</h1>
                            <form method="post" action="signUpUser">
                                <div class="form">
                                    <!--First Name-->
                                    <div id="username-field" class="field-wrapper input">
                                        <label for="username">ID</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <input type="text" class="form-control" id="username" name="username" maxlength="100" required
                                               placeholder="Enter your ID">
                                    </div>

                                    <div id="username-field" class="field-wrapper input">
                                        <label for="name">NAME</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <input type="text" class="form-control" id="name" name="name" maxlength="100" required
                                               placeholder="Enter your name">
                                    </div>

                                    <div id="password-field" class="field-wrapper input">
                                        <label for="password">PASSWORD</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                        <input type="password" class="form-control" id="password" name="password" maxlength="100" value="" required
                                               placeholder="Enter your password" />
                                        <div style="color: red">${passwordError}</div>
                                    </div>

                                    <div id="confirmPassword-field" class="field-wrapper input">
                                        <label for="cPassword">CONFIRM PASSWORD</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" maxlength="100" value="" required
                                               placeholder="Re-enter your password" />
                                    </div>

                                    <div id="email-field" class="field-wrapper input">
                                        <label for="email">EMAIL ADDRESS</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-at-sign register"><circle cx="12" cy="12" r="4"></circle><path d="M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-3.92 7.94"></path></svg>
                                        <input type="email" class="form-control" id="email" name="email" maxlength="100" required 
                                               placeholder="example@gmail.com">
                                    </div>

                                    <div id="dropdown-field" class="field-wrapper input">
                                        <label for="area">AREA</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-phone"></svg>
                                        <select class="form-control" name="area" id="area" required>
                                            <option value="">Select your area:</option>
                                            <option value="Menggatal">Menggatal</option>
                                            <option value="Kolombong">Kolombong</option>
                                            <option value="Kota Kinabalu">Kota Kinabalu</option>
                                        </select>
                                    </div>   

                                    <div id="file-field" class="field-wrapper input">
                                        <label for="photo">PROFILE PHOTO</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-at-sign register"></svg>
                                        <input type="file" class="form-control" id="photo" name="photo" accept="image/*" required>
                                    </div>
                                    <% if (request.getParameter("error") != null) {
                                    String error = request.getParameter("error");%>
                                    <p style="color: red;"><%= error%></p>
                                    <% } %>
                                    <div class="d-sm-flex justify-content-between">
                                        <div class="field-wrapper">
                                            <input type="submit" class="btn btn-warning register" value="Get Started!">
                                        </div>
                                    </div>
                                    <br>
                                    <a href="login.jsp">Back to login</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>