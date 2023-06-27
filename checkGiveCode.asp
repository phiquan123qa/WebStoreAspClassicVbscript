<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
    Dim code
    code = Request.QueryString("code")
    If (NOT isnull(code) AND TRIM(code)<>"") Then
        Dim cmdPrep, rs
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "SELECT * FROM GiftCode WHERE giftCode=?"
        cmdPrep.Parameters(0)=code
        Set rs = cmdPrep.execute()
        If Not rs.EOF Then
            Session("GiftCode")= rs("giftCode")
            Session("discount")= rs("discount")
        Else
            Session.Contents.Remove("GiftCode")
            Session.Contents.Remove("discount")

        End If
        rs.Close
        connDB.close()
    End if
    Response.redirect("shoppingCart.asp")
End If
%>
