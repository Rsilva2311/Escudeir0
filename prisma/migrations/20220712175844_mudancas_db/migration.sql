/*
  Warnings:

  - You are about to drop the column `classCharacterId` on the `characters` table. All the data in the column will be lost.
  - Added the required column `characterClassId` to the `classesCharacter` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[characters] DROP CONSTRAINT [characters_classCharacterId_fkey];

-- AlterTable
ALTER TABLE [dbo].[characters] DROP COLUMN [classCharacterId];

-- AlterTable
ALTER TABLE [dbo].[classesCharacter] ADD [characterClassId] NVARCHAR(1000) NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[classesCharacter] ADD CONSTRAINT [classesCharacter_characterClassId_fkey] FOREIGN KEY ([characterClassId]) REFERENCES [dbo].[characters]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
