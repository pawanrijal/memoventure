/*
  Warnings:

  - You are about to drop the `_ImageToMemory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_MemoryToTag` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "_ImageToMemory" DROP CONSTRAINT "_ImageToMemory_A_fkey";

-- DropForeignKey
ALTER TABLE "_ImageToMemory" DROP CONSTRAINT "_ImageToMemory_B_fkey";

-- DropForeignKey
ALTER TABLE "_MemoryToTag" DROP CONSTRAINT "_MemoryToTag_A_fkey";

-- DropForeignKey
ALTER TABLE "_MemoryToTag" DROP CONSTRAINT "_MemoryToTag_B_fkey";

-- DropTable
DROP TABLE "_ImageToMemory";

-- DropTable
DROP TABLE "_MemoryToTag";

-- CreateTable
CREATE TABLE "ImagesOnMemories" (
    "id" SERIAL NOT NULL,
    "memoryId" INTEGER,
    "imageId" INTEGER,
    "assignedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ImagesOnMemories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TagsOnMemories" (
    "id" SERIAL NOT NULL,
    "tagId" INTEGER,
    "memoryId" INTEGER,

    CONSTRAINT "TagsOnMemories_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ImagesOnMemories" ADD CONSTRAINT "ImagesOnMemories_memoryId_fkey" FOREIGN KEY ("memoryId") REFERENCES "memories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ImagesOnMemories" ADD CONSTRAINT "ImagesOnMemories_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES "images"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagsOnMemories" ADD CONSTRAINT "TagsOnMemories_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "tags"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TagsOnMemories" ADD CONSTRAINT "TagsOnMemories_memoryId_fkey" FOREIGN KEY ("memoryId") REFERENCES "memories"("id") ON DELETE SET NULL ON UPDATE CASCADE;
