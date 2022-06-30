/*
  Warnings:

  - You are about to drop the column `description` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the `actions` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `classDescriptionId` to the `classes` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[actions] DROP CONSTRAINT [actions_actionClassId_fkey];

-- AlterTable
ALTER TABLE [dbo].[classes] DROP COLUMN [description];
ALTER TABLE [dbo].[classes] ADD [classDescriptionId] NVARCHAR(1000) NOT NULL;

-- DropTable
DROP TABLE [dbo].[actions];

-- CreateTable
CREATE TABLE [dbo].[descriptions] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [descriptions_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [descriptions_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[classDescriptions] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [level] INT NOT NULL,
    [actionTime] NVARCHAR(1000) NOT NULL,
    [recovery] NVARCHAR(1000) NOT NULL,
    [descriptionId] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [classDescriptions_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [classDescriptions_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[classesCharacter] (
    [id] NVARCHAR(1000) NOT NULL,
    [level] INT NOT NULL,
    [classId] NVARCHAR(1000) NOT NULL,
    [characterId] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [classesCharacter_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [classesCharacter_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[characters] (
    [id] NVARCHAR(1000) NOT NULL,
    [level] INT NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [characters_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [characters_pkey] PRIMARY KEY ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[classDescriptions] ADD CONSTRAINT [classDescriptions_descriptionId_fkey] FOREIGN KEY ([descriptionId]) REFERENCES [dbo].[descriptions]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[classes] ADD CONSTRAINT [classes_classDescriptionId_fkey] FOREIGN KEY ([classDescriptionId]) REFERENCES [dbo].[classDescriptions]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[classesCharacter] ADD CONSTRAINT [classesCharacter_classId_fkey] FOREIGN KEY ([classId]) REFERENCES [dbo].[classes]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[classesCharacter] ADD CONSTRAINT [classesCharacter_characterId_fkey] FOREIGN KEY ([characterId]) REFERENCES [dbo].[characters]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
