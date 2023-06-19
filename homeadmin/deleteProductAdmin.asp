<!--#include file="../connect.asp"-->
<%
Dim Pid
Pid = Request.QueryString("id")
If (NOT isnull(Pid) AND TRIM(Pid)<>"") Then
        Dim sql
        sql = "Delete from ProductsDetail where id=?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=Pid
        Dim result
        set result = cmdPrep.execute()

        Dim sqll
        sqll = "Delete from Products where id=?"
        Dim cmdPrepp
        set cmdPrepp = Server.CreateObject("ADODB.Command")
        cmdPrepp.ActiveConnection = connDB
        cmdPrepp.CommandType=1
        cmdPrepp.Prepared=true
        cmdPrepp.CommandText = sqll
        cmdPrepp.Parameters(0)=Pid
        Dim resultt
        set resultt = cmdPrepp.execute()
        Session("Success")="Add Successfully."
        Response.redirect("productsAdmin.asp") 
        connDB.Close()
End if
%>