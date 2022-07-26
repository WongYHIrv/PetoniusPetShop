<%-- 
    Document   : adminLogin
    Author     : Vivian
--%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Login Page</title>
        <link rel="stylesheet" href="css/login.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/6f6d5e33e6.js"></script>
    </head>

    <body class="form">
        <div class="form-container outer">
            <div class="form-form">
                <div class="form-form-wrap">
                    <div class="form-container">
                        <div class="form-content">

                            <h1 class="">Sign In</h1>
                            <p class="">Log in to your account to continue.</p>
                            <div style="color: red;">${accountError}</div>
                            <!----------------------------------------------------------------------------------------->
                            <form class="text-left" method="post" action="VerifyAdminLogin">
                                <!----------------------------------------------------------------------------------------->
                                <div class="form">

                                    <div id="username-field" class="field-wrapper input mb-2">
                                        <div class="d-flex justify-content-between">
                                            <label for="username">USERNAME</label>
                                        </div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                             stroke-linejoin="round" class="feather feather-user">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                        </svg>
                                        <!----------------------------------------------------------------------------------------->
                                        <input id="username" name="username" type="text" class="form-control" value="${username}"
                                               placeholder="Enter your username here">
                                        <!----------------------------------------------------------------------------------------->
                                    </div>

                                    <div id="password-field" class="field-wrapper input mb-2">
                                        <div class="d-flex justify-content-between">
                                            <label for="password">PASSWORD</label>
                                        </div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                             fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                             stroke-linejoin="round" class="feather feather-lock">
                                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                        </svg>
                                        <!----------------------------------------------------------------------------------------->
                                        <input id="password" name="password" type="password" class="form-control"
                                               placeholder="Password">
                                        <!----------------------------------------------------------------------------------------->
                                        </svg>
                                    </div>
                                    <div class="radio-role">
                                        <div class="n-chk">
                                            Login role with: <br>
                                            <label class="new-control new-radio new-radio-text radio-primary">
                                                <!----------------------------------------------------------------------------------------->
                                                <input type="radio" class="new-control-input" name="position" value="M" checked ${positionManager}>
                                                <!----------------------------------------------------------------------------------------->
                                                <span class="new-control-indicator"></span><span
                                                    class="new-radio-content">Manager</span>
                                            </label>
                                        </div>
                                        <div class="n-chk">
                                            <label class="new-control new-radio new-radio-text radio-primary">
                                                <!----------------------------------------------------------------------------------------->
                                                <input type="radio" class="new-control-input" name="position" value="A" ${positionAdmin}>
                                                <!----------------------------------------------------------------------------------------->
                                                <span class="new-control-indicator"></span><span
                                                    class="new-radio-content">Admin</span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="d-sm-flex justify-content-between">
                                        <div class="field-wrapper">
                                            <button type="submit" class="btn btn-warning" value="">Log In</button>
                                        </div>
                                    </div>

                                    <div class="division">
                                        <span>OR</span>
                                    </div>

                                    <p class="customer-login">Back to <a href="login.jsp">Customer Login</a>
                                    </p>

                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>