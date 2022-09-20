-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Lists" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "userId" INTEGER,
    CONSTRAINT "Lists_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Posts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "postStatsId" INTEGER NOT NULL,
    "userId" INTEGER,
    "listsId" INTEGER,
    CONSTRAINT "Posts_postStatsId_fkey" FOREIGN KEY ("postStatsId") REFERENCES "PostStats" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Posts_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Posts_listsId_fkey" FOREIGN KEY ("listsId") REFERENCES "Lists" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PostImages" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "img" TEXT NOT NULL,
    "postsId" INTEGER,
    CONSTRAINT "PostImages_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PostText" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT NOT NULL,
    "postsId" INTEGER,
    CONSTRAINT "PostText_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PostStats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claps" INTEGER NOT NULL,
    "comments" INTEGER NOT NULL,
    "date" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Follows" (
    "followerId" INTEGER NOT NULL,
    "followingId" INTEGER NOT NULL,

    PRIMARY KEY ("followerId", "followingId"),
    CONSTRAINT "Follows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Follows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
