-- CreateTable
CREATE TABLE `UserProfile` (
    `userProfileId` INTEGER NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(50) NOT NULL,
    `lastName` VARCHAR(50) NOT NULL,
    `emailAddress` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `hashedPassword` VARCHAR(255) NOT NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,
    `userRole` ENUM('user', 'admin', 'mentor') NOT NULL DEFAULT 'user',

    UNIQUE INDEX `UserProfile_emailAddress_key`(`emailAddress`),
    PRIMARY KEY (`userProfileId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EventDetail` (
    `eventDetailId` INTEGER NOT NULL AUTO_INCREMENT,
    `eventName` VARCHAR(100) NOT NULL,
    `image` TEXT NULL,
    `eventTicketPrice` VARCHAR(191) NOT NULL,
    `eventDescription` TEXT NULL,
    `startDate` DATETIME NOT NULL,
    `endDate` DATETIME NOT NULL,
    `eventLocation` VARCHAR(255) NULL,
    `meetingLink` VARCHAR(255) NULL,
    `recordingLink` VARCHAR(255) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`eventDetailId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EventEnrollment` (
    `eventEnrollmentId` INTEGER NOT NULL AUTO_INCREMENT,
    `userProfileId` INTEGER NOT NULL,
    `eventDetailId` INTEGER NOT NULL,
    `registrationDate` DATETIME(3) NOT NULL,
    `ticketType` ENUM('regular', 'student', 'vip') NOT NULL,
    `paymentStatus` ENUM('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending',
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`eventEnrollmentId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SubmissionRecord` (
    `submissionRecordId` INTEGER NOT NULL AUTO_INCREMENT,
    `eventDetailId` INTEGER NOT NULL,
    `userProfileId` INTEGER NOT NULL,
    `submissionTitle` VARCHAR(255) NOT NULL,
    `submissionAbstract` TEXT NULL,
    `submissionDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `submissionStatus` ENUM('submitted', 'under_review', 'accepted', 'rejected') NOT NULL DEFAULT 'submitted',
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`submissionRecordId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Feedback` (
    `feedbackId` INTEGER NOT NULL AUTO_INCREMENT,
    `submissionRecordId` INTEGER NOT NULL,
    `evaluatorId` INTEGER NOT NULL,
    `feedbackComments` VARCHAR(191) NULL,
    `feedbackRating` INTEGER NOT NULL,
    `reviewDate` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`feedbackId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EventSchedule` (
    `eventScheduleId` INTEGER NOT NULL AUTO_INCREMENT,
    `eventDetailId` INTEGER NOT NULL,
    `scheduledTime` DATETIME(3) NOT NULL,
    `scheduleLocation` VARCHAR(255) NULL,
    `speakerName` VARCHAR(255) NOT NULL,
    `speakerDesc` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`eventScheduleId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MentorshipProgram` (
    `mentorshipProgramId` INTEGER NOT NULL AUTO_INCREMENT,
    `mentorProfileId` INTEGER NOT NULL,
    `menteeProfileId` INTEGER NOT NULL,
    `startDate` DATETIME(3) NOT NULL,
    `endDate` DATETIME(3) NULL,
    `mentorshipStatus` ENUM('active', 'completed', 'cancelled') NOT NULL DEFAULT 'active',
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NULL,

    PRIMARY KEY (`mentorshipProgramId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `from_user` INTEGER NOT NULL,
    `to_user` INTEGER NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` TIMESTAMP(0) NULL,

    INDEX `messages_from_user_foreign`(`from_user`),
    INDEX `messages_to_user_foreign`(`to_user`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Expertise` (
    `expertiseId` INTEGER NOT NULL AUTO_INCREMENT,
    `expertiseName` VARCHAR(100) NOT NULL,

    UNIQUE INDEX `Expertise_expertiseName_key`(`expertiseName`),
    PRIMARY KEY (`expertiseId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserExpertise` (
    `userExpertiseId` INTEGER NOT NULL AUTO_INCREMENT,
    `userProfileId` INTEGER NOT NULL,
    `expertiseId` INTEGER NOT NULL,

    UNIQUE INDEX `UserExpertise_userProfileId_expertiseId_key`(`userProfileId`, `expertiseId`),
    PRIMARY KEY (`userExpertiseId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SubmissionExpertise` (
    `submissionExpertiseId` INTEGER NOT NULL AUTO_INCREMENT,
    `submissionRecordId` INTEGER NOT NULL,
    `expertiseId` INTEGER NOT NULL,

    UNIQUE INDEX `SubmissionExpertise_submissionRecordId_expertiseId_key`(`submissionRecordId`, `expertiseId`),
    PRIMARY KEY (`submissionExpertiseId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `EventEnrollment` ADD CONSTRAINT `EventEnrollment_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EventEnrollment` ADD CONSTRAINT `EventEnrollment_eventDetailId_fkey` FOREIGN KEY (`eventDetailId`) REFERENCES `EventDetail`(`eventDetailId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SubmissionRecord` ADD CONSTRAINT `SubmissionRecord_eventDetailId_fkey` FOREIGN KEY (`eventDetailId`) REFERENCES `EventDetail`(`eventDetailId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SubmissionRecord` ADD CONSTRAINT `SubmissionRecord_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_submissionRecordId_fkey` FOREIGN KEY (`submissionRecordId`) REFERENCES `SubmissionRecord`(`submissionRecordId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_evaluatorId_fkey` FOREIGN KEY (`evaluatorId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EventSchedule` ADD CONSTRAINT `EventSchedule_eventDetailId_fkey` FOREIGN KEY (`eventDetailId`) REFERENCES `EventDetail`(`eventDetailId`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MentorshipProgram` ADD CONSTRAINT `MentorshipProgram_mentorProfileId_fkey` FOREIGN KEY (`mentorProfileId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MentorshipProgram` ADD CONSTRAINT `MentorshipProgram_menteeProfileId_fkey` FOREIGN KEY (`menteeProfileId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_from_user_foreign` FOREIGN KEY (`from_user`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `messages` ADD CONSTRAINT `messages_to_user_foreign` FOREIGN KEY (`to_user`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `UserExpertise` ADD CONSTRAINT `UserExpertise_userProfileId_fkey` FOREIGN KEY (`userProfileId`) REFERENCES `UserProfile`(`userProfileId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserExpertise` ADD CONSTRAINT `UserExpertise_expertiseId_fkey` FOREIGN KEY (`expertiseId`) REFERENCES `Expertise`(`expertiseId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SubmissionExpertise` ADD CONSTRAINT `SubmissionExpertise_submissionRecordId_fkey` FOREIGN KEY (`submissionRecordId`) REFERENCES `SubmissionRecord`(`submissionRecordId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SubmissionExpertise` ADD CONSTRAINT `SubmissionExpertise_expertiseId_fkey` FOREIGN KEY (`expertiseId`) REFERENCES `Expertise`(`expertiseId`) ON DELETE RESTRICT ON UPDATE CASCADE;
