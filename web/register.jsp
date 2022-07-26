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
                            <form method="post" action="ValidateRegister">
                                <div class="form">
                                    <!--First Name-->
                                    <div id="fname-field" class="field-wrapper input">
                                        <label for="fname">FIRST NAME</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <input type="text" class="form-control" id="fname" name="fname" maxlength="100" value="${fname}" 
                                               placeholder="Enter your first name">
                                        <div style="color: red">${firstNameError}</div>
                                    </div>

                                    <div id="lname-field" class="field-wrapper input">
                                        <label for="lname">LAST NAME</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <input type="text" class="form-control" id="lname" name="lname" maxlength="100" value="${lname}" 
                                               placeholder="Enter your last name">
                                        <div style="color: red">${lastNameError}</div>
                                    </div>

                                    <div id="username-field" class="field-wrapper input">
                                        <label for="username">USERNAME</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <input type="text" class="form-control" id="username" name="username" maxlength="100" value="${username}" 
                                               placeholder="Enter a username">
                                        <div style="color: red">${usernameError}</div>

                                    </div>

                                    <div id="email-field" class="field-wrapper input">
                                        <label for="email">EMAIL ADDRESS</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-at-sign register"><circle cx="12" cy="12" r="4"></circle><path d="M16 8v5a3 3 0 0 0 6 0v-1a10 10 0 1 0-3.92 7.94"></path></svg>
                                        <input type="email" class="form-control" id="email" name="email" maxlength="100" value="${email}" 
                                               placeholder="example@gmail.com">
                                        <div style="color: red">${emailError}</div>
                                    </div>

                                    <div id="dob-field" class="field-wrapper input">
                                        <label for="DOB">DATE OF BIRTH</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-calendar"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                        <input type="date" class="form-control" id="DOB" name="DOB" value="${DOB}" min="1900-01-01" max="2002-01-01" 
                                               >
                                        <div style="color: red">${DOBError}</div>
                                    </div>

                                    <div id="hp-field" class="field-wrapper input">
                                        <label for="DOB">PHONE NUMBER</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-phone"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                                        <input type="number" class="form-control" id="hp" name="phoneNumber" maxlength="11" value="${phoneNumber}" 
                                               placeholder="0123456789">
                                        <div style="color: red">${phoneNumberError}</div>
                                    </div>

                                    <div id="password-field" class="field-wrapper input mb-2">
                                        <label for="password">PASSWORD</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                        <input type="password" class="form-control" id="password" name="password" maxlength="100" value="" 
                                               placeholder="Enter your password" />
                                        <div style="color: red">${passwordError}</div>
                                    </div>

                                    <div id="confirmPassword-field" class="field-wrapper input mb-2">
                                        <label for="cPassword">CONFIRM PASSWORD</label>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-lock"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" maxlength="100" value="" 
                                               placeholder="Re-enter your password" />
                                        <div style="color: red">${confirmPasswordError}</div>
                                    </div>

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