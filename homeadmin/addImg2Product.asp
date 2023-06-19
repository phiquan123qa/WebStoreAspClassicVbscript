<!-- #include file="../vbsUpload.asp" -->
<!--#include file="../connect.asp"-->
<%
Dim objUpload, lngLoop

If Request.TotalBytes > 0 Then
	Set objUpload = New vbsUpload
  For lngLoop = 0 to objUpload.Files.Count - 1
    objUpload.Files.Item(lngLoop).Save "C:\Users\admin\Desktop\QTDWebside\img\list"
    Dim name
    name = objUpload.Files.Item(lngLoop).FileName
    Response.Write(name)
     Dim sql
        sql = "update ProductsDetail set imageDes2= ? where id= ?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType=1
        cmdPrep.Prepared=true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0)=name
        cmdPrep.Parameters(1)=Session("idp")
        Response.Write(cmdPrep.CommandText)
        Dim result
        set result = cmdPrep.execute()
        connDB.Close()
	Next
  Response.redirect("editProductsAdmin.asp?id="&Session("idp"))
End if
%>