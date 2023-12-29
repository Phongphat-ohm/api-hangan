-- CreateTable
CREATE TABLE "bill" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "reciver_code" TEXT NOT NULL,
    "reciver_type" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Topup_History" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "amount" REAL NOT NULL,
    "time_stamp" TEXT NOT NULL,
    "provide_name" TEXT NOT NULL,
    "provide_is" TEXT NOT NULL
);
