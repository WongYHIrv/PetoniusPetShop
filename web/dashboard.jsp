<%-- 
    Document   : dashboard + 3 types sales reports
    Author     : rexko
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

    String pageName = "Dashboard";
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
<%@page import="java.io.*"%>
<%
    Date d = new Date();
    int year = d.getYear() + 1900;
%>
<%
    String host = "jdbc:derby://localhost:1527/pet";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "Product";
    String tableName2 = "Cart";
    Connection conn = null;
    PreparedStatement stmt;
    PreparedStatement stmt1;
    PreparedStatement stmt2;
    PreparedStatement stmt3;
    PreparedStatement stmt4;
    PreparedStatement stmt5;
    PreparedStatement stmt6;
    PreparedStatement stmt7;
    PreparedStatement stmt8;
    PreparedStatement stmt9;
    PreparedStatement stmt10;
    PreparedStatement stmt11;
    PreparedStatement stmt12;
    PreparedStatement sstmt;
    PreparedStatement cstmt;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection(host, user, password);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>

<jsp:include page="include/header.jsp" /> 

<link href="https://fonts.googleapis.com/css?family=Quicksand:400,500,600,700&display=swap" rel="stylesheet">
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="assets/css/plugins.css" rel="stylesheet" type="text/css" />
<link href="plugins/apex/apexcharts.css" rel="stylesheet" type="text/css">
<link href="assets/css/dashboard/dash_1.css" rel="stylesheet" type="text/css" />
<link href="assets/css/loader.css" rel="stylesheet" type="text/css" />
<script src="assets/js/loader.js"></script>

<script>
    function changeFunc(i) {
        window.location.href = 'dashboard.jsp?year=' + i;
    }
</script>

<%
    String convertedRevenue = "0.00";
    String str = "SELECT SUM(SUBTOTAL) as revenue FROM TRANSACTIONS WHERE (DATEPURCHASED >= '" + request.getParameter("year") + "-01-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-12-31')";
    stmt = conn.prepareStatement(str);

    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        double revennue = rs.getDouble("revenue");
        convertedRevenue = String.format("%.2f", revennue);
    }

%>

<%int monthly[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};%>

<%

    String str1 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-01-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-01-31')";
    stmt1 = conn.prepareStatement(str1);

    ResultSet rs1 = stmt1.executeQuery();
    if (rs1.next()) {
        monthly[0] = rs1.getInt("revenue");
    }
%>

<%
    String str2 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-02-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-02-28')";
    stmt2 = conn.prepareStatement(str2);

    ResultSet rs2 = stmt2.executeQuery();
    if (rs2.next()) {
        monthly[1] = rs2.getInt("revenue");
    }
%>

<%
    String str3 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-03-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-03-31')";
    stmt3 = conn.prepareStatement(str3);

    ResultSet rs3 = stmt3.executeQuery();
    if (rs3.next()) {
        monthly[2] = rs3.getInt("revenue");
    }
%>

<%
    String str4 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-04-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-04-30')";
    stmt4 = conn.prepareStatement(str4);

    ResultSet rs4 = stmt4.executeQuery();
    if (rs4.next()) {
        monthly[3] = rs4.getInt("revenue");
    }
%>

<%
    String str5 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-05-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-05-31')";
    stmt5 = conn.prepareStatement(str5);

    ResultSet rs5 = stmt5.executeQuery();
    if (rs5.next()) {
        monthly[4] = rs5.getInt("revenue");
    }
%>

<%
    String str6 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-06-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-06-30')";
    stmt6 = conn.prepareStatement(str6);

    ResultSet rs6 = stmt6.executeQuery();
    if (rs6.next()) {
        monthly[5] = rs6.getInt("revenue");
    }
%>

<%
    String str7 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-07-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-07-31')";
    stmt7 = conn.prepareStatement(str7);

    ResultSet rs7 = stmt7.executeQuery();
    if (rs7.next()) {
        monthly[6] = rs7.getInt("revenue");
    }
%>

<%
    String str8 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-08-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-08-31')";
    stmt8 = conn.prepareStatement(str8);

    ResultSet rs8 = stmt8.executeQuery();
    if (rs8.next()) {
        monthly[7] = rs8.getInt("revenue");
    }
%>

<%
    String str9 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-09-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-09-30')";
    stmt9 = conn.prepareStatement(str9);

    ResultSet rs9 = stmt9.executeQuery();
    if (rs9.next()) {
        monthly[8] = rs9.getInt("revenue");
    }
%>

<%
    String str10 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-10-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-10-31')";
    stmt10 = conn.prepareStatement(str10);

    ResultSet rs10 = stmt10.executeQuery();
    if (rs10.next()) {
        monthly[9] = rs10.getInt("revenue");
    }
%>

<%
    String str11 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-11-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-11-30')";
    stmt11 = conn.prepareStatement(str11);

    ResultSet rs11 = stmt11.executeQuery();
    if (rs11.next()) {
        monthly[10] = rs11.getInt("revenue");
    }
%>

<%
    String str12 = "SELECT sum(subtotal) as revenue from transactions where (DATEPURCHASED >= '" + request.getParameter("year") + "-12-01' AND DATEPURCHASED <= '" + request.getParameter("year") + "-12-31')";
    stmt12 = conn.prepareStatement(str12);

    ResultSet rs12 = stmt12.executeQuery();
    if (rs12.next()) {
        monthly[11] = rs11.getInt("revenue");
    }
%>

<%
    int itemSold[] = {0, 0, 0, 0, 0};
%>

<%
    int j = 0;
    String cstr = "SELECT P.CATEGORY, SUM(T.QUANTITY) AS SOLD FROM PRODUCT P, TRANSACTIONS T WHERE T.PRODUCTID = P.ID AND T.DATEPURCHASED >= '" + request.getParameter("year") + "-01-01' AND T.DATEPURCHASED <= '" + request.getParameter("year") + "-12-31' GROUP BY P.CATEGORY ORDER BY P.CATEGORY";
    cstmt = conn.prepareStatement(cstr);

    ResultSet crs = cstmt.executeQuery();
    while (crs.next()) {
        if (crs.getString("CATEGORY").equals("CAGE")) {
            itemSold[0] = crs.getInt("SOLD");
        }
        if (crs.getString("CATEGORY").equals("CLOTH")) {
            itemSold[1] = crs.getInt("SOLD");
        }
        if (crs.getString("CATEGORY").equals("FOOD")) {
            itemSold[2] = crs.getInt("SOLD");
        }
        if (crs.getString("CATEGORY").equals("OTHER")) {
            itemSold[3] = crs.getInt("SOLD");
        }
        if (crs.getString("CATEGORY").equals("TOY")) {
            itemSold[4] = crs.getInt("SOLD");
        }
        
    }
%>

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
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 layout-spacing">
                    <div class="widget widget-chart-one">
                        <div class="widget-heading">
                            <h5 class="">

                                <table>
                                    <tr>
                                        <td>
                                            <h5>Revenue of &nbsp;&nbsp;</h5>
                                        </td>
                                        <td>
                                            <select class="form-control form-control-sm" id="selectBox" name="year" onchange="changeFunc(value);">
                                                <%
                                                    for (int i = 2020; i <= year; i++) {
                                                %>
                                                <option value="<%=i%>"

                                                        <%
                                                            if (i == Integer.parseInt(request.getParameter("year"))) {
                                                                out.println("selected");
                                                            }
                                                        %>

                                                        ><%=i%></option>
                                                <%
                                                    }
                                                %>

                                            </select>
                                        </td>
                                    </tr>
                                </table>

                            </h5>
                        </div>

                        <div class="widget-content">
                            <div id="revenueMonthly"></div>
                        </div>
                    </div>
                </div>

                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 layout-spacing">
                    <div class="widget widget-chart-two">
                        <div class="widget-heading">
                            <h5 class="">
                                <table>
                                    <tr>
                                        <td>Sales by Category in &nbsp;&nbsp;</td>
                                        <td>
                                            <select class="form-control form-control-sm" id="selectBox" name="year" onchange="changeFunc(value);">
                                                <%
                                                    for (int i = 2020; i <= year; i++) {
                                                %>
                                                <option value="<%=i%>"

                                                        <%
                                                            if (i == Integer.parseInt(request.getParameter("year"))) {
                                                                out.println("selected");
                                                            }
                                                        %>

                                                        ><%=i%></option>
                                                <%
                                                    }
                                                %>

                                            </select>
                                        </td>
                                    </tr>
                                </table>

                            </h5>
                        </div>
                        <div class="widget-content">
                            <div id="chart-2" class=""></div>
                        </div>
                    </div>
                </div>                                

                <div class="col-xl-12 col-lg-6 col-md-6 col-sm-6 col-12 layout-spacing">
                    <div class="widget widget-three">
                        <div class="widget-heading">
                            <h5 class="">
                                <table>
                                    <tr>
                                        <td><h5>Sales by Top 3 item in &nbsp;&nbsp;</h5></td>
                                        <td>

                                            <select class="form-control form-control-sm" id="selectBox" name="year" onchange="changeFunc(value);">
                                                <%
                                                    for (int i = 2020; i <= year; i++) {
                                                %>
                                                <option value="<%=i%>"

                                                        <%
                                                            if (i == Integer.parseInt(request.getParameter("year"))) {
                                                                out.println("selected");
                                                            }
                                                        %>

                                                        ><%=i%></option>
                                                <%
                                                    }
                                                %>

                                            </select>
                                        </td>
                                    </tr>
                                </table>

                            </h5>
                        </div>
                        <div class="widget-content">

                            <div class="order-summary">

                                <%
                                    int count = 0;
                                    String sstr = "SELECT P.NAME, P.QUANTITY, P.IMAGE, P.ID, SUM(T.QUANTITY) AS SOLD FROM PRODUCT P, TRANSACTIONS T WHERE P.ID = T.PRODUCTID "
                                            + "AND T.DATEPURCHASED >= '" + request.getParameter("year") + "-01-01' AND T.DATEPURCHASED <= '" + request.getParameter("year") + "-12-31' GROUP BY P.NAME, P.QUANTITY, P.IMAGE, P.ID ORDER BY SUM(T.QUANTITY) DESC fetch first 3 rows only";
                                    sstmt = conn.prepareStatement(sstr);

                                    ResultSet rss = sstmt.executeQuery();
                                    double sold = 0;
                                    double quantity = 0;
                                    double occ = 0;
                                    while (rss.next()) {
                                        count++;
                                %>

                                <div class="summary-list">
                                    <a style="color: blue" href="viewItem.jsp?id=<%=rss.getString("ID")%>"><img src="itemImage/<%=rss.getString("IMAGE")%>" width="40px" height="40px"></a>&nbsp; 

                                    <div class="w-summary-details">
                                        <div class="w-summary-info">
                                            <h5><a style="color: blue" href="viewItem.jsp?id=<%=rss.getString("ID")%>"><%=rss.getString("NAME")%></a></h5>
                                            <p class="summary-count"><%=rss.getString("SOLD")%> / <%=rss.getInt("SOLD") + rss.getInt("QUANTITY")%> Sold</p>
                                        </div>
                                        <div class="w-summary-stats">
                                            <div class="progress">
                                                <%
                                                    sold = rss.getDouble("SOLD");
                                                    quantity = rss.getDouble("QUANTITY");
                                                    occ = (sold / (sold + quantity)) * 100;
                                                %>
                                                <div class="progress-bar
                                                     <%
                                                         if (count == 1) {
                                                             out.print("bg-gradient-success");
                                                         } else if (count == 2) {
                                                             out.print("bg-gradient-secondary");
                                                         } else {
                                                             out.print("bg-gradient-warning");
                                                         }
                                                     %>

                                                     " role="progressbar" style="width: <%=occ%>%" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>   

                                <%
                                    }
                                    if (count == 0) {

                                %>
                                <h5 style="color: blue">No item sold in <%=request.getParameter("year")%></h5>
                                <%}%>
                            </div>

                        </div>
                    </div>
                </div>



            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp" /> 

<!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->

<script src="plugins/apex/apexcharts.min.js"></script>
<script>
                                                try {

                                                    /*
                                                     ==============================
                                                     |    @Options Charts Script   |
                                                     ==============================
                                                     */

                                                    /*
                                                     =============================
                                                     Daily Sales | Options
                                                     =============================
                                                     */
                                                    var d_2options1 = {
                                                        chart: {
                                                            height: 160,
                                                            type: 'bar',
                                                            stacked: true,
                                                            stackType: '100%',
                                                            toolbar: {
                                                                show: false,
                                                            }
                                                        },
                                                        dataLabels: {
                                                            enabled: false,
                                                        },
                                                        stroke: {
                                                            show: true,
                                                            width: 1,
                                                        },
                                                        colors: ['#e2a03f', '#e0e6ed'],
                                                        responsive: [{
                                                                breakpoint: 480,
                                                                options: {
                                                                    legend: {
                                                                        position: 'bottom',
                                                                        offsetX: -10,
                                                                        offsetY: 0
                                                                    }
                                                                }
                                                            }],
                                                        series: [{
                                                                name: 'Sales',
                                                                data: [44, 55, 41, 67, 22, 43, 21]
                                                            }, {
                                                                name: 'Last Week',
                                                                data: [13, 23, 20, 8, 13, 27, 33]
                                                            }],
                                                        xaxis: {
                                                            labels: {
                                                                show: false,
                                                            },
                                                            categories: ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
                                                        },
                                                        yaxis: {
                                                            show: false
                                                        },
                                                        fill: {
                                                            opacity: 1
                                                        },
                                                        plotOptions: {
                                                            bar: {
                                                                horizontal: false,
                                                                columnWidth: '25%',

                                                            }
                                                        },
                                                        legend: {
                                                            show: false,
                                                        },
                                                        grid: {
                                                            show: false,
                                                            xaxis: {
                                                                lines: {
                                                                    show: false
                                                                }
                                                            },
                                                            padding: {
                                                                top: 10,
                                                                right: 0,
                                                                bottom: -40,
                                                                left: 0
                                                            },
                                                        },
                                                    }

                                                    /*
                                                     =============================
                                                     Total Orders | Options
                                                     =============================
                                                     */

                                                    if (Cookies.getCookie('dark_mode') != "") {

                                                        var d_2options2 = {
                                                            chart: {
                                                                id: 'sparkline1',
                                                                group: 'sparklines',
                                                                type: 'area',
                                                                height: 290,
                                                                sparkline: {
                                                                    enabled: true
                                                                },
                                                            },
                                                            stroke: {
                                                                curve: 'smooth',
                                                                width: 2
                                                            },
                                                            fill: {
                                                                type: "gradient",
                                                                gradient: {
                                                                    type: "vertical",
                                                                    shadeIntensity: 1,
                                                                    inverseColors: !1,
                                                                    opacityFrom: .30,
                                                                    opacityTo: .05,
                                                                    stops: [100, 100]
                                                                }
                                                            },
                                                            series: [{
                                                                    name: 'Sales',
                                                                    data: [28, 40, 36, 52, 38, 60, 38, 52, 36, 40]
                                                                }],
                                                            labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                                                            yaxis: {
                                                                min: 0
                                                            },
                                                            grid: {
                                                                padding: {
                                                                    top: 125,
                                                                    right: 0,
                                                                    bottom: 0,
                                                                    left: 0
                                                                },
                                                            },
                                                            tooltip: {
                                                                x: {
                                                                    show: false,
                                                                },
                                                                theme: 'dark'
                                                            },
                                                            colors: ['#1abc9c']
                                                        }

                                                    } else {

                                                        var d_2options2 = {
                                                            chart: {
                                                                id: 'sparkline1',
                                                                group: 'sparklines',
                                                                type: 'area',
                                                                height: 290,
                                                                sparkline: {
                                                                    enabled: true
                                                                },
                                                            },
                                                            stroke: {
                                                                curve: 'smooth',
                                                                width: 2
                                                            },
                                                            fill: {
                                                                opacity: 1,
                                                            },
                                                            series: [{
                                                                    name: 'Sales',
                                                                    data: [28, 40, 36, 52, 38, 60, 38, 52, 36, 40]
                                                                }],
                                                            labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                                                            yaxis: {
                                                                min: 0
                                                            },
                                                            grid: {
                                                                padding: {
                                                                    top: 125,
                                                                    right: 0,
                                                                    bottom: 0,
                                                                    left: 0
                                                                },
                                                            },
                                                            tooltip: {
                                                                x: {
                                                                    show: false,
                                                                },
                                                                theme: 'dark'
                                                            },
                                                            colors: ['#1abc9c']
                                                        }

                                                    }

                                                    /*
                                                     =================================
                                                     Revenue Monthly | Options
                                                     =================================
                                                     */

                                                    if (Cookies.getCookie('dark_mode') != "") {
                                                        var options1 = {
                                                            chart: {
                                                                fontFamily: 'Nunito, sans-serif',
                                                                height: 365,
                                                                type: 'area',
                                                                zoom: {
                                                                    enabled: false
                                                                },
                                                                dropShadow: {
                                                                    enabled: true,
                                                                    opacity: 0.2,
                                                                    blur: 10,
                                                                    left: -7,
                                                                    top: 22
                                                                },
                                                                toolbar: {
                                                                    show: false
                                                                },
                                                                events: {
                                                                    mounted: function (ctx, config) {
                                                                        const highest1 = ctx.getHighestValueInSeries(0);
                                                                        const highest2 = ctx.getHighestValueInSeries(1);

                                                                        ctx.addPointAnnotation({
                                                                            x: new Date(ctx.w.globals.seriesX[0][ctx.w.globals.series[0].indexOf(highest1)]).getTime(),
                                                                            y: highest1,
                                                                            label: {
                                                                                style: {
                                                                                    cssClass: 'd-none'
                                                                                }
                                                                            },
                                                                            customSVG: {
                                                                                SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#2196f3" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                                                                cssClass: undefined,
                                                                                offsetX: -8,
                                                                                offsetY: 5
                                                                            }
                                                                        })

                                                                        ctx.addPointAnnotation({
                                                                            x: new Date(ctx.w.globals.seriesX[1][ctx.w.globals.series[1].indexOf(highest2)]).getTime(),
                                                                            y: highest2,
                                                                            label: {
                                                                                style: {
                                                                                    cssClass: 'd-none'
                                                                                }
                                                                            },
                                                                            customSVG: {
                                                                                SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#e7515a" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                                                                cssClass: undefined,
                                                                                offsetX: -8,
                                                                                offsetY: 5
                                                                            }
                                                                        })
                                                                    },
                                                                }
                                                            },
                                                            colors: ['#2196f3', '#e7515a'],
                                                            dataLabels: {
                                                                enabled: false
                                                            },
                                                            markers: {
                                                                discrete: [{
                                                                        seriesIndex: 0,
                                                                        dataPointIndex: 7,
                                                                        fillColor: '#000',
                                                                        strokeColor: '#000',
                                                                        size: 5
                                                                    }, {
                                                                        seriesIndex: 2,
                                                                        dataPointIndex: 11,
                                                                        fillColor: '#000',
                                                                        strokeColor: '#000',
                                                                        size: 4
                                                                    }]
                                                            },
                                                            subtitle: {
                                                                text: '$10,840',
                                                                align: 'left',
                                                                margin: 0,
                                                                offsetX: 95,
                                                                offsetY: 0,
                                                                floating: false,
                                                                style: {
                                                                    fontSize: '18px',
                                                                    color: '#4361ee'
                                                                }
                                                            },
                                                            title: {
                                                                text: 'Total Profit',
                                                                align: 'left',
                                                                margin: 0,
                                                                offsetX: -10,
                                                                offsetY: 0,
                                                                floating: false,
                                                                style: {
                                                                    fontSize: '18px',
                                                                    color: '#bfc9d4'
                                                                },
                                                            },
                                                            stroke: {
                                                                show: true,
                                                                curve: 'smooth',
                                                                width: 2,
                                                                lineCap: 'square'
                                                            },
                                                            series: [{
                                                                    name: 'Income',
                                                                    data: [16800, 16800, 15500, 17800, 15500, 17000, 19000, 16000, 15000, 17000, 14000, 17000]
                                                                }],
                                                            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                                            xaxis: {
                                                                axisBorder: {
                                                                    show: false
                                                                },
                                                                axisTicks: {
                                                                    show: false
                                                                },
                                                                crosshairs: {
                                                                    show: true
                                                                },
                                                                labels: {
                                                                    offsetX: 0,
                                                                    offsetY: 5,
                                                                    style: {
                                                                        fontSize: '12px',
                                                                        fontFamily: 'Nunito, sans-serif',
                                                                        cssClass: 'apexcharts-xaxis-title',
                                                                    },
                                                                }
                                                            },
                                                            yaxis: {
                                                                labels: {
                                                                    formatter: function (value, index) {
                                                                        return (value / 1000) + 'K'
                                                                    },
                                                                    offsetX: -22,
                                                                    offsetY: 0,
                                                                    style: {
                                                                        fontSize: '12px',
                                                                        fontFamily: 'Nunito, sans-serif',
                                                                        cssClass: 'apexcharts-yaxis-title',
                                                                    },
                                                                }
                                                            },
                                                            grid: {
                                                                borderColor: '#191e3a',
                                                                strokeDashArray: 5,
                                                                xaxis: {
                                                                    lines: {
                                                                        show: true
                                                                    }
                                                                },
                                                                yaxis: {
                                                                    lines: {
                                                                        show: false,
                                                                    }
                                                                },
                                                                padding: {
                                                                    top: 0,
                                                                    right: 0,
                                                                    bottom: 0,
                                                                    left: -10
                                                                },
                                                            },
                                                            legend: {
                                                                position: 'top',
                                                                horizontalAlign: 'right',
                                                                offsetY: -50,
                                                                fontSize: '16px',
                                                                fontFamily: 'Quicksand, sans-serif',
                                                                markers: {
                                                                    width: 10,
                                                                    height: 10,
                                                                    strokeWidth: 0,
                                                                    strokeColor: '#fff',
                                                                    fillColors: undefined,
                                                                    radius: 12,
                                                                    onClick: undefined,
                                                                    offsetX: 0,
                                                                    offsetY: 0
                                                                },
                                                                itemMargin: {
                                                                    horizontal: 0,
                                                                    vertical: 20
                                                                }
                                                            },
                                                            tooltip: {
                                                                theme: 'dark',
                                                                marker: {
                                                                    show: true,
                                                                },
                                                                x: {
                                                                    show: false,
                                                                }
                                                            },
                                                            fill: {
                                                                type: "gradient",
                                                                gradient: {
                                                                    type: "vertical",
                                                                    shadeIntensity: 1,
                                                                    inverseColors: !1,
                                                                    opacityFrom: .19,
                                                                    opacityTo: .05,
                                                                    stops: [100, 100]
                                                                }
                                                            },
                                                            responsive: [{
                                                                    breakpoint: 575,
                                                                    options: {
                                                                        legend: {
                                                                            offsetY: -30,
                                                                        },
                                                                    },
                                                                }]
                                                        }
                                                    } else {
                                                        var options1 = {
                                                            chart: {
                                                                fontFamily: 'Nunito, sans-serif',
                                                                height: 365,
                                                                type: 'area',
                                                                zoom: {
                                                                    enabled: false
                                                                },
                                                                dropShadow: {
                                                                    enabled: true,
                                                                    opacity: 0.2,
                                                                    blur: 10,
                                                                    left: -7,
                                                                    top: 22
                                                                },
                                                                toolbar: {
                                                                    show: false
                                                                },
                                                                events: {
                                                                    mounted: function (ctx, config) {
                                                                        const highest1 = ctx.getHighestValueInSeries(0);
                                                                        const highest2 = ctx.getHighestValueInSeries(1);

                                                                        ctx.addPointAnnotation({
                                                                            x: new Date(ctx.w.globals.seriesX[0][ctx.w.globals.series[0].indexOf(highest1)]).getTime(),
                                                                            y: highest1,
                                                                            label: {
                                                                                style: {
                                                                                    cssClass: 'd-none'
                                                                                }
                                                                            },
                                                                            customSVG: {
                                                                                SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#1b55e2" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                                                                cssClass: undefined,
                                                                                offsetX: -8,
                                                                                offsetY: 5
                                                                            }
                                                                        })

                                                                        ctx.addPointAnnotation({
                                                                            x: new Date(ctx.w.globals.seriesX[1][ctx.w.globals.series[1].indexOf(highest2)]).getTime(),
                                                                            y: highest2,
                                                                            label: {
                                                                                style: {
                                                                                    cssClass: 'd-none'
                                                                                }
                                                                            },
                                                                            customSVG: {
                                                                                SVG: '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="#e7515a" stroke="#fff" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" class="feather feather-circle"><circle cx="12" cy="12" r="10"></circle></svg>',
                                                                                cssClass: undefined,
                                                                                offsetX: -8,
                                                                                offsetY: 5
                                                                            }
                                                                        })
                                                                    },
                                                                }
                                                            },
                                                            colors: ['#1b55e2', '#e7515a'],
                                                            dataLabels: {
                                                                enabled: false
                                                            },
                                                            markers: {
                                                                discrete: [{
                                                                        seriesIndex: 0,
                                                                        dataPointIndex: 7,
                                                                        fillColor: '#000',
                                                                        strokeColor: '#000',
                                                                        size: 5
                                                                    }, {
                                                                        seriesIndex: 2,
                                                                        dataPointIndex: 11,
                                                                        fillColor: '#000',
                                                                        strokeColor: '#000',
                                                                        size: 4
                                                                    }]
                                                            },
                                                            subtitle: {

                                                                text: 'RM <%=convertedRevenue%>',
                                                                align: 'left',
                                                                margin: 0,
                                                                offsetX: 110,
                                                                offsetY: 0,
                                                                floating: false,
                                                                style: {
                                                                    fontSize: '18px',
                                                                    color: '#4361ee'
                                                                }
                                                            },
                                                            title: {
                                                                text: 'Total Income',
                                                                align: 'left',
                                                                margin: 0,
                                                                offsetX: -10,
                                                                offsetY: 0,
                                                                floating: false,
                                                                style: {
                                                                    fontSize: '18px',
                                                                    color: '#0e1726'
                                                                },
                                                            },
                                                            stroke: {
                                                                show: true,
                                                                curve: 'smooth',
                                                                width: 2,
                                                                lineCap: 'square'
                                                            },
                                                            series: [{
                                                                    //HEREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE VALUE
                                                                    name: 'Income',
                                                                    data: [<%=monthly[0]%>, <%=monthly[1]%>, <%=monthly[2]%>, <%=monthly[3]%>, <%=monthly[4]%>, <%=monthly[5]%>, <%=monthly[6]%>, <%=monthly[7]%>, <%=monthly[8]%>, <%=monthly[9]%>, <%=monthly[10]%>, <%=monthly[11]%>]
                                                                }],
                                                            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                                            xaxis: {
                                                                axisBorder: {
                                                                    show: false
                                                                },
                                                                axisTicks: {
                                                                    show: false
                                                                },
                                                                crosshairs: {
                                                                    show: true
                                                                },
                                                                labels: {
                                                                    offsetX: 0,
                                                                    offsetY: 5,
                                                                    style: {
                                                                        fontSize: '12px',
                                                                        fontFamily: 'Nunito, sans-serif',
                                                                        cssClass: 'apexcharts-xaxis-title',
                                                                    },
                                                                }
                                                            },
                                                            yaxis: {
                                                                labels: {
                                                                    formatter: function (value, index) {
                                                                        return (value / 1000) + 'K'
                                                                    },
                                                                    offsetX: -22,
                                                                    offsetY: 0,
                                                                    style: {
                                                                        fontSize: '12px',
                                                                        fontFamily: 'Nunito, sans-serif',
                                                                        cssClass: 'apexcharts-yaxis-title',
                                                                    },
                                                                }
                                                            },
                                                            grid: {
                                                                borderColor: '#e0e6ed',
                                                                strokeDashArray: 5,
                                                                xaxis: {
                                                                    lines: {
                                                                        show: true
                                                                    }
                                                                },
                                                                yaxis: {
                                                                    lines: {
                                                                        show: false,
                                                                    }
                                                                },
                                                                padding: {
                                                                    top: 0,
                                                                    right: 0,
                                                                    bottom: 0,
                                                                    left: -10
                                                                },
                                                            },
                                                            legend: {
                                                                position: 'top',
                                                                horizontalAlign: 'right',
                                                                offsetY: -50,
                                                                fontSize: '16px',
                                                                fontFamily: 'Nunito, sans-serif',
                                                                markers: {
                                                                    width: 10,
                                                                    height: 10,
                                                                    strokeWidth: 0,
                                                                    strokeColor: '#fff',
                                                                    fillColors: undefined,
                                                                    radius: 12,
                                                                    onClick: undefined,
                                                                    offsetX: 0,
                                                                    offsetY: 0
                                                                },
                                                                itemMargin: {
                                                                    horizontal: 0,
                                                                    vertical: 20
                                                                }
                                                            },
                                                            tooltip: {
                                                                theme: 'dark',
                                                                marker: {
                                                                    show: true,
                                                                },
                                                                x: {
                                                                    show: false,
                                                                }
                                                            },
                                                            fill: {
                                                                type: "gradient",
                                                                gradient: {
                                                                    type: "vertical",
                                                                    shadeIntensity: 1,
                                                                    inverseColors: !1,
                                                                    opacityFrom: .28,
                                                                    opacityTo: .05,
                                                                    stops: [45, 100]
                                                                }
                                                            },
                                                            responsive: [{
                                                                    breakpoint: 575,
                                                                    options: {
                                                                        legend: {
                                                                            offsetY: -30,
                                                                        },
                                                                    },
                                                                }]
                                                        }
                                                    }

                                                    /*
                                                     ==================================
                                                     Sales By Category | Options
                                                     ==================================
                                                     */

                                                    if (Cookies.getCookie('dark_mode') != "") {
                                                        var options = {
                                                            chart: {
                                                                type: 'donut',
                                                                width: 380
                                                            },
                                                            colors: ['#5c1ac3', '#e2a03f', '#e7515a', '#e2a03f'],
                                                            dataLabels: {
                                                                enabled: false
                                                            },
                                                            legend: {
                                                                position: 'bottom',
                                                                horizontalAlign: 'center',
                                                                fontSize: '14px',
                                                                markers: {
                                                                    width: 10,
                                                                    height: 10,
                                                                },
                                                                itemMargin: {
                                                                    horizontal: 0,
                                                                    vertical: 8
                                                                }
                                                            },
                                                            plotOptions: {
                                                                pie: {
                                                                    donut: {
                                                                        size: '65%',
                                                                        background: 'transparent',
                                                                        labels: {
                                                                            show: true,
                                                                            name: {
                                                                                show: true,
                                                                                fontSize: '29px',
                                                                                fontFamily: 'Nunito, sans-serif',
                                                                                color: undefined,
                                                                                offsetY: -10
                                                                            },
                                                                            value: {
                                                                                show: true,
                                                                                fontSize: '26px',
                                                                                fontFamily: 'Nunito, sans-serif',
                                                                                color: '#bfc9d4',
                                                                                offsetY: 16,
                                                                                formatter: function (val) {
                                                                                    return val
                                                                                }
                                                                            },
                                                                            total: {
                                                                                show: true,
                                                                                showAlways: true,
                                                                                label: 'Total',
                                                                                color: '#888ea8',
                                                                                formatter: function (w) {
                                                                                    return w.globals.seriesTotals.reduce(function (a, b) {
                                                                                        return a + b
                                                                                    }, 0)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            stroke: {
                                                                show: true,
                                                                width: 25,
                                                                colors: '#0e1726'
                                                            },
                                                            series: [985, 737, 270],
                                                            labels: ['Apparel', 'Sports', 'Others'],
                                                            responsive: [{
                                                                    breakpoint: 1599,
                                                                    options: {
                                                                        chart: {
                                                                            width: '350px',
                                                                            height: '400px'
                                                                        },
                                                                        legend: {
                                                                            position: 'bottom'
                                                                        }
                                                                    },

                                                                    breakpoint: 1439,
                                                                    options: {
                                                                        chart: {
                                                                            width: '250px',
                                                                            height: '390px'
                                                                        },
                                                                        legend: {
                                                                            position: 'bottom'
                                                                        },
                                                                        plotOptions: {
                                                                            pie: {
                                                                                donut: {
                                                                                    size: '65%',
                                                                                }
                                                                            }
                                                                        }
                                                                    },
                                                                }]
                                                        }
                                                    } else {

                                                        var options = {
                                                            chart: {
                                                                type: 'donut',
                                                                width: 380
                                                            },
                                                            colors: ['#5c1ac3', '#e2a03f', '#e7515a', '#A4D8D8', '#BFDEA4'],
                                                            dataLabels: {
                                                                enabled: false
                                                            },
                                                            legend: {
                                                                position: 'bottom',
                                                                horizontalAlign: 'center',
                                                                fontSize: '14px',
                                                                markers: {
                                                                    width: 10,
                                                                    height: 10,
                                                                },
                                                                itemMargin: {
                                                                    horizontal: 0,
                                                                    vertical: 8
                                                                }
                                                            },
                                                            plotOptions: {
                                                                pie: {
                                                                    donut: {
                                                                        size: '65%',
                                                                        background: 'transparent',
                                                                        labels: {
                                                                            show: true,
                                                                            name: {
                                                                                show: true,
                                                                                fontSize: '29px',
                                                                                fontFamily: 'Nunito, sans-serif',
                                                                                color: undefined,
                                                                                offsetY: -10
                                                                            },
                                                                            value: {
                                                                                show: true,
                                                                                fontSize: '26px',
                                                                                fontFamily: 'Nunito, sans-serif',
                                                                                color: '20',
                                                                                offsetY: 16,
                                                                                formatter: function (val) {
                                                                                    return val
                                                                                }
                                                                            },
                                                                            total: {
                                                                                show: true,
                                                                                showAlways: true,
                                                                                label: 'Total',
                                                                                color: '#888ea8',
                                                                                formatter: function (w) {
                                                                                    return w.globals.seriesTotals.reduce(function (a, b) {
                                                                                        return a + b
                                                                                    }, 0)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            },
                                                            stroke: {
                                                                show: true,
                                                                width: 25,
                                                            },
                                                            series: [<%=itemSold[0]%>, <%=itemSold[1]%>, <%=itemSold[2]%>, <%=itemSold[3]%>, <%=itemSold[4]%>],
                                                            labels: ['Cage & Aquarium', 'Clothes', 'Food & Treats', 'Others', 'Toys'],
                                                            responsive: [{
                                                                    breakpoint: 1599,
                                                                    options: {
                                                                        chart: {
                                                                            width: '350px',
                                                                            height: '400px'
                                                                        },
                                                                        legend: {
                                                                            position: 'bottom'
                                                                        }
                                                                    },

                                                                    breakpoint: 1439,
                                                                    options: {
                                                                        chart: {
                                                                            width: '250px',
                                                                            height: '390px'
                                                                        },
                                                                        legend: {
                                                                            position: 'bottom'
                                                                        },
                                                                        plotOptions: {
                                                                            pie: {
                                                                                donut: {
                                                                                    size: '65%',
                                                                                }
                                                                            }
                                                                        }
                                                                    },
                                                                }]
                                                        }

                                                    }
                                                    /*
                                                     ==============================
                                                     |    @Render Charts Script    |
                                                     ==============================
                                                     */


                                                    /*
                                                     ============================
                                                     Daily Sales | Render
                                                     ============================
                                                     */
                                                    var d_2C_1 = new ApexCharts(document.querySelector("#daily-sales"), d_2options1);
                                                    d_2C_1.render();

                                                    /*
                                                     ============================
                                                     Total Orders | Render
                                                     ============================
                                                     */
                                                    var d_2C_2 = new ApexCharts(document.querySelector("#total-orders"), d_2options2);
                                                    d_2C_2.render();

                                                    /*
                                                     ================================
                                                     Revenue Monthly | Render
                                                     ================================
                                                     */
                                                    var chart1 = new ApexCharts(
                                                            document.querySelector("#revenueMonthly"),
                                                            options1
                                                            );

                                                    chart1.render();

                                                    /*
                                                     =================================
                                                     Sales By Category | Render
                                                     =================================
                                                     */
                                                    var chart = new ApexCharts(
                                                            document.querySelector("#chart-2"),
                                                            options
                                                            );

                                                    chart.render();

                                                    /*
                                                     =============================================
                                                     Perfect Scrollbar | Recent Activities
                                                     =============================================
                                                     */
                                                    const ps = new PerfectScrollbar(document.querySelector('.mt-container'));

                                                    const topSellingProduct = new PerfectScrollbar('.widget-table-three .table-scroll table', {
                                                        wheelSpeed: .5,
                                                        swipeEasing: !0,
                                                        minScrollbarLength: 40,
                                                        maxScrollbarLength: 100,
                                                        suppressScrollY: true

                                                    });

                                                } catch (e) {
                                                    console.log(e);
                                                }

</script>
<!-- BEGIN PAGE LEVEL PLUGINS/CUSTOM SCRIPTS -->

