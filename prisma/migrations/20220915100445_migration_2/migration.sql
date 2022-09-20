/*
  Warnings:

  - Made the column `postsId` on table `PostText` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PostText" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT NOT NULL,
    "postsId" INTEGER NOT NULL,
    CONSTRAINT "PostText_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_PostText" ("id", "postsId", "text") SELECT "id", "postsId", "text" FROM "PostText";
DROP TABLE "PostText";
ALTER TABLE "new_PostText" RENAME TO "PostText";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
