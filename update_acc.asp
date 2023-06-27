<%@ Language="VBScript" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<!-- #include file="vbsUpload.asp" -->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
    If isnull(Session("email")) Then
        Response.redirect("index.asp")
    Else
        Dim name, email, phone, dateOfBirth, city, district, ward, address, avata
        name = Request.Form("name")
        email = Request.Form("email")
        phone = Request.Form("phone")
        dateOfBirth = Request.Form("dateOfBirth")
        city = Request.Form("city")
		district = Request.Form("district")
		ward = Request.Form("ward")
        address = Request.Form("street")
        avata = Request.Form("avata")

        Dim sql
        sql = "update Account set [name]=?, phone=?, dateOfBirth=CAST(? AS DATE), [address]=N'"&address&"', city=N'"&city&"', district=N'"&district&"', ward=N'"&ward&"' where email= ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=name
        cmdPrep.Parameters(1)=phone
        cmdPrep.Parameters(2)=dateOfBirth
        cmdPrep.Parameters(3)=email
        Response.Write(cmdPrep.CommandText)
        Dim result
        set result = cmdPrep.execute()
        connDB.Close()
        Session("SuccessAcc") = "Update complete!"
        Response.redirect("account.asp")
    End if
End if
%>
