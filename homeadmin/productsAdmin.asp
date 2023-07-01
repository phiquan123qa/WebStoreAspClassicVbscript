<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->
<%
Dim key
' ham lam tron so nguyen
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

' trang hien tai
    page = Request.QueryString("page")
    limit = 8

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
        key = Request.QueryString("key")
        sort=Request.QueryString("sort")
        typee=Request.QueryString("type")
        brand=Request.QueryString("brand")
        enable = Request.QueryString("enable")
        if(isnull(sort) OR TRIM(sort)="") then
            sort = "id"
        else
            sort=Request.QueryString("sort")
            if(sort="hot")then
                sort="id"
            end if
        end if
        'if(sort="id")then
            'sortPrice= "AND price<>cost "
        'end if
        if(isnull(typee) OR TRIM(typee)="") then
            typee = "is not null"
        else
            typee="='"&Request.QueryString("type")&"'"
        end if
        if(isnull(brand) OR TRIM(brand)="") then
            brand = "is not null"
        else
            brand="='"&Request.QueryString("brand")&"'"
        end if
        if(isnull(enable) or TRIM(enable)="") then
            enable = ""
        Else
          enable = " Or isEnabled = 0"
        end if
        IF(isnull(key) OR TRIM(key)="" AND sort="id")Then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products  WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand
        elseif(isnull(key) OR TRIM(key)="") then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products  WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand
        elseif(not isnull(key) AND sort="id" OR TRIM(key)<>"" AND sort="id") then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%'" 
        Else
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%'" 
        END IF
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
connDB.Close()
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
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <form class="card" id="form-input-search" method="get" action="productsAdmin.asp">
              <!--Search-->
                <div class="card-body p-2 d-flex align-items-center">
                  <label for="SearchInput" class="form-label mx-1">Search Products</label>
                  <input type="text" name="key" class="form-control mx-4" id="SearchInput" value="<%=key%>">
                  <!--Sort-->
                  <select id="Selection1" name= "sort" class="form-select mx-1">
                  <%sort=Request.QueryString("sort")%>
                    <option value="name" <%=checkPage(sort="name", "selected")%>>Name</option>
                    <option value="hot" <%=checkPage(sort="hot", "selected")%>>Hot</option>
                    <option value="price ASC" <%=checkPage(sort="price ASC", "selected")%>>Price up</option>
                    <option value="price DESC" <%=checkPage(sort="price DESC", "selected")%>>Price down</option>
                  </select>
                  <button type="submit" class="btn btn-light m-1 mx-1">Submit</button>
                </div>
                <div class="card-body p-2">
                  <!--Type-->
                  <div class="row">
                    <div class="col-lg-6">
                      <label for="Selection2" class="form-label">Type</label>
                      <%
                      Dim cmddd
                      set cmddd = Server.CreateObject("ADODB.Command")
                      connDB.Open()
                      cmddd.ActiveConnection = connDB
                      cmddd.CommandType=1
                      cmddd.Prepared=true
                      cmddd.CommandText = "SELECT DISTINCT type FROM Products  WHERE isEnabled = 1 ORDER BY type "
                      Dim rsss
                      set rsss = cmddd.Execute()
                      Dim typeinput
                      typeinput = Request.QueryString("type")
                      %>
                      <select id="Selection2" name="type" class="form-select">
                        <option value="" <%=checkPage(typeinput="", "selected")%>>All</option>
                        <%While Not rsss.EOF %>
                        <option value="<%=rsss("type")%>" <%=checkPage(typeinput=rsss("type"), "selected")%>><%=rsss("type")%></option>
                        <%
                        rsss.MoveNext()
                        Wend
                        rsss.Close()
                        connDB.Close()
                        %>
                      </select>
                      <%enable = Request.QueryString("enable")%>
                      <div class="d-flex align-items-baseline">
                        <label class="form-label mt-3" for="checkEnable">Enable</label>
                        <input id="checkEnable" class="form-input mx-2" type="checkbox" name="enable" <%=checkPage(enable="on", "checked")%>/>
                      </div>
                    </div>
                    <!--Brand-->
                    <div class="col-lg-6">
                      <label for="Selection3" class="form-label">Brand</label>
                      <%
                      Dim cmdddd
                      set cmdddd = Server.CreateObject("ADODB.Command")
                      connDB.Open()
                      cmdddd.ActiveConnection = connDB
                      cmdddd.CommandType=1
                      cmdddd.Prepared=true
                      cmdddd.CommandText = "SELECT DISTINCT brand FROM Products WHERE isEnabled = 1 ORDER BY brand"
                      Dim rssss
                      set rssss = cmdddd.Execute()
                      Dim brandinput
                      brandinput = Request.QueryString("brand")
                      %>
                      <select id="Selection3" name="brand" class="form-select">
                        <option value="" <%=checkPage(brandinput="", "selected")%>>All</option>
                        <%While Not rssss.EOF %>
                        <option value="<%=rssss("brand")%>" <%=checkPage(brandinput=rssss("brand"), "selected")%>><%=rssss("brand")%></option>
                        <%
                        rssss.MoveNext()
                        Wend
                        rssss.Close()
                        connDB.Close()
                        %>
                      </select>
                    </div>
                  </div>
                </div>
              </form>
              <a href="addProductsAdmin.asp"><button type="button" class="btn btn-primary">Add Product</button></a>
              <div class="products d-flex flex-wrap">
              <%
              Dim cmd
              set cmd = Server.CreateObject("ADODB.Command")
              connDB.Open()
              cmd.ActiveConnection = connDB
              cmd.CommandType=1
              cmd.Prepared=true
              If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
                  key = Request.QueryString("key")
                  sort=Request.QueryString("sort")
                  typee=Request.QueryString("type")
                  brand=Request.QueryString("brand")
                  enable = Request.QueryString("enable")
                  if(isnull(sort) OR TRIM(sort)="") then
                      sort = "id"
                  else
                      sort=Request.QueryString("sort")
                      if(sort="hot")then
                      sort="id"
                      end if
                  end if
                  'if(sort="id")then
                      'sortPrice= "AND price<>cost "
                  'end if
                  if(isnull(typee) OR TRIM(typee)="") then
                      typee = "is not null"
                  else
                      typee="='"&Request.QueryString("type")&"'"
                  end if
                  if(isnull(brand) OR TRIM(brand)="") then
                      brand = "is not null"
                  else
                      brand="='"&Request.QueryString("brand")&"'"
                  end if
                  if(isnull(enable) or TRIM(enable)="") then
                      enable = ""
                  Else
                    enable = " Or isEnabled = 0"
                  end if
                  IF(isnull(key) OR TRIM(key)="" AND sort="id")Then
                      cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE p.isEnabled = 1 "&enable&" AND p.type "&typee&" AND p.brand "&brand&" ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"
                  elseif(isnull(key) OR TRIM(key)="") then
                      cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand&" ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY "
                  elseif(not isnull(key) AND sort="id" OR TRIM(key)<>"" AND sort="id") then
                      cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%' ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY " 
                  Else
                      cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 "&enable&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%' ORDER BY "&sort&" OFFSET "& offset &"ROWS FETCH NEXT "& limit &" ROWS ONLY " 
                  END IF
              END IF
              Dim rs
              set rs = cmd.Execute()
              While Not rs.EOF %>
                <div class="col-md-3 p-1">
                  <div class="card" style = "min-height:30rem">
                    <img src="../img/list/<%= rs("mainImage")%>" class="card-img-top" alt="...">
                    <div class="card-body d-flex flex-wrap align-content-between">
                      <div style="width:14rem">
                        <h5 class="card-title mb-3"><%= rs("name") %></h5>
                        <h5 class="card-title" style="font-size: 13px;">Cost: <%= rs("cost") %>$</h5>
                        <h5 class="card-title" style="font-size: 13px;">Price <%= rs("price") %>$</h5>
                      </div>
                      <div>
                        <a href="editProductsAdmin.asp?id=<%=rs("id")%>" class="btn btn-primary">Edit</a>
                      </div>
                    </div>
                  </div>
                </div>
              <% rs.MoveNext()
              Wend
              rs.Close()
              connDB.Close()
              %>
              </div>
              <div class="pagination-container">
              <div class="pagination">
              <% 
              typee = Request.QueryString("type")
              brand = Request.QueryString("brand")
              enable = Request.QueryString("enable")
              IF( isnull(key) OR TRIM(key)="")Then
                  sort=Request.QueryString("sort")
                  if(isnull(sort) OR TRIM(sort)="") then
                      sort = "id"
                  else
                      sort=Request.QueryString("sort")
                  end if
                  if (pages>1) then
                      if(Clng(page)>=2) then%>
                          <a class="pagination-newer" href="productsAdmin.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=Clng(page)-1%>">Prev</a>
                  <%    
                      end if 
                      for i= 1 to range%>
                          <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="productsAdmin.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=i%>"><%=i%></a>
                  <%
                      next
                      if (Clng(page)<pages) then%>
                          <a class="pagination-older" href="productsAdmin.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=Clng(page)+1%>">Next</a>
                  <%
                      end if    
                  end if
              else
                  sort=Request.QueryString("sort")
                  if(isnull(sort) OR TRIM(sort)="") then
                      sort = "id"
                  else
                      sort=Request.QueryString("sort")
                  end if
                  if (pages>1) then
                      if(Clng(page)>=2) then%>
                      <a class="pagination-newer" href="productsAdmin.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=Clng(page)-1%>">Prev</a>
                  <%    
                      end if 
                      for i= 1 to range%>
                          <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="productsAdmin.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=i%>"><%=i%></a>
                  <%
                      next
                      if (Clng(page)<pages) then%>
                          <a class="pagination-older" href="productsAdmin.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&enable=<%=enable%>&page=<%=Clng(page)+1%>">Next</a>
                  <%
                      end if    
                  end if
              end if%>
                  </div>
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
</body>

</html>