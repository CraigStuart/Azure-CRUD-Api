CREATE TABLE dbo.ToDo (
    [Id] UNIQUEIDENTIFIER PRIMARY KEY,
    [order] INT NULL,
    [completed] BIT NOT NULL,
    [title] NVARCHAR (200) NOT NULL
    )
