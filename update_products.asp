
<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
    If isnull(Session("email")) Then
        Response.redirect("index.asp")
    Else
        Dim id, Pname, Ptype, Pbrand, Pprice, Pcost, Pdescribe
        id = Request.Form("id")
        Pname = Request.Form("Pname")
        Ptype = Request.Form("Ptype")
        Pbrand = Request.Form("Pbrand")
        Pprice = Request.Form("Pprice")
        Pcost = Request.Form("Pcost")
        Pdescribe = Request.Form("Pdescribe")
        Dim sql
        sql = "update Products set [name]= ?, [type]= ?, brand= ?, price= ?, cost= ?, describe= ? where id= ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=Pname 
        cmdPrep.Parameters(1)=Ptype
        cmdPrep.Parameters(2)=Pbrand
        cmdPrep.Parameters(3)=Pprice
        cmdPrep.Parameters(4)=Pcost
        cmdPrep.Parameters(5)=Pdescribe
        cmdPrep.Parameters(6)=id
        Dim result  
        set result = cmdPrep.execute()
        connDB.Close()
        Response.redirect("products.asp?id="&id)
        Session("SuccessProducts") = "Update complete!"
    End if
End if
%>
