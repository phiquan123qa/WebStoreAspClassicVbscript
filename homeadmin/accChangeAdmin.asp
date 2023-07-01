<!--#include file="../connect.asp"-->
<%
    If (Request.ServerVariables("REQUEST_METHOD")= "POST")Then
        id = Request.Form("id")
        enable = Request.Form("enable")
        '1= true 0=false
        sql = "Update Account Set isEnabled = ? WHERE id = ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)= not enable
        cmdPrep.Parameters(1)= id
        Dim result
        set result = cmdPrep.execute()
        connDB.Close()
        Session("SuccessPro") = "Update complete!"
        Response.Redirect("accAdmin.asp")
    End If
%>