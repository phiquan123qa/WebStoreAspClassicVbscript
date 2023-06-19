<%@ Language="VBScript" CODEPAGE="65001"%>
<!--#include file="../connect.asp"-->
<%
    If isnull(Session("email")) Then
        Response.redirect("../index.asp")
    Else
        Dim id, Pname, Ptype, Pbrand, Pprice, Pcost, Pdescribe, Penable, Pquantity
        id = Session("idp")
        Pname = Request.Form("name")
        Ptype = Request.Form("type")
        Pbrand = Request.Form("brand")
        Pprice = Request.Form("price")
        Pcost = Request.Form("cost")
		Pdescribe = Request.Form("describe")
        Pquantity = Request.Form("quantity")
        Penable = Request.Form("enable")
        if(isnull(Penable) Or Trim(Penable)="") then
            Penable = 0
        else
            Penable = 1
        end if

        Dim sql
        sql = sql & " UPDATE Products"
        sql = sql & " SET [name] = ?,"
        sql = sql & " [type] = ?,"
        sql = sql & " brand = ?,"
        sql = sql & " price = ?,"
        sql = sql & " cost = ?,"
        sql = sql & " [describe] = ?,"
        sql = sql & " isEnabled = ?"
        sql = sql & " WHERE id = ?;"
        sql = sql & " UPDATE ProductsDetail"
        sql = sql & " SET quantity = ?"
        sql = sql & " WHERE id = ?;"

        'Response.Write(sql)
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
        cmdPrep.Parameters(6)=Penable
        cmdPrep.Parameters(7)=id
        cmdPrep.Parameters(8)=Pquantity
        cmdPrep.Parameters(9)=id
        Response.Write(cmdPrep.CommandText)
        Dim result
        set result = cmdPrep.execute()
        connDB.Close()
        Session("SuccessPro") = "Update complete!"
        Response.redirect("editProductsAdmin.asp?id="&Session("idp"))
    End if
%>
