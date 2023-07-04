<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->
<%
Dim key
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function

    page = Request.QueryString("page")
    limit = 6

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    Dim cmdd
    set cmdd = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdd.ActiveConnection = connDB
    cmdd.CommandType=1
    cmdd.Prepared=true
    If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
        active = Request.QueryString("active")
        if(TRIM(active)="avaliable") then
          active = " amount > 0"
        Elseif(TRIM(active)="expired") then
          active = " amount < 1 OR amount IS NULL "
        Else
          active = " 1 = 1"
        end if
          cmdd.CommandText = "SELECT COUNT(giftCode) AS count FROM giftCode WHERE"& active
    END IF
    Dim rss
    set rss = cmdd.Execute()
    

    totalRows = CLng(rss("count"))

    Set rss = Nothing
    pages = Ceil(totalRows/limit)
    Dim range
    If (pages<=15) Then
        range = pages
    Else
        range = 99
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
          <%
            If  NOT isnull(Session("SuccessAddGiftCode")) AND TRIM(Session("SuccessAddGiftCode"))<>"" Then
              Response.write("<div id='alert' role='alert' class='alert alert-success d-flex justify-content-center mt-3' style='width:40rem; left:200px'>"&Session("SuccessAddGiftCode")&"</div>")
                Session("SuccessAddGiftCode") = ""
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
      <div class="container-fluid">
        <!--  Row 1 -->
        <div class="row">
          <div class="col-lg-12  d-flex align-items-stretch">
            <div class="card w-100">
              <div class="card-body p-4">
                <div class="mb-4 d-flex justify-content-between">
                  <h5 class="card-title fw-semibold">Gift Code</h5>
                  <%active = Request.QueryString("active")%>
                  <form action="giftAdmin.asp" class="d-flex" id="formStatus" method="get">
                    <div class="ps-2">
                      <input type="radio"  id="all" name="active" value="" <%=checkPage(active="", "checked")%>>
                      <label for="all">All</label><br>
                    </div>
                    <div class="ps-2">
                      <input type="radio" id="prepare" name="active" value="avaliable" <%=checkPage(active="avaliable", "checked")%>>
                      <label for="prepare">Avaliable</label><br>
                    </div>
                    <div class="ps-2">
                      <input type="radio" id="complete" name="active" value="expired" <%=checkPage(active="expired", "checked")%>>
                      <label for="complete">Expired</label>
                    </div>
                  </form>
                </div>
                <a href="addGiftCodeAdmin.asp"><button type="button" class="btn btn-primary mb-3">Add Gift Code</button></a>
                <div class="table-responsive">
                  <table class="table text-nowrap mb-0 align-middle">
                    <thead class="text-dark fs-4">
                      <tr>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Gift Code</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Discount</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Expire</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Amount</h6>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                    <%
                      Dim cmddd
                      set cmddd = Server.CreateObject("ADODB.Command")
                      cmddd.ActiveConnection = connDB
                      cmddd.CommandType=1
                      cmddd.Prepared=true
                      If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
                          active = Request.QueryString("active")
                          if(TRIM(active)="avaliable") then
                            active = " amount > 0"
                          Elseif(TRIM(active)="expired") then
                            active = " amount < 1 OR amount IS NULL"
                          Else
                            active = " 1 = 1"
                          end if
                      cmddd.CommandText = "SELECT * FROM GiftCode WHERE "& active &" ORDER BY expire OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"
                      END IF
                      Dim rsss
                      set rsss = cmddd.Execute()
                    %>
                    <%While Not rsss.EOF %>
                      <tr>
                        <td class="border-bottom-0">
                            <h6 class="fw-semibold mb-0"><%=rsss("giftCode")%></h6>                       
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("discount")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("expire")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("amount")%></p>
                        </td>
                      </tr> 
                      <%
                        rsss.MoveNext()
                        Wend
                        rsss.Close()
                        connDB.Close()
                      %>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="pagination-container">
              <div class="pagination">
              <% 
              active = Request.QueryString("active")
                  if (pages>1) then
                      if(Clng(page)>=2) then%>
                          <a class="pagination-newer" href="giftAdmin.asp?active=<%=active%>&page=<%=Clng(page)-1%>">Prev</a>
                  <%    
                      end if 
                      for i= 1 to range%>
                          <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="giftAdmin.asp?active=<%=active%>&page=<%=i%>"><%=i%></a>
                  <%
                      next
                      if (Clng(page)<pages) then%>
                          <a class="pagination-older" href="giftAdmin.asp?active=<%=active%>&page=<%=Clng(page)+1%>">Next</a>
                  <%
                      end if    
                  end if
                  %>
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
 <script>
  const form = document.getElementById('formStatus');
  const radioButtons = form.querySelectorAll('input[type="radio"]');
  radioButtons.forEach(radio => {
    radio.addEventListener('change', () => {
      form.submit();
    });
  });
</script>
<script type="text/javascript">
        setTimeout(function () {
            // Closing the alert
            $('#alert').alert('close');
        }, 5000);
  </script>
</body>
</html>