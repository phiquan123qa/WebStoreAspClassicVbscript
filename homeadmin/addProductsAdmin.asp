
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
            Session("SuccessAddProduct")="Add Successfully."
            connDB.Close()
            Response.redirect("productsAdmin.asp") 
    End if
End if
%>
<!DOCTYPE html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Modernize Free</title>
        <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
        <link rel="stylesheet" href="../css/styles.min.css" />
        <link rel="stylesheet" href="../css/tabler-icons/tabler-icons.css" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12 d-flex align-items-stretch justify-content-center">
                    <div class="card w-100 m-5" style="max-width:50rem">
                        <div class="card-body p-4">
                            <div class="mb-4 d-flex justify-content-between">
                                <h5 class="card-title fw-semibold">Add Product</h5>        
                            </div>
                            <form method="post" action="addProductsAdmin.asp">
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
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/jquery/dist/jquery.min.js"></script>
        <script src="../js/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../js/sidebarmenu.js"></script>
        <script src="../js/app.min.js"></script>
        <script src="../js/libs/apexcharts/dist/apexcharts.min.js"></script>
        <script src="../js/libs/simplebar/dist/simplebar.js"></script>
        <script src="../js/dashboard.js"></script>
    </body>
</html>