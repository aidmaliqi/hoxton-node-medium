-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PostImages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "img" TEXT NOT NULL,
    "postsId" INTEGER,
    CONSTRAINT "PostImages_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_PostImages" ("id", "img", "postsId") SELECT "id", "img", "postsId" FROM "PostImages";
DROP TABLE "PostImages";
ALTER TABLE "new_PostImages" RENAME TO "PostImages";
CREATE TABLE "new_PostText" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT NOT NULL,
    "postsId" INTEGER NOT NULL,
    CONSTRAINT "PostText_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_PostText" ("id", "postsId", "text") SELECT "id", "postsId", "text" FROM "PostText";
DROP TABLE "PostText";
ALTER TABLE "new_PostText" RENAME TO "PostText";
CREATE TABLE "new_PostStats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claps" INTEGER NOT NULL,
    "comments" INTEGER NOT NULL,
    "date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_PostStats" ("claps", "comments", "date", "id") SELECT "claps", "comments", "date", "id" FROM "PostStats";
DROP TABLE "PostStats";
ALTER TABLE "new_PostStats" RENAME TO "PostStats";
CREATE TABLE "new_Lists" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "userId" INTEGER,
    CONSTRAINT "Lists_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Lists" ("id", "title", "userId") SELECT "id", "title", "userId" FROM "Lists";
DROP TABLE "Lists";
ALTER TABLE "new_Lists" RENAME TO "Lists";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
