CREATE DATABASE WebSellProduct
GO

USE WebSellProduct

GO
CREATE TABLE Products(
id int IDENTITY(1, 1) PRIMARY KEY,
[name] NVARCHAR(255),
[type] NVARCHAR(255),
brand NVARCHAR(255),
price real,
cost real,
describe NVARCHAR(255),
isEnabled  BIT  Default 1
)

GO
CREATE TABLE ProductsDetail(
id int PRIMARY KEY,
quantity int,
mainImage varchar(255),
imageDes1 varchar(255),
imageDes2 varchar(255),
imageDes3 varchar(255),
FOREIGN KEY (id) REFERENCES Products(id)
)

GO
CREATE TABLE Account(
id int IDENTITY(1, 1) PRIMARY KEY,
[name] NVARCHAR(255),
email NVARCHAR(255),
phone VARCHAR(10),
dateOfBirth DATE,
city NVARCHAR(255),
district NVARCHAR(255),
ward NVARCHAR(255),
[address] NVARCHAR(255),
dateCreate DATETIME DEFAULT GETDATE(),
[password] NVARCHAR(255),
avata NVARCHAR(255) DEFAULT 'default.svg',
[role] NVARCHAR(255) DEFAULT 'USER',
isEnabled  BIT  DEFAULT 1
)

GO
CREATE UNIQUE INDEX IX_Account_Phone_NotNull
    ON Account (phone)
    WHERE phone IS NOT NULL;

GO
CREATE UNIQUE INDEX IX_Account_Email_NotNull
    ON Account (email)
    WHERE email IS NOT NULL;


GO
CREATE TABLE Url2SliderImgBanner(
id int IDENTITY(1, 1) PRIMARY KEY,
urlImg VARCHAR(255)
)
GO
CREATE TABLE Feedback(
id int IDENTITY(1, 1) PRIMARY KEY,
accId int,
comment NVARCHAR(255),
FOREIGN KEY (accId) REFERENCES Account(id)
)

GO
CREATE TABLE [Order](
id int IDENTITY(1, 1) PRIMARY KEY,
accId int,
totalPrice real,
orderStatus BIT,
FOREIGN KEY (accId) REFERENCES Account(id),
)

GO
CREATE TABLE OrderDetail(
id int IDENTITY(1, 1) PRIMARY KEY,
orderID int, 
productId int,
quantity int,
FOREIGN KEY (productId)  REFERENCES Products(id),
FOREIGN KEY (orderID) REFERENCES [Order](id)
)

GO
CREATE TABLE GiftCode(
giftCode VARCHAR(20),
discount DECIMAL(10,2),
expire DATETIME,
amount INT,
orderId int,
FOREIGN KEY (orderID) REFERENCES [Order](id)
)

GO
CREATE TRIGGER trg_InsertProductsDetail
ON Products
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM ProductsDetail pd
        INNER JOIN inserted i ON pd.id = i.id
    )
    BEGIN
        RAISERROR ('The id already exists in ProductsDetail table', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
    
    INSERT INTO ProductsDetail (id, quantity)
    SELECT i.id, 0 FROM inserted i
    WHERE NOT EXISTS (
        SELECT 1 FROM ProductsDetail pd WHERE pd.id = i.id
    )
END

GO
INSERT INTO Products([name], [type], brand, price, cost, describe, isEnabled)
VALUES('Bluetooth Marshall Acton III', 'Audio', 'Marshall', 349, 400, 'The smallest speaker model in the new Home Speaker series introduced by Marshall in mid-2022.', DEFAULT),
	  ('Edifier MR4', 'Audio', 'Edifier', 199, 199, 'A product in the line of professional monitor speakers to satisfy any demanding user with advanced technologies.', DEFAULT),
	  ('Smart watch Huawei Watch GT3 46mm', 'Watch', 'Huawei', 149, 200, 'The product inherits the sporty design of the previous versions, besides the round face and luxurious metal frame.', DEFAULT),
	  ('AirTag Leather Key Ring', 'Accessory', 'Apple', 15, 25, 'The AirTag Apple Leather Keyring strap is a must-have accessory that makes it easy to attach your AirTag to a variety of items.', DEFAULT),
	  ('Tempered glass sticker for Iphone 12 Pro', 'Accessory', 'Apple', 10, 10, 'Unlike most ill-fitting cases that are bulky or heavy, these sticker skins are heated for a firm, ultra-slim fit.', DEFAULT),
	  ('PDF Devia sticker back for Iphone 11', 'Accessory', 'Apple', 5, 9, 'The screen protector is designed with rough texture, durable and with special features.', DEFAULT),
	  ('Logitech G304 Lightspeed Wireless Gaming Mouse', 'Mouse', 'Logitech', 39, 45, 'Designed for real performance with the latest technological breakthroughs. Impressive 250 hours of battery life. Now there are many vibrant colors.', DEFAULT),
	  ('Razer Basilisk X HyperSpeed', 'Mouse', 'Razer', 45, 45, 'Ergonomic design comfortably moves when playing games. Convenient wireless connection, maximum distance up to 10m.', DEFAULT),
	  ('Logitech K480 keyboard', 'Keyboard', 'Logitech', 30, 30, 'Bracket design for paired devices, allowing multi-device connection via Bluetooth. Smart keys, quick device switching with convenient buttons.', DEFAULT),
	  ('AKKO 3087 V2 DS Matcha Red Bean', 'Keyboard', 'AKKO', 599, 630, 'One of the product lines with a luxurious, eye-catching impressive design and quality switch, outstanding with the Double-Shot keycap set that does not fade or fade after a period of use.', DEFAULT),
	  ('EPOMAKER MIA CAT Keycaps Set', 'Keycaps', 'EPOMAKER', 25, 30, '149 Keys Set, ANSI/ISO Layout Compatible. Wide Compatibility for MX Structure Switch and Various Layout', DEFAULT),
	  ('HyperX Pudding Keycaps', 'Keycaps', 'HyperX', 35, 40, 'The “Pudding” translucent double-layer style is designed to let more light out for increased brilliance. The keycaps use durable double-molded construction for reliability and outstanding style.', DEFAULT),
	  ('ASUS ROG Harpe Ace Aim Lab Edition Gaming Mouse', 'Mouse', 'ASUS', 125, 149, 'Absolute precision, Perfectly designed for gaming and beautiful with Aura Sync RGB lighting.', DEFAULT),
	  ('HP X3000 G2 Wireless Mouse ', 'Mouse', 'HP', 120, 120, '1600 dpi optical sensor provides reliable mouse tracking, exceptional speed, and pinpoint accuracy that can be customized to match your working style.', DEFAULT),
	  ('Razer DeathAdder Essential Gaming Mouse', 'Mouse', 'Razer', 20, 20, 'Ergonomic design, eye-catching LED light. Up to 6400 dpi resolution, responsive controls.', DEFAULT),
	  ('Apple EarPods Headphones', 'Audio', 'Apple', 15, 30, 'Designed to maximize sound output and minimize sound loss, which means you get high-quality sound.', DEFAULT),
	  ('Apple Watch SE 2022 40mm', 'Watch', 'Apple', 249, 300, 'The successor to the Apple Watch SE was released earlier. Apple Watch SE 2022 smart watch is equipped with Apple S8 chip and impressive features such as smart accident and fall detection.', DEFAULT),
	  ('Xiaomi Watch S1 Active', 'Watch', 'Xiaomi', 110, 150, 'This product is a new design that hits the smartwatch market of Xiaomi and opens a new wave for mid- and high-end smart watches.', DEFAULT),
	  ('Xiaomi Monitor 1C BHR4510GL 23.8 inch', 'Computer Screen', 'Xiaomi', 130, 150, 'Large size, ultra-thin bezels, 60 Hz sharp images, and above all keeping your eyes safe, the 23.8-inch Xiaomi Monitor 1C BHR4510gl monitor is just what a PC rig needs to entertain and work with. optimal performance.', DEFAULT),
	  ('ASUS ProArt PA278QV 27 inch', 'Computer Screen', 'ASUS', 449, 470, 'The Asus ProArt PA278QV graphics monitor has a large size and is equipped with advanced technologies, making it an effective companion to support you in graphic work.', DEFAULT)

GO
UPDATE ProductsDetail SET quantity = 2 WHERE id = 1
UPDATE ProductsDetail SET quantity = 12 WHERE id = 2
UPDATE ProductsDetail SET quantity = 22 WHERE id = 3
UPDATE ProductsDetail SET quantity = 43 WHERE id = 4
UPDATE ProductsDetail SET quantity = 32 WHERE id = 5
UPDATE ProductsDetail SET quantity = 79 WHERE id = 6
UPDATE ProductsDetail SET quantity = 83 WHERE id = 7
UPDATE ProductsDetail SET quantity = 9 WHERE id = 8
UPDATE ProductsDetail SET quantity = 19 WHERE id = 9
UPDATE ProductsDetail SET quantity = 24 WHERE id = 10


GO
INSERT INTO Account([name], email, phone, dateOfBirth, [address], dateCreate, [password], avata, isEnabled)
VALUES('Quan', 'phiquan070902@gmail.com', '0965152902',  GETDATE(), 'Ha Noi',  DEFAULT, '1', DEFAULT, DEFAULT),
('Thanh', 'thanhthat2002@gmail.com', '0965152901',  GETDATE(), 'Hai Duong',  DEFAULT, '1', DEFAULT, DEFAULT),
('Duong', 'phuongchamsong@gmail.com', '0965152900',  GETDATE(), 'Ha Tinh',  DEFAULT, '1', DEFAULT, DEFAULT),
('Hung', 'hunghuhi@gmail.com', '0965152899',  GETDATE(), 'Hai Phong',  DEFAULT, '1', DEFAULT, DEFAULT),
('Duy', 'duydapdaphequa@gmail.com', '0965152898',  GETDATE(), 'Hung Yen',  DEFAULT, '1', DEFAULT, DEFAULT)


GO 
INSERT INTO Url2SliderImgBanner VALUES
('banner_headphone.png'),
('banner_iphone.jpg'),
('banner_tv.png')


GO
UPDATE ProductsDetail SET quantity = 2, mainImage = 'marshall_audio.jpg' WHERE id = 1
UPDATE ProductsDetail SET quantity = 12, mainImage = 'EdifierMR4_audio.jpg' WHERE id = 2
UPDATE ProductsDetail SET quantity = 22, mainImage = 'HuaweiGT3_watch.jpg' WHERE id = 3
UPDATE ProductsDetail SET quantity = 43, mainImage = 'AirTagLeather_accessory.jpg' WHERE id = 4
UPDATE ProductsDetail SET quantity = 32,mainImage = 'TemperedGlassIp12_accessory.jpg' WHERE id = 5
UPDATE ProductsDetail SET quantity = 79, mainImage = 'PDFDeviaBackIp11_accessory.jpg' WHERE id = 6
UPDATE ProductsDetail SET quantity = 83, mainImage = 'LogitechG304_mouse.jpg' WHERE id = 7
UPDATE ProductsDetail SET quantity = 9, mainImage = 'RazeHyperSpeed_mouse.jpg' WHERE id = 8
UPDATE ProductsDetail SET quantity = 19, mainImage = 'LogitechK480_keyboard.jpg' WHERE id = 9
UPDATE ProductsDetail SET quantity = 24, mainImage = 'AKKO3087V2DS_keyboard.png' WHERE id = 10
UPDATE ProductsDetail SET quantity = 24, mainImage = 'EPOMAKERMIACAT _keycaps.jpg' WHERE id = 11
UPDATE ProductsDetail SET quantity = 24, mainImage = 'HyperXPudding_keycaps.jpg' WHERE id = 12
UPDATE ProductsDetail SET quantity = 24, mainImage = 'AsusRog_mouse.jpeg' WHERE id = 13
UPDATE ProductsDetail SET quantity = 24, mainImage = 'HPX300G2_mouse.png' WHERE id = 14
UPDATE ProductsDetail SET quantity = 24, mainImage = 'Razer_mouse.jpg' WHERE id = 15
UPDATE ProductsDetail SET quantity = 24, mainImage = 'AppleEarPods_audio.jpg' WHERE id = 16
UPDATE ProductsDetail SET quantity = 24, mainImage = 'AppleSE2022_watch.jpg' WHERE id = 17
UPDATE ProductsDetail SET quantity = 24, mainImage = 'XiaomiS1Active_watch.png' WHERE id = 18
UPDATE ProductsDetail SET quantity = 24, mainImage = 'XiaomiMonitor_computerScreen.jpg' WHERE id = 19
UPDATE ProductsDetail SET quantity = 24, mainImage = 'ASUSProArt_computerScreen.jpg' WHERE id = 20

GO
INSERT INTO GiftCode VALUES
('FREESHIP', 5, null, null, null)
