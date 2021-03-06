USE [Treinamento]
GO



SET NOCOUNT ON

SET IDENTITY_INSERT [dbo].[Video] ON

MERGE INTO [dbo].[Video] AS Target
USING (VALUES
  (1,'Introducao',180,1,'r122rNpobmw')
 ,(2,'SQL Server capitulo 1',400,1,'rkrYgICjrww')
 ,(3,'Sql server capitulo 2',300,2,'X2Vo-i54c2o')
 ,(4,'Sql server capitulo 3',200,3,'Zy60yku7bxs')
) AS Source ([Id],[Nome],[Duracao],[IdCapitulo],[CodigoYoutube])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (
	NULLIF(Source.[Nome], Target.[Nome]) IS NOT NULL OR NULLIF(Target.[Nome], Source.[Nome]) IS NOT NULL OR 
	NULLIF(Source.[Duracao], Target.[Duracao]) IS NOT NULL OR NULLIF(Target.[Duracao], Source.[Duracao]) IS NOT NULL OR 
	NULLIF(Source.[IdCapitulo], Target.[IdCapitulo]) IS NOT NULL OR NULLIF(Target.[IdCapitulo], Source.[IdCapitulo]) IS NOT NULL OR 
	NULLIF(Source.[CodigoYoutube], Target.[CodigoYoutube]) IS NOT NULL OR NULLIF(Target.[CodigoYoutube], Source.[CodigoYoutube]) IS NOT NULL) THEN
 UPDATE SET
  [Nome] = Source.[Nome], 
  [Duracao] = Source.[Duracao], 
  [IdCapitulo] = Source.[IdCapitulo], 
  [CodigoYoutube] = Source.[CodigoYoutube]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Nome],[Duracao],[IdCapitulo],[CodigoYoutube])
 VALUES(Source.[Id],Source.[Nome],Source.[Duracao],Source.[IdCapitulo],Source.[CodigoYoutube])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
;
GO
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Video]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[dbo].[Video] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
GO

SET IDENTITY_INSERT [dbo].[Video] OFF
GO
SET NOCOUNT OFF
GO
