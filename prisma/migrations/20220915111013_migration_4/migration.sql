/*
  Warnings:

  - Made the column `userId` on table `Posts` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Posts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "postStatsId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "listsId" INTEGER,
    CONSTRAINT "Posts_postStatsId_fkey" FOREIGN KEY ("postStatsId") REFERENCES "PostStats" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Posts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Posts_listsId_fkey" FOREIGN KEY ("listsId") REFERENCES "Lists" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Posts" ("id", "listsId", "postStatsId", "title", "userId") SELECT "id", "listsId", "postStatsId", "title", "userId" FROM "Posts";
DROP TABLE "Posts";
ALTER TABLE "new_Posts" RENAME TO "Posts";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
