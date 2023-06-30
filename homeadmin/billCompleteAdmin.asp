<!--#include file="../connect.asp"-->
<%
    If (Request.ServerVariables("REQUEST_METHOD")= "POST") Then
        id = Request.Form("idBill")
        Response.Write(id)
        if not IsNull(id) then
        Dim sql
        sql = "Update [Order] SET orderStatus = 0 WHERE id = ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0) = id
        Dim result
        set result = cmdPrep.execute()
        'Response.Redirect("detailBillAdmin.asp?id="& id)
        end if

    End if
%>