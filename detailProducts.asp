<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
    id = Request.QueryString("id")
    Dim cmddd
    set cmddd = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmddd.ActiveConnection = connDB
    cmddd.CommandType=1
    cmddd.Prepared=true
    cmddd.CommandText = "SELECT p.id, p.name, p.type, p.brand, p.price, p.cost, p.describe, d.quantity, d.mainImage, d.imageDes1, d.imageDes2, d.imageDes3 FROM Products p JOIN ProductsDetail d ON p.id = d.id WHERE isEnabled = 1 AND p.id = ? "
    cmddd.Parameters(0)= id
    Dim rs
    set rs = cmddd.Execute()
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Detail Products QTD</title>
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
        <link rel="stylesheet" href="./css/font-jost.css" data-tag="font" />
        <link rel="stylesheet" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="./css/reset.css"/>
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="./css/home.css"/>
        <style>
            
        </style>
        </head>
    <body>
        <!-- Navigation-->
        <!-- #include file="header.asp" -->
        <!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6 p-5">
                        <img class="card-img-top mb-5 mb-md-0 p-4" src="img/list/<%=rs("mainImage")%>" alt="..." />
                    </div>
                    <div class="col-md-6">
                        <h2 class="display-5 fw-bolder"><%=rs("name")%></h2>
                        <div class="small mb-1"><%=rs("type")%></div>
                        <div class="fs-5 mb-5">
                            <%If rs("cost") <> rs("price") THEN%>
                            <span class="text-decoration-line-through">$<%=rs("cost")%></span>
                            <%End If%>
                            <span>$<%=rs("price")%></span>
                        </div>
                        <p class="lead"><%=rs("describe")%></p>
                        <div class="d-flex mt-3">
                            <a href="addCart.asp?idProduct=<%=rs("id")%>"><button class="btn btn-outline-dark flex-shrink-0" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                            </button></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Related products</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    
                    <%
                    Dim cmdd
                    set cmdd = Server.CreateObject("ADODB.Command")
                    cmdd.ActiveConnection = connDB
                    cmdd.CommandType=1
                    cmdd.Prepared=true
                    cmdd.CommandText = "SELECT TOP 4 * FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE p.isEnabled=1 ORDER BY NEWID()"
                    Dim rss
                    set rss = cmdd.Execute()
                    %>

                    
                    <% While Not rss.EOF %>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <%If rss("cost")<>rss("price") then%>
                                <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <%End If%>
                            <!-- Product image-->
                            <img class="card-img-top" src="img/list/<%=rss("mainImage")%>" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <a href="detailProducts.asp?id=<%=rss("id")%>"><h5 class="fw-bolder"><%=rss("name")%></h5></a>
                                    <!-- Product price-->
                                    <%If rss("cost")<>rss("price") then%>
                                    <span class="text-muted text-decoration-line-through">$<%=rss("cost")%></span>
                                    <%End If%>
                                    $<%=rss("price")%>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="addCart.asp?idProduct=<%=rss("id")%>">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    
                    <%
                    rss.MoveNext() 
                    Wend 
                    connDB.Close()%>
                </div>
            </div>
        </section>






        <!-- Footer-->
        <!-- Bootstrap core JS-->
        <script src="js/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/libs/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>