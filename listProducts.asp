<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->

<%
Dim key
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function

    function checkActive(cond, ret) 
    if cond=true then
        Response.write ret
    else
        Response.write ""
    end if
    end function

    function checkChecked(cond, ret) 
    if cond=true then
        Response.write ret
    else
        Response.write ""
    end if
    end function

' trang hien tai
    page = Request.QueryString("page")
    limit = 8

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)


    Dim cmdd
    set cmdd = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdd.ActiveConnection = connDB
    cmdd.CommandType=1
    cmdd.Prepared=true
    If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
        key = Request.QueryString("key")
        sort=Request.QueryString("sort")
        typee=Request.QueryString("type")
        brand=Request.QueryString("brand")
        if(isnull(sort) OR TRIM(sort)="") then
            sort = "id"
        else
            sort=Request.QueryString("sort")
            if(sort="hot")then
                sort="id"
            end if
        end if
        if(sort="id")then
            sortPrice= "AND price<>cost "
        end if
        if(isnull(typee) OR TRIM(typee)="") then
            typee = "is not null"
        else
            typee="='"&Request.QueryString("type")&"'"
        end if
        if(isnull(brand) OR TRIM(brand)="") then
            brand = "is not null"
        else
            brand="='"&Request.QueryString("brand")&"'"
        end if
        IF(isnull(key) OR TRIM(key)="" AND sort="id")Then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products  WHERE isEnabled = 1 "&sortPrice&" AND type "&typee&" AND brand "&brand
        elseif(isnull(key) OR TRIM(key)="") then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products  WHERE isEnabled = 1 AND type "&typee&" AND brand "&brand
        elseif(not isnull(key) AND sort="id" OR TRIM(key)<>"" AND sort="id") then
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products WHERE isEnabled = 1 "&sortPrice&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%'" 
        Else
            cmdd.CommandText = "SELECT COUNT(id) AS count FROM Products WHERE isEnabled = 1 AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%'" 
        END IF
    END IF
    Dim rss
    set rss = cmdd.Execute()
    

    totalRows = CLng(rss("count"))

    Set rss = Nothing
    pages = Ceil(totalRows/limit)
    Dim range
    If (pages<=15) Then
        range = pages
    Else
        range = 99
    End if
connDB.Close()
%>


<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />
    <title>Products QTD</title>
    <link rel="stylesheet" href="./css/font-jost.css" data-tag="font" />
    <link rel="stylesheet" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="./css/reset.css"/>
    <link rel="stylesheet" href="./css/style.css"/>
    <link rel="stylesheet" href="./css/home.css"/>
    <link rel="stylesheet" href="./css/listProducts.css"/>
    <link rel="stylesheet" href="./css/shop_left_menu.css"/>

    <style>
        .left_menu{
            float: left;
            width: 15%;
        }
        .sort_selection{
            margin: 4rem auto;
            border:1px solid gray;
            border-width: 1px 1px 1px 0;
            border-radius:0 10px 10px 0;
            padding:1rem 0.5rem 1rem 2rem;
            background-color:#fafafa;
        }
        .list_card{
            float: left;
            width: 85%;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            flex-wrap: wrap;
            flex-direction: row;
            align-content: center;
            margin-bottom:20px
        }
        .container{
            padding-top: 65px;

        }
            .product-card {
        flex: 0 0 23.7%;
        position: relative;
        box-shadow: 0 2px 7px #dfdfdf;
        margin: 2rem 0.5rem auto;
        background: #fafafa;
        height: 520px;
        }
            /* fkjdfjkđìk */
        .pagination-container{
            margin: 50px auto;
            text-align: center;
        }
        
        .a_pagination{
            position: relative;
            display: inline-block;
            color: #2c3e50;
            text-decoration: none;
            font-size: 1.2rem;
            padding: 8px 16px 10px;
        }
        .a_pagination::before{
            z-index: -1;
            position: absolute;
            height: 100%;
            width: 100%;
            content: "";
            top: 0;
            left: 0;
            background-color: #2c3e50;
            border-radius: 24px;
            transform: scale(0);		
            transition: all 0.2s;
        }
        .a_pagination:hover ,
        .pagination-active{
            color: gray;        
        }
        .pagination a:hover ,
        .pagination-active::before{
            transform: scale(1);  
        } 
        .pagination-active{
            color: #fff;
        }
        .pagination-active::before{
            transform: scale(1);
        }
        .pagination-newer{
            margin-right: 50px;
        }
        .pagination-older{
            margin-left: 50px;
        }
        .icon{
            margin-right:5px
        }
        .sort_fillter{
            width:100%;
            padding-top: 2rem;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right:0.5rem;
            flex-wrap: wrap;
        }
        .btn-filter{
            display:flex;
            align-items: center;
            margin-right:1rem;
            padding:0.5rem;
            background: #f3f4f6;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            color: #444;
            cursor: pointer;
        }
        .active{
            background: #fef2f2;
            border: 1px solid #d70018;
            color: #d70018;
        }
        .product-tumb {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 300px;
            padding:0px;
            background: #f0f0f0;
        }
        
    </style>
</head>
<body>
    <div class="container">
        <!-- #include file="header.asp" -->
        <div class="left_menu">
            <div class="sort_selection">
            <%
            Dim cmddd
            set cmddd = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmddd.ActiveConnection = connDB
            cmddd.CommandType=1
            cmddd.Prepared=true
            cmddd.CommandText = "SELECT DISTINCT type FROM Products  WHERE isEnabled = 1 ORDER BY type "
            Dim rsss
            set rsss = cmddd.Execute()
            %>
            <h3>Type</h3>
            <%
            Dim typeinput
            typeinput = Request.QueryString("type")
            %>
            <input type="hidden" id="typeinput" name="typeinput" value="<%=typeinput%>">
            <p>
                <input type="radio" id="type1" name="type" value ="" onclick="checkkType()" <%=checkActive(typeinput="", "checked")%>/>
                <label for="type1">All</label>
            </p>
            <% 
            Dim holdderNumber
            holdderNumber = 1
            While Not rsss.EOF 
            holdderNumber= holdderNumber+1
            %>
            <p>
                <input type="radio" id="type<%=holdderNumber%>" name="type" value="<%=rsss("type")%>" onclick="checkkType()" <%=checkActive(typeinput=rsss("type"), "checked")%>/>
                <label for="type<%=holdderNumber%>"><%=rsss("type")%></label>
            </p>
            <%
            rsss.MoveNext()
            Wend
            rsss.Close()
            connDB.Close()%>

            <br>
            <br>
            <%
            Dim cmdddd
            set cmdddd = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdddd.ActiveConnection = connDB
            cmdddd.CommandType=1
            cmdddd.Prepared=true
            cmdddd.CommandText = "SELECT DISTINCT brand FROM Products WHERE isEnabled = 1 ORDER BY brand"
            Dim rssss
            set rssss = cmdddd.Execute()
            %>
            <h3>Brand</h3>
            <%
            Dim brandinput
            brandinput = Request.QueryString("brand")
            %>
            <input type="hidden" id="brandinput" name="brandinput" value="<%=brandinput%>">
            <p>
                <input type="radio" id="brand1" name="brand" value ="" onclick="checkkBrand()" <%=checkActive(brandinput="", "checked")%>/>
                <label for="brand1">All</label>
            </p>
            <% 
            Dim holdderNumberr
            holdderNumberr = 1
            While Not rssss.EOF 
            holdderNumberr= holdderNumberr+1
            %>
            <p>
                <input type="radio" id="brand<%=holdderNumberr%>" name="brand" value="<%=rssss("brand")%>" onclick="checkkBrand()" <%=checkActive(brandinput=rssss("brand"), "checked")%>/>
                <label for="brand<%=holdderNumberr%>"><%=rssss("brand")%></label>
            </p>
            <%
            rssss.MoveNext()
            Wend
            rssss.Close()
            connDB.Close()%>
        </div>
    </div>
        <%key = Request.QueryString("key")
        sort = Request.QueryString("sort")
        typee = Request.QueryString("type")
        brand = Request.QueryString("brand")%>
        <div class="list_card">
            <div class="sort_fillter">
                    <a class="btn-filter button__sort <%=checkActive(sort="price ASC", "active")%>" href="listproducts.asp?key=<%=key%>&sort=price ASC&brand=<%=brand%>&type=<%=typee%>">
                        <div class="icon">
                            <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                <path d="M416 288h-95.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H416c17.67 0 32-14.33 32-32S433.7 288 416 288zM544 32h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 32 544 32zM352 416h-32c-17.67 0-32 14.33-32 32s14.33 32 32 32h32c17.67 0 31.1-14.33 31.1-32S369.7 416 352 416zM480 160h-159.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H480c17.67 0 32-14.33 32-32S497.7 160 480 160zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z"></path>
                            </svg>
                        </div>
                        Price low to hight
                    </a>
                    <a class="btn-filter button__sort <%=checkActive(sort="price DESC", "active")%>" href="listproducts.asp?key=<%=key%>&sort=price DESC&brand=<%=brand%>&type=<%=typee%>">
                        <div class="icon">
                            <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                <path d="M320 224H416c17.67 0 32-14.33 32-32s-14.33-32-32-32h-95.1c-17.67 0-32 14.33-32 32S302.3 224 320 224zM320 352H480c17.67 0 32-14.33 32-32s-14.33-32-32-32h-159.1c-17.67 0-32 14.33-32 32S302.3 352 320 352zM320 96h32c17.67 0 31.1-14.33 31.1-32s-14.33-32-31.1-32h-32c-17.67 0-32 14.33-32 32S302.3 96 320 96zM544 416h-223.1c-17.67 0-32 14.33-32 32s14.33 32 32 32H544c17.67 0 32-14.33 32-32S561.7 416 544 416zM192.4 330.7L160 366.1V64.03C160 46.33 145.7 32 128 32S96 46.33 96 64.03v302L63.6 330.7c-6.312-6.883-14.94-10.38-23.61-10.38c-7.719 0-15.47 2.781-21.61 8.414c-13.03 11.95-13.9 32.22-1.969 45.27l87.1 96.09c12.12 13.26 35.06 13.26 47.19 0l87.1-96.09c11.94-13.05 11.06-33.31-1.969-45.27C224.6 316.8 204.4 317.7 192.4 330.7z"></path>
                            </svg>
                        </div>
                        Price hight to low</a>
                    <a class="btn-filter button__sort <%=checkActive(sort="hot", "active")%>" href="listproducts.asp?key=<%=key%>&sort=hot&brand=<%=brand%>&type=<%=typee%>">
                        <div class="icon">
                            <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                <path d="M112 224c61.9 0 112-50.1 112-112S173.9 0 112 0 0 50.1 0 112s50.1 112 112 112zm0-160c26.5 0 48 21.5 48 48s-21.5 48-48 48-48-21.5-48-48 21.5-48 48-48zm224 224c-61.9 0-112 50.1-112 112s50.1 112 112 112 112-50.1 112-112-50.1-112-112-112zm0 160c-26.5 0-48-21.5-48-48s21.5-48 48-48 48 21.5 48 48-21.5 48-48 48zM392.3.2l31.6-.1c19.4-.1 30.9 21.8 19.7 37.8L77.4 501.6a23.95 23.95 0 0 1-19.6 10.2l-33.4.1c-19.5 0-30.9-21.9-19.7-37.8l368-463.7C377.2 4 384.5.2 392.3.2z"></path>
                            </svg>
                        </div>
                        Hot deals</a>
                    <a class="btn-filter button__sort <%=checkActive(sort="name", "active")%>" href="listproducts.asp?key=<%=key%>&sort=name&brand=<%=brand%>&type=<%=typee%>">
                        <div class="icon">
                            <svg height="15" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                <path d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z"></path>
                            </svg>
                        </div>
                        Sort by name
                    </a>
            </div>
            <%
            Dim cmd
            set cmd = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmd.ActiveConnection = connDB
            cmd.CommandType=1
            cmd.Prepared=true
            If (Request.ServerVariables("REQUEST_METHOD")= "GET")Then
                key = Request.QueryString("key")
                sort=Request.QueryString("sort")
                typee=Request.QueryString("type")
                brand=Request.QueryString("brand")
                if(isnull(sort) OR TRIM(sort)="") then
                    sort = "id"
                else
                    sort=Request.QueryString("sort")
                    if(sort="hot")then
                    sort="id"
                    end if
                end if
                if(sort="id")then
                    sortPrice= "AND price<>cost "
                end if
                if(isnull(typee) OR TRIM(typee)="") then
                    typee = "is not null"
                else
                    typee="='"&Request.QueryString("type")&"'"
                end if
                if(isnull(brand) OR TRIM(brand)="") then
                    brand = "is not null"
                else
                    brand="='"&Request.QueryString("brand")&"'"
                end if
                IF(isnull(key) OR TRIM(key)="" AND sort="id")Then
                    cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE p.isEnabled = 1 "&sortPrice&" AND p.type "&typee&" AND p.brand "&brand&" ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY"
                elseif(isnull(key) OR TRIM(key)="") then
                    cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 AND type "&typee&" AND brand "&brand&" ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY "
                elseif(not isnull(key) AND sort="id" OR TRIM(key)<>"" AND sort="id") then
                    cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 "&sortPrice&" AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%' ORDER BY "&sort&" OFFSET "& offset &" ROWS FETCH NEXT "& limit &" ROWS ONLY " 
                Else
                    cmd.CommandText = "SELECT p.*, d.mainImage FROM Products p JOIN ProductsDetail d ON p.id=d.id WHERE isEnabled = 1 AND type "&typee&" AND brand "&brand&" AND name LIKE '%" & key & "%' ORDER BY "&sort&" OFFSET "& offset &"ROWS FETCH NEXT "& limit &" ROWS ONLY " 
                END IF
                'Response.Write(cmd.CommandText)
            END IF
            Dim rs
            set rs = cmd.Execute()
            %>
            <% While Not rs.EOF %>
            <div class="product-card">
                <%if(rs("cost")<>rs("price")) then%>
                <div class="badge">Hot</div>
                <%end if%>
                <div class="product-tumb">
                    <img src="img/list/<%= rs("mainImage")%>" alt="">
                </div>
                <div class="product-details">
                    <span class="product-catagory"><%= rs("type") %></span>
                    <h4><a href="detailProducts.asp?id=<%=rs("id")%>"><%= rs("name") %></a></h4>
                    <div class="product-bottom-details">
                        <div class="product-price">
                            <%if(rs("cost")=rs("price")) then
                                Response.write("$"&rs("price"))
                            else
                            %>
                            <small>$<%= rs("cost") %></small>$<%= rs("price") %>
                            <%end if%>
                        </div>
                        <div class="product-links">
                            <a href="addCart.asp?idProduct=<%=rs("id")%>"><i class="fa fa-shopping-cart"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <% rs.MoveNext() %>
            <% Wend %>
        </div>
    
    <%
    rs.Close()
    connDB.Close()
    %>
    <div class="pagination-container">
		<div class="pagination">
    <% 
    typee = Request.QueryString("type")
    brand = Request.QueryString("brand")
    IF( isnull(key) OR TRIM(key)="")Then
        sort=Request.QueryString("sort")
        if(isnull(sort) OR TRIM(sort)="") then
            sort = "id"
        else
            sort=Request.QueryString("sort")
        end if
        if (pages>1) then
            if(Clng(page)>=2) then%>
                <a class="pagination-newer" href="listProducts.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=Clng(page)-1%>">Prev</a>
        <%    
            end if 
            for i= 1 to range%>
                <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="listProducts.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=i%>"><%=i%></a>
        <%
            next
            if (Clng(page)<pages) then%>
                <a class="pagination-older" href="listProducts.asp?sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=Clng(page)+1%>">Next</a>
        <%
            end if    
        end if
    else
        sort=Request.QueryString("sort")
        if(isnull(sort) OR TRIM(sort)="") then
            sort = "id"
        else
            sort=Request.QueryString("sort")
        end if
        if (pages>1) then
            if(Clng(page)>=2) then%>
            <a class="pagination-newer" href="listProducts.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=Clng(page)-1%>">Prev</a>
        <%    
            end if 
            for i= 1 to range%>
                <a class="a_pagination <%=checkPage(Clng(i)=Clng(page),"pagination-active")%>" href="listProducts.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=i%>"><%=i%></a>
        <%
            next
            if (Clng(page)<pages) then%>
                <a class="pagination-older" href="listProducts.asp?key=<%=key%>&sort=<%=sort%>&brand=<%=brand%>&type=<%=typee%>&page=<%=Clng(page)+1%>">Next</a>
        <%
            end if    
        end if
    end if%>
        </div>
    </div>
</div>
<script>

const url = new URLSearchParams(window.location.search);
const myparam1 = url.get('key');
if(myparam1==null){
    myparam1="";    
}
const myparam2 = url.get('sort');
if(myparam2==null){
    myparam2="";    
}

var radiosBrand = document.getElementsByName('brand');
link="listproducts.asp?key="+myparam1+"&sort="+myparam2+"&brand="
var radiosType = document.getElementsByName('type');
function checkkType(){
    for (var i = 0, length = radiosType.length; i < length; i++) {
        if (radiosType[i].checked) {
            document.getElementById("typeinput").value = radiosType[i].value;
            window.location.href=link+document.getElementById("brandinput").value+"&type="+radiosType[i].value;
            break;
        }
    }
}
function checkkBrand(){
    for (var i = 0, length = radiosBrand.length; i < length; i++) {
        if (radiosBrand[i].checked) {
            document.getElementById("brandinput").value = radiosBrand[i].value;
            window.location.href=link+radiosBrand[i].value+"&type="+document.getElementById("typeinput").value;
            break;
        }
    }
}
</script>
</body>

</html>