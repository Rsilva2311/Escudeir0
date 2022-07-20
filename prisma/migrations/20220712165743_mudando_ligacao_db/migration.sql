/*
  Warnings:

  - You are about to drop the column `description` on the `classDescriptions` table. All the data in the column will be lost.
  - You are about to drop the column `descriptionId` on the `classDescriptions` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `classDescriptions` table. All the data in the column will be lost.
  - You are about to drop the column `characterId` on the `classesCharacter` table. All the data in the column will be lost.
  - You are about to drop the column `classId` on the `classesCharacter` table. All the data in the column will be lost.
  - Added the required column `classCharacterId` to the `characters` table without a default value. This is not possible if the table is not empty.
  - Added the required column `classesCharacterId` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `classDescriptionId` to the `descriptions` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[classDescriptions] DROP CONSTRAINT [classDescriptions_descriptionId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[classesCharacter] DROP CONSTRAINT [classesCharacter_characterId_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[classesCharacter] DROP CONSTRAINT [classesCharacter_classId_fkey];

-- AlterTable
ALTER TABLE [dbo].[characters] ADD [classCharacterId] NVARCHAR(1000) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[classDescriptions] DROP COLUMN [description],
[descriptionId],
[name];

-- AlterTable
ALTER TABLE [dbo].[classes] ADD [classesCharacterId] NVARCHAR(1000) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[classesCharacter] DROP COLUMN [characterId],
[classId];

-- AlterTable
ALTER TABLE [dbo].[descriptions] ADD [classDescriptionId] NVARCHAR(1000) NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[descriptions] ADD CONSTRAINT [descriptions_classDescriptionId_fkey] FOREIGN KEY ([classDescriptionId]) REFERENCES [dbo].[classDescriptions]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[classes] ADD CONSTRAINT [classes_classesCharacterId_fkey] FOREIGN KEY ([classesCharacterId]) REFERENCES [dbo].[classesCharacter]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[characters] ADD CONSTRAINT [characters_classCharacterId_fkey] FOREIGN KEY ([classCharacterId]) REFERENCES [dbo].[classesCharacter]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
