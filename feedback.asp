<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
    function Check(cond)
        if (not isnull(cond) AND TRIM(cond)<>"") Then
            Response.Write("readonly='readonly'")
        end if
    end function


    Dim name, email, msg
    name = Request.Form("name")
    email = Request.Form("email")
    msg = Request.Form("msg")
    If(Not isnull(name) AND TRIM(name)<>"" AND Not isnull(email) And TRIM(email)<>"" And Not isnull(msg) And TRIM(msg)<>"") then
        Dim sql
        sqlCheck = "INSERT INTO Feedback([name], email, comment) VALUES(?, ?, ?)"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sqlCheck
        cmdPrep.Parameters(0)=name
        cmdPrep.Parameters(1)=email
		cmdPrep.Parameters(2)=msg
        Dim result
        set result = cmdPrep.execute()
        Session("Feedbackmsgcss")="Send Feedback Complete"
        connDB.Close()
    Else
        Session("Feedbackmsgerr")="Send Feedback Error"
    End if
    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
    <title>Feedback QTD</title>
    <link rel="stylesheet" href="./css/feedback.css">
</head>
<body>
    <div class="background">
        <div class="container">
            <div class="screen">
                <div class="screen-header">
                    <div class="screen-header-left">
                        <div class="screen-header-button close"></div>
                        <div class="screen-header-button maximize"></div>
                        <div class="screen-header-button minimize"></div>
                    </div>
                    <div class="screen-header-right">
                        <div class="screen-header-ellipsis"></div>
                        <div class="screen-header-ellipsis"></div>
                        <div class="screen-header-ellipsis"></div>
                    </div>
                </div>
                <div class="screen-body">
                    <div class="screen-body-item left">
                        <div class="app-title">
                            <span>CONTACT US</span>
                        </div>
                        <div class="app-contact">CONTACT INFO : +62 81 314 928 595</div>
                    </div>
                    <form method="post" action="feedback.asp" class="screen-body-item">
                        <div class="app-form">
                            <div class="app-form-group">
                                <input class="app-form-control" name="name" placeholder="NAME">
                            </div>
                            <div class="app-form-group">
                                <input class="app-form-control" name="email" placeholder="EMAIL" value="<%=Session("email")%>" <%=Check(Session("email"))%>/> 
                            </div>
                            <div class="app-form-group message">
                                <textarea class="app-form-control" name="msg" style="resize: none; width: 567px; height: 300px;" placeholder="MESSAGE"></textarea>
                            </div>
                            <div class="app-form-group buttons">
                                <button class="app-form-button"><a class="app-form-button" href="index.asp" style="text-decoration: none;">CANCEL</a></button>
                                <button type="submit" class="app-form-button">SEND</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>