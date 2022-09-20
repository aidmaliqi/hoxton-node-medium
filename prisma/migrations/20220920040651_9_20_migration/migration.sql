-- CreateTable
CREATE TABLE "PostComments" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "text" TEXT NOT NULL,
    "postsId" INTEGER NOT NULL,
    CONSTRAINT "PostComments_postsId_fkey" FOREIGN KEY ("postsId") REFERENCES "Posts" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
