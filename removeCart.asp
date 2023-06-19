<!--#include file="connect.asp"-->
<%
    Dim idProduct
    idProduct = Request.QueryString("idproduct")
    If (NOT IsNull(idProduct) and idProduct <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Products WHERE id=?"
            cmdPrep.Parameters(0)=idProduct
            Set Result = cmdPrep.execute()

            If not Result.EOF then
                'ID exits
                'check session exists
                Dim currentCarts, arrays, cc, mycarts, List
                If (NOT IsEmpty(Session("mycarts"))) Then
                    ' true
                    Set currentCarts = Session("mycarts")                                                    
                    if currentCarts.Exists(idProduct) = true then
                            currentCarts.Remove(idProduct)
                    end if 
                    Set Session("mycarts") = currentCarts
                End if
                Session("SuccessCart") = "The Product has bean remove to your cart."
            Else
                Session("ErrorCart") = "The Product is not exists, please try again."
            End If
            Result.Close()
            connDB.Close()
            Response.redirect("shoppingCart.asp")            
    End if
%>