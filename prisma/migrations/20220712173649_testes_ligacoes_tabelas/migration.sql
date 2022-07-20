/*
  Warnings:

  - You are about to drop the column `classDescriptionId` on the `descriptions` table. All the data in the column will be lost.
  - Added the required column `descriptionId` to the `classDescriptions` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[descriptions] DROP CONSTRAINT [descriptions_classDescriptionId_fkey];

-- AlterTable
ALTER TABLE [dbo].[classDescriptions] ADD [descriptionId] NVARCHAR(1000) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[descriptions] DROP COLUMN [classDescriptionId];

-- AddForeignKey
ALTER TABLE [dbo].[classDescriptions] ADD CONSTRAINT [classDescriptions_descriptionId_fkey] FOREIGN KEY ([descriptionId]) REFERENCES [dbo].[descriptions]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
