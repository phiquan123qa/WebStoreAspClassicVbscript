<%'@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->

<%
    strSQL1 = "SELECT MONTH(dateCreate) AS Month, YEAR(dateCreate) AS Year, SUM(totalPrice) AS TotalMoney FROM [Order] WHERE dateCreate >= DATEADD(MONTH, -6, GETDATE()) GROUP BY YEAR(dateCreate), MONTH(dateCreate) ORDER BY YEAR(dateCreate), MONTH(dateCreate);"
    connDB.Open()
    Set Result1 = connDB.execute(strSQL1)
    Dim i
    i = 1
    While Not Result1.EOF
  %>
  <input type="hidden" id="Month<%=i%>" value="<%=Result1("Month")%>">
  <input type="hidden" id="Year<%=i%>" value="<%=Result1("Year")%>">
  <input type="hidden" id="Total<%=i%>" value="<%=Result1("TotalMoney")%>">
  <%
    i=i+1
    Result1.MoveNext()
    Wend
    connDB.Close()
  %>


  <%
    strSQL2 = "SELECT type, COUNT(*) AS count FROM Products GROUP BY type;"
    connDB.Open()
    Set Result2 = connDB.execute(strSQL2)
    Dim j
    j = 1
    totalProducts = 0
    While Not Result2.EOF
  %>
    <input type="hidden" id="Type<%=j%>" value="<%=Result2("type")%>">
    <input type="hidden" id="Count<%=j%>" value="<%=Result2("count")%>">
  <%
    j=j+1
    totalProducts = totalProducts + CInt(Result2("count"))
    Result2.MoveNext()
    Wend

    connDB.Close()
  %>
  <input type="hidden" id="TotalProducts" value="<%=totalProducts%>">
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modernize Free</title>
  <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
  <link rel="stylesheet" href="../css/styles.min.css" />
  <link rel="stylesheet" href="../css/tabler-icons/tabler-icons.css" />
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
          <div class="col-lg-7 d-flex align-items-strech">
            <div class="card w-100">
              <div class="card-body">
                <div class="d-sm-flex d-block align-items-center justify-content-between mb-9">
                  <div class="mb-3 mb-sm-0">
                    <h5 class="card-title fw-semibold">Sales Overview</h5>
                  </div>
                </div>
                <div id="chartt"></div>
              </div>
            </div>
          </div>
          <div class="col-lg-5">
                <!-- Yearly Breakup -->
                <div class="card" style="height:500px">
                  <div class="card-body p-4">
                    <h5 class="card-title mb-9 fw-semibold">About Products</h5>
                    <div class="row align-items-center mb-3">
                      <div id="chart"></div>
                    </div>
                    <p class="mb-0 fw-normal mt-3">
                    This section provides a detailed description of 
                    the products included in the report. It includes 
                    information about the product categories, subcategories,
                     and their respective features. Additionally, it outlines the
                      objectives and goals of the products.
                    </p>
                  </div>
                </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-12 d-flex align-items-stretch">
            <div class="card w-100">
              <div class="card-body p-4">
                <h5 class="card-title fw-semibold mb-4">Newest Transactions</h5>
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
                          <h6 class="fw-semibold mb-0">Phone</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Total Price</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Address</h6>
                        </th>
                        <th class="border-bottom-0">
                          <h6 class="fw-semibold mb-0">Order Status</h6>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                    <%
                      Dim cmddd
                      set cmddd = Server.CreateObject("ADODB.Command")
                      connDB.Open()
                      cmddd.ActiveConnection = connDB
                      cmddd.CommandType=1
                      cmddd.Prepared=true
                      cmddd.CommandText = "SELECT TOP(5) o.id idOrder , o.*, a.* FROM [Order] o JOIN Account a ON o.accId = a.id ORDER BY idOrder DESC"
                      Dim rsss
                      set rsss = cmddd.Execute()
                    %>
                    <%While Not rsss.EOF %>
                      <tr>
                        <td class="border-bottom-0"><h6 class="fw-semibold mb-0"><%=rsss("idOrder")%></h6></td>
                        <td class="border-bottom-0">
                            <p class="mb-0 fw-normal"><%=rsss("name")%></p>                        
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("phone")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("totalPrice")%> $</p>
                        </td>
                        <td class="border-bottom-0">
                          <p class="mb-0 fw-normal"><%=rsss("address")&", "&rsss("ward")&", "&rsss("district")&", "&rsss("city")%></p>
                        </td>
                        <td class="border-bottom-0">
                          <%If rsss("orderStatus")="True" Then%>
                          <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-danger rounded-3 fw-semibold">Prepare</span>
                          </div>
                          <%Else%>
                          <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-success rounded-3 fw-semibold">Complete</span>
                          </div>
                          <%End if%>
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
      </div>
    </div>
  </div>





  


  <script src="../js/jquery/dist/jquery.min.js"></script>
  <script src="../js/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../js/sidebarmenu.js"></script>
  <script src="../js/app.min.js"></script>
  <script src="../js/libs/apexcharts/dist/apexcharts.min.js"></script>
  <script src="../js/libs/simplebar/dist/simplebar.js"></script>
  <script>
    // Create arrays to store the values
    const years = [];
    const months = [];
    const totalMoney = [];

    // Retrieve the values from the hidden input fields
    for (let i = 1; i <= 6; i++) {
      const yearInput = document.getElementById(`Year${i}`);
      const monthInput = document.getElementById(`Month${i}`);
      const totalInput = document.getElementById(`Total${i}`);

      if (yearInput && monthInput && totalInput) {
        years.push(yearInput.value);
        months.push(monthInput.value);
        totalMoney.push(parseFloat(totalInput.value));
      }
    }

    // Create the chart data object
    const chartData1 = {
      years,
      months,
      totalMoney
    };

    // Create the chart options
    const chartOptions1 = {
      chart: {
        type: 'bar',
        height: 350,
        toolbar: { show: false },
        foreColor: "#adb0bb",
        fontFamily: 'inherit',
        sparkline: { enabled: false },
      },
      colors: ["#49BEFF"],
      plotOptions: {
      bar: {
        horizontal: false,
        columnWidth: "30%",
        borderRadius: [6],
        borderRadiusApplication: 'end',
        borderRadiusWhenStacked: 'all'
      },
    },
    grid: {
      borderColor: "rgba(0,0,0,0.1)",
      strokeDashArray: 3,
      xaxis: {
        lines: {
          show: false,
        },
      },
    },
    markers: { size: 0 },
      series: [{
        name: 'Total Money ($)',
        data: chartData1.totalMoney 
      }],
      xaxis: {
        categories: chartData1.months.map((month, index) => `${chartData1.years[index]}-${month}`)
      }
    };

    // Create the chart instance
    const chartt = new ApexCharts(document.querySelector("#chartt"), chartOptions1);

    // Render the chart
    chartt.render();
  </script>




  <script>
    // Retrieve the total number of products
  const totalProductsInput = document.getElementById("TotalProducts");
  const totalProducts = totalProductsInput ? parseInt(totalProductsInput.value) : 0;

  // Create arrays to store the values
  const types = [];
  const counts = [];

  // Retrieve the values from the hidden input fields
  for (let i = 1; i <= 6; i++) {
    const typeInput = document.getElementById(`Type${i}`);
    const countInput = document.getElementById(`Count${i}`);

    if (typeInput && countInput) {
      types.push(typeInput.value);
      counts.push(parseInt(countInput.value));
    }
  }

  // Create the chart data object
  const chartData2 = {
    types,
    counts
  };

  // Create the chart options
  const chartOptions2 = {
    chart: {
      type: 'donut',
      height: 350,
      toolbar: { show: false },
      foreColor: "#adb0bb",
      fontFamily: 'inherit',
      sparkline: { enabled: false },
    },
    plotOptions: {
      pie: {
        donut: {
          labels: {
            show: true,
            name: {
              show: true,
              fontSize: '14px',
              fontFamily: 'Helvetica, Arial, sans-serif',
              fontWeight: 600,
              color: undefined,
              offsetY: -10,
              formatter: function (val) {
                return val;
              }
            },
            value: {
              show: true,
              fontSize: '16px',
              fontFamily: 'Helvetica, Arial, sans-serif',
              fontWeight: 400,
              color: undefined,
              offsetY: 16,
              formatter: function (val) {
                return val;
              }
            },
            total: {
              show: true,
              showAlways: true,
              label: 'Total Products',
              fontSize: '16px',
              fontFamily: 'Helvetica, Arial, sans-serif',
              fontWeight: 600,
              color: '#373d3f',
              offsetY: 0,
              formatter: function () {
                return totalProducts;
              }
            }
          }
        }
      }
    },
    series: chartData2.counts,
    labels: chartData2.types
  };

  // Create the chart instance
  const chart = new ApexCharts(document.querySelector("#chart"), chartOptions2);

  // Render the chart
  chart.render();
  </script>

</body>
</html>