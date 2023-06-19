<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "PROVIDER=SQLOLEDB;SERVER=MSI;DATABASE=WebSellProduct;User Id = sa; Password = 123456"
connDB.ConnectionString = strConnection
%>