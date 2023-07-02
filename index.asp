<!-- #include file="connect.asp" -->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN
    DIM sqlString, rs
    sqlString = "SELECT * FROM Url2SliderImgBanner"
    connDB.Open()
    set rs = connDB.execute(sqlString)
End if
%> 
<!DOCTYPE html>
<head>
  <title>QTD Online Store</title>
  <meta property="og:title" content="QTD Online Store" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta charset="utf-8" />
  <link rel="icon" type="image/png" href="../images/logos/qtdlogo.png" />

  <link rel="stylesheet" href="./css/font-jost.css" data-tag="font"/>
  <link rel="stylesheet" href="./css/reset.css">
  <link rel="stylesheet" href="./css/style.css"/>
  <link rel="stylesheet" href="./css/home.css"/>
 

</head>

<body>
  <div>
    <!-- #include file="header.asp" -->
    <div class="home-container">
      <div class="home-main">
        <div class="home-hero section-container">
          <div class="home-max-width max-width-container">
            <div class="home-hero1">
              <div class="slideshow-container">
                <% While Not rs.EOF %>
                <div class="mySlides fade">
                  <img class="myimg" src="./img/banner/<%=rs("urlImg")%>" style="border-radius: 8px;"/>
                </div>
                <%rs.MoveNext%>
                <%Wend
                rs.CLose()
                connDB.Close()%>
              </div>
              <div hidden>
                <span class="dot"></span>
                <span class="dot"></span>
                <span class="dot"></span>
              </div>
            </div>
          </div>
        </div>
        <div class="section-container column">
          <div class="max-width-container">
            <div class="section-heading-section-heading">
              <h1 class="section-heading-text Heading-2">
                <span>SHOP BY CATEGORIES</span>
              </h1>
              <span class="section-heading-text1">
                <span>
                  Start shopping based on the categories you are interested in
                </span>
              </span>
            </div>
            <div class="home-cards-container">
              <a href="listproducts.asp?key=&sort=hot&brand=&type=Audio" class="category-card-category-card">
                <img alt="image" src="./img/audio_banner.jpg" class="category-card-image" />
                <span class="category-card-text"><span>Audio</span></span>
              </a>
              <a href="listproducts.asp?key=&sort=hot&brand=&type=Watch" class="category-card-category-card">
                <img alt="image" src="./img/watch_banner.gif" class="category-card-image" />
                <span class="category-card-text"><span>Smart Watch</span></span>
              </a>
              <a href="listproducts.asp?key=&sort=hot&brand=&type=Accessory" class="category-card-category-card">
                <img alt="image" src="./img/accessory_banner.jpg" class="category-card-image" />
                <span class="category-card-text"><span>Accessory</span></span>
              </a>
              <a href="listproducts.asp?key=&sort=hot&brand=&type=Mouse" class="category-card-category-card">
                <img alt="image" src="./img/mouse_banner.jpg" class="category-card-image" />
                <span class="category-card-text"><span>Mouse</span></span>
              </a>
              <a href="listproducts.asp?key=&sort=hot&brand=&type=Keyboard" class="category-card-category-card">
                <img alt="image" src="./img/keyboard_banner.jpg" class="category-card-image" />
                <span class="category-card-text"><span>Keyboard</span></span>
              </a>
              <a href="#" class="category-card-category-card">
                <img alt="image" src="./img/home_banner.jpg" class="category-card-image" />
                <span class="category-card-text">
                  <span>Smart Home</span>
                </span>
              </a>
              <a href="listproducts.asp?key=&sort=hot" class="category-card-category-card">
                <img alt="image" src="./img/deals_banner.jpg" class="category-card-image" />
                <span class="category-card-text">
                  <span>Hot Deals</span>
                </span>
              </a>
            </div>
          </div>
          <div class="home-banner">
            <div class="home-container03">
              <h3 class="home-text08 Heading-3">QTDSTORE</h3>
              <span class="home-text09">
                <span></span>
                <span>furniture</span>
              </span>
            </div>
          </div>
          <div class="home-container04 max-width-container">
            <div class="home-container05">
              <span class="home-text12">
                <span>
                  QTD Store is a shop that specializes in selling accessories related to technology. From phone cases to
                  laptop sleeves, QTD Store has everything you need to protect and enhance your devices. The name "QTD"
                  stands for "Quality Technology Design," emphasizing the store's commitment to providing high-quality
                  and well-designed products. Whether you're looking for a stylish phone case, a durable laptop bag, or
                  other tech accessories, QTD Store has a wide selection to choose from. With their focus on quality and
                  design, you can trust that the products sold at QTD Store will not only protect your devices but also
                  elevate their appearance.
                </span>
              </span>
              <button class="button">Read more</button>
            </div>
          </div>
        </div>

        <div class="home-full-width-banner section-container">
          <div class="home-bannerr1">
            <img alt="image"
              src="https://images.unsplash.com/photo-1512295767273-ac109ac3acfa?ixid=Mnw5MTMyMXwwfDF8c2VhcmNofDd8fG1pbmltYWxpc20lMjB5ZWxsb3d8ZW58MHx8fHwxNjI2MTg0NjU3&amp;ixlib=rb-1.2.1&amp;w=400"
              class="home-imagee4" />
            <div class="home-containerr06">
              <h1 class="home-textt18">You don't have account</h1>
              <span class="home-textt19">
                <span class="home-textt20">
                  Create an account now to use full features, accumulate
                  incentives when paying for products and participate in the
                  Refer a Friend program to receive permanent commissions at
                  GameQT.
                </span>
                <span>
                  <span></span>
                  <span></span>
                </span>
                <span>
                  <span></span>
                  <span></span>
                </span>
              </span>
              <div class="home-containerr07">
                <%If isnull(Session("email")) OR TRIM(Session("email"))=""Then
                    Response.Write("<a href='/register.asp'>")
                  Else
                    Response.Write("<a href=''>")
                  End If
                %>
                  <button class="home-buttonn1 button">Register Now</button>
                </a>
                <div class="home-containerr08">
                  <span class="home-textt27">
                    &nbsp; Allready have account?&nbsp;
                  </span>
                  <%If isnull(Session("email")) OR TRIM(Session("email"))=""Then
                    Response.Write("<a href='/login.asp'>")
                  Else
                    Response.Write("<a href=''>")
                  End If
                  %>
                    <span class="home-textt28">Sign in</span>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>

      </div>
      <div class="home-footer">
        <div class="max-width-container">
          <footer class="home-footer1">
            <div class="home-container06">
              <h3 class="home-text21 Heading-3">QTDSTORE</h3>
              <span class="home-text22">
                <span>314 Washington DC</span>
                <br />
                <span>United States</span>
              </span>
              <span class="home-text25">(891) 551-0110</span>
              <span class="home-text26">qtdstoresupport@gmail.com</span>
            </div>
            <div class="home-links-container">
              <div class="home-container08">
                <span class="home-text34">Company</span>
                <span class="home-text35"><a href="listproducts.asp?key=&sort=hot">Shop</a></span>
                <span class="home-text36"><a href="feedback.asp">About</a></span>
                <span class="home-text37"><a href="feedback.asp">Contact us</a></span>
              </div>
            </div>
          </footer>
        </div>
      </div>
    </div>
  </div>
  <script>
    let slideIndex = 0;
    showSlides();
    function showSlides() {
      let i;
      let slides = document.getElementsByClassName("mySlides");
      let dots = document.getElementsByClassName("dot");
      for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
      }
      slideIndex++;
      if (slideIndex > slides.length) { slideIndex = 1 }
      for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
      }
      slides[slideIndex - 1].style.display = "block";
      dots[slideIndex - 1].className += " active";
      setTimeout(showSlides, 4000); // Change image every 2 seconds
    }
  </script>
  <script src="js/custom-scripts.js"></script>

</body>

</html>