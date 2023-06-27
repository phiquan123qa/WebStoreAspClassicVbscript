<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
	Dim email, password
	email = Request.Form("email")
	password = Request.Form("password")
	If (NOT isnull(email) AND NOT isnull(password) AND TRIM(email)<>"" AND TRIM(password)<>"" ) Then
		Dim sql
		sql = "select * from Account where email= ? and password= ?"
		Dim cmdPrep
		set cmdPrep = Server.CreateObject("ADODB.Command")
		connDB.Open()
		cmdPrep.ActiveConnection = connDB
		cmdPrep.CommandType=1
		cmdPrep.Prepared=true
		cmdPrep.CommandText = sql
		cmdPrep.Parameters(0)=email
		cmdPrep.Parameters(1)=password
		Dim result
		set result = cmdPrep.execute()
		If not result.EOF Then
			Session("email")=result("email")
			Session("SuccessLogin")="Login Successfully"
			if(result("role")="ADMIN") then
				Response.redirect("homeadmin/homeAdmin.asp")
			else
				Response.redirect("index.asp")
			End If
		Else
			Session("ErrorLogin") = "Wrong email or password"
		End if
		result.Close()
		connDB.Close()
	Else
		Session("ErrorLogin")="Please input email and password"
	End if
End if
%>

<!DOCTYPE html>

<head>
	<title>Login QTD</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login QTD</title>
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
			<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-40">
				<%
				If  NOT isnull(Session("ErrorLogin")) AND TRIM(Session("ErrorLogin"))<>"" Then
					Response.write("<div id='alert' role='alert' class = 'alert alert-danger d-flex justify-content-center'>"&Session("ErrorLogin")&"</div>")
    				Session("ErrorLogin") = ""
				End If
				%>
				<form class="login100-form validate-form" method="post" action="login.asp">
					<span class="login100-form-title p-b-49">
						Login
					</span>

					<div class="wrap-input100 validate-input m-b-23" data-validate="Email is reauired">
						<span class="label-input100">Username</span>
						<input class="input100" type="text" name="email" placeholder="Type your email" value="<%=email%>">
						<span class="focus-input100" data-symbol="&#xf206;"></span>
					</div>

					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<span class="label-input100">Password</span>
						<input class="input100" type="password" name="password" placeholder="Type your password">
						<span class="focus-input100" data-symbol="&#xf190;"></span>
					</div>

					<div class="text-right p-t-8 p-b-31">
						<a href="#">
							Forgot password?
						</a>
					</div>

					<div class="container-login100-form-btn">
						<div class="wrap-login100-form-btn">
							<div class="login100-form-bgbtn"></div>
							<button class="login100-form-btn">
								Login
							</button>
						</div>
					</div>

					<div class="txt1 text-center p-t-54 p-b-20">
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

					<div class="flex-col-c p-t-50">
						<span class="txt1 p-b-17">
							Or Sign Up Using
						</span>

						<a href="register.asp" class="txt2 p-b-20">
							Sign Up
						</a>
					</div>
					<a href="index.asp" class="txt1">
					<i class="fa fa-arrow-left" aria-hidden="true"></i>
						Back To Home
					</a>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
        setTimeout(function () {
            // Closing the alert
            $('#alert').alert('close');
        }, 5000);
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

</body>

</html>