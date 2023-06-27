<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="connect.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
    Dim name, phone, address, idAcc, Shipment, totalPrice, giftCode
    name = Request.Form("name")
    phone = Request.Form("phone")
    address = Request.Form("street")
    Shipment=Request.Form("Shipment")
    totalPrice = Request.Form("Ttp")
    If(Not isnull(Session("discount")) And Trim(Session("discount"))<>"") then
        giftCode = Session("discount")
    Else
        giftCode = 0
    End if
    'Session("Shipment") = Shipment
    Response.Write("ship="&Shipment)
    Response.Write("gift="&giftCode)
    Response.Write("total="&totalPrice)
    totalPrice = CInt(totalPrice) + CInt(Shipment) - CInt(giftCode)

	If(Not isnull(Session("email")) And Trim(Session("email"))<>"")Then
		Dim cmdPrepppp, rssss
        Set cmdPrepppp = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrepppp.ActiveConnection = connDB
        cmdPrepppp.CommandType = 1
        cmdPrepppp.CommandText = "SELECT * FROM Account WHERE email = ? AND isEnabled = 1"
        cmdPrepppp.Parameters(0)=Session("email")
        Response.Write(cmdPrepppp.CommandText)
        Set rssss = cmdPrepppp.execute()
		If not rssss.EOF then
			idAcc=rssss("id")
		End if
		Response.Write(idAcc)
		rssss.Close()
        connDB.Close()

    ELseIf( Not isnull(name) And Trim(name)<>"" And Not isnull(phone) And Trim(phone)<>"" And Not isnull(address) And Trim(address)<>"")Then
        Dim cmdPrep, rs
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.CommandText = "SELECT * FROM Account WHERE phone = ? AND isEnabled = 1"
        cmdPrep.Parameters(0)=phone
        Response.Write(cmdPrep.CommandText)
        Set rs = cmdPrep.execute()
        If rs.EOF Then
            Dim cmdPrepp, responseType
            Set cmdPrepp = Server.CreateObject("ADODB.Command")
            cmdPrepp.ActiveConnection = connDB
            cmdPrepp.CommandType = 1
            cmdPrepp.CommandText = "INSERT INTO Account([name], phone, [address], dateCreate, avata, isEnabled) OUTPUT INSERTED.id VALUES (?, ?, ?, DEFAULT, DEFAULT, DEFAULT)"
            cmdPrepp.Parameters(0)=name
            cmdPrepp.Parameters(1)=phone
            cmdPrepp.Parameters(2)=address
            Set rss = cmdPrepp.execute()
            Response.Write(cmdPrepp.CommandText)
            idAcc=rss.Fields("id").Value
            'rss.Close()
        Else 
            idAcc=rs("id")
        End if
        Response.Write(idAcc)
        rs.Close()
        connDB.Close()
        Session("BillAccSuccess")="Create Acc Success"
        Response.Write(Session("BillAccSuccess"))
    Else
        Session("BillAccErr")="Please input all field!"
        Response.Write(Session("BillAccErr"))
    End if


    Dim cmdPreppp, rsss, ordId
    Set cmdPreppp = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPreppp.ActiveConnection = connDB
    cmdPreppp.CommandType = 1
    cmdPreppp.CommandText = "INSERT INTO [Order](accId, totalPrice) OUTPUT INSERTED.id VALUES ( ?, ?)"
    cmdPreppp.Parameters(0)=idAcc
    cmdPreppp.Parameters(1)=totalPrice
    Response.Write(cmdPreppp.CommandText)
    Set rsss = cmdPreppp.execute()
    ordId = rsss.Fields("id").Value
    Response.Write(ordId)
    rsss.Close()

    Dim carts, idProduct, quantity
    If (NOT IsEmpty(Session("mycarts"))) Then
        Set carts= Session("mycarts")
        Dim orderDetailsInsertSQL, orderDetailsInsertCmd
        orderDetailsInsertSQL = "INSERT INTO OrderDetail (orderID, productId, quantity) VALUES (?, ?, ?);"

        Set orderDetailsInsertCmd = Server.CreateObject("ADODB.Command")
        orderDetailsInsertCmd.ActiveConnection = connDB
        orderDetailsInsertCmd.CommandText = orderDetailsInsertSQL
        orderDetailsInsertCmd.CommandType = 1

        For Each idProduct In carts.Keys
            quantity = carts.Item(idProduct)
            orderDetailsInsertCmd.Parameters.Append(orderDetailsInsertCmd.CreateParameter("@orderID", 3, 1, , ordId))
            orderDetailsInsertCmd.Parameters.Append(orderDetailsInsertCmd.CreateParameter("@productId", 3, 1, , idProduct))
            orderDetailsInsertCmd.Parameters.Append(orderDetailsInsertCmd.CreateParameter("@quantity", 3, 1, , quantity))

            orderDetailsInsertCmd.Execute()
            Do While orderDetailsInsertCmd.Parameters.Count > 0
                orderDetailsInsertCmd.Parameters.Delete(0)
            Loop
        Next
        Set Session("mycarts") = Server.CreateObject("Scripting.Dictionary")
    End if
    connDB.Close()
    'Response.redirect("shoppingCart.asp")  
End if
%>

<!DOCTYPE html>
<html lang="en" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title></title>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<link href="https://fonts.googleapis.com/css?family=Cabin" rel="stylesheet" type="text/css"/>
	<style>
		* {
			box-sizing: border-box;
		}

		body {
			margin: 0;
			padding: 0;
		}

		a[x-apple-data-detectors] {
			color: inherit !important;
			text-decoration: inherit !important;
		}

		#MessageViewBody a {
			color: inherit;
			text-decoration: none;
		}

		p {
			line-height: inherit
		}

		.desktop_hide,
		.desktop_hide table {
			display: none;
			max-height: 0px;
			overflow: hidden;
		}

		.image_block img+div {
			display: none;
		}

		@media (max-width:700px) {

			.desktop_hide table.icons-inner,
			.social_block.desktop_hide .social-table {
				display: inline-block !important;
			}

			.icons-inner {
				text-align: center;
			}

			.icons-inner td {
				margin: 0 auto;
			}

			.fullMobileWidth,
			.row-content {
				width: 100% !important;
			}

			.mobile_hide {
				display: none;
			}

			.stack .column {
				width: 100%;
				display: block;
			}

			.mobile_hide {
				min-height: 0;
				max-height: 0;
				max-width: 0;
				overflow: hidden;
				font-size: 0px;
			}

			.desktop_hide,
			.desktop_hide table {
				display: table !important;
				max-height: none !important;
			}

			.reverse {
				display: table;
				width: 100%;
			}

			.reverse .column.first {
				display: table-footer-group !important;
			}

			.reverse .column.last {
				display: table-header-group !important;
			}

			.row-5 td.column.first .border {
				padding: 35px 0 35px 25px;
				border-top: 0;
				border-right: 0px;
				border-bottom: 0;
				border-left: 0;
			}

			.row-5 td.column.last .border {
				padding: 0 0 5px;
				border-top: 0;
				border-right: 0px;
				border-bottom: 0;
				border-left: 0;
			}
		}
	</style>
</head>

<body style="background-color: #f2f2f2; margin: 0; padding: 0; -webkit-text-size-adjust: none; text-size-adjust: none;">
	<table cellpadding="0" cellspacing="0" class="nl-container" role="presentation"
		style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #f2f2f2;" width="100%">
		<tbody>
			<tr>
				<td>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-5"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr class="reverse">
												<td class="column column-1 first"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 35px; padding-left: 25px; padding-top: 35px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="50%">
													<div class="border">
														<table border="0" cellpadding="0" cellspacing="0"
															class="heading_block block-1" role="presentation"
															style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
															width="100%">
															<tr>
																<td class="pad"
																	style="padding-left:5px;padding-top:10px;text-align:center;width:100%;">
																	<h1
																		style="margin: 0; color: #fe7062; direction: ltr; font-family: Cabin, Arial, Helvetica Neue, Helvetica, sans-serif; font-size: 13px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: left; margin-top: 0; margin-bottom: 0;">
																		<span class="tinyMce-placeholder">THANK
																			YOU</span>
																	</h1>
																</td>
															</tr>
														</table>
														<table border="0" cellpadding="0" cellspacing="0"
															class="heading_block block-2" role="presentation"
															style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
															width="100%">
															<tr>
																<td class="pad"
																	style="padding-bottom:10px;padding-left:5px;padding-right:5px;padding-top:5px;text-align:center;width:100%;">
																	<h1
																		style="margin: 0; color: #2f2e41; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 29px; font-weight: 400; letter-spacing: 1px; line-height: 120%; text-align: left; margin-top: 0; margin-bottom: 0;">
																		<strong>We received your application!</strong>
																	</h1>
																</td>
															</tr>
														</table>
														<table border="0" cellpadding="0" cellspacing="0"
															class="paragraph_block block-3" role="presentation"
															style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;"
															width="100%">
															<tr>
																<td class="pad"
																	style="padding-bottom:10px;padding-left:5px;padding-right:5px;padding-top:10px;">
																	<div
																		style="color:#393d47;direction:ltr;font-family:Cabin, Arial, Helvetica Neue, Helvetica, sans-serif;font-size:15px;font-weight:400;letter-spacing:0px;line-height:150%;text-align:left;mso-line-height-alt:22.5px;">
																		<p style="margin: 0;">We will keep you posted on
																			next steps! In the meantime, here are a few
																			things you should know.</p>
																	</div>
																</td>
															</tr>
														</table>
													</div>
												</td>
												<td class="column column-2 last"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="50%">
													<div class="border">
														<table border="0" cellpadding="20" cellspacing="0"
															class="image_block block-1" role="presentation"
															style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
															width="100%">
															<tr>
																<td class="pad">
																	<div align="center" class="alignment"
																		style="line-height:10px"><img alt="Resume"
																			class="fullMobileWidth"
																			src="images/illustration_png-03.png"
																			style="display: block; height: auto; border: 0; width: 282px; max-width: 100%;"
																			title="Resume" width="282" /></div>
																</td>
															</tr>
														</table>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-6"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<div class="spacer_block block-1"
														style="height:10px;line-height:10px;font-size:1px;"> </div>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-7"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<div class="spacer_block block-1"
														style="height:20px;line-height:20px;font-size:1px;"> </div>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-8"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-size: auto;"
						width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; background-size: auto; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 15px; padding-left: 25px; padding-right: 25px; padding-top: 25px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<table border="0" cellpadding="5" cellspacing="0"
														class="heading_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad">
																<h1
																	style="margin: 0; color: #2f2e41; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 23px; font-weight: 400; letter-spacing: 1px; line-height: 120%; text-align: left; margin-top: 0; margin-bottom: 0;">
																	<strong>What you can expect working at
																		Brand.</strong>
																</h1>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="paragraph_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; word-break: break-word;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-left:5px;padding-right:5px;padding-top:10px;">
																<div
																	style="color:#393d47;direction:ltr;font-family:Cabin, Arial, Helvetica Neue, Helvetica, sans-serif;font-size:14px;font-weight:400;letter-spacing:0px;line-height:150%;text-align:left;mso-line-height-alt:21px;">
																	<p style="margin: 0;">Lorem ipsum dolor sit amet,
																		consectetur adipiscing elit. Ac, enim feugiat
																		vitae duis. Imperdiet sit aliquet morbi lorem
																		quam:</p>
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-9"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; padding-top: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="25%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-03_1.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	Health insurance</h1>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-3" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-08.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-4" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	<span class="tinyMce-placeholder">Sick leave</span>
																</h1>
															</td>
														</tr>
													</table>
												</td>
												<td class="column column-2"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; padding-top: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="25%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-05.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	Personal leave</h1>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-3" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-07.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-4" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	<span class="tinyMce-placeholder">Flexible
																		hours</span>
																</h1>
															</td>
														</tr>
													</table>
												</td>
												<td class="column column-3"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; padding-top: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="25%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-02.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	Dental insurance</h1>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-3" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-09.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-4" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	<span class="tinyMce-placeholder">Fitness</span>
																</h1>
															</td>
														</tr>
													</table>
												</td>
												<td class="column column-4"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-left: 20px; padding-right: 20px; padding-top: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="25%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-06.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	Personal growth</h1>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="image_block block-3" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="width:100%;padding-right:0px;padding-left:0px;">
																<div align="center" class="alignment"
																	style="line-height:10px"><img alt="Benefit"
																		src="images/employee_benefits_icons-04.png"
																		style="display: block; height: auto; border: 0; width: 130px; max-width: 100%;"
																		title="Benefit" width="130" /></div>
															</td>
														</tr>
													</table>
													<table border="0" cellpadding="0" cellspacing="0"
														class="heading_block block-4" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;text-align:center;width:100%;">
																<h1
																	style="margin: 0; color: #979faf; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 12px; font-weight: 700; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	<span
																		class="tinyMce-placeholder">Transportation</span>
																</h1>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-10"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 15px; padding-top: 10px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="button_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="padding-bottom:15px;padding-left:10px;padding-right:10px;padding-top:15px;text-align:center;">
																<div align="center" class="alignment">
																	<!--[if mso]><v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="example.com" style="height:42px;width:155px;v-text-anchor:middle;" arcsize="0%" stroke="false" fillcolor="#4042e2"><w:anchorlock/><v:textbox inset="0px,0px,0px,0px"><center style="color:#ffffff; font-family:Arial, sans-serif; font-size:14px"><![endif]--><a
																		href="example.com"
																		style="text-decoration:none;display:inline-block;color:#ffffff;background-color:#4042e2;border-radius:0px;width:auto;border-top:0px solid #8a3b8f;font-weight:400;border-right:0px solid #8a3b8f;border-bottom:0px solid #8a3b8f;border-left:0px solid #8a3b8f;padding-top:5px;padding-bottom:5px;font-family:Cabin, Arial, Helvetica Neue, Helvetica, sans-serif;font-size:14px;text-align:center;mso-border-alt:none;word-break:keep-all;"
																		target="_blank"><span
																			style="padding-left:35px;padding-right:35px;font-size:14px;display:inline-block;letter-spacing:1px;"><span
																				style="word-break:break-word;"><span
																					data-mce-style=""
																					style="line-height: 28px;"><strong>Learn
																						More</strong></span></span></span></a><!--[if mso]></center></v:textbox></v:roundrect><![endif]-->
																</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-16"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; background-color: #fbfbfb; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-top: 7px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<div class="spacer_block block-1"
														style="height:25px;line-height:25px;font-size:1px;"> </div>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-17"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-left: 25px; padding-right: 25px; padding-top: 7px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<div class="spacer_block block-1"
														style="height:30px;line-height:30px;font-size:1px;"> </div>
													<table border="0" cellpadding="5" cellspacing="0"
														class="heading_block block-2" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad">
																<h1
																	style="margin: 0; color: #575c66; direction: ltr; font-family: 'Cabin', Arial, 'Helvetica Neue', Helvetica, sans-serif; font-size: 18px; font-weight: 400; letter-spacing: 1px; line-height: 120%; text-align: center; margin-top: 0; margin-bottom: 0;">
																	<strong>Have any questions? <a href="example.com"
																			rel="noopener"
																			style="text-decoration: none; color: #fe7062;"
																			target="_blank">Contact us!</a></strong>
																</h1>
															</td>
														</tr>
													</table>
													<div class="spacer_block block-3"
														style="height:30px;line-height:30px;font-size:1px;"> </div>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<table align="center" border="0" cellpadding="0" cellspacing="0" class="row row-20"
						role="presentation" style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;" width="100%">
						<tbody>
							<tr>
								<td>
									<table align="center" border="0" cellpadding="0" cellspacing="0"
										class="row-content stack" role="presentation"
										style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; color: #000000; width: 680px;"
										width="680">
										<tbody>
											<tr>
												<td class="column column-1"
													style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; font-weight: 400; text-align: left; padding-bottom: 5px; padding-top: 5px; vertical-align: top; border-top: 0px; border-right: 0px; border-bottom: 0px; border-left: 0px;"
													width="100%">
													<table border="0" cellpadding="0" cellspacing="0"
														class="icons_block block-1" role="presentation"
														style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
														width="100%">
														<tr>
															<td class="pad"
																style="vertical-align: middle; color: #9d9d9d; font-family: inherit; font-size: 15px; padding-bottom: 5px; padding-top: 5px; text-align: center;">
																<table cellpadding="0" cellspacing="0"
																	role="presentation"
																	style="mso-table-lspace: 0pt; mso-table-rspace: 0pt;"
																	width="100%">
																	<tr>
																		<td class="alignment"
																			style="vertical-align: middle; text-align: center;">
																			<!--[if vml]><table align="left" cellpadding="0" cellspacing="0" role="presentation" style="display:inline-block;padding-left:0px;padding-right:0px;mso-table-lspace: 0pt;mso-table-rspace: 0pt;"><![endif]-->
																			<!--[if !vml]><!-->
																			<table cellpadding="0" cellspacing="0"
																				class="icons-inner" role="presentation"
																				style="mso-table-lspace: 0pt; mso-table-rspace: 0pt; display: inline-block; margin-right: -4px; padding-left: 0px; padding-right: 0px;">
																				<!--<![endif]-->
																				<tr>
																					<td
																						style="vertical-align: middle; text-align: center; padding-top: 5px; padding-bottom: 5px; padding-left: 5px; padding-right: 6px;">
																						<a href="https://www.designedwithbee.com/"
																							style="text-decoration: none;"
																							target="_blank"><img
																								align="center"
																								alt="Designed with BEE"
																								class="icon" height="32"
																								src="images/bee.png"
																								style="display: block; height: auto; margin: 0 auto; border: 0;"
																								width="34" /></a>
																					</td>
																					<td
																						style="font-family: Cabin, Arial, Helvetica Neue, Helvetica, sans-serif; font-size: 15px; color: #9d9d9d; vertical-align: middle; letter-spacing: undefined; text-align: center;">
																						<a href="https://www.designedwithbee.com/"
																							style="color: #9d9d9d; text-decoration: none;"
																							target="_blank">Designed
																							with BEE</a>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
    <script>
        setTimeout(function(){
            window.location.href="index.asp";
        },10000)
    </script>
</body>

</html>