USE [gym]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 11.12.2023 11:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customerID] [int] IDENTITY(1,1) NOT NULL,
	[fcs] [nchar](255) NOT NULL,
	[birthdate] [date] NOT NULL,
	[phone] [nchar](15) NOT NULL,
	[e-mail] [nchar](255) NULL,
 CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[season_tickets]    Script Date: 11.12.2023 11:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[season_tickets](
	[season_ticketID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](50) NOT NULL,
	[validity] [int] NOT NULL,
	[price] [int] NOT NULL,
 CONSTRAINT [PK_season_tickets] PRIMARY KEY CLUSTERED 
(
	[season_ticketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer-ticket]    Script Date: 11.12.2023 11:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer-ticket](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[customerID] [int] NOT NULL,
	[season_ticketID] [int] NOT NULL,
	[buy_date] [date] NOT NULL,
 CONSTRAINT [PK_customer-ticket] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[main]    Script Date: 11.12.2023 11:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[main]
AS
SELECT        c.fcs, t.name, ct.buy_date, DATEADD(dd, t.validity, ct.buy_date) AS end_date
FROM            dbo.[customer-ticket] AS ct INNER JOIN
                         dbo.customers AS c ON c.customerID = ct.customerID INNER JOIN
                         dbo.season_tickets AS t ON t.season_ticketID = ct.season_ticketID
GO
/****** Object:  Table [dbo].[Authorization]    Script Date: 11.12.2023 11:16:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authorization](
	[login] [nchar](50) NOT NULL,
	[password] [nchar](50) NULL,
 CONSTRAINT [PK_Authorization] PRIMARY KEY CLUSTERED 
(
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Authorization] ([login], [password]) VALUES (N'user                                              ', N'user                                              ')
GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([customerID], [fcs], [birthdate], [phone], [e-mail]) VALUES (1, N'Шапедько Виталий Алексеевич                                                                                                                                                                                                                                    ', CAST(N'2005-05-18' AS Date), N'+79124257437   ', NULL)
INSERT [dbo].[customers] ([customerID], [fcs], [birthdate], [phone], [e-mail]) VALUES (3, N'Родермель Артем Владимирович                                                                                                                                                                                                                                   ', CAST(N'2005-04-26' AS Date), N'+79252065097   ', NULL)
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
SET IDENTITY_INSERT [dbo].[customer-ticket] ON 

INSERT [dbo].[customer-ticket] ([ID], [customerID], [season_ticketID], [buy_date]) VALUES (11, 3, 1, CAST(N'2023-12-10' AS Date))
INSERT [dbo].[customer-ticket] ([ID], [customerID], [season_ticketID], [buy_date]) VALUES (18, 1, 2, CAST(N'2023-11-12' AS Date))
INSERT [dbo].[customer-ticket] ([ID], [customerID], [season_ticketID], [buy_date]) VALUES (19, 1, 2, CAST(N'2001-10-02' AS Date))
INSERT [dbo].[customer-ticket] ([ID], [customerID], [season_ticketID], [buy_date]) VALUES (20, 1, 1, CAST(N'2023-11-12' AS Date))
SET IDENTITY_INSERT [dbo].[customer-ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[season_tickets] ON 

INSERT [dbo].[season_tickets] ([season_ticketID], [name], [validity], [price]) VALUES (1, N'Безлимит                                          ', 30, 20000)
INSERT [dbo].[season_tickets] ([season_ticketID], [name], [validity], [price]) VALUES (2, N'Фитнес зал                                        ', 10, 5000)
SET IDENTITY_INSERT [dbo].[season_tickets] OFF
GO
ALTER TABLE [dbo].[customer-ticket] ADD  CONSTRAINT [DF_customer-ticket_buy_date]  DEFAULT (getdate()) FOR [buy_date]
GO
ALTER TABLE [dbo].[customer-ticket]  WITH CHECK ADD  CONSTRAINT [FK_customer-ticket_customers] FOREIGN KEY([customerID])
REFERENCES [dbo].[customers] ([customerID])
GO
ALTER TABLE [dbo].[customer-ticket] CHECK CONSTRAINT [FK_customer-ticket_customers]
GO
ALTER TABLE [dbo].[customer-ticket]  WITH CHECK ADD  CONSTRAINT [FK_customer-ticket_season_tickets] FOREIGN KEY([season_ticketID])
REFERENCES [dbo].[season_tickets] ([season_ticketID])
GO
ALTER TABLE [dbo].[customer-ticket] CHECK CONSTRAINT [FK_customer-ticket_season_tickets]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ct"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'main'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'main'
GO
