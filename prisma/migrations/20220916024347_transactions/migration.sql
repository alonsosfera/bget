/*
  Warnings:

  - You are about to drop the column `accountId` on the `Transaction` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_accountId_fkey";

-- AlterTable
ALTER TABLE "Transaction" DROP COLUMN "accountId";

-- CreateTable
CREATE TABLE "CreditCardOptions" (
    "id" TEXT NOT NULL,
    "paymentDate" TIMESTAMP(3) NOT NULL,
    "closingDay" TIMESTAMP(3) NOT NULL,
    "paid" BOOLEAN NOT NULL,
    "accountId" TEXT NOT NULL,

    CONSTRAINT "CreditCardOptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransactionEntry" (
    "id" TEXT NOT NULL,
    "transactionId" TEXT NOT NULL,
    "accountId" TEXT,

    CONSTRAINT "TransactionEntry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecurrentTransaction" (
    "id" TEXT NOT NULL,
    "transactionId" TEXT NOT NULL,
    "accountId" TEXT,

    CONSTRAINT "RecurrentTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CreditCardOptions_accountId_key" ON "CreditCardOptions"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "TransactionEntry_transactionId_key" ON "TransactionEntry"("transactionId");

-- CreateIndex
CREATE UNIQUE INDEX "RecurrentTransaction_transactionId_key" ON "RecurrentTransaction"("transactionId");

-- AddForeignKey
ALTER TABLE "CreditCardOptions" ADD CONSTRAINT "CreditCardOptions_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransactionEntry" ADD CONSTRAINT "TransactionEntry_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransactionEntry" ADD CONSTRAINT "TransactionEntry_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecurrentTransaction" ADD CONSTRAINT "RecurrentTransaction_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "Transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecurrentTransaction" ADD CONSTRAINT "RecurrentTransaction_accountId_fkey" FOREIGN KEY ("accountId") REFERENCES "Account"("id") ON DELETE SET NULL ON UPDATE CASCADE;
