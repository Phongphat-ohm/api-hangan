/*
  Warnings:

  - You are about to drop the column `bil_id` on the `topup_history` table. All the data in the column will be lost.
  - Added the required column `bill_id` to the `topup_history` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_topup_history" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "bill_id" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "time_stamp" TEXT NOT NULL,
    "provide_name" TEXT NOT NULL,
    "provide_is" TEXT NOT NULL
);
INSERT INTO "new_topup_history" ("amount", "id", "provide_is", "provide_name", "time_stamp") SELECT "amount", "id", "provide_is", "provide_name", "time_stamp" FROM "topup_history";
DROP TABLE "topup_history";
ALTER TABLE "new_topup_history" RENAME TO "topup_history";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
