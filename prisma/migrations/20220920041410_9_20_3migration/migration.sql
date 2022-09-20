/*
  Warnings:

  - Made the column `userId` on table `PostComments` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PostComments" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT NOT NULL,
    "postsId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "PostComments_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "PostComments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_PostComments" ("id", "postsId", "text", "userId") SELECT "id", "postsId", "text", "userId" FROM "PostComments";
DROP TABLE "PostComments";
ALTER TABLE "new_PostComments" RENAME TO "PostComments";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
