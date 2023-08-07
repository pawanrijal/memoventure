/*
  Warnings:

  - You are about to drop the column `images` on the `memories` table. All the data in the column will be lost.
  - You are about to drop the column `tags` on the `memories` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "memories" DROP COLUMN "images",
DROP COLUMN "tags";

-- CreateTable
CREATE TABLE "images" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "memoryId" INTEGER,

    CONSTRAINT "images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_MemoryToTag" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "tags_name_key" ON "tags"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_MemoryToTag_AB_unique" ON "_MemoryToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_MemoryToTag_B_index" ON "_MemoryToTag"("B");

-- AddForeignKey
ALTER TABLE "images" ADD CONSTRAINT "images_memoryId_fkey" FOREIGN KEY ("memoryId") REFERENCES "memories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MemoryToTag" ADD CONSTRAINT "_MemoryToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "memories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_MemoryToTag" ADD CONSTRAINT "_MemoryToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;
