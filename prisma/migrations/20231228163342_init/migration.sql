/*
  Warnings:

  - Added the required column `amount_bill` to the `bill` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_bill" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "amount_bill" REAL NOT NULL,
    "reciver_code" TEXT NOT NULL,
    "reciver_type" TEXT NOT NULL
);
INSERT INTO "new_bill" ("amount", "id", "name", "reciver_code", "reciver_type") SELECT "amount", "id", "name", "reciver_code", "reciver_type" FROM "bill";
DROP TABLE "bill";
ALTER TABLE "new_bill" RENAME TO "bill";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
