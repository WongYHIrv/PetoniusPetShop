<%-- 
    Document   : About Us Section
    Author     : VIvianSSH, AbigailSA
--%>

<%
    String sessionName = (String) session.getAttribute("username");
    if (sessionName == null) {
        String redirectURL = "login.jsp";
        response.sendRedirect(redirectURL);
        return;
    }

    String pageName = "About Us";
    request.setAttribute("pageName", pageName);
%>

<jsp:include page="include/header.jsp" /> 
<link href="css/aboutUs.css" rel="stylesheet">

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
                <div class="fq-header-wrapper">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 align-self-center order-md-0 order-1">
                                <h1 class="">ABOUT US</h1>
                                <p class="">Who We Are</p>
                            </div>
                            <div class="col-md-6 order-md-0 order-0">
                                <div class="banner-img">
                                    <img src="assets/img/faq.svg" class="d-block" alt="header-image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq container">

                    <div class="faq-layouting layout-spacing">


                        <div class="fq-comman-question-wrapper">
                            <div class="row">
                                <div class="col-md-12">
                                    <h5>We started out as a small local pet shop of 2 staff back in 2015, has evolved
                                        into a huge family of over 16 dedicated team players!
                                        With over 7 incredible years of experience under our belt, it's no wonder
                                        Petonius is recognised as one of the top pet food suppliers.</h5>

                                    <br>

                                    <p style="text-indent: 3ch">Petonius is a locally owned and operated pet food and
                                        supply store. Our mission is to provide dog and cat parents with everything that
                                        they need to ensure their pet lives a long and happy life. We love to talk about
                                        pets of all types and we are even more excited when you bring your furry family
                                        member into the store to meet us! We are constantly researching and learning
                                        about new products that can make our pets lives better. </p>

                                    <p style="text-indent: 3ch">Our goal is to provide a clean, pet friendly store that
                                        has everything that your dog or cat needs. While our store is not very large, we
                                        offer an experience that is fast, friendly, local, and less expensive that the
                                        "Big Box" pet stores.
                                        Located in Ching Chong Cheng, Kota Kinabalu we look to serve all Dog and Cat
                                        owners in the surrounding areas by offering a local, low cost alternative to the
                                        "Big Box" pet stores. </p>

                                    <p style="text-indent: 3ch">We carry over 18 brands of Dog/Cat foods, including most
                                        major brands.
                                        We also have access to many brands that are not on our shelves so, if you don't
                                        see what you are looking for, please ask about special ordering! We also have an
                                        extensive selection of toys, treats, grooming supplies, supplements and outdoor
                                        supplies that dog or cat owners may need.</p>

                                    <p style="text-indent: 3ch">Our doors opened for the first time on April 12, 2015
                                        and we have been growing ever since. Thanks again for visiting our site and
                                        learning about our company!</p>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 