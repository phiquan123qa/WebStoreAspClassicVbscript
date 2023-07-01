
<!--#include file="../connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD")= "POST")Then
    Dim Pname, Ptype, Pbrand, Pprice, Pcost, Pdescribe
    Pname = Request.Form("name")
    Ptype = Request.Form("type")
    Pbrand = Request.Form("brand")
    Pprice = Request.Form("price")
    Pcost = Request.Form("cost")
    Pdescribe = Request.Form("describe")

    If (NOT isnull(Pname) AND NOT isnull(Ptype) AND NOT isnull(Pbrand) AND NOT isnull(Pprice) AND NOT isnull(Pcost) AND NOT isnull(Pdescribe) AND TRIM(Pname)<>""AND TRIM(Ptype)<>""AND TRIM(Pbrand)<>""AND TRIM(Pprice)<>""AND TRIM(Pcost)<>""AND TRIM(Pdescribe)<>"") Then
            Dim sqlCheck
            sqlCheck = "INSERT INTO Products([name], [type], brand, price, cost, describe, isEnabled) VALUES(?, ?, ? ,? ,? ,?, DEFAULT)"
            Dim cmdPrep
            set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType=1
            cmdPrep.Prepared=true
            cmdPrep.CommandText = sqlCheck
            cmdPrep.Parameters(0)=Pname
            cmdPrep.Parameters(1)=Ptype
            cmdPrep.Parameters(2)=Pbrand
            cmdPrep.Parameters(3)=Pprice
            cmdPrep.Parameters(4)=Pcost
            cmdPrep.Parameters(5)=Pdescribe
            Dim result
            set result = cmdPrep.execute()
            Session("Success")="Add Successfully."
            connDB.Close()
            Response.redirect("productsAdmin.asp") 
    End if
End if
%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/products.css">
        <title>Add QTD</title>
    </head>
    <body style= "background-image: url('img/banner/bn_products.jpg'); ">
        <div class="container mt-3">
        <div class="row justify-content-center">
        <div class="col-md-6 "> 
            <form method="post" action="addProductsAdmin.asp">
                <div style = "text-align: center"><h1> Add Products </h1></div>
                    <div class="mb-2">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Input name" >
                    </div>
                    <div class="mb-2">
                        <label for="type" class="form-label">Type</label>
                        <input type="text" class="form-control" id="type" name="type" placeholder="Input type">
                    </div>
                    <div class="mb-2">
                        <label for="brand" class="form-label">Brand</label>
                        <input type="text" class="form-control" id="brand" name="brand" placeholder="Input brand">
                    </div>
                    <div class="mb-2">
                        <label for="price" class="form-label">Price</label>
                        <input type="number" class="form-control" id="price" name="price" placeholder="Input number">
                    </div>
                    <div class="mb-2">
                        <label for="cost" class="form-label">Cost</label>
                        <input type="number" class="form-control" id="cost" name="cost" placeholder="Input number">
                    </div>
                    <div class="mb-2">
                        <label for="describe" class="form-label">Describe</label>
                        <textarea type="text" class="form-control" id="describe" name="describe" placeholder="Input describe"></textarea>
                    </div>
                    <div class="mb-2 d-flex justify-content-between">
                        <a href="productsAdmin.asp">Back To Home</a>
                        <button type="submit" class="btn btn-primary"> Submit </button>
                    </div>
                </div>
            </form>
        </div>
        </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>         
    </body>
</html>