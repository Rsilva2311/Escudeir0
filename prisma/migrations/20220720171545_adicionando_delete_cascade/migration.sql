BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[classDescriptions] DROP CONSTRAINT [classDescriptions_classDescriptionId_fkey];

-- AddForeignKey
ALTER TABLE [dbo].[classDescriptions] ADD CONSTRAINT [classDescriptions_classDescriptionId_fkey] FOREIGN KEY ([classDescriptionId]) REFERENCES [dbo].[classes]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
