<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/home.css" />
    <link rel="stylesheet" href="./css/style.css" />
    <link rel="stylesheet" href="./css/font-jost.css" data-tag="font" />
    <link rel="stylesheet" type="text/css" href="css/products.css">
    <link rel="stylesheet" href="./css/detailproducts.css" />
    <title>Detail Products</title>
</head>
<body>
    <!-- #include file="header.asp" -->
    <div style= "text-align: center" class="main"><h2>.</h2>
        <div class="left">
            <form method="post" action="detailProducts.asp">
            <div style = "text-align: center"><h1> Chi Tiết Sản Phẩm </h1></div>
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    
                </div>
                <div class="mb-3">
                    <label for="type" class="form-label">Type</label>
                    <input type="text" class="form-control" id="type" name="type" placeholder="Input type">
                </div>
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Input brand">
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" placeholder="Input number">
                </div>
                <div class="mb-3">
                    <label for="cost" class="form-label">Cost</label>
                    <input type="number" class="form-control" id="cost" name="cost" placeholder="Input number">
                </div>
                <div class="mb-3">
                    <label for="describe" class="form-label">Describe</label>
                    <textarea type="text" class="form-control" id="describe" name="describe" placeholder="Input describe"></textarea>
                </div>
            </form>
        </div>

        <div class="right">
        <form method="post" action="detailProducts.asp">
            <div style = "text-align: center"><h1> Chi Tiết Sản Phẩm </h1></div>
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    
                </div>
                <div class="mb-3">
                    <label for="type" class="form-label">Type</label>
                    <input type="text" class="form-control" id="type" name="type" placeholder="Input type">
                </div>
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand</label>
                    <input type="text" class="form-control" id="brand" name="brand" placeholder="Input brand">
                </div>
                <div class="mb-3">
                    <label for="price" class="form-label">Price</label>
                    <input type="number" class="form-control" id="price" name="price" placeholder="Input number">
                </div>
                <div class="mb-3">
                    <label for="cost" class="form-label">Cost</label>
                    <input type="number" class="form-control" id="cost" name="cost" placeholder="Input number">
                </div>
                <div class="mb-3">
                    <label for="describe" class="form-label">Describe</label>
                    <textarea type="text" class="form-control" id="describe" name="describe" placeholder="Input describe"></textarea>
                </div>
            </form>
        </div>
    </div>
      


</body>
</html>