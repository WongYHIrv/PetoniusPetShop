<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.io.*"%>

<%
    String image = (String) session.getAttribute("image");
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");

    String position = (String) session.getAttribute("position");
    Date d = new Date();
    int year = d.getYear() + 1900;
%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no">
        <title><%out.println(request.getAttribute("pageName"));%></title>
        <link rel="icon" type="image/x-icon" href="image/petonius1.jpg" />
        <link href="assets/css/loader.css" rel="stylesheet" type="text/css" />
        <script src="assets/js/loader.js"></script>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="https://fonts.googleapis.com/css?family=Quicksand:400,500,600,700&display=swap" rel="stylesheet">
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->

        <!--  BEGIN CUSTOM STYLE FILE  -->
        <link href="assets/css/users/user-profile.css" rel="stylesheet" type="text/css" />
        <!--  END CUSTOM STYLE FILE  -->
    </head>

    <body class="sidebar-noneoverflow">

        <!-- BEGIN LOADER -->
        <div id="load_screen">
            <div class="loader">
                <div class="loader-content">
                    <div class="spinner-grow align-self-center"></div>
                </div>
            </div>
        </div>
        <!--  END LOADER -->

        <!--  BEGIN NAVBAR  -->
        <div class="header-container">
            <header class="header navbar navbar-expand-sm">

                <a href="javascript:void(0);" class="sidebarCollapse" data-placement="bottom"><svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                        class="feather feather-menu">
                    <line x1="3" y1="12" x2="21" y2="12"></line>
                    <line x1="3" y1="6" x2="21" y2="6"></line>
                    <line x1="3" y1="18" x2="21" y2="18"></line>
                    </svg></a>

                <div class="nav-logo align-self-center">
                    <a class="navbar-brand" href="

                       <%
                           if (position.equals("M") || position.equals("A")) {
                               out.println("dashboard.jsp?year=" + year);
                           } else {
                               out.println("homepage.jsp");
                           }
                       %>


                       "><img alt="logo" src="image/petonius1.jpg"> <span
                            class="navbar-brand-name">Petonius</span></a>
                </div>

                <ul class="navbar-item topbar-navigation">

                    <!--  BEGIN TOPBAR  -->
                    <div class="topbar-nav header navbar" role="banner">
                        <nav id="topbar">
                            <ul class="navbar-nav theme-brand flex-row  text-center">
                                <li class="nav-item theme-logo">
                                    <a href="homepage.jsp">
                                        <img src="image/petonius1.jpg" class="navbar-logo" alt="logo">
                                    </a>
                                </li>
                                <li class="nav-item theme-text">
                                    <a href="homepage.jsp" class="nav-link"> Petonius </a>
                                </li>
                            </ul>

                            <ul class="list-unstyled menu-categories" id="topAccordion">
                                <% if (position.equals("C")) { %> 
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Homepage")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="homepage.jsp">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                 stroke-linecap="round" stroke-linejoin="round" class="feather feather-home">
                                            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                            <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                            </svg>
                                            <span>Homepage</span>
                                        </div>
                                    </a>
                                </li>

                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("About Us")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="aboutUs.jsp">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                 stroke-linecap="round" stroke-linejoin="round"
                                                 class="feather feather-clipboard">
                                            <path
                                                d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2">
                                            </path>
                                            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                                            </svg>
                                            <span>About Us</span>
                                        </div>
                                    </a>
                                </li>
                                <!----------------------------------------------------------------------------------------------------------------->
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Shop")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="shop.jsp?searchResult=&category=">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-cart"><circle cx="9" cy="21" r="1"></circle><circle cx="20" cy="21" r="1"></circle><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path></svg>
                                            <span>Shop</span>
                                        </div>
                                    </a>
                                </li>
                                <!----------------------------------------------------------------------------------------------------------------->
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Item Status")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="itemStatus.jsp?status=PACKAGING">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-shopping-bag">
                                            <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
                                            <span>Item Status</span>
                                        </div>
                                    </a>
                                </li>
                                <!----------------------------------------------------------------------------------------------------------------->
                                <% } else if (position.equals("M") || position.equals("A")) {%>
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Dashboard")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="dashboard.jsp?year=<%=year%>">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                 stroke-linecap="round" stroke-linejoin="round"
                                                 class="feather feather-clipboard">
                                            <path
                                                d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2">
                                            </path>
                                            <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                                            </svg>
                                            <span>Dashboard</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Manage Item")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="manageItem.jsp?searchResult=&category=&status=&name=">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-archive" viewBox="0 0 16 16">
                                            <path d="M0 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v7.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 12.5V5a1 1 0 0 1-1-1V2zm2 3v7.5A1.5 1.5 0 0 0 3.5 14h9a1.5 1.5 0 0 0 1.5-1.5V5H2zm13-3H1v2h14V2zM5 7.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                            </svg>
                                            <span>Manage Item</span>
                                        </div>
                                    </a>
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Manage Status")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="manageItemStatus.jsp?transactionid=&status=">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-toggles" viewBox="0 0 16 16">
                                            <path d="M4.5 9a3.5 3.5 0 1 0 0 7h7a3.5 3.5 0 1 0 0-7h-7zm7 6a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm-7-14a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zm2.45 0A3.49 3.49 0 0 1 8 3.5 3.49 3.49 0 0 1 6.95 6h4.55a2.5 2.5 0 0 0 0-5H6.95zM4.5 0h7a3.5 3.5 0 1 1 0 7h-7a3.5 3.5 0 1 1 0-7z"/>
                                            </svg>
                                            <span>Manage Status</span>
                                        </div>
                                    </a>
                                </li>
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Sales Record")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="salesRecord.jsp?searchResult=&orderBy=datepurchased&sorting=desc">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-ui-checks" viewBox="0 0 16 16">
                                            <path d="M7 2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5v-1zM2 1a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2zm0 8a2 2 0 0 0-2 2v2a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2v-2a2 2 0 0 0-2-2H2zm.854-3.646a.5.5 0 0 1-.708 0l-1-1a.5.5 0 1 1 .708-.708l.646.647 1.646-1.647a.5.5 0 1 1 .708.708l-2 2zm0 8a.5.5 0 0 1-.708 0l-1-1a.5.5 0 0 1 .708-.708l.646.647 1.646-1.647a.5.5 0 0 1 .708.708l-2 2zM7 10.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5v-1zm0-5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 8a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                            </svg>
                                            <span>Sales Record</span>
                                        </div>
                                    </a>
                                </li>
                                <% if (position.equals("A")) { %> 
                                <li class="menu single-menu
                                    <%
                                        if ((request.getAttribute("pageName")).equals("Manage Account")) {
                                            out.println("active");
                                        }
                                    %>
                                    ">
                                    <a href="manageAccount.jsp?searchResult=&bannedUser=&orderBy=position&sorting=ASC">
                                        <div class="">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                 stroke-linejoin="round" class="feather feather-user">
                                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="12" cy="7" r="4"></circle>
                                            </svg>
                                            <span>Manage Account</span>
                                        </div>
                                    </a>
                                    <ul class="collapse submenu list-unstyled animated fadeInUp" id="dashboard" data-parent="#topAccordion">
                                        <li>
                                            <a href="index.html"> Sales </a>
                                        </li>
                                        <li>
                                            <a href="index2.html"> Analytics </a>
                                        </li>
                                    </ul>
                                </li>
                                <% } %>
                                <% } %>
                            </ul>
                        </nav>
                    </div>
                    <!--  END TOPBAR  -->

                </ul>

                <ul class="navbar-item flex-row ml-auto">
                    <li class="nav-item align-self-center search-animated">
                    </li>
                </ul>

                <ul class="navbar-item flex-row nav-dropdowns">
                    <li class="nav-item dropdown user-profile-dropdown order-lg-0 order-1">
                        <a href="javascript:void(0);" class="nav-link dropdown-toggle user" id="user-profile-dropdown"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <div class="media">
                                <img src="profileImage/<%out.println(image);%>" class="img-fluid" alt="admin-profile" height="25px" width="25px">
                            </div>
                        </a>
                        <div class="dropdown-menu position-absolute" aria-labelledby="userProfileDropdown">
                            <div class="user-profile-section">
                                <div class="media mx-auto">
                                    <div class="media-body">
                                            <h5><%out.println(firstName
                                                    + " " + lastName);%></h5>
                                    </div>
                                </div>
                            </div>

                            <% if (position.equals(
                                        "C")) { %> 
                            <div class="dropdown-item">
                                <a href="userProfile.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="feather feather-user">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                    </svg> <span>Profile</span>
                                </a>
                            </div>
                            <% }%>

                            <div class="dropdown-item">
                                <a href="include/killsession.jsp">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                         fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                         stroke-linejoin="round" class="feather feather-log-out">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                    </svg> <span>Log Out</span>
                                </a>
                            </div>
                        </div>

                    </li>
                </ul>
            </header>
        </div>