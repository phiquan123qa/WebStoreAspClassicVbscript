<%@ Language="VBScript" CodePage=65001 %>
<!--#include file="connect.asp"-->
<!-- #include file="vbsUpload.asp" -->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
    Dim name, email, phone, dateOfBirth, city, district, ward, address, avata
    email = Session("email")
    If isnull(email) OR TRIM(email)="" Then
        Response.redirect("index.asp")
    Else
        Dim sql
        sql = "select * from Account where email= ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=email
        Dim result
        set result = cmdPrep.execute()
        If not result.EOF Then
            name = result.Fields("name").Value
            email = result.Fields("email").Value
            phone = result.Fields("phone").Value
            dateOfBirth = result.Fields("dateOfBirth").Value
			city = result.Fields("city").Value
			district = result.Fields("district").Value
			ward = result.Fields("ward").Value
            address = result.Fields("address").Value
            avata = result.Fields("avata").Value
        Else
            Session("ErrorAcc") = "Something wrong with your account"
        End if
        result.Close()
        connDB.Close()
    End if
End if
%>




<!DOCTYPE html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="./images/logos/qtdlogo.png" />
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Account QTD</title>
    </head>
    <body>        
        
    <div class="limiter">
		<div class="container-login100" style="background-image: url('img/bg-01.jpg');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-40" style="min-width:700px;max-width:1000px">
				<%
				If NOT isnull(Session("ErrorAcc")) AND TRIM(Session("ErrorAcc"))<>"" Then
					Response.write("<div id='alert' role='alert' class = 'alert alert-danger d-flex justify-content-center'>"&Session("ErrorAcc")&"</div>")
    				Session("ErrorAcc") = ""
				End If
				%>
				<div>
                    <span class="login100-form-title p-b-30">
                    Edit Profile
                    </span>
                    <form method=post id="formAvata" enctype="multipart/form-data" action="addAvata.asp" style="display: flex; align-items: center; padding-bottom: 20px;">
                        <div class="wrap-input100 validate-input m-b-23">
                            <span class="label-input100" >Avata</span>
                            <div style="height:55px;display:flex">
                                <input type=file id="avata" name=avata>
                            </div>
                        </div>
                        <img src="/img/avata_user/<%=avata%>" alt="avata user" style="max-width:100px; border:2px solid #adadad; margin-left:10px"/>
                    </form>
                    <form class="login100-form validate-form" id="validate-form" method="post" accept-charset="UTF-8">
                        <div class="flex-row">
                            <div class="" style="flex:40%;margin-right:5%">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <span class="label-input100">Username</span>
                                    <input class="input100" type="text" name="name" id="name" placeholder="Type your name" value="<%=name%>">
                                    <span class="focus-input100" data-symbol="&#xf206;"></span>
                                </div>
                                <div class="wrap-input100 validate-input m-b-23">
                                    <span class="label-input100">Email</span>
                                    <input class="input100" type="text" name="email" id="email" placeholder="Type your email" value="<%=email%>" readonly>
                                    <span class="focus-input100" data-symbol="&#xf205;"></span>
                                </div>
                            </div>
                            <div class=""  style="flex:40%">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <span class="label-input100">Phone</span>
                                    <input class="input100" type="text" name="phone" id="phone" placeholder="Type your phone" value="<%=phone%>">
                                    <span class="focus-input100" data-symbol="&#xf206;"></span>
                                </div>
                                <div class="wrap-input100 validate-input m-b-23">
                                    <span class="label-input100">Date Of Birth</span>
                                    <input class="input100" type="date" name="dateOfBirth" id="dateOfBirth" value="<%=dateOfBirth%>">
                                    <span class="focus-input100" data-symbol="&#xf206;"></span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-group-field">Address</label>
                            <div>
                                <div style="margin-bottom: 10px">
                                    <select class="custom-select col-md-10" name="city" id="cityID">
                                        <option>Select City</option>
                                    </select>
                                    <p id="my_city" hidden><%=city%></p>
                                </div>
                                <div style="margin-bottom: 10px">
                                    <select class="custom-select col-md-10" name="district" id="districtID">
                                        <option>Select District</option>
                                    </select>
                                    <p id="my_district" hidden><%=district%></p></div>
                                <div style="margin-bottom: 10px">
                                    <select class="custom-select col-md-10" name="ward" id="wardID">
                                        <option>Select ward</option>
                                    </select>
                                    <p id="my_ward" hidden><%=ward%></p>
                                </div>
                                <div style="margin-bottom: 10px">
                                    <input type="text" name="street" class="form-text form-control"
                                    placeholder="House number, Street" name="street" id="street" value="<%=address%>"/>
                                </div>
                            </div>
                        </div>
                        <div class="container-login100-form-btn p-b-10">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" onclick="submitForm()" value="Upload">
                                    submit
                                </button>
                            </div>
                        </div>
                        <a href="index.asp" class="txt1">
                        <i class="fa fa-arrow-left" aria-hidden="true"></i>
                            Back To Home
                        </a>
                    </form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
        var formAvata = document.getElementById("formAvata");
        var avata = document.getElementById("avata");
        avata.addEventListener('change', function(event) {
            // Get the selected file
            var file = event.target.files[0];

            // Perform any necessary file validation or processing here

            // Redirect to another page
            formAvata.submit();
        });
        setTimeout(function () {
            // Closing the alert
            $('#alert').alert('close');
        }, 5000);

		function submitForm() {
			// get the form element
			var form = document.getElementById("validate-form");
			
			// set the form's action attribute to the URL of the script that will handle the form submission
			form.action = "update_acc.asp";
			
			// submit the form
			form.submit();
		}

    </script>
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<script src="js/main.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
	<script type="text/javascript">
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
            for (const c of data) {
                let option1 = new Option(c.Name, c.Name);
                cities.options[cities.options.length] = option1;
                if (c.Name === $("#my_city").text()) {
                    option1.selected = true;
                }
            }
            renderDistrict(data, $("#my_city").text(), 1);
            renderWard(data, $("#my_city").text(), $("#my_district").text(), 1)
            cities.onchange = function () {
                renderDistrict(data, this.value, 2)
            };
            districts.onchange = function () {
                renderWard(data, cities.value, this.value, 2);
            }
        }

        function renderDistrict(data, cityName, type) {
            districts.length = 1;
            wards.length = 1;
            if (cityName != "") {
                const result = data.filter(n => n.Name === cityName);
                if (type == 2) {
                    districts.options[0].selected = true;
                }
                for (const k of result[0].Districts) {
                    let option2 = new Option(k.Name, k.Name);
                    districts.options[districts.options.length] = option2;
                    if (type == 1 && k.Name === $("#my_district").text()) {
                        option2.selected = true;
                    }
                }
            }
        }

        function renderWard(data, cityName, districtName, type) {
            wards.length = 1;
            const dataCity = data.filter(n => n.Name === cityName);
            if (districtName != "") {
                const dataWards = dataCity[0].Districts.filter(n => n.Name === districtName)[0].Wards;
                if (type == 2) {
                    wards.options[0].selected = true;
                }
                for (const w of dataWards) {
                    let option3 = new Option(w.Name, w.Name);
                    wards.options[wards.options.length] = option3;
                    if (type == 1 && w.Name === $("#my_ward").text()) {
                        option3.selected = true;
                    }
                }
            }
        }
	</script>
    </body>
</html>