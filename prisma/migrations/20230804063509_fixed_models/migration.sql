/*
  Warnings:

  - You are about to drop the `ImagesOnMemories` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TagsOnMemories` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `images` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tags` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "ImagesOnMemories" DROP CONSTRAINT "ImagesOnMemories_imageId_fkey";

-- DropForeignKey
ALTER TABLE "ImagesOnMemories" DROP CONSTRAINT "ImagesOnMemories_memoryId_fkey";

-- DropForeignKey
ALTER TABLE "TagsOnMemories" DROP CONSTRAINT "TagsOnMemories_memoryId_fkey";

-- DropForeignKey
ALTER TABLE "TagsOnMemories" DROP CONSTRAINT "TagsOnMemories_tagId_fkey";

-- AlterTable
ALTER TABLE "memories" ADD COLUMN     "images" TEXT[],
ADD COLUMN     "tags" TEXT[];

-- DropTable
DROP TABLE "ImagesOnMemories";

-- DropTable
DROP TABLE "TagsOnMemories";

-- DropTable
DROP TABLE "images";

-- DropTable
DROP TABLE "tags";
