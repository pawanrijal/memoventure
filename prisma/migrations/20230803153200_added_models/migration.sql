/*
  Warnings:

  - You are about to drop the column `memoryId` on the `images` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "images" DROP CONSTRAINT "images_memoryId_fkey";

-- AlterTable
ALTER TABLE "images" DROP COLUMN "memoryId";

-- CreateTable
CREATE TABLE "_ImageToMemory" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ImageToMemory_AB_unique" ON "_ImageToMemory"("A", "B");

-- CreateIndex
CREATE INDEX "_ImageToMemory_B_index" ON "_ImageToMemory"("B");

-- AddForeignKey
ALTER TABLE "_ImageToMemory" ADD CONSTRAINT "_ImageToMemory_A_fkey" FOREIGN KEY ("A") REFERENCES "images"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ImageToMemory" ADD CONSTRAINT "_ImageToMemory_B_fkey" FOREIGN KEY ("B") REFERENCES "memories"("id") ON DELETE CASCADE ON UPDATE CASCADE;
