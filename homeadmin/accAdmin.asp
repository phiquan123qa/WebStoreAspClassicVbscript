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
        enable = Request.QueryString("enable")
        if(TRIM(enable)="enable") then
          enable = " isEnabled = 1"
        Elseif(TRIM(enable)="disable") then
          enable = " isEnabled = 0"
        Else
          enable = " isEnabled = 0 OR isEnabled = 1"
        end if
          cmdd.CommandText = "SELECT COUNT(id) AS count FROM Account WHERE" & enable
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
                  <h5 class="card-title fw-semibold">Manager Account</h5>
                  <%enable = Request.QueryString("enable")%>
                  <form action="accAdmin.asp" class="d-flex" id="formEnable" method="get">
                    <div class="ps-2">
                      <input type="radio"  id="all" name="enable" value="" <%=checkPage(enable="", "checked")%>>
                      <label for="all">All</label><br>
                    </div>
                    <div class="ps-2">
                      <input type="radio" id="enable" name="enable" value="enable" <%=checkPage(enable="enable", "checked")%>>
                      <label for="prepare">Enable</label><br>
                    </div>
                    <div class="ps-2">
                      <input type="radio" id="disable" name="enable" value="disable" <%=checkPage(enable="disable", "checked")%>>
                      <label for="complete">Disable</label>
                    </div>
                  </form>
                </div>
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
                          <h6 class="fw-semibold mb-0">Email</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Phone</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Address</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">DOB</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Date Create</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Role</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Active</h6>
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
                          enable = Request.QueryString("enable")
                          if(TRIM(enable)="enable") then
                            enable = " isEnabled = 1"
                          Elseif(TRIM(enable)="disable") then
                            enable = " isEnabled = 0"
                          Else
                            enable = " isEnabled = 0 OR isEnabled = 1"
                          end if
                      cmddd.CommandText = "SELECT * FROM Account WHERE"& enable &" ORDER BY id ASC OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"
                      END IF
                      Dim rsss
                      set rsss = cmddd.Execute()
                    %>
                    <%While Not rsss.EOF %>
                      <tr>
                        <td class="border-bottom-0"><h6 class="fw-semibold mb-0"><%=rsss("id")%></h6></td>
                        <td class="border-bottom-0">
                            <p class="mb-0 fw-normal"><%=rsss("name")%></p>                        
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("email")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("phone")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("city")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%= Right("0" & Day(rsss("dateOfBirth")), 2) & "/" & Right("0" & Month(rsss("dateOfBirth")), 2) & "/" & Year(rsss("dateOfBirth")) %></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%= FormatDateTime(rsss("dateCreate"), 2) & " " & Right("0" & Hour(rsss("dateCreate")), 2) & ":" & Right("0" & Minute(rsss("dateCreate")), 2) %></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("role")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <%If rsss("isEnabled")="True" Then%>
                          <div class="d-flex align-items-center gap-2">
                            <a href= "" <%=checkPage(rsss("role")="ADMIN", "style='pointer-events: none'")%> data-bs-toggle="modal" data-bs-target="#disableModal<%=rsss("id")%>"><span class="badge bg-success rounded-3 fw-semibold">Active</span></a>
                          </div>
                          <%Else%>
                          <div class="d-flex align-items-center gap-2">
                            <a href ="" data-bs-toggle="modal" data-bs-target="#disableModal<%=rsss("id")%>"><span class="badge bg-danger rounded-3 fw-semibold" >Disable</span></a>
                          </div>
                          <%End if%>
                        </td>
                      </tr> 
                      <div class="modal fade" id="disableModal<%=rsss("id")%>" tabindex="-1" aria-labelledby="disableModal<%=rsss("id")%>Label" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                          <div class="modal-content">
                            <div class="modal-header">
                              <h5 class="modal-title" id="disableModal<%=rsss("id")%>Label">Confirm Change Active</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                              Do you want to change active user <mark><%=rsss("name")%></mark>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                              <form action="accChangeAdmin.asp" method="post">
                                <input type="hidden" name="id" value="<%=rsss("id")%>"/>
                                <input type="hidden" name="enable" value="<%=rsss("isEnabled")%>"/>
                                <button type="submit" class="btn btn-danger">Change</button>
                              </form>
                            </div>
                          </div>
                        </div>
                      </div>
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
              status = Request.QueryString("status")
                  if (pages>1) then
                      if(Clng(page)>=2) then%>
                          <a class="pagination-newer" href="billsAdmin.asp?status=<%=status%>&page=<%=Clng(page)-1%>">Prev</a>
                  <%    
                      end if 
                      for i= 1 to range%>
                          <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="billsAdmin.asp?status=<%=status%>&page=<%=i%>"><%=i%></a>
                  <%
                      next
                      if (Clng(page)<pages) then%>
                          <a class="pagination-older" href="billsAdmin.asp?status=<%=status%>&page=<%=Clng(page)+1%>">Next</a>
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
  const form = document.getElementById('formEnable');
  const radioButtons = form.querySelectorAll('input[type="radio"]');
  radioButtons.forEach(radio => {
    radio.addEventListener('change', () => {
      form.submit();
    });
  });
</script>
</body>
</html>