BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[actions] DROP CONSTRAINT [actions_updatedAt_df];
ALTER TABLE [dbo].[actions] ADD [actionClassId] NVARCHAR(1000);

-- CreateTable
CREATE TABLE [dbo].[classes] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [description] NVARCHAR(1000) NOT NULL,
    [createdAt] DATETIME2 NOT NULL CONSTRAINT [classes_createdAt_df] DEFAULT CURRENT_TIMESTAMP,
    [updatedAt] DATETIME2 NOT NULL,
    CONSTRAINT [classes_pkey] PRIMARY KEY ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[actions] ADD CONSTRAINT [actions_actionClassId_fkey] FOREIGN KEY ([actionClassId]) REFERENCES [dbo].[classes]([id]) ON DELETE SET NULL ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
