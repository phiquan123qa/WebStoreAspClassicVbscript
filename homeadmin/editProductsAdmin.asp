
<!--#include file="../connect.asp"-->
<%
    Dim id, Pname, Ptype, Pbrand, Pprice, Pcost, Pdescribe, Penable, Pquantity, mainimg, imgdes1, imgdes2, imgdes3
    id = Request.QueryString("id")
    Session("idp") = id
    If isnull(Session("email")) OR TRIM(Session("email"))="" Then
        Response.redirect("../index.asp")
    Else
        Dim sql
        sql = "select p.*, dp.* from Products p join ProductsDetail dp on p.id = dp.id where p.id= ?"
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
        If not result.EOF Then
            Pname = result.Fields("name").Value
            Ptype = result.Fields("type").Value
            Pprice = result.Fields("price").Value
			Pcost = result.Fields("cost").Value
            Pbrand = result.Fields("brand").Value
			Pdescribe = result.Fields("describe").Value
            Penable = result.Fields("isEnabled").Value
            Pquantity = result.Fields("quantity").Value
            mainimg = result.Fields("mainImage").Value
            imgdes1 = result.Fields("imageDes1").Value
            imgdes2 = result.Fields("imageDes2").Value
            imgdes3 = result.Fields("imageDes3").Value
        Else
            Session("ErrorProducts") = "Something wrong with your products"
        End if
        result.Close()
        connDB.Close()
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
                                <h5 class="card-title fw-semibold">Edit Product</h5>        
                            </div>
                            <form method=post id="formimg1" enctype="multipart/form-data" action="addMainImgProduct.asp" class="d-flex justify-content-around align-items-center my-3">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <div class="d-flex">
                                        <div class="btn btn-primary btn-rounded">
                                            <label class="form-label text-white m-1" for="img1">Choose Image Main</label>
                                            <input type="file" class="form-control d-none" id="img1"/>
                                        </div>
                                    </div>
                                </div>
                                <img src="/img/list/<%=mainimg%>" alt="main img" style="max-width:150px; border:1px solid #adadad"/>
                            </form>
                    <!--img 1-->
                            <form method=post id="formimg2" enctype="multipart/form-data" action="addImg1Product.asp" class="d-flex justify-content-around align-items-center my-3">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <div class="d-flex">
                                        <div class="btn btn-primary btn-rounded">
                                            <label class="form-label text-white m-1" for="img2">Choose Image First Des</label>
                                            <input type="file" class="form-control d-none" id="img2"/>
                                        </div>
                                    </div>
                                </div>
                                <img src="/img/list/<%=imgdes1%>" alt="first img" style="max-width:150px; border:1px solid #adadad"/>
                            </form>
                    <!--img 2-->
                            <form method=post id="formimg3" enctype="multipart/form-data" action="addImg2Product.asp" class="d-flex justify-content-around align-items-center my-3">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <div class="d-flex">
                                        <div class="btn btn-primary btn-rounded">
                                            <label class="form-label text-white m-1" for="img3">Choose Image Second Des</label>
                                            <input type="file" class="form-control d-none" id="img3"/>
                                        </div>
                                    </div>
                                </div>
                                <img src="/img/list/<%=imgdes2%>" alt="second img" style="max-width:150px; border:1px solid #adadad"/>
                            </form>
                    <!--img 3-->
                            <form method=post id="formimg4" enctype="multipart/form-data" action="addImg3Product.asp" class="d-flex justify-content-around align-items-center my-3">
                                <div class="wrap-input100 validate-input m-b-23">
                                    <div class="d-flex">
                                        <div class="btn btn-primary btn-rounded">
                                            <label class="form-label text-white m-1" for="img4">Choose Image Third Des</label>
                                            <input type="file" class="form-control d-none" id="img4"/>
                                        </div>
                                    </div>
                                </div>
                                <img src="/img/list/<%=imgdes3%>" alt="third img" style="max-width:150px; border:1px solid #adadad"/>
                            </form>
                    <!--input form-->
                            <form method="post" action="updateProduct.asp">
                                <div class="mb-2">
                                    <label for="name" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Input name" value="<%=Pname%>">
                                </div>
                                <div class="mb-2">
                                    <label for="type" class="form-label">Type</label>
                                    <input type="text" class="form-control" id="type" name="type" placeholder="Input type" value="<%=Ptype%>">
                                </div>
                                <div class="mb-2">
                                    <label for="brand" class="form-label">Brand</label>
                                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Input brand" value="<%=Pbrand%>">
                                </div>
                                <div class="mb-2">
                                    <label for="price" class="form-label">Price</label>
                                    <input type="number" class="form-control" id="price" name="price" placeholder="Input number" value="<%=Pprice%>">
                                </div>
                                <div class="mb-2">
                                    <label for="cost" class="form-label">Cost</label>
                                    <input type="number" class="form-control" id="cost" name="cost" placeholder="Input number" value="<%=Pcost%>">
                                </div>
                                <div class="mb-2">
                                    <label for="describe" class="form-label">Describe</label>
                                    <textarea type="text" class="form-control" id="describe" name="describe" placeholder="Input describe"><%=Pdescribe%></textarea>
                                </div>
                                <div class="mb-2">
                                    <label for="quantity" class="form-label">Cost</label>
                                    <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Input number" value="<%=Pquantity%>">
                                </div>
                                <div class="mb-2">
                                    <label for="enable" class="form-label">Enable</label>
                                    <input type="checkbox" class="form-input" id="enable" name="enable" <%if(Penable="True")then Response.Write("checked") else Response.Write("") end if%>>
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
        <script type="text/javascript">
            var formimg1 = document.getElementById("formimg1");
            var formimg2 = document.getElementById("formimg2");
            var formimg3 = document.getElementById("formimg3");
            var formimg4 = document.getElementById("formimg4");

            var img1 = document.getElementById("img1");
            var img2= document.getElementById("img2");
            var img3 = document.getElementById("img3");
            var img4 = document.getElementById("img4");

            img1.addEventListener('change', function(event) {
                var file = event.target.files[0];
                formimg1.submit();
            });
            img2.addEventListener('change', function(event) {
                var file = event.target.files[0];
                formimg2.submit();
            });
            img3.addEventListener('change', function(event) {
                var file = event.target.files[0];
                formimg3.submit();
            });
            img4.addEventListener('change', function(event) {
                var file = event.target.files[0];
                formimg4.submit();
            });
        </script>    
    </body>
</html>