CREATE DATABASE [Bank]
GO

PRINT N'Bank database created successfully!'

USE [Bank]
GO

CREATE TABLE [dbo].[CuentasDeCheques]
(
    [NoCuenta] [SMALLINT] NOT NULL,
    [Saldo] [MONEY] NOT NULL,
    CONSTRAINT [PK_Cheques] PRIMARY KEY CLUSTERED ([NoCuenta] ASC)
)
GO

CREATE TABLE [dbo].[TarjetasDeCrédito]
(
    [NoTarjeta] [SMALLINT] NOT NULL,
    [Saldo] [MONEY] NOT NULL,
    CONSTRAINT [PK_Tarjetas] PRIMARY KEY CLUSTERED ([NoTarjeta] ASC)
)
GO

CREATE TABLE [dbo].[MovimientosCheques]
(
    [Referencia] [SMALLINT] IDENTITY(1,1) NOT NULL,
    [Fecha] [DATETIME] NOT NULL,
    [NoCuenta] [SMALLINT] NOT NULL,
    [Monto] [MONEY] NOT NULL,
    [Concepto] [NVARCHAR](100) NOT NULL,
    CONSTRAINT [PK_MovimientosCheques] PRIMARY KEY CLUSTERED ([Referencia] ASC)
)
GO

CREATE TABLE [dbo].[MovimientosTarjetas]
(
    [Referencia] [SMALLINT] IDENTITY(1,1) NOT NULL,
    [Fecha] [DATETIME] NOT NULL,
    [NoTarjeta] [SMALLINT] NOT NULL,
    [Monto] [MONEY] NOT NULL,
    [Concepto] [NVARCHAR](100) NOT NULL,
    CONSTRAINT [PK_MovimientosTarjetas] PRIMARY KEY CLUSTERED ([Referencia] ASC)
)
GO

ALTER TABLE [dbo].[CuentasDeCheques]
ADD CONSTRAINT SobregiroNoPermitido CHECK(Saldo > 0)
GO

ALTER TABLE [dbo].[MovimientosCheques]
WITH NOCHECK ADD CONSTRAINT [FK_MovimientosCuentasToCuentasDeCheques]
FOREIGN KEY([NoCuenta])
REFERENCES [dbo].[CuentasDeCheques]([NoCuenta])
GO

ALTER TABLE [dbo].[MovimientosTarjetas]
WITH NOCHECK ADD CONSTRAINT [FK_MovimientosTarjetasToTarjetasDeCrédito]
FOREIGN KEY([NoTarjeta])
REFERENCES [dbo].[TarjetasDeCrédito]([NoTarjeta])
GO

CREATE PROCEDURE [Transferencia]
    @NoCuentaOrigen INT,
	@NoCuentaDestino INT,
	@Monto MONEY,
	@SaldoAnteriorOrigen MONEY OUTPUT,
	@SaldoNuevoOrigen MONEY OUTPUT,
	@SaldoAnteriorDestino MONEY OUTPUT,
	@SaldoNuevoDestino MONEY OUTPUT
AS
	BEGIN TRY
		BEGIN TRANSACTION

		UPDATE CuentasDeCheques
		SET @SaldoAnteriorDestino = Saldo, Saldo = Saldo + @Monto, @SaldoNuevoDestino = Saldo + @Monto
		WHERE NoCuenta = @NoCuentaDestino

		UPDATE CuentasDeCheques
		SET @SaldoAnteriorOrigen = Saldo, Saldo = Saldo - @Monto, @SaldoNuevoOrigen = Saldo - @Monto
		WHERE NoCuenta = @NoCuentaOrigen

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

SET NOCOUNT ON

INSERT INTO [dbo].[CuentasDeCheques]([NoCuenta], [Saldo]) VALUES(100, 1000)
INSERT INTO [dbo].[CuentasDeCheques]([NoCuenta], [Saldo]) VALUES(200, 2000)
INSERT INTO [dbo].[CuentasDeCheques]([NoCuenta], [Saldo]) VALUES(300, 3000)
GO

INSERT INTO [dbo].[TarjetasDeCrédito]([NoTarjeta], [Saldo]) VALUES(700, 7000)
INSERT INTO [dbo].[TarjetasDeCrédito]([NoTarjeta], [Saldo]) VALUES(800, 8000)
INSERT INTO [dbo].[TarjetasDeCrédito]([NoTarjeta], [Saldo]) VALUES(900, 9000)
GO

INSERT INTO [dbo].[MovimientosCheques]([Fecha], [NoCuenta], [Monto], [Concepto])
VALUES('Apr 01, 1988', 100, 1000, N'Apertura de cuenta')

INSERT INTO [dbo].[MovimientosCheques]([Fecha], [NoCuenta], [Monto], [Concepto])
VALUES('Dec 07, 1990', 200, 2000, N'Apertura de cuenta')

INSERT INTO [dbo].[MovimientosCheques]([Fecha], [NoCuenta], [Monto], [Concepto])
VALUES('Aug 14, 1995', 300, 3000, N'Apertura de cuenta')
GO

INSERT INTO [dbo].[MovimientosTarjetas]([Fecha], [NoTarjeta], [Monto], [Concepto])
VALUES('Apr 01, 2000', 700, 7000, N'Compra por Internet')

INSERT INTO [dbo].[MovimientosTarjetas]([Fecha], [NoTarjeta], [Monto], [Concepto])
VALUES('Dec 07, 2001', 800, 8000, N'Compra por Internet')

INSERT INTO [dbo].[MovimientosTarjetas]([Fecha], [NoTarjeta], [Monto], [Concepto])
VALUES('Aug 14, 2002', 900, 9000, N'Compra por Internet')
GO
