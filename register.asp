<!--#include file="connect.asp"-->
<%
Dim email, password, repassword, phone
email = Request.Form("email")
phone = Request.Form("phone")
password = Request.Form("password")
repassword = Request.Form("repassword")
If (NOT isnull(email) AND NOT isnull(phone) AND NOT isnull(password) AND NOT isnull(repassword) AND TRIM(email)<>"" AND TRIM(phone)<>""  AND TRIM(password)<>"" AND TRIM(repassword)<>"" ) Then
    

    If (password<>repassword OR TRIM(password)<>TRIM(repassword)) Then
        Session("ErrorRegister") = "Password and repassword not same!"
    Else
        Dim sqlCheck
        sqlCheck = "select * from Account where email= ? or phone=?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sqlCheck
        cmdPrep.Parameters(0)=email
		cmdPrep.Parameters(1)=phone
        Dim result, resultt
        set result = cmdPrep.execute()
        If result.EOF Then
            Dim sqlCreateAcc
            sqlCreateAcc = "Insert into Account ([name], email, phone, dateOfBirth, [address], dateCreate, [password], isEnabled) values(null, ?, ?, null, null,  DEFAULT, ?, DEFAULT)"
            Dim cmdPrepp
            Set cmdPrepp = Server.CreateObject("ADODB.Command")
            cmdPrepp.ActiveConnection = connDB
            cmdPrepp.CommandType=1
            cmdPrepp.Prepared=true
            cmdPrepp.CommandText = sqlCreateAcc
            cmdPrepp.Parameters(0)=email
            cmdPrepp.Parameters(1)=phone
            cmdPrepp.Parameters(2)=password
			Response.Write(cmdPrepp.CommandText)
            Set resultt = cmdPrepp.execute()
			If cmdPrepp.State = adStateOpen Then
            	Session("SuccessRegister")="Register Successfully"
            	Response.redirect("login.asp")
			Else
    			Session("ErrorRegister") = "Have Error"
			End If
		Elseif(not result.EOF AND not isnull(result("phone")) and isnull(result("email")))Then
			Dim sqlUpdateAcc
            sqlUpdateAcc = "UPDATE Account SET email=?, password=? Where phone =?"
            Dim cmdPreppp
            Set cmdPreppp = Server.CreateObject("ADODB.Command")
            cmdPreppp.ActiveConnection = connDB
            cmdPreppp.CommandType=1
            cmdPreppp.Prepared=true
            cmdPreppp.CommandText = sqlUpdateAcc
            cmdPreppp.Parameters(0)=email
            cmdPreppp.Parameters(1)=password
            cmdPreppp.Parameters(2)=phone
			Response.Write(cmdPreppp.CommandText)
            Set resultt = cmdPreppp.execute()
			If cmdPreppp.State = adStateOpen Then
            	Session("SuccessRegister")="Register Successfully"
            	Response.redirect("login.asp")
			Else
    			Session("ErrorRegister") = "Have Error"
			End If
        Else
            Session("ErrorRegister") = "This email or phone number already exits!"
        End if
        result.Close()
        connDB.Close()
    End if
Else
    Session("ErrorRegister")="Please input email, password and repassword."
	
End if
%>


<!DOCTYPE html>

<head>
	<title>Login QTD</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Register QTD</title>
	<link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
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
</head>

<body>

	<div class="limiter">
		<div class="container-login100" style="background-image: url('img/bg-01.jpg');">
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
				<%
				If NOT isnull(Session("ErrorRegister")) AND TRIM(Session("ErrorRegister"))<>"" Then
					Response.write("<div id='alert' role='alert' class = 'alert alert-danger d-flex justify-content-center'>"&Session("Error")&"</div>")
				End If
				'Session.Contents.Remove("ErrorRegister")
				%>
				<form class="login100-form validate-form" method="post" action="register.asp">
					<span class="login100-form-title p-b-49">
						Register
					</span>

					<div class="wrap-input100 validate-input m-b-23" data-validate="Email is reauired">
						<span class="label-input100">Username</span>
						<input class="input100" type="text" name="email" placeholder="Type your email" value="<%=email%>">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

                    <div class="wrap-input100 validate-input m-b-23" data-validate="Email is reauired">
						<span class="label-input100">Phone Number</span>
						<input class="input100" type="tel" name="phone" placeholder="Type your phone" value="<%=phone%>" pattern="[0][0-9]{9}">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-23" data-validate="Password is required">
						<span class="label-input100">Password</span>
						<input class="input100" type="password" name="password" placeholder="Type your password">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

                    <div class="wrap-input100 validate-input m-b-23" data-validate="Repassword is required">
						<span class="label-input100">Repassword</span>
						<input class="input100" type="password" name="repassword" placeholder="Type your repassword">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>


					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn">
								Register
							</button>
						</div>
					</div>

					<div class="txt1 text-center p-t-35 p-b-20">
						<span>
							Or Sign Up Using
						</span>
					</div>

					<div class="flex-c-m">
						<a href="#" class="login100-social-item bg1">
							<i class="fa fa-facebook"></i>
						</a>

						<a href="#" class="login100-social-item bg2">
							<i class="fa fa-twitter"></i>
						</a>

						<a href="#" class="login100-social-item bg3">
							<i class="fa fa-google"></i>
						</a>
					</div>

					<div class="flex-col-c p-t-40">
						<span class="txt1 p-b-17">
							Or Sign In Using
						</span>

						<a href="login.asp" class="txt2">
							Sign In
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="vendor/animsition/js/animsition.min.js"></script>
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js"></script>
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
	<script src="vendor/countdowntime/countdowntime.js"></script>
	<script src="js/main.js"></script>

</body>

</html>
