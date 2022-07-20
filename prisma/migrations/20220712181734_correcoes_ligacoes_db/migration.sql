/*
  Warnings:

  - You are about to drop the column `classesCharacterId` on the `classes` table. All the data in the column will be lost.
  - Added the required column `classesId` to the `classesCharacter` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[classes] DROP CONSTRAINT [classes_classesCharacterId_fkey];

-- AlterTable
ALTER TABLE [dbo].[classes] DROP COLUMN [classesCharacterId];

-- AlterTable
ALTER TABLE [dbo].[classesCharacter] ADD [classesId] NVARCHAR(1000) NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[classesCharacter] ADD CONSTRAINT [classesCharacter_classesId_fkey] FOREIGN KEY ([classesId]) REFERENCES [dbo].[classes]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
