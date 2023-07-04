
<!--#include file="../connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD")= "POST")Then
    Dim Pname, Ptype, Pbrand, Pprice, Pcost, Pdescribe
    Pname = Request.Form("name")
    Ptype = Request.Form("type")
    Pbrand = Request.Form("brand")
    Pprice = Request.Form("price")
    Pcost = Request.Form("cost")
    Pdescribe = Request.Form("describe")

    If (NOT isnull(Pname) AND NOT isnull(Ptype) AND NOT isnull(Pbrand) AND NOT isnull(Pprice) AND NOT isnull(Pcost) AND NOT isnull(Pdescribe) AND TRIM(Pname)<>""AND TRIM(Ptype)<>""AND TRIM(Pbrand)<>""AND TRIM(Pprice)<>""AND TRIM(Pcost)<>""AND TRIM(Pdescribe)<>"") Then
        Dim sqlCheck
        sqlCheck = "INSERT INTO Products([name], [type], brand, price, cost, describe, isEnabled) VALUES(?, ?, ? ,? ,? ,?, DEFAULT)"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sqlCheck
        cmdPrep.Parameters(0)=Pname
        cmdPrep.Parameters(1)=Ptype
        cmdPrep.Parameters(2)=Pbrand
        cmdPrep.Parameters(3)=Pprice
        cmdPrep.Parameters(4)=Pcost
        cmdPrep.Parameters(5)=Pdescribe
        Dim result
        set result = cmdPrep.execute()
        Session("SuccessAddProduct")="Add Successfully."
        connDB.Close()
        Response.redirect("productsAdmin.asp") 
    Else
        Session("FailAddProduct")="Please fill all field."
    End if
End if
%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Modernize Free</title>
        <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
        <link rel="stylesheet" href="../css/styles.min.css" />
        <link rel="stylesheet" href="../css/tabler-icons/tabler-icons.css" />
    </head>
    <body>
    <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <!-- Sidebar Start -->
    <aside class="left-sidebar">
      <!-- Sidebar scroll-->
      <div>
        <div class="brand-logo d-flex align-items-center justify-content-between">
          <a href="./homeAdmin.asp" class="text-nowrap logo-img">
            <img class="py-3" src="../images/logos/qtdlogo.png" width="150" alt="" />
          </a>
          <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
          </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
          <ul id="sidebarnav">
            <li class="sidebar-item">
              <a class="sidebar-link" href="./homeAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-home"></i>
                </span>
                <span class="hide-menu">Home</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./productsAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-brand-producthunt"></i>
                </span>
                <span class="hide-menu">Products</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./billsAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-receipt-2"></i>
                </span>
                <span class="hide-menu">Bills</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./accAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-users"></i>
                </span>
                <span class="hide-menu">Accounts</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./giftAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-gift"></i>
                </span>
                <span class="hide-menu">Gift Code</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./feedbackAdmin.asp" aria-expanded="false">
                <span>
                  <i class="ti ti-file-description "></i>
                </span>
                <span class="hide-menu">Feed Back</span>
              </a>
            </li>
          </ul>
        </nav>
        <!-- End Sidebar navigation -->
      </div>
      <!-- End Sidebar scroll-->
    </aside>
    <!--  Sidebar End -->
    <!--  Main wrapper -->
    <div class="body-wrapper">
      <!--  Header Start -->
      <header class="app-header">
        <nav class="navbar navbar-expand-lg navbar-light">
          <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <%
				If  NOT isnull(Session("FailAddProduct")) AND TRIM(Session("FailAddProduct"))<>"" Then
					Response.write("<div id='alert' role='alert' class='alert alert-danger d-flex justify-content-center mt-3' style='width:40rem; left:200px'>"&Session("FailAddProduct")&"</div>")
    				Session("FailAddProduct") = ""
				End If
			%>
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
              <li class="nav-item dropdown">
                <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                  aria-expanded="false">
                  <img src="../images/profile/user-1.jpg" alt="" width="35" height="35" class="rounded-circle">
                </a>
                <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                  <div class="message-body">
                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                      <i class="ti ti-user fs-6"></i>
                      <p class="mb-0 fs-3">My Profile</p>
                    </a>
                    <a href="../logout.asp" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!--  Header End -->

    </div>
  </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 d-flex align-items-stretch justify-content-center">
                    <div class="card w-100" style="max-width:50rem; margin-top: 80px;">
                        <div class="card-body p-4" style="">
                            <div class="mb-4 d-flex justify-content-between">
                                <h5 class="card-title fw-semibold">Add Product</h5>        
                            </div>
                            <form method="post" action="addProductsAdmin.asp">
                                <div class="mb-2">
                                    <label for="name" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Input name" >
                                </div>
                                <div class="mb-2">
                                    <label for="type" class="form-label">Type</label>
                                    <input type="text" class="form-control" id="type" name="type" placeholder="Input type">
                                </div>
                                <div class="mb-2">
                                    <label for="brand" class="form-label">Brand</label>
                                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Input brand">
                                </div>
                                <div class="mb-2">
                                    <label for="price" class="form-label">Price</label>
                                    <input type="number" class="form-control" id="price" name="price" placeholder="Input number">
                                </div>
                                <div class="mb-2">
                                    <label for="cost" class="form-label">Cost</label>
                                    <input type="number" class="form-control" id="cost" name="cost" placeholder="Input number">
                                </div>
                                <div class="mb-2">
                                    <label for="describe" class="form-label">Describe</label>
                                    <textarea type="text" class="form-control" id="describe" name="describe" placeholder="Input describe"></textarea>
                                </div>
                                <div class="mb-2 d-flex justify-content-between">
                                    <a href="productsAdmin.asp">Back To Home</a>
                                    <button type="submit" class="btn btn-primary"> Submit </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/jquery/dist/jquery.min.js"></script>
        <script src="../js/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../js/sidebarmenu.js"></script>
        <script src="../js/app.min.js"></script>
        <script src="../js/libs/apexcharts/dist/apexcharts.min.js"></script>
        <script src="../js/libs/simplebar/dist/simplebar.js"></script>
          <script type="text/javascript">
        setTimeout(function () {
            // Closing the alert
            $('#alert').alert('close');
        }, 5000);
  </script>
    </body>
</html>