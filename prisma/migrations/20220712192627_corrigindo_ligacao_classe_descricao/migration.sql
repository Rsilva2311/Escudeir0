/*
  Warnings:

  - You are about to drop the column `classDescriptionId` on the `classes` table. All the data in the column will be lost.
  - Added the required column `classDescriptionId` to the `classDescriptions` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[classes] DROP CONSTRAINT [classes_classDescriptionId_fkey];

-- AlterTable
ALTER TABLE [dbo].[classDescriptions] ADD [classDescriptionId] NVARCHAR(1000) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[classes] DROP COLUMN [classDescriptionId];

-- AddForeignKey
ALTER TABLE [dbo].[classDescriptions] ADD CONSTRAINT [classDescriptions_classDescriptionId_fkey] FOREIGN KEY ([classDescriptionId]) REFERENCES [dbo].[classes]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
