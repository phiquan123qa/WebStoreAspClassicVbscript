<!--#include file="../connect.asp"-->
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modernize Free</title>
  <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
  <link rel="stylesheet" href="../css/styles.min.css" />
  <link rel="stylesheet" href="../css/tabler-icons/tabler-icons.css" />
  <style>
  #chartt {
    max-width: 650px;
    margin: 35px auto;
  }
  </style>
</head>

<body>
  <%
    strSQL = "SELECT type, COUNT(*) AS count FROM Products GROUP BY type;"
    connDB.Open()
    Set Result = connDB.execute(strSQL)
    Dim i
    i = 1
    totalProducts = 0
    While Not Result.EOF
  %>
    <input type="hidden" id="Type<%=i%>" value="<%=Result("type")%>">
    <input type="hidden" id="Count<%=i%>" value="<%=Result("count")%>">
  <%
    i=i+1
    totalProducts = totalProducts + CInt(Result("count"))
    Result.MoveNext()
    Wend

    connDB.Close()
  %>
  <input type="hidden" id="TotalProducts" value="<%=totalProducts%>">
  <div id="chartt"></div>

  <script src="../js/jquery/dist/jquery.min.js"></script>
  <script src="../js/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../js/libs/apexcharts/dist/apexcharts.min.js"></script>
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
  const chartData = {
    types,
    counts
  };

  // Create the chart options
  const chartOptions = {
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
              fontSize: '16px',
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
    series: chartData.counts,
    labels: chartData.types
  };

  // Create the chart instance
  const chartt = new ApexCharts(document.querySelector("#chartt"), chartOptions);

  // Render the chart
  chartt.render();
  </script>
</body>

</html>
