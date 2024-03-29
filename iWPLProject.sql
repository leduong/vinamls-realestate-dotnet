create database VietnamMLS
go

use VietnamMLS
go


--use master
--go
--drop database VietnamMLS
--go
--drop table [Languages]
--drop table Countries
--drop table Cities
--drop table LocalizedCities
--drop table ParentCategories
--drop table LocalizedCategories
--drop table Categories
--drop table LocalizedCategories
--drop table News
--drop table LocalizedNews


--//////////////////////////////////////////////////////////////////////////////////
--Old Queries, database version 1
--select * from News n
--	inner join News_Language nl on n.NewsID = nl.NewsID
--	inner join [Language] l on l.LanguageID = nl.LanguageID

--select n.NewsID, nl.Title, PostedDate, p.ParentCtgName, c.CategoryName,
--		ct.CityName, IsApproved, l.LanguageName from News n
--	inner join News_Language nl on n.NewsID = nl.NewsID
--	inner join [Language] l on l.LanguageID = nl.LanguageID
--	inner join Category_Language c on c.LanguageID = nl.LanguageID and c.CategoryID = nl.CategoryID
--	inner join ParentCategory_Language p on p.ParentCtgID = c.ParentCtgID and p.LanguageID = nl.LanguageID
--	inner join City ct on ct.CityID = p.CityID
--	where nl.LanguageID = 1 and nl.CategoryID = 1
--///////////////////////////////////////////////////////////////////////////////////




--1
create table [Languages]
(
	LanguageID int identity(1,1) primary key,
	LanguageCode varchar(4) not null,
	[Name] nvarchar(50) not null,
	Flag varchar(50) default 'language.jpg',
	IsUsed bit default 'true',
	SortOrder int,
)
go
--alter table Languages drop constraint DF__Languages__Flag__7D78A4E7
--alter table Languages drop column Flag 
--alter table Languages alter column Flag varchar(50)
--alter table Languages add SortOrder int
--alter table [Languages] add Flag varchar(200)
--alter table [Languages] add IsUsed bit default 'true'
--drop table [Languages]
--set entity
SET IDENTITY_INSERT [dbo].[Languages] ON
INSERT [dbo].[Languages] ([LanguageID], [LanguageCode], [Name], [Flag]) VALUES (1, N'vn', N'Việt Nam', NULL)
INSERT [dbo].[Languages] ([LanguageID], [LanguageCode], [Name], [Flag]) VALUES (2, N'en', N'English', NULL)
INSERT [dbo].[Languages] ([LanguageID], [LanguageCode], [Name], [Flag]) VALUES (3, N'jp', N'日本', NULL)
INSERT [dbo].[Languages] ([LanguageID], [LanguageCode], [Name], [Flag]) VALUES (4, N'fr', N'France', NULL)
INSERT [dbo].[Languages] ([LanguageID], [LanguageCode], [Name], [Flag]) VALUES (5, N'cn', N'中国', NULL)
SET IDENTITY_INSERT [dbo].[Languages] OFF


--2
create table Roles
(
	RoleID int primary key,
	RoleName varchar(20) not null	
)
--alter table Roles alter column RoleName varchar(20)
--drop table Roles
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Administrator')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Advanced User')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Members')


--3
create table Users
(
	UserID int identity(1,1) primary key,
	Username varchar(16) not null,
	[Password] varchar(16) not null,
	Email varchar(30),
	RoleID int,
	foreign key (RoleID) references Roles(RoleID)
)
--drop table Users
--alter table Users add Email varchar(30)
--alter table Users drop constraint PK__Users__014935CB
--alter table Users add UserID int identity(1,1) primary key
--alter table Users drop constraint PK__Users__2F10007B
--alter table Users(UserID int, Username varchar(16), 
	--[Password] varchar(16), RoleID int)
--alter table Users drop constraint FK__Users__RoleID__023D5A04
--select * from Users
--set entity
INSERT [dbo].[Users] ([Username], [Password], [RoleID]) VALUES (N'long', N'1', 1)

--4
create table Countries
(
	CountryID int identity(1,1) primary key,
	Name nvarchar(50) unique not null,
	IsUsed bit default 'true'
)
go
--drop table Countries
--set entity
SET IDENTITY_INSERT [dbo].[Countries] ON
INSERT [dbo].[Countries] ([CountryID], [Name], [IsUsed]) VALUES (1, N'Việt Nam', 1)
INSERT [dbo].[Countries] ([CountryID], [Name], [IsUsed]) VALUES (2, N'USA', 1)
INSERT [dbo].[Countries] ([CountryID], [Name], [IsUsed]) VALUES (3, N'Japan', 0)
INSERT [dbo].[Countries] ([CountryID], [Name], [IsUsed]) VALUES (4, N'France', 0)
INSERT [dbo].[Countries] ([CountryID], [Name], [IsUsed]) VALUES (5, N'China', 0)
SET IDENTITY_INSERT [dbo].[Countries] OFF

--5
create table Cities
(
	CityID int identity(1,1) primary key,
	[Description] nvarchar(50),
	CountryID int,
	IsUsed bit default 'true',
	foreign key (CountryID) references Countries(CountryID)
)
go
--drop table Cities
--set entity
SET IDENTITY_INSERT [dbo].[Cities] ON
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (1, N'TP. Hồ Chí Minh', 1, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (2, N'TP. Hà Nội', 1, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (3, N'Đà Nẵng', 1, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (4, N'Huế', 1, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (5, N'Nha Trang', 1, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (6, N'New York', 2, 1)
INSERT [dbo].[Cities] ([CityID], [Description], [CountryID], [IsUsed]) VALUES (7, N'San Francisco', 2, 1)
SET IDENTITY_INSERT [dbo].[Cities] OFF


--
create table CitiesInHome
(
	CityID int primary key,
	IsDefault bit default 'false',
	SortOrder int,
	foreign key (CityID) references Cities(CityID)
)
--alter table CitiesInHome drop column InHome
--alter table CitiesInHome drop constraint DF__CitiesInH__InHom__0DAF0CB0
--alter table CitiesInHome add IsDefault bit default 'true'
--alter table CitiesInHome add SortOrder int
--drop table CitiesInHome

--
create table LocalizedCities
(
	CityID int,
	LanguageID int,
	Name nvarchar(50),
	SEOUrl varchar(255),
	SEOKeyword varchar(255),
	SEODescription varchar(255),
	primary key (CityID, LanguageID),
	foreign key (CityID) references Cities(CityID),
	foreign key (LanguageID) references Languages(LanguageID)
)
--alter table LocalizedCities add SEOURL varchar(255)
--alter table LocalizedCities add SEOKeyword varchar(255)
--alter table LocalizedCities add SEODescription varchar(255)
--drop table LocalizedCities
--set entity
INSERT [dbo].[LocalizedCities] ([CityID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 1, N'TP. Hồ Chí Minh', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCities] ([CityID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 2, N'Ho Chi Minh city', NULL, NULL, NULL)


--6
create table ParentCategories
(
	ParentCategoryID int identity(1,1) primary key,
	[Description] nvarchar(100),
	CityID int,
	IsUsed bit default 'true',
	SortOrder int,
	foreign key (CityID) references Cities(CityID)
)
go
--exec sp_rename 'ParentCategories.ParentCtgID','ParentCategoryID','COLUMN'
--alter table ParentCategories add SortOrder int
--drop table ParentCategories
--set entity
SET IDENTITY_INSERT [dbo].[ParentCategories] ON
INSERT [dbo].[ParentCategories] (ParentCategoryID, [Description], [CityID], [IsUsed]) VALUES (1, N'Nhip song', 1, 1)
INSERT [dbo].[ParentCategories] (ParentCategoryID, [Description], [CityID], [IsUsed]) VALUES (2, N'Giai tri', 1, 1)
SET IDENTITY_INSERT [dbo].[ParentCategories] OFF

--7
create table LocalizedParentCategories
(
	ParentCategoryID int,
	LanguageID int,
	Name nvarchar(100) not null,
	SEOUrl varchar(255),
	SEOKeyword varchar(255),
	SEODescription varchar(255),
	primary key (ParentCategoryID, LanguageID),
	foreign key (ParentCategoryID) references [ParentCategories](ParentCategoryID),
	foreign key (LanguageID) references [Languages](LanguageID)
)
go
--exec sp_rename 'LocalizedParentCategories.ParentCtgID','ParentCategoryID','COLUMN'
--alter table LocalizedParentCategories add foreign key (ParentCtgID) references ParentCategories(ParentCtgID)
--alter table LocalizedParentCategories add SEOURL varchar(255)
--alter table LocalizedParentCategories add SEOKeyword varchar(255)
--alter table LocalizedParentCategories add SEODescription varchar(255)
--drop table LocalizedParentCategories
--set entity
INSERT [dbo].[LocalizedParentCategories] (ParentCategoryID, [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 1, N'Nhịp sống', NULL, NULL, NULL)
INSERT [dbo].[LocalizedParentCategories] (ParentCategoryID, [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 2, N'Living', NULL, NULL, NULL)
INSERT [dbo].[LocalizedParentCategories] (ParentCategoryID, [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 1, N'Giải trí', NULL, NULL, NULL)
INSERT [dbo].[LocalizedParentCategories] (ParentCategoryID, [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 2, N'Entertainment', NULL, NULL, NULL)



--8
create table Categories
(
	CategoryID int identity(1,1) primary key,
	[Description] nvarchar(100),
	IsUsed bit default 'true',
	ParentCategoryID int,
	DefaultImage varchar(50) default 'categories.jpg',
	SortOrder int,
	foreign key (ParentCategoryID) references ParentCategories(ParentCategoryID)
)
go
--exec sp_rename 'Categories.ParentCtgID','ParentCategoryID','COLUMN'
--alter table Categories add DefaultImage varchar(200) default '\images\categories\default.jpg'
--alter table Categories add SortOrder int
--drop table Categories
--set entiy
SET IDENTITY_INSERT [dbo].[Categories] ON
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (1, N'Gioi thieu', 1, 1)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (2, N'Phuong tien cong cong', 1, 1)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (3, N'Truong hoc', 1, 1)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (4, N'San bay', 1, 1)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (5, N'Mua sam', 1, 1)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (6, N'Am thuc', 1, 2)
INSERT [dbo].[Categories] ([CategoryID], [Description], [IsUsed], ParentCategoryID) VALUES (7, N'Du lich', 1, 2)
SET IDENTITY_INSERT [dbo].[Categories] OFF


--9
create table LocalizedCategories
(
	CategoryID int,
	LanguageID int,
	Name nvarchar(100),
	SEOUrl varchar(255),
	SEOKeyword varchar(255),
	SEODescription varchar(255),
	primary key (CategoryID, LanguageID),
	foreign key (CategoryID) references Categories(CategoryID),
	foreign key (LanguageID) references [Languages](LanguageID)
)
go
--alter table LocalizedCategories add SEOURL varchar(255)
--alter table LocalizedCategories add SEOKeyword varchar(255)
--alter table LocalizedCategories add SEODescription varchar(255)
--drop table LocalizedCategories
--set entity
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 1, N'Giới thiệu', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 2, N'Introduction', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 1, N'Phương tiện công cộng', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 2, N'Transportations', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (3, 1, N'Trường học', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (3, 2, N'Schools', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (4, 1, N'Sân bay', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (4, 2, N'Airport', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (5, 1, N'Mua sắm', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (5, 2, N'Shopping', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (6, 1, N'Ẩm thực', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (6, 2, N'Cooking', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (7, 1, N'Du lịch', NULL, NULL, NULL)
INSERT [dbo].[LocalizedCategories] ([CategoryID], [LanguageID], [Name], [SEOURL], [SEOKeyword], [SEODescription]) VALUES (7, 2, N'Traveling', NULL, NULL, NULL)



--10
create table News
(
	NewsId int identity(1,1) primary key,
	PostedDate smalldatetime,
	CategoryID int,
	IsApproved bit default 'false',
	MainImage nvarchar(50) default 'news.jpg',
	UserID int,
	CreatedDate smalldatetime,
	ParentCategoryID int,
	CityID int,
	foreign key (CategoryID) references Categories(CategoryID),
	foreign key (UserID) references Users(UserID),
	foreign key (ParentCategoryID) references ParentCategories(ParentCategoryID),
	foreign key (CityID) references Cities(CityID)
)
go
--alter table News add foreign key (ParentCategoryID) references ParentCategories(ParentCategoryID)
--alter table News add foreign key (CityID) references Cities(CityID)
--alter table News drop constraint FK__News__Username__267ABA7A
--alter table News drop column Username
--alter table News add UserID int
--alter table News add foreign key (UserID) references Users(UserID)
--alter table News add MainImage nvarchar(200) default '\images\default.jpg'
--alter table News add Username varchar(16)
--alter table News add foreign key (UserID) references Users(UserID)
--alter table News add CreatedDate smalldatetime
--alter table News add ParentCategoryID int
--alter table News add CityID int
--alter table News add foreign key (ParentCategoryID) references ParentCategories(ParentCategoryID)
--alter table News add foreign key (CityID) references Cities(CityID)
--drop table News
--set entity
SET IDENTITY_INSERT [dbo].[News] ON
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (1, NULL, 1, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (2, NULL, 1, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (3, NULL, 1, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (4, NULL, 1, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (5, NULL, 1, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (6, NULL, 2, 1, NULL, NULL)
INSERT [dbo].[News] ([NewsID], [PostedDate], [CategoryID], [IsApproved], [MainImage], UserID) VALUES (7, NULL, 2, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[News] OFF


--11
create table LocalizedNews
(
	NewsID int,
	LanguageID int,
	Title nvarchar(300),
	FullContent nvarchar(max),
	SEOUrl varchar(255),
	SEOKeyword varchar(255),
	SEODescription varchar(255),
	Tags nvarchar(50),
	primary key (NewsID, LanguageID),
	foreign key (NewsID) references News(NewsID),
	foreign key (LanguageID) references [Languages](LanguageID)
)
--alter table LocalizedNews add Tags nvarchar(50)
--exec sp_rename 'LocalizedNews.Content', 'FullContent', 'COLUMN'
--alter table LocalizedNews add SEOURL varchar(255)
--alter table LocalizedNews add SEOKeyword varchar(255)
--alter table LocalizedNews add SEODescription varchar(255)
--drop table LocalizedNews
--set entity
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 1, N'Tin tức 1', N'nội dung tin tức số 1', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (1, 2, N'News 1', N'News 1''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 1, N'tin tức 2', N'nội dung tin tức 2', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (2, 2, N'news 2', N'news 2''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (3, 1, N'tin tức 3', N'nội dung tin tức 3', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (3, 2, N'news 3', N'news 3''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (4, 1, N'tin tức 4', N'nội dung tin tức 4', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (4, 2, N'news 4', N'news 4''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (5, 1, N'tin 5', N'nội dung tin 5', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (5, 2, N'news 5', N'news 5''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (6, 1, N'tin 6', N'nội dung tin 6', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (6, 2, N'news 6', N'news 6''s content', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (7, 1, N'tin số 7', N'nội dung tin số 7', NULL, NULL, NULL)
INSERT [dbo].[LocalizedNews] ([NewsID], [LanguageID], [Title], FullContent, [SEOURL], [SEOKeyword], [SEODescription]) VALUES (7, 2, N'news 7', N'news 7''s content', NULL, NULL, NULL)

--


--12
create table PromotedNews
(
	NewsID int,
	StartedDate smalldatetime not null,
	EndedDate smalldatetime not null,
	[Description] nvarchar(300),
	IsUsed bit default 'false',
	LevelID int,
	primary key (NewsID),
	foreign key (NewsID) references News(NewsID)
)
--drop table PromotedNews
--alter table PromotedNews add LevelID int
--alter table PromotedNews drop constraint FK__PromotedN__NewsI__3F466844
--alter table PromotedNews add foreign key (NewsID) references News(NewsID)
--alter table PromotedNews drop constraint PK__PromotedNews__2C3393D0

