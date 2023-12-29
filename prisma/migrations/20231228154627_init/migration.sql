/*
  Warnings:

  - You are about to drop the `Topup_History` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Topup_History";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "topup_history" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bil_id" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "time_stamp" TEXT NOT NULL,
    "provide_name" TEXT NOT NULL,
    "provide_is" TEXT NOT NULL
);
