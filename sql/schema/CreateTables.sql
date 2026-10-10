-- Example schema for Home-cookinng app
-- REVIEW before executing on any server. These are sample DDL statements.

SET NOCOUNT ON;
GO

-- Users
CREATE TABLE dbo.Users (
	UserId INT IDENTITY(1,1) PRIMARY KEY,
	UserName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(255) NULL,
	CreatedDate DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

-- Recipes
CREATE TABLE dbo.Recipes (
	RecipeId INT IDENTITY(1,1) PRIMARY KEY,
	UserId INT NOT NULL,
	Title NVARCHAR(200) NOT NULL,
	Instructions NVARCHAR(MAX) NULL,
	PrepTimeMinutes INT NULL,
	CookTimeMinutes INT NULL,
	CreatedDate DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
	CONSTRAINT FK_Recipes_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId)
);
GO

-- Ingredients
CREATE TABLE dbo.Ingredients (
	IngredientId INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(200) NOT NULL UNIQUE,
	DefaultUnit NVARCHAR(50) NULL
);
GO

-- RecipeIngredients (many-to-many)
CREATE TABLE dbo.RecipeIngredients (
	RecipeIngredientId INT IDENTITY(1,1) PRIMARY KEY,
	RecipeId INT NOT NULL,
	IngredientId INT NOT NULL,
	Quantity DECIMAL(8,2) NOT NULL DEFAULT 1.00,
	Unit NVARCHAR(50) NULL,
	CONSTRAINT FK_RecipeIngredients_Recipes FOREIGN KEY (RecipeId) REFERENCES dbo.Recipes(RecipeId),
	CONSTRAINT FK_RecipeIngredients_Ingredients FOREIGN KEY (IngredientId) REFERENCES dbo.Ingredients(IngredientId)
);
GO

-- Ratings / Reviews
CREATE TABLE dbo.Ratings (
	RatingId INT IDENTITY(1,1) PRIMARY KEY,
	RecipeId INT NOT NULL,
	UserId INT NOT NULL,
	Rating TINYINT NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
	Review NVARCHAR(1000) NULL,
	CreatedDate DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
	CONSTRAINT FK_Ratings_Recipes FOREIGN KEY (RecipeId) REFERENCES dbo.Recipes(RecipeId),
	CONSTRAINT FK_Ratings_Users FOREIGN KEY (UserId) REFERENCES dbo.Users(UserId)
);
GO

-- Optional helpful indexes (nonclustered)
CREATE INDEX IX_Recipes_UserId ON dbo.Recipes(UserId);
CREATE INDEX IX_RecipeIngredients_RecipeId ON dbo.RecipeIngredients(RecipeId);
CREATE INDEX IX_RecipeIngredients_IngredientId ON dbo.RecipeIngredients(IngredientId);
CREATE INDEX IX_Ratings_RecipeId ON dbo.Ratings(RecipeId);
GO

-- End of schema script

``` 
