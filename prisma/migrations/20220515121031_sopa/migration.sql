-- CreateEnum
CREATE TYPE "Role" AS ENUM ('admin', 'moderator', 'user');

-- CreateEnum
CREATE TYPE "EventType" AS ENUM ('test', 'exam', 'labaratoryWork', 'courseWork', 'diplomaWork', 'practice', 'olympiad', 'conference');

-- CreateTable
CREATE TABLE "User" (
    "userId" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "middleName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "avatarUrl" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT E'user',
    "guildId" TEXT NOT NULL,
    "healthPoints" INTEGER NOT NULL DEFAULT 100,
    "experience" INTEGER NOT NULL DEFAULT 0,
    "locationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Guild" (
    "guildId" TEXT NOT NULL,
    "guildName" TEXT NOT NULL,
    "guildDescription" TEXT,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "Item" (
    "itemId" TEXT NOT NULL,
    "itemName" TEXT NOT NULL,
    "itemDescription" TEXT NOT NULL,
    "itemCost" INTEGER,
    "isUnique" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Item_pkey" PRIMARY KEY ("itemId")
);

-- CreateTable
CREATE TABLE "Attribute" (
    "attributeId" TEXT NOT NULL,
    "attributeName" TEXT NOT NULL,
    "attributeDescription" TEXT NOT NULL,
    "attributeValue" INTEGER NOT NULL,

    CONSTRAINT "Attribute_pkey" PRIMARY KEY ("attributeId")
);

-- CreateTable
CREATE TABLE "Title" (
    "titleId" TEXT NOT NULL,
    "tittleName" TEXT NOT NULL,

    CONSTRAINT "Title_pkey" PRIMARY KEY ("titleId")
);

-- CreateTable
CREATE TABLE "Location" (
    "locationId" TEXT NOT NULL,
    "locationName" TEXT NOT NULL,
    "locationDescription" TEXT,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("locationId")
);

-- CreateTable
CREATE TABLE "Event" (
    "eventId" TEXT NOT NULL,
    "eventName" TEXT NOT NULL,
    "eventDescription" TEXT NOT NULL,
    "eventType" "EventType" NOT NULL,
    "eventStart" TIMESTAMP(3) NOT NULL,
    "evemtEnd" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Event_pkey" PRIMARY KEY ("eventId")
);

-- CreateTable
CREATE TABLE "UsersEvents" (
    "userId" TEXT NOT NULL,
    "enteredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "exitedAt" TIMESTAMP(3) NOT NULL,
    "eventId" TEXT NOT NULL,

    CONSTRAINT "UsersEvents_pkey" PRIMARY KEY ("userId","eventId")
);

-- CreateTable
CREATE TABLE "_ItemToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_AttributeToItem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_TitleToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_EventToLocation" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_EventToItem" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_userName_key" ON "User"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "_ItemToUser_AB_unique" ON "_ItemToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ItemToUser_B_index" ON "_ItemToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AttributeToItem_AB_unique" ON "_AttributeToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_AttributeToItem_B_index" ON "_AttributeToItem"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_TitleToUser_AB_unique" ON "_TitleToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_TitleToUser_B_index" ON "_TitleToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_EventToLocation_AB_unique" ON "_EventToLocation"("A", "B");

-- CreateIndex
CREATE INDEX "_EventToLocation_B_index" ON "_EventToLocation"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_EventToItem_AB_unique" ON "_EventToItem"("A", "B");

-- CreateIndex
CREATE INDEX "_EventToItem_B_index" ON "_EventToItem"("B");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("locationId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsersEvents" ADD CONSTRAINT "UsersEvents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsersEvents" ADD CONSTRAINT "UsersEvents_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "Event"("eventId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToUser" ADD CONSTRAINT "_ItemToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItemToUser" ADD CONSTRAINT "_ItemToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AttributeToItem" ADD CONSTRAINT "_AttributeToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Attribute"("attributeId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AttributeToItem" ADD CONSTRAINT "_AttributeToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TitleToUser" ADD CONSTRAINT "_TitleToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Title"("titleId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_TitleToUser" ADD CONSTRAINT "_TitleToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToLocation" ADD CONSTRAINT "_EventToLocation_A_fkey" FOREIGN KEY ("A") REFERENCES "Event"("eventId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToLocation" ADD CONSTRAINT "_EventToLocation_B_fkey" FOREIGN KEY ("B") REFERENCES "Location"("locationId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToItem" ADD CONSTRAINT "_EventToItem_A_fkey" FOREIGN KEY ("A") REFERENCES "Event"("eventId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EventToItem" ADD CONSTRAINT "_EventToItem_B_fkey" FOREIGN KEY ("B") REFERENCES "Item"("itemId") ON DELETE CASCADE ON UPDATE CASCADE;
