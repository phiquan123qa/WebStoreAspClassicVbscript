
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
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="css/products.css">
        <title>Add QTD</title>
    </head>
    <body style= "background-image: url('img/banner/bn_products.jpg'); ">
        <div class="container mt-3">
            <div class="row justify-content-center">
                <div class="col-md-6 ">
                    <h1 class="text-center"> Sửa Sản Phẩm </h1>
                    <!--main img-->
                    <form method=post id="formimg1" enctype="multipart/form-data" action="addMainImgProduct.asp" style="display: flex; align-items: center; padding-bottom: 20px;">
                        <div class="wrap-input100 validate-input m-b-23">
                            <span class="label-input100">Main Image</span>
                            <div style="height:55px;display:flex">
                                <input type=file id="img1" name=avata>
                            </div>
                        </div>
                        <img src="/img/list/<%=mainimg%>" alt="main img" style="max-width:130px; border:2px solid #adadad; margin-left:10px"/>
                    </form>
                    <!--img 1-->
                    <form method=post id="formimg2" enctype="multipart/form-data" action="addImg1Product.asp" style="display: flex; align-items: center; padding-bottom: 20px;">
                        <div class="wrap-input100 validate-input m-b-23">
                            <span class="label-input100" >First Image Describe</span>
                            <div style="height:55px;display:flex">
                                <input type=file id="img2" name=avata>
                            </div>
                        </div>
                        <img src="/img/list/<%=imgdes1%>" alt="first img" style="max-width:130px; border:2px solid #adadad; margin-left:10px"/>
                    </form>
                    <!--img 2-->
                    <form method=post id="formimg3" enctype="multipart/form-data" action="addImg2Product.asp" style="display: flex; align-items: center; padding-bottom: 20px;">
                        <div class="wrap-input100 validate-input m-b-23">
                            <span class="label-input100" >Second Image Describe </span>
                            <div style="height:55px;display:flex">
                                <input type=file id="img3" name=avata>
                            </div>
                        </div>
                        <img src="/img/list/<%=imgdes2%>" alt="second img" style="max-width:130px; border:2px solid #adadad; margin-left:10px"/>
                    </form>
                    <!--img 3-->
                    <form method=post id="formimg4" enctype="multipart/form-data" action="addImg3Product.asp" style="display: flex; align-items: center; padding-bottom: 20px;">
                        <div class="wrap-input100 validate-input m-b-23">
                            <span class="label-input100" >Third Image Describe</span>
                            <div style="height:55px;display:flex">
                                <input type=file id="img4" name=avata>
                            </div>
                        </div>
                        <img src="/img/list/<%=imgdes3%>" alt="third img" style="max-width:130px; border:2px solid #adadad; margin-left:10px"/>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>         
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