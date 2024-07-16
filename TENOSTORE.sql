Create database TENOSTORE
GO 
USE TENOSTORE 


create table ProductCategory(
	ProductCategoryId int IDENTITY(1,1) NOT NULL primary key ,
	Title nvarchar(150) NOT NULL,
	Description nvarchar(max) NULL,
	Icon  varchar(max)NUll,
	CreatedBy nvarchar(max) NULL,
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime  NULL,
	Modifiedby nvarchar(max) NULL,
	Alias nvarchar(150) NOT NULL,
	IsActive bit NOT NULL DEFAULT 0,
)
go



create table Product(
	ProductsId int IDENTITY(1,1) not null primary key ,
	Title nvarchar(max),
	CreatedBy nvarchar(max) NULL,
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime ,
	Modifeby nvarchar(max),
	Alias nvarchar(max)Null,
	IsActive bit NOT NULL DEFAULT 0,
	IsHome bit NOT NULL DEFAULT 0,
	IsSale bit NOT NULL DEFAULT 0,
	IsFeature bit NOT NULL DEFAULT 0,
	IsHot bit NOT NULL DEFAULT 0,
	ProductCode nvarchar(50),
	ProductCategoryId int,
	foreign key  (ProductCategoryId) REFERENCES ProductCategory (ProductCategoryId)
)
go



Create table ProductDetailImage(
	ProductImageId int IDENTITY(1,1) NOT NULL  primary key ,
	ProductsId int NOT NULL,
	Image varchar(max)NUll,
	IsDefault bit NOT NULL,
	foreign key  (ProductsId) REFERENCES Product (ProductsId)
)
go


create table RoleEmployee(
	RoleEmployeeId int IDENTITY(1,1) NOT NULL  primary key ,
	 RoleName nvarchar(100),
	 RoleDescription nvarchar(255),
)
go



create  TABLE Employee(
	EmployeeId int IDENTITY(1,1) NOT NULL  primary key ,--NhanVienId
	PhoneNumber VARCHAR(15)  Not null,--SDT
    NameEmployee NVARCHAR(max) not null,--TenNhanVien
	CitizenIdentificationCard char(12)not null,--CCCD
    Email VARCHAR(100)not null,
	Birthday Date not null ,
	Location nvarchar(max)not null,--DiaChi
	DayofWork date ,--NgayVaoLam
	Sex nvarchar(7),--GioiTinh
	CreatedBy nvarchar(max) NULL,
	CreatedDate datetime NOT NULL,
	ModifiedBy nvarchar(max) NULL,
	ModifiedDate datetime NOT NULL,
	Image varbinary(max)NUll,
	RoleEmployeeId int--IDCHu chuc ngang
	foreign key  (RoleEmployeeId) REFERENCES RoleEmployee (RoleEmployeeId)
)
go


create table AccountEmployee(
	EmployeeId int  NOT NULL  primary key ,--NhanVienId
   Password  varchar(100) not null,	
   	Code varchar(10) Not null,--MSNV
	Lock bit NOT NULL DEFAULT 0,
	foreign key  (EmployeeId) REFERENCES Employee (EmployeeId)
)
go


CREATE table UserTokens (
    UserId int PRIMARY KEY, -- ID của nhân viên
    Token char(8000), -- Token
    ExpiryDate datetime, -- Ngày hết hạn của token
    CONSTRAINT FK_UserTokens_Users FOREIGN KEY (UserId) REFERENCES AccountEmployee(EmployeeId) ON DELETE CASCADE 
);

create  table Customer (--tb_Customer
	CustomerId  int IDENTITY(1,1) NOT NULL primary key ,--CustomerId
    PhoneNumber VARCHAR(15)null ,
	FirstName NVARCHAR(100)  null,
	LastName NVARCHAR(max)  null,
    CustomerName NVARCHAR(max) not null,--TenKhachHang
    Email VARCHAR(200 )not null unique,
	Date_of_Birth Date null ,
	NumberofPurchases int, --SoLanMua
	Gender nvarchar(10) null,
	Image varbinary(max)NUll
)
go


create table AccountCustomer(
CustomerId  int primary key ,--CustomerId
 PhoneNumber VARCHAR(15)null ,
 Password  varchar(100) ,
Lock bit NOT NULL DEFAULT 0,
Code char(10),
foreign key  (CustomerId) REFERENCES Customer (CustomerId)
)
go


create table CustomerAddress(
	CustomerAddressId  int IDENTITY(1,1) NOT NULL primary key ,--CustomerId
	AddressCustomer nvarchar(max)not null,
	NameWard nvarchar(max)not null,
	NameDistrict nvarchar(max)not null,
	NameProvince  nvarchar(max)not null,
	CustomerId  int
	foreign key  (CustomerId) REFERENCES Customer (CustomerId)
)
go



create table Orders(
	OrderId int IDENTITY(1,1) NOT NULL primary key,
	Code nvarchar(max) NOT NULL,
	TotalAmount [decimal](18, 2) NOT NULL,
	CreatedBy nvarchar(max) NULL,
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime NOT NULL,
	Modifiedby nvarchar(max) NULL,
	TypePayment int NOT NULL,
	typeOrder bit NOT NULL DEFAULT 0,--dơn hàng huỷ 
	OrdernotesCancel nvarchar (250),
	Confirm bit NOT NULL DEFAULT 0,
	Note nvarchar(max),--Khách hàng dghi chú 
	typeReturn bit NOT NULL DEFAULT 0,--neu true là đơn hàng trả 
	Success bit NOT NULL DEFAULT 0,--trang thái đơn hàng (true khách đã nhận đưuọc hàng)
	SuccessDate datetime,--Nếu Success ==true thì sẽ đây là ngày nhận hàng
	CustomerId int not null ,
	CustomerAddressId int  not null,
	Address  nvarchar(max) null,
	NameWard nvarchar(max) null,
	NameDistrict nvarchar(max) null,
	NameProvince  nvarchar(max) null,
	foreign key  (CustomerId) REFERENCES Customer (CustomerId),
	foreign key  (CustomerAddressId) REFERENCES CustomerAddress (CustomerAddressId)
)
go


create table OrderDetail (
	OrderDetailId int IDENTITY(1,1) NOT NULL primary key ,
	Quantity int NOT NULL,
	OrderId int,
	ProductsId int,
	foreign key  (OrderId) REFERENCES Orders (OrderId),
		foreign key  (ProductsId) REFERENCES Product (ProductsId),
)
go





create table Bill(
	BillId int IDENTITY(1,1) NOT NULL primary key,
	Code nvarchar(max) NOT NULL,
	TotalAmount [decimal](18, 2) NOT NULL,
	CreatedBy nvarchar(max) NULL,
	CreatedDate datetime NOT NULL,
	ModifiedDate datetime NOT NULL,
	Modifiedby nvarchar(max) NULL,
	TypePayment int NOT NULL,
	TypeOrder bit NOT NULL DEFAULT 0,--Hoá đơn trả
	Note nvarchar(max),--Khách hàng dghi chú 
	PhoneCustomer nchar(15),
	NameCustomer nvarchar(250),
	EmployeeId int ,
		foreign key  (EmployeeId) REFERENCES Employee (EmployeeId)
)
go
create table BillDetail (
	BillDetailId int IDENTITY(1,1) NOT NULL primary key ,
	Quantity int NOT NULL,
	BillId int,
	ProductsId int,
		foreign key  (BillId) REFERENCES Bill (BillId),
			foreign key  (ProductsId) REFERENCES Product (ProductsId)
)
go




create table Cart(
	CartId int IDENTITY(1,1) NOT NULL primary key ,
	CustomerId  int,
	foreign key  (CustomerId) REFERENCES Customer (CustomerId),
)
go

create table CartItem (
	CartItem int IDENTITY(1,1) NOT NULL primary key ,
	CartId int NOT NULL,
	Quantity int NOT NULL,
	ProductsId int NOT NULL,
	foreign key  (CartId) REFERENCES Cart (CartId),
			foreign key  (ProductsId) REFERENCES Product (ProductsId)
)
go

create table News(
	NewsId int IDENTITY(1,1) NOT NULL primary key ,
	Title nvarchar(350)  NULL,
	Createdate date ,
	EmployeeId int,
	IsActive bit NOT NULL DEFAULT 0,
	Image varbinary(max),
	foreign key  (EmployeeId) REFERENCES Employee (EmployeeId)
)
go

create table NewDetail(
	NewDetailId int IDENTITY(1,1) NOT NULL primary key ,
	Createdate date ,
	Content nvarchar(max),
	LinkIg char(900),
	IsActive bit NOT NULL DEFAULT 0,

	NewsId int,
		foreign key  (NewsId) REFERENCES News (NewsId)
)
go
create table ImageNewDetail(
	ImageNewDetailId int IDENTITY(1,1) NOT NULL  primary key ,
	NewDetailId int NOT NULL,
	Image varbinary(max)NUll,
	IsDefault bit NOT NULL,
	foreign key  (NewDetailId) REFERENCES NewDetail (NewDetailId)
)
go





create table Banner(
	BannerId int IDENTITY(1,1) NOT NULL primary key ,
	Title nvarchar(350)  NULL,
	Createdate date ,
	EmployeeId int,
	IsActive bit NOT NULL DEFAULT 0,
	Image varbinary(max)
)
go


	create table Provinces(
		idProvinces int identity(1,1) primary key,
		name nvarchar(255),
	);
	go

	create table Districts(
		idDistricts int identity(1,1) primary key,
		name nvarchar(255),
		idProvinces int,
		foreign key (idProvinces) references Provinces(idProvinces)
	);
	go

	create table Wards(
		idWards int identity(1,1) primary key,
		name nvarchar(255),
		idDistricts int,
		foreign key (idDistricts) references Districts(idDistricts)
	);
	go


CREATE TRIGGER CreateCartOnInsertKhachHang
ON Customer
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Chèn dữ liệu mới vào bảng tb_Cart
    INSERT INTO Cart (CustomerId)
    SELECT CustomerId
    FROM inserted;
END;

