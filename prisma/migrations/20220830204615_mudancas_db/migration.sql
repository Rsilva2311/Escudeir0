/*
  Warnings:

  - Added the required column `alignmentId` to the `characters` table without a default value. This is not possible if the table is not empty.
  - Added the required column `backgroundId` to the `characters` table without a default value. This is not possible if the table is not empty.
  - Added the required column `inspiration` to the `characters` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `characters` table without a default value. This is not possible if the table is not empty.
  - Added the required column `proficiencyBonus` to the `characters` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[characters] ADD [alignmentId] INT NOT NULL,
[backgroundId] INT NOT NULL,
[inspiration] BIT NOT NULL,
[name] NVARCHAR(1000) NOT NULL,
[proficiencyBonus] INT NOT NULL;

-- CreateTable
CREATE TABLE [dbo].[Alignment] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Alignment_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[atributes] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [value] INT NOT NULL,
    [characterId] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [atributes_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[skilss] (
    [id] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [atributeId] INT NOT NULL,
    CONSTRAINT [skilss_pkey] PRIMARY KEY ([id])
);

-- CreateTable
CREATE TABLE [dbo].[skillsCharacter] (
    [id] NVARCHAR(1000) NOT NULL,
    [skillsCharacterId] NVARCHAR(1000) NOT NULL,
    [characterSkillId] NVARCHAR(1000) NOT NULL,
    [proficiency] BIT NOT NULL,
    [jackOfAllTrades] BIT NOT NULL,
    [expertise] BIT NOT NULL,
    CONSTRAINT [skillsCharacter_pkey] PRIMARY KEY ([id])
);

-- AddForeignKey
ALTER TABLE [dbo].[atributes] ADD CONSTRAINT [atributes_characterId_fkey] FOREIGN KEY ([characterId]) REFERENCES [dbo].[characters]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[skillsCharacter] ADD CONSTRAINT [skillsCharacter_skillsCharacterId_fkey] FOREIGN KEY ([skillsCharacterId]) REFERENCES [dbo].[skilss]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[skillsCharacter] ADD CONSTRAINT [skillsCharacter_characterSkillId_fkey] FOREIGN KEY ([characterSkillId]) REFERENCES [dbo].[characters]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
