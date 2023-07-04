<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->
<%
    If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
        Dim id
        id = Request.QueryString("id")
        Dim cmd
        set cmd = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmd.ActiveConnection = connDB
        cmd.CommandType=1
        cmd.Prepared=true
        cmd.CommandText = "SELECT o.accId, o.dateCreate, a.[name], a.city, a.ward, a.district, a.[address], a.phone, o.totalPrice, o.orderStatus, o.giftCode, o.shipment, g.discount FROM [Order] o LEFT JOIN Account a ON o.accId = a.id LEFT JOIN GiftCode g ON g.giftCode = o.giftCode WHERE o.id = ?"
        cmd.Parameters(0)=id
        Dim rs
        set rs = cmd.Execute()

        Dim cmdd
        set cmdd = Server.CreateObject("ADODB.Command")
        cmdd.ActiveConnection = connDB
        cmdd.CommandType=1
        cmdd.Prepared=true
        cmdd.CommandText = "SELECT p.[name], p.[type], p.brand, o.quantity, p.price FROM Products p JOIN OrderDetail o ON o.productId = p.id WHERE o.orderID = ?"
        cmdd.Parameters(0)=id
        Dim rss
        set rss = cmdd.Execute()
    End if
%>
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
          <div class="col-lg-12  d-flex align-items-stretch">
            <div class="card w-100">
              <div class="card-body p-4">
                <div class="mb-4 d-flex justify-content-between">
                <div class="col-md-8 pe-3">
                    <h5 class="card-title fw-semibold mb-4">Detail Recent Transactions</h5>
                    <div class="card">
                      <div class="card-body">
                        <div class="table-responsive">
                          <table class="table text-nowrap mb-0 align-middle">
                            <thead class="text-dark fs-4">
                              <tr>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Id</h6>
                                </th>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Name</h6>
                                </th>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Type</h6>
                                </th>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Brand</h6>
                                </th>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Quantity</h6>
                                </th>
                                <th class="border-bottom-0">
                                  <h6 class="fw-semibold mb-0">Price</h6>
                                </th>
                              </tr>
                            </thead>
                            <tbody>
                            <%While Not rss.EOF 
                            i=i+1
                            %>
                              <tr>
                                <td class="border-bottom-0"><h6 class="fw-semibold mb-0"><%=i%></h6></td>
                                <td class="border-bottom-0">
                                    <p class="mb-0 fw-normal"><%=rss("name")%></p>                        
                                </td>
                                <td class="border-bottom-0">
                                  <p class="mb-0 fw-normal"><%=rss("type")%></p>
                                </td>
                                <td class="border-bottom-0">
                                  <p class="mb-0 fw-normal"><%=rss("brand")%></p>
                                </td>
                                <td class="border-bottom-0">
                                  <p class="mb-0 fw-normal"><%=rss("quantity")%></p>
                                </td>
                                <td class="border-bottom-0">
                                  <p class="mb-0 fw-normal"><%=rss("price")%> $</p>
                                </td>
                              </tr> 
                              <%
                                rss.MoveNext()
                                Wend
                                rss.Close()
                              %>
                            </tbody>
                          </table>
                        </div>
                        <h6 class="card-subtitle my-2 text-muted">Shipment: <%=rs("shipment")%></h6>
                        <h6 class="card-subtitle my-2 text-muted">Gift Code: 
                          <%If NOT IsNull(rs("giftCode")) AND Trim(rs("giftCode"))<>"" Then
                              Response.write( rs("giftCode"))
                              Response.write("[ -" & rs("discount")&"$ ]")
                            Else
                              Response.write("None")
                            End If%>
                        </h6>
                        <h5>Total Price: <%=rs("totalPrice")%> $</h5>
                        <form method="post" action="billCompleteAdmin.asp">
                          <input type="hidden" name= "idBill" value="<%=id%>">
                          <button type="submit" class="btn btn-success my-2"<%If rs("orderStatus") = "False" Then Response.Write("disabled")%>>Complete Order</button>
                        </form>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-4">
                    <h5 class="card-title fw-semibold mb-4">Information of Customer</h5>
                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">Name: <%=rs("name")%></h5>
                        <h6 class="card-subtitle mb-2 text-muted">Address: <%=(rs("city")&", "&rs("district")&", "&rs("ward")&", "&rs("address"))%></h6>
                        <p class="card-text">Phone Number: <%=rs("phone")%></p>
                      </div>
                    </div>
                  </div>
                  <%connDB.Close()%>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>