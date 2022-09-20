/*
  Warnings:

  - You are about to drop the `PostStats` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "PostStats";
PRAGMA foreign_keys=on;

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Posts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "postStatsId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "listsId" INTEGER,
    "claps" INTEGER,
    "comments" INTEGER,
    "date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Posts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Posts_listsId_fkey" FOREIGN KEY ("listsId") REFERENCES "Lists" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Posts" ("id", "listsId", "postStatsId", "title", "userId") SELECT "id", "listsId", "postStatsId", "title", "userId" FROM "Posts";
DROP TABLE "Posts";
ALTER TABLE "new_Posts" RENAME TO "Posts";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
