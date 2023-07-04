<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
Sub updateQuantity(idProduct, cond)
    ' Retrieve the current quantity from the session
    Dim currentCarts, quantity
    Set currentCarts = Session("mycarts")
    quantity = currentCarts.Item(idProduct)
    
    ' Update the quantity based on the condition
    If cond = "+" Then
        quantity = quantity + 1
    ElseIf cond = "-" Then
        quantity = quantity - 1
    End If
    
    ' Update the quantity in the session
    currentCarts.Item(idProduct) = quantity
    Set Session("mycarts") = currentCarts
    
    ' Perform a server-side redirect to update the page
    Response.Redirect "shoppingCart.asp"
End Sub

'Set currentCarts= Session("mycarts")
%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
    <title>Cart QTD</title>
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Lato&display=swap" >
    <link rel="stylesheet" type="text/css" href="/css/shoppingCart.css"/>
</head>
<body>
<%
    Dim quantity
    Dim currentCarts
    Dim itemCount
    Dim sum
    sum = 0
    If (NOT IsEmpty(Session("mycarts"))) Then
        Set currentCarts= Session("mycarts")
        itemCount = currentCarts.Count
%>
        <div class="card">
            <div class="row">
                <div class="col-md-8 cart" id="cart">
                    <div class="title">
                        <div class="row">
                            <div class="col"><h4><b>Shopping Cart</b></h4></div>
                            <div class="col align-self-center text-right text-muted"><%=itemCount%> items</div>
                        </div>
                    </div>
                    <%if(itemCount<1 or IsNull(currentCarts) or IsEmpty(currentCarts)) then
                        If (NOT isnull(Session("GiftCode")) AND TRIM(Session("GiftCode"))<>"") Then
                            Session.Contents.Remove("GiftCode")
                            Session.Contents.Remove("discount")
                        End If
                    %>
                    <div class="row border-top border-bottom">
                        <div class="row main align-items-center">
                            <div class="col">
                                <p>Your Cart now is empty</p>
                            </div>
                        </div>
                    </div>
                    <%
                    Else
                        For Each idProduct In currentCarts.Keys
                            quantity = currentCarts.Item(idProduct)
                            Dim productName, mainImage
                            Dim cmdPrep, rs
                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            connDB.Open()
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.CommandText = "SELECT p.name,p.type, p.price, d.mainImage, d.quantity FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE p.id=?"
                            cmdPrep.Parameters(0)=idProduct
                            Set rs = cmdPrep.execute()
                            If Not rs.EOF Then
                                productName = rs("name")
                                mainImage = rs("mainImage")
                                productType = rs("type") 
                                productPrice = rs("price")
                                sum = sum+productPrice*quantity
                                
                    %>
                    <div class="row border-top border-bottom">
                        <div class="row main align-items-center">
                            <div class="col-2"><img class="img-fluid" src="img/list/<%=mainImage%>"></div>
                            <div class="col">
                                <div class="row text-muted"><%=productType%></div>
                                <div class="row"><%=productName%></div>
                                <%If rs("quantity") < 10 Then%>
                                <div class="row" style="color:#ff000087">Only have <%=rs("quantity")%> left</div>
                                <%End If%>
                            </div>
                            <div class="col" style="display: flex;justify-content: center;align-items: center;">
                                <a href="subCart.asp?idProduct=<%=idProduct%>">-</a>
                                <input class="border" id="quantity_<%=idProduct%>" value="<%=quantity%>" style="width:26%;margin-top:25px" readonly/>
                                <%If quantity < rs("quantity") Then%>
                                <a href="addCart.asp?idProduct=<%=idProduct%>">+</a>
                                <%Else%>
                                <a href="addCart.asp?idProduct=<%=idProduct%>" style="pointer-events: none;">+</a>
                                <%End If%>
                            </div>
                            <div class="col">$ <%=productPrice%> <a  href="removeCart.asp?idProduct=<%=idProduct%>"><span class="close">&#10005;</span></a></div>
                        </div>
                    </div>
                    <%
                            End If
                            rs.Close
                            Set rs = Nothing
                            connDB.close()
                        Next
                        %>

                    
                    <%
                        End If
                    End If
                    %>
                




                    <div class="back-to-shop"><a href="listproducts.asp?key=&sort=hot">&leftarrow;<span class="text-muted">Back to shop</span></a></div>
                </div>

                <form method="post" action="createBill.asp" class="col-md-8 info" id="info" style="display:none">
                    <div class="">
                        <div class="row">
                            <div class="col"><h4><b>Contact Infomation</b></h4></div>
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput1">Name</label>
                            <input type="text" class="form-control" name="name" id="formGroupExampleInput1" placeholder="Input your name" required>
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Phone</label>
                            <input type="tel" class="form-control" name="phone" id="formGroupExampleInput2" placeholder="Input your phone " required>
                        </div>
                            <p class="mb-0">Address</p>
                            <br>
                            <div class="mainlocationinput">
                                <select class="locationinput" oninput="showCarLocation()" name="city" id="cityID">
                                    <option value="" selected="">Select Country</option>
                                </select>
                            </div>
                            <div class="">
                                <select class="locationinput" name="district" id="districtID" oninput="showCarLocation()">
                                    <option value="" selected="">Select District</option>
                                </select>
                            </div>
                            <div class="">
                                <select class="locationinput" name="ward" id="wardID" oninput="showCarLocation()">
                                    <option value="" selected="">Select Ward</option>
                                </select>
                            </div>
                            <div class=" addressinput">
                                <input type="text" name="street" placeholder="House number, Street" id="formGroupExampleInput3" required/>
                            </div>
                            <input type="hidden" name="Shipment" id="Shipment">
                            <input type="hidden" name = "Ttp" value="<%=sum%>">
                    </div>
                    <a href="" class="custom-btn btn-9" id="btn_back_cart" style="border:1px solid black;padding:10px;color:black">Back to cart</a>
                    <div class="back-to-shop"><a href="index.asp">&leftarrow;<span class="text-muted">Back to shop</span></a></div>
                </form>

                <div class="col-md-4 summary">
                    <div><h5><b>Summary</b></h5></div>
                    <hr>
                    <div class="row">
                        <div class="col" style="padding-left:0;">ITEMS <%=itemCount%></div>
                        <div class="col text-right ">$<%=sum%></div>
                    </div>
                    <div style="margin-top:2vh">
                        <p>SHIPPING</p>
                        <select id="deliverySelect" class="term" onchange="updateTotal()" required>
                            <option value ="0" class="text-muted" selected>Select Option Ship</option>
                            <option value ="5" class="text-muted">Standard-Delivery- $5.00</option>
                            <option value ="10" class="text-muted">Extra-Delivery- $10.00</option>
                        </select>
                        <p>GIVE CODE</p>
                        <form method="get" action="checkGiveCode.asp" class="form-inline" style="flex-wrap:nowrap; align-items:baseline">
                            <input id="code" name = "code" placeholder="Enter your code"  value="<%=Session("GiftCode")%>" style="margin-bottom:1vh">
                            <button class="btn" style="margin-top: 1vh;width:30%" type="submit">Check</button>
                        </form>
                        <%
                                If (NOT isnull(Session("GiftCode")) AND TRIM(Session("GiftCode"))<>"") Then
                                    Response.write("<p style='color:green'>Valid Discount Code</p>")
                                End If
                            %>
                    </div>
                    <%
                        If (NOT isnull(Session("discount")) AND TRIM(Session("discount"))<>"") Then
                    %>
                    <div class="row">
                        <div class="col">Discount code</div>
                        <div class="col text-right">-$ <%=Session("discount")%></div>
                    </div>
                    <%
                     End If
                    %>
                    <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                        <div class="col">TOTAL PRICE</div>
                        <input type="hidden" id="totalPricee" value="
                        <%
                        If (NOT isnull(Session("discount")) AND TRIM(Session("discount"))<>"") Then
                            sum = sum - CInt(Session("discount"))
                            Response.write(sum)
                        Else
                            Response.write(sum)
                        End if
                        %>
                        ">
                        <div class="col text-right" id="currentSum">$ <%=sum%></div>
                    </div>
                    <%
                    if(itemCount<1)Then%>
                    <button class="btn checkoutBtn">CHECKOUT</button>
                    <%Else%>
                        <%If(Not isnull(Session("email")) AND TRIM(Session("email"))<>"")Then%>
                            <button class="btn checkoutBtn" onclick="addSubmitFormForUser()" type="submit">CHECKOUT</button>
                        <%ELse%>
                            <button class="btn checkoutBtn" onclick="displayForm()" id="btnCheckout">CHECKOUT</button>
                            <button class="btn completeBtn" onclick="addSubmitForm()" type="submit" style="display:none" id="btnComplete">COMPLETE</button>
                        <%End if%>
                    <%
                    End if
                    %>

                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script type="text/javascript">
        function updateTotal() {
            var totalSum = 0;
            var realPrice = parseInt(document.getElementById("totalPricee").value)
            var selectElement = document.getElementById("deliverySelect");
            var selectedValue = parseInt(selectElement.options[selectElement.selectedIndex].value);

            var currentSumValue = document.getElementById("Shipment");
            currentSumValue.value = selectedValue;

            totalSum = realPrice + selectedValue;
            var currentSumElement = document.getElementById("currentSum");
            currentSumElement.innerText = "$ " + totalSum;
        }

        function addSubmitForm(){
            var form = document.getElementById("info");
            var shipType = document.getElementById('deliverySelect').value;
            var nameInfo = document.getElementById('formGroupExampleInput1').value;
            var phoneInfo = document.getElementById('formGroupExampleInput2').value;
            var addressInfo = document.getElementById('formGroupExampleInput3').value;
            var check=false;
            if(check==false){
                if (shipType == "0"&&nameInfo==""&&!phoneInfo.match("[0][0-9]{9}")&&addressInfo==""){
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (shipType == "0"&&nameInfo==""&&!phoneInfo.match("[0][0-9]{9}")){
                    document.getElementById('formGroupExampleInput3').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                }
                else if (shipType == "0"&&nameInfo==""&&addressInfo==""){
                    document.getElementById('formGroupExampleInput3').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                }
                else if (shipType == "0"&&!phoneInfo.match("[0][0-9]{9}")&&addressInfo==""){
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (nameInfo==""&&!phoneInfo.match("[0][0-9]{9}")&&addressInfo==""){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (shipType == "0"&&nameInfo==""){
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                }
                else if (shipType == "0"&&!phoneInfo.match("[0][0-9]{9}")){
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                }
                else if (shipType == "0"&&addressInfo==""){
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (nameInfo==""&&!phoneInfo.match("[0][0-9]{9}")){
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                }
                else if (nameInfo==""&&addressInfo==""){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (!phoneInfo.match("[0][0-9]{9}")&&addressInfo==""){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else if (shipType == "0"){
                    document.getElementById('deliverySelect').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                }
                else if (nameInfo==""){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                }
                else if (!phoneInfo.match("[0][0-9]{9}")){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "thin solid red";
                    document.getElementById('formGroupExampleInput3').style.border = "";
                }
                else if (addressInfo==""){
                    document.getElementById('deliverySelect').style.border = "";
                    document.getElementById('formGroupExampleInput1').style.border = "";
                    document.getElementById('formGroupExampleInput2').style.border = "";
                    document.getElementById('formGroupExampleInput3').style.border = "thin solid red";
                }
                else{
                check= true;
                }
            }
            if(check==true){
            document.getElementById('deliverySelect').style.border = "";
            document.getElementById('formGroupExampleInput1').style.border = "";
            document.getElementById('formGroupExampleInput2').style.border = "";
            document.getElementById('formGroupExampleInput3').style.border = "";
            form.submit();
            }
        }

        function addSubmitFormForUser(){
            var form = document.getElementById("info");
            var shipType = document.getElementById('deliverySelect').value;
            if (shipType == "0") {
                // Display an error message
                alert("Please select a ship type!");
                document.getElementById('deliverySelect').style.border = "thin solid red"
                returnToPreviousPage();
            }
            else{
            document.getElementById('deliverySelect').style.border = "";
            form.submit();
            }
        }

        function displayForm() {
        // Hide the shopping cart
        var cartElement = document.getElementById("cart");
        cartElement.style.display = "none";
        var infoElement = document.getElementById("info");
        infoElement.style.display = "block";
        var btncheckElement = document.getElementById("btnCheckout")
        btncheckElement.style.display = "none";
        var btncomElement = document.getElementById("btnComplete")
        btncomElement.style.display = "block";

        // Create a back button
        var backButton = document.getElementById('btn_back_cart');
            backButton.addEventListener('click', function() {
                // Show the shopping cart again
                cartElement.style.display = 'block';
                infoElement.style.display = "none";
                btncheckElement.style.display = "block";
                btncomElement.style.display = "none";
            });
        }
        //json input location
        var cities = document.getElementById("cityID");
        var districts = document.getElementById("districtID");
        var wards = document.getElementById("wardID");
        var Parameter = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promise = axios(Parameter);
        promise.then(function (result) {
            renderCity(result.data);
        });

        function renderCity(data) {
            for (const x of data) {
                cities.options[cities.options.length] = new Option(x.Name, x.Name);
            }
            cities.onchange = function () {
                districts.length = 1;
                wards.length = 1;
                if (this.value != "") {
                    const result = data.filter(n => n.Name === this.value);
                    for (const k of result[0].Districts) {
                        districts.options[districts.options.length] = new Option(k.Name, k.Name);
                    }
                }
            };
            districts.onchange = function () {
                wards.length = 1;
                const dataCity = data.filter((n) => n.Name === cities.value);
                if (this.value != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;
                    for (const w of dataWards) {
                        wards.options[wards.options.length] = new Option(w.Name, w.Name);
                    }
                }
            };
        }
        
    </script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
  <script type="text/javascript">
//   let shipItems = JSON.parse(sessionStorage.getItem("ShipItems")) || [];  
//     $(function() {
//     if (shipItems) {
//         shipItems.forEach(obj => {
//         const [k, v] = Object.entries(obj)[0]
//         $("#" + k).val(v)
//         })
//     }
//     $('.term').on("change", function() {
//         shipItems = $('.term').map(function() {
//         return {
//             [this.id]: this.value
//         }
//         }).get();
//         sessionStorage.setItem("ShipItems", JSON.stringify(shipItems))    
//     });

//     });
    </script>
</body>
</html>