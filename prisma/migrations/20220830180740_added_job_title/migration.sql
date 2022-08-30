/*
  Warnings:

  - Added the required column `archetypeId` to the `classesCharacter` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[classesCharacter] ADD [archetypeId] NVARCHAR(1000) NOT NULL;

-- CreateTable
CREATE TABLE [dbo].[archetypeDescriptions] (
    [id] NVARCHAR(1000) NOT NULL,
    [level] INT NOT NULL,
    [actionTime] NVARCHAR(1000) NOT NULL,
    [recovery] NVARCHAR(1000) NOT NULL,
    [descriptionId] NVARCHAR(1000) NOT NULL,
    [archetypeDescriptionId] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [archetypeDescriptions_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [archetypeDescriptions_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[archetypes] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [archetypes_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [archetypes_pkey] PRIMARY KEY ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[archetypeDescriptions] ADD CONSTRAINT [archetypeDescriptions_descriptionId_fkey] FOREIGN KEY ([descriptionId]) REFERENCES [dbo].[descriptions]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[archetypeDescriptions] ADD CONSTRAINT [archetypeDescriptions_archetypeDescriptionId_fkey] FOREIGN KEY ([archetypeDescriptionId]) REFERENCES [dbo].[archetypes]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[classesCharacter] ADD CONSTRAINT [classesCharacter_archetypeId_fkey] FOREIGN KEY ([archetypeId]) REFERENCES [dbo].[archetypes]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
