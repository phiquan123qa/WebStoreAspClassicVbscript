<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
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
                Dim currentCarts, arrays, cc, mycarts, List
                If (NOT IsEmpty(Session("mycarts"))) Then
                    Set currentCarts = Session("mycarts")                                                    
                    if currentCarts.Exists(idProduct) = true then
                        Dim value
                        value = Clng(currentCarts.Item(idProduct))+1
                        currentCarts.Item(idProduct) = value                        
                    else
                        currentCarts.Add idProduct, 1
                    end if 
                    Set Session("mycarts") = currentCarts
                Else
                    Dim quantity
                    quantity = 1
                    Set mycarts = Server.CreateObject("Scripting.Dictionary")
                    mycarts.Add idProduct, quantity
                    'creating a session for my cart
                    Set Session("mycarts") = mycarts
                    Set mycarts = Nothing
                    Response.Write("Session created!")
                End if
                Session("Success") = "The Product has bean added to your cart."
            Else
                Session("Error") = "The Product is not exists, please try again."
            End If
            Result.Close()
            connDB.Close()
            Response.redirect("shoppingCart.asp")            
    End if
End If
%>