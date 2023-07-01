<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD")= "POST")Then

    Dim giftcode, discount, expired, amount
    giftcode = Request.Form("giftcode")
    discount = Request.Form("discount")
    expired = Request.Form("expired")
    amount = Request.Form("amount")

    If (NOT isnull(giftcode) AND NOT isnull(discount) AND NOT isnull(expired) AND NOT isnull(amount) AND TRIM(giftcode)<>""AND TRIM(discount)<>""AND TRIM(expired)<>""AND TRIM(amount)<>"") Then
        Dim sqlCheck
        sqlCheck = "INSERT INTO GiftCode ( giftcode, discount, expire, amount) VALUES(?, ?, ? ,? )"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sqlCheck
        cmdPrep.Parameters(0)=giftcode
        cmdPrep.Parameters(1)=discount
        cmdPrep.Parameters(2)=expired
        cmdPrep.Parameters(3)=amount
        Dim result
        set result = cmdPrep.execute()
        Session("SuccessAddGiftCode")="Add Successfully."
        connDB.Close()
        Response.redirect("addGiftCodeAdmin.asp")
    End if
End if
%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modernize Free</title>
  <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
  <link rel="stylesheet" href="../css/styles.min.css" />
  <link rel="stylesheet" href="../css/tabler-icons/tabler-icons.css" />
  <link rel="stylesheet" href="../css/pagination.css" />
</head>

<body>
  <!--  Body Wrapper -->
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
      <div class="container-fluid">
        <!--  Row 1 -->
        <div class="row">
            <%
				If NOT isnull(Session("SuccessAddGiftCode")) AND TRIM(Session("SuccessAddGiftCode"))<>"" Then
					Response.write("<div id='alert' role='alert' class = 'alert alert-success d-flex justify-content-center'>"&Session("SuccessAddGiftCode")&"</div>")
    				Session("SuccessAddGiftCode") = null
				End If
			%>
          <div class="col-lg-12  d-flex align-items-stretch">
            <div class="card w-100">
              <div class="card-body p-4">
                <div class="mb-4 d-flex justify-content-between">
                  <h5 class="card-title fw-semibold">Add Gift Code</h5>
                </div>
                <form method="post" action="addGiftCodeAdmin.asp">
                        <div class="mb-2">
                            <label for="giftcode" class="form-label">Gift Code</label>
                            <input type="text" class="form-control" id="giftcode" name="giftcode" placeholder="Input Gift Code" >
                        </div>
                        <div class="mb-2">
                            <label for="discount" class="form-label">Discount</label>
                            <input type="number" class="form-control" id="discount" name="discount" placeholder="Input Discount">
                        </div>
                        <div class="mb-2">
                            <label for="expired" class="form-label">Expired</label>
                            <input type="date" class="form-control" id="expired" name="expired" placeholder="Input Expired">
                        </div>
                        <div class="mb-2">
                            <label for="amount" class="form-label">Amount</label>
                            <input type="number" class="form-control" id="amount" name="amount" placeholder="Input Amount">
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <a class="mt-3" href="giftAdmin.asp">Back</a>
                            <button type="submit" class="btn btn-primary"> Submit </button>
                        </div>
                    </div>
                </form>
              </div>
            </div>
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
  <script src="../js/dashboard.js"></script>
  <script type="text/javascript">
        setTimeout(function () {
            // Closing the alert
            $('#alert').alert('close');
        }, 5000);
    </script>
</body>
</html>