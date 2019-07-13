-- ----------------------------------------------------------
-- MDB Tools - A library for reading MS Access database files
-- Copyright (C) 2000-2011 Brian Bruns and others.
-- Files in libmdb are licensed under LGPL and the utilities under
-- the GPL, see COPYING.LIB and COPYING files respectively.
-- Check out http://mdbtools.sourceforge.net
-- ----------------------------------------------------------

SET client_encoding = 'UTF-8';

CREATE TABLE "AbstractAssembliesList"
 (
	"AbstractTypeID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...

CREATE TABLE "AbstractPartType"
 (
	"AbstractPartTypeID"			INTEGER NOT NULL, 
	"ParentAbstractPartTypeID"			INTEGER, 
	"DependsOn"			INTEGER, 
	"PartFilename"			VARCHAR (20), 
	"EAPT"			VARCHAR (100) NOT NULL, 
	"GAPT"			VARCHAR (100), 
	"FAFT"			VARCHAR (100), 
	"SAFT"			VARCHAR (100), 
	"IAFT"			VARCHAR (100), 
	"JAFT"			VARCHAR (100), 
	"SWAFT"			VARCHAR (100), 
	"BAFT"			VARCHAR (100), 
	"ModifiedRule"			INTEGER, 
	"EUT"			TEXT, 
	"GUT"			TEXT, 
	"FUT"			TEXT, 
	"SUT"			TEXT, 
	"IUT"			TEXT, 
	"JUT"			TEXT, 
	"SWUT"			TEXT, 
	"BUT"			TEXT, 
	"PartPaired"			INTEGER, 
	"SchematicPicname1"			VARCHAR (9), 
	"SchematicPicname2"			VARCHAR (9), 
	"BlockFamilyCompatibility"			INTEGER, 
	"RepairCostModifier"			REAL, 
	"ScrapValueModifier"			REAL, 
	"GarageCategory"			INTEGER
);
COMMENT ON COLUMN "AbstractPartType"."ModifiedRule" IS '1 means car doesnt become modified from adding/removing part';
COMMENT ON COLUMN "AbstractPartType"."EUT" IS 'Upgrade tip text';
COMMENT ON COLUMN "AbstractPartType"."BlockFamilyCompatibility" IS 'Boolean: non-zero means true';
COMMENT ON COLUMN "AbstractPartType"."GarageCategory" IS 'Power, Handling, Aero, Other';

-- CREATE INDEXES ...
ALTER TABLE "AbstractPartType" ADD CONSTRAINT "AbstractPartType_pkey" PRIMARY KEY ("AbstractPartTypeID");

CREATE TABLE "AttachmentPoint"
 (
	"AttachmentPointID"			INTEGER NOT NULL, 
	"AttachmentPoint"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "AttachmentPoint" ADD CONSTRAINT "AttachmentPoint_pkey" PRIMARY KEY ("AttachmentPointID");

CREATE TABLE "AttachmentPoint1"
 (
	"AttachmentPointID"			INTEGER NOT NULL, 
	"AttachmentPoint"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "AttachmentPoint1" ADD CONSTRAINT "AttachmentPoint1_pkey" PRIMARY KEY ("AttachmentPointID");

CREATE TABLE "AuctionPersonaMakes"
 (
	"PlayerID"			INTEGER NOT NULL, 
	"BrandID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...
CREATE INDEX "AuctionPersonaMakes_BrandID_idx" ON "AuctionPersonaMakes" ("BrandID");
CREATE INDEX "AuctionPersonaMakes_PlayerID_idx" ON "AuctionPersonaMakes" ("PlayerID");

CREATE TABLE "Badge"
 (
	"BadgeTypeID"			INTEGER NOT NULL, 
	"PlayerID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...
CREATE INDEX "Badge_BadgeTypeID_idx" ON "Badge" ("BadgeTypeID");
CREATE INDEX "Badge_PlayerID_idx" ON "Badge" ("PlayerID");

CREATE TABLE "BadgeType"
 (
	"BadgeTypeID"			INTEGER NOT NULL, 
	"BadgePatch"			INTEGER NOT NULL, 
	"EName"			VARCHAR (100), 
	"GName"			VARCHAR (100), 
	"FName"			VARCHAR (100), 
	"SName"			VARCHAR (100), 
	"Shapename"			VARCHAR (9)
);
COMMENT ON COLUMN "BadgeType"."BadgePatch" IS '1 means Patch';
COMMENT ON COLUMN "BadgeType"."EName" IS 'English';
COMMENT ON COLUMN "BadgeType"."GName" IS 'German';
COMMENT ON COLUMN "BadgeType"."FName" IS 'French';
COMMENT ON COLUMN "BadgeType"."SName" IS 'Spanish';
COMMENT ON COLUMN "BadgeType"."Shapename" IS 'used by FE for art';

-- CREATE INDEXES ...
CREATE INDEX "BadgeType_BadgeID_idx" ON "BadgeType" ("BadgeTypeID");
ALTER TABLE "BadgeType" ADD CONSTRAINT "BadgeType_pkey" PRIMARY KEY ("BadgeTypeID");

CREATE TABLE "Brand"
 (
	"BrandID"			INTEGER NOT NULL, 
	"Brand"			VARCHAR (100), 
	"PicName"			VARCHAR (50), 
	"IsStock"			SMALLINT
);

-- CREATE INDEXES ...
ALTER TABLE "Brand" ADD CONSTRAINT "Brand_pkey" PRIMARY KEY ("BrandID");

CREATE TABLE "BrandedPart"
 (
	"BrandedPartID"			INTEGER NOT NULL, 
	"PartTypeID"			INTEGER NOT NULL, 
	"ModelID"			INTEGER NOT NULL, 
	"MfgDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"QtyAvail"			INTEGER NOT NULL, 
	"RetailPrice"			INTEGER NOT NULL, 
	"MaxItemWear"			INTEGER, 
	"EngineBlockFamilyID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...
CREATE INDEX "BrandedPart_EngineBlockFamilyID_idx" ON "BrandedPart" ("EngineBlockFamilyID");
ALTER TABLE "BrandedPart" ADD CONSTRAINT "BrandedPart_pkey" PRIMARY KEY ("BrandedPartID");

CREATE TABLE "CatalogCriteriaMethod"
 (
	"CatalogCriteriaMethodID"			INTEGER NOT NULL, 
	"CatalogCriteriaMethod"			VARCHAR (50), 
	"UseSubDivisions"			SMALLINT, 
	"SubDivisionHelp"			VARCHAR (128)
);
COMMENT ON COLUMN "CatalogCriteriaMethod"."CatalogCriteriaMethod" IS 'Debug - Text description';
COMMENT ON COLUMN "CatalogCriteriaMethod"."UseSubDivisions" IS 'TRUE: SubDivision Table provides Label & Help Data; else comes from some other table';
COMMENT ON COLUMN "CatalogCriteriaMethod"."SubDivisionHelp" IS 'Debug - Describe structure of subdivision data';

-- CREATE INDEXES ...
CREATE UNIQUE INDEX "CatalogCriteriaMethod_CatalogCriteriaMethodID_idx" ON "CatalogCriteriaMethod" ("CatalogCriteriaMethodID");
ALTER TABLE "CatalogCriteriaMethod" ADD CONSTRAINT "CatalogCriteriaMethod_pkey" PRIMARY KEY ("CatalogCriteriaMethodID");

CREATE TABLE "CatalogIndexLevel"
 (
	"AbstractPartTypeID"			INTEGER NOT NULL, 
	"IndexLevel"			INTEGER NOT NULL, 
	"CatalogCriteriaMethodID"			INTEGER NOT NULL, 
	"CatalogIndexLevel"			VARCHAR (50), 
	"PhysVal"			INTEGER, 
	"PhysicsTypeID"			INTEGER, 
	"EPromptText"			VARCHAR (128), 
	"FPromptText"			VARCHAR (128), 
	"GPromptText"			VARCHAR (128)
);
COMMENT ON COLUMN "CatalogIndexLevel"."CatalogIndexLevel" IS 'Debug - Description';
COMMENT ON COLUMN "CatalogIndexLevel"."PhysVal" IS 'Optional -  Physics Param Value Number';
COMMENT ON COLUMN "CatalogIndexLevel"."PhysicsTypeID" IS 'Optional -';
COMMENT ON COLUMN "CatalogIndexLevel"."EPromptText" IS 'Prompt String shown above sub-division choices';
COMMENT ON COLUMN "CatalogIndexLevel"."FPromptText" IS 'Prompt String shown above sub-division choices';
COMMENT ON COLUMN "CatalogIndexLevel"."GPromptText" IS 'Prompt String shown above sub-division choices';

-- CREATE INDEXES ...
CREATE INDEX "CatalogIndexLevel_AbstractPartTypeID_idx" ON "CatalogIndexLevel" ("AbstractPartTypeID");
CREATE INDEX "CatalogIndexLevel_CatalogIndexCriteriaMethodID_idx" ON "CatalogIndexLevel" ("CatalogCriteriaMethodID");
CREATE INDEX "CatalogIndexLevel_IndexLevel_idx" ON "CatalogIndexLevel" ("IndexLevel");

CREATE TABLE "CatalogIndexSubDivision"
 (
	"AbstractPartTypeID"			INTEGER NOT NULL, 
	"IndexLevel"			INTEGER NOT NULL, 
	"OrderBy"			INTEGER, 
	"ELabel"			VARCHAR (255), 
	"FLabel"			VARCHAR (255), 
	"GLabel"			VARCHAR (255), 
	"EHelp"			TEXT, 
	"FHelp"			TEXT, 
	"GHelp"			TEXT, 
	"IntegerData0"			INTEGER, 
	"IntegerData1"			INTEGER, 
	"FloatData0"			REAL, 
	"FloatData1"			REAL
);
COMMENT ON COLUMN "CatalogIndexSubDivision"."IntegerData0" IS 'Optional -';
COMMENT ON COLUMN "CatalogIndexSubDivision"."IntegerData1" IS 'Optional -';
COMMENT ON COLUMN "CatalogIndexSubDivision"."FloatData0" IS 'Optional -';
COMMENT ON COLUMN "CatalogIndexSubDivision"."FloatData1" IS 'Optional -';

-- CREATE INDEXES ...
CREATE INDEX "CatalogIndexSubDivision_AbstractPartTypeID_idx" ON "CatalogIndexSubDivision" ("AbstractPartTypeID");
CREATE INDEX "CatalogIndexSubDivision_IndexLevel_idx" ON "CatalogIndexSubDivision" ("IndexLevel");
CREATE INDEX "CatalogIndexSubDivision_OrderBy_idx" ON "CatalogIndexSubDivision" ("OrderBy");

CREATE TABLE "CopVehicle"
 (
	"BrandedPartID"			INTEGER, 
	"Rating"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE "DriverClass"
 (
	"DriverClassID"			SMALLINT NOT NULL, 
	"DriverClass"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "DriverClass" ADD CONSTRAINT "DriverClass_pkey" PRIMARY KEY ("DriverClassID");

CREATE TABLE "Element"
 (
	"ElementID"			INTEGER NOT NULL, 
	"Element"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "Element" ADD CONSTRAINT "Element_pkey" PRIMARY KEY ("ElementID");

CREATE TABLE "EngineBlockFamily"
 (
	"EngineBlockFamilyID"			INTEGER NOT NULL, 
	"BrandID"			INTEGER NOT NULL, 
	"EName"			VARCHAR (50), 
	"EShortName"			VARCHAR (25)
);

-- CREATE INDEXES ...
CREATE INDEX "EngineBlockFamily_BrandID_idx" ON "EngineBlockFamily" ("BrandID");
CREATE INDEX "EngineBlockFamily_EngineBlockFamilyID_idx" ON "EngineBlockFamily" ("EngineBlockFamilyID");
ALTER TABLE "EngineBlockFamily" ADD CONSTRAINT "EngineBlockFamily_pkey" PRIMARY KEY ("EngineBlockFamilyID");

CREATE TABLE "Event"
 (
	"EventID"			INTEGER NOT NULL, 
	"TrackID"			INTEGER, 
	"EventStatusID"			INTEGER, 
	"RaceTypeID"			INTEGER, 
	"StartDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"EndDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"EntryFee"			INTEGER NOT NULL, 
	"TotalPurse"			INTEGER NOT NULL, 
	"MaxRegistrations"			INTEGER NOT NULL, 
	"RacersPerRace"			INTEGER NOT NULL, 
	"Event"			VARCHAR (100) NOT NULL, 
	"Description"			TEXT
);

-- CREATE INDEXES ...
ALTER TABLE "Event" ADD CONSTRAINT "Event_pkey" PRIMARY KEY ("EventID");
CREATE INDEX "Event_XIF218Event_idx" ON "Event" ("RaceTypeID");
CREATE INDEX "Event_XIF220Event_idx" ON "Event" ("EventStatusID");
CREATE INDEX "Event_XIF229Event_idx" ON "Event" ("TrackID");

CREATE TABLE "EventHistory"
 (
	"TrackID"			INTEGER, 
	"NumInvited"			INTEGER, 
	"CashWon"			INTEGER, 
	"NumRaces"			INTEGER, 
	"StartTime"			TIMESTAMP WITHOUT TIME ZONE, 
	"EventName"			VARCHAR (50), 
	"DriverName"			VARCHAR (50), 
	"CarName"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE INDEX "EventHistory_NumInvited_idx" ON "EventHistory" ("NumInvited");
CREATE INDEX "EventHistory_NumRaces_idx" ON "EventHistory" ("NumRaces");
CREATE INDEX "EventHistory_TrackID_idx" ON "EventHistory" ("TrackID");

CREATE TABLE "EventStatus"
 (
	"EventStatusID"			INTEGER NOT NULL, 
	"EventStatus"			VARCHAR (100)
);

-- CREATE INDEXES ...
ALTER TABLE "EventStatus" ADD CONSTRAINT "EventStatus_pkey" PRIMARY KEY ("EventStatusID");

CREATE TABLE "GameConfigurationType"
 (
	"ConfigurationTypeID"			INTEGER NOT NULL, 
	"Configuration"			VARCHAR (50)
);

-- CREATE INDEXES ...
CREATE UNIQUE INDEX "GameConfigurationType_GameConfigurationTypeID_idx" ON "GameConfigurationType" ("ConfigurationTypeID");
ALTER TABLE "GameConfigurationType" ADD CONSTRAINT "GameConfigurationType_pkey" PRIMARY KEY ("ConfigurationTypeID");

CREATE TABLE "GameRecord"
 (
	"GameRecordID"			SERIAL, 
	"VehicleID"			INTEGER, 
	"RecordTypeID"			INTEGER NOT NULL, 
	"HubID"			INTEGER NOT NULL, 
	"TrackID"			INTEGER, 
	"PlayerID"			INTEGER, 
	"RaceTypeID"			INTEGER, 
	"i_Record1"			INTEGER, 
	"i_Record2"			INTEGER, 
	"i_Record3"			INTEGER, 
	"f_Record1"			DOUBLE PRECISION, 
	"f_Record2"			DOUBLE PRECISION, 
	"f_Record3"			DOUBLE PRECISION
);

-- CREATE INDEXES ...
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_pkey" PRIMARY KEY ("GameRecordID");

CREATE TABLE "Junkyard"
 (
	"VehicleID"			INTEGER NOT NULL, 
	"ScrappedDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"NumPartsRemaining"			INTEGER NOT NULL, 
	"BeingViewedBy"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Junkyard" ADD CONSTRAINT "Junkyard_pkey" PRIMARY KEY ("VehicleID");

CREATE TABLE "MessagePost"
 (
	"MessageID"			SERIAL, 
	"MsgTo"			INTEGER NOT NULL, 
	"MsgFrom"			INTEGER NOT NULL, 
	"PostedDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"MessageRead"			SMALLINT NOT NULL, 
	"Header"			VARCHAR (30), 
	"Message"			VARCHAR (255), 
	"FromText"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "MessagePost" ADD CONSTRAINT "MessagePost_pkey" PRIMARY KEY ("MessageID");

CREATE TABLE "Model"
 (
	"ModelID"			INTEGER NOT NULL, 
	"BrandID"			INTEGER NOT NULL, 
	"EModel"			VARCHAR (100), 
	"GModel"			VARCHAR (100), 
	"FModel"			VARCHAR (100), 
	"SModel"			VARCHAR (100), 
	"IModel"			VARCHAR (100), 
	"JModel"			VARCHAR (100), 
	"SwModel"			VARCHAR (100), 
	"BModel"			VARCHAR (100), 
	"EExtraInfo"			VARCHAR (100), 
	"GExtraInfo"			VARCHAR (100), 
	"FExtraInfo"			VARCHAR (100), 
	"SExtraInfo"			VARCHAR (100), 
	"IExtraInfo"			VARCHAR (100), 
	"JExtraInfo"			VARCHAR (100), 
	"SwExtraInfo"			VARCHAR (100), 
	"BExtraInfo"			VARCHAR (100), 
	"EShortModel"			VARCHAR (50), 
	"GShortModel"			VARCHAR (50), 
	"FShortModel"			VARCHAR (50), 
	"SShortModel"			VARCHAR (50), 
	"IShortModel"			VARCHAR (50), 
	"JShortModel"			VARCHAR (50), 
	"SwShortModel"			VARCHAR (50), 
	"BShortModel"			VARCHAR (50), 
	"Debug_String"			VARCHAR (255), 
	"Debug_Sort_String"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "Model" ADD CONSTRAINT "Model_pkey" PRIMARY KEY ("ModelID");

CREATE TABLE "NewSkinHSV"
 (
	"PartFilename"			VARCHAR (255), 
	"H0"			DOUBLE PRECISION, 
	"S0"			DOUBLE PRECISION, 
	"V0"			DOUBLE PRECISION, 
	"H1"			DOUBLE PRECISION, 
	"S1"			DOUBLE PRECISION, 
	"V1"			DOUBLE PRECISION, 
	"H2"			DOUBLE PRECISION, 
	"S2"			DOUBLE PRECISION, 
	"V2"			DOUBLE PRECISION, 
	"H3"			DOUBLE PRECISION, 
	"S3"			DOUBLE PRECISION, 
	"V3"			DOUBLE PRECISION, 
	"H4"			DOUBLE PRECISION, 
	"S4"			DOUBLE PRECISION, 
	"V4"			DOUBLE PRECISION, 
	"H5"			DOUBLE PRECISION, 
	"S5"			DOUBLE PRECISION, 
	"V5"			DOUBLE PRECISION, 
	"H6"			DOUBLE PRECISION, 
	"S6"			DOUBLE PRECISION, 
	"V6"			DOUBLE PRECISION, 
	"H7"			DOUBLE PRECISION, 
	"S7"			DOUBLE PRECISION, 
	"V7"			DOUBLE PRECISION
);

-- CREATE INDEXES ...

CREATE TABLE "Part"
 (
	"PartID"			INTEGER NOT NULL, 
	"ParentPartID"			INTEGER, 
	"BrandedPartID"			INTEGER NOT NULL, 
	"PercentDamage"			SMALLINT NOT NULL, 
	"ItemWear"			INTEGER NOT NULL, 
	"AttachmentPointID"			INTEGER, 
	"OwnerID"			INTEGER, 
	"PartName"			VARCHAR (100), 
	"RepairCost"			INTEGER, 
	"ScrapValue"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Part" ADD CONSTRAINT "Part_pkey" PRIMARY KEY ("PartID");

CREATE TABLE "PartGrade"
 (
	"PartGradeID"			INTEGER NOT NULL, 
	"EText"			VARCHAR (50), 
	"GText"			VARCHAR (50), 
	"FText"			VARCHAR (50), 
	"PartGrade"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "PartGrade" ADD CONSTRAINT "PartGrade_pkey" PRIMARY KEY ("PartGradeID");

CREATE TABLE "PartType"
 (
	"PartTypeID"			INTEGER NOT NULL, 
	"AbstractPartTypeID"			INTEGER NOT NULL, 
	"PartType"			VARCHAR (100) NOT NULL, 
	"PartFilename"			VARCHAR (20), 
	"PartGradeID"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "PartType" ADD CONSTRAINT "PartType_pkey" PRIMARY KEY ("PartTypeID");

CREATE TABLE "PartTypeCompatibility"
 (
	"ParentPartTypeID"			INTEGER NOT NULL, 
	"ChildPartTypeID"			INTEGER NOT NULL, 
	"Critical"			SMALLINT NOT NULL, 
	"MinQty"			SMALLINT, 
	"MaxQty"			SMALLINT
);

-- CREATE INDEXES ...
ALTER TABLE "PartTypeCompatibility" ADD CONSTRAINT "PartTypeCompatibility_pkey" PRIMARY KEY ("ParentPartTypeID", "ChildPartTypeID");

CREATE TABLE "Paste Errors"
 (
	"PartTypeID"			INTEGER, 
	"AbstractPartTypeID"			INTEGER, 
	"PartType"			VARCHAR (255), 
	"PartFilename"			VARCHAR (255), 
	"PartGradeID"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE "PhysicsType"
 (
	"PhysicsTypeID"			INTEGER NOT NULL, 
	"PhysicsTypeNum"			INTEGER NOT NULL, 
	"PhysicsType"			VARCHAR (30) NOT NULL, 
	"EIndexLabel"			VARCHAR (100), 
	"FIndexLabel"			VARCHAR (100), 
	"GIndexLabel"			VARCHAR (100), 
	"EIndexHelp"			TEXT, 
	"FIndexHelp"			TEXT, 
	"GIndexHelp"			TEXT
);
COMMENT ON COLUMN "PhysicsType"."PhysicsType" IS 'Debug';
COMMENT ON COLUMN "PhysicsType"."EIndexLabel" IS 'Catalog Index Label text';
COMMENT ON COLUMN "PhysicsType"."FIndexLabel" IS 'Catalog Index Label text';
COMMENT ON COLUMN "PhysicsType"."GIndexLabel" IS 'Catalog Index Label text';
COMMENT ON COLUMN "PhysicsType"."EIndexHelp" IS 'Catalog Index Help text';
COMMENT ON COLUMN "PhysicsType"."FIndexHelp" IS 'Catalog Index Help text';
COMMENT ON COLUMN "PhysicsType"."GIndexHelp" IS 'Catalog Index Help text';

-- CREATE INDEXES ...

CREATE TABLE "Player"
 (
	"PlayerID"			INTEGER NOT NULL, 
	"CustomerID"			INTEGER NOT NULL, 
	"PlayerTypeID"			INTEGER NOT NULL, 
	"SanctionedScore"			INTEGER, 
	"ChallengeScore"			INTEGER, 
	"LastLoggedIn"			TIMESTAMP WITHOUT TIME ZONE, 
	"TimesLoggedIn"			INTEGER, 
	"BankBalance"			INTEGER NOT NULL, 
	"NumCarsOwned"			INTEGER NOT NULL, 
	"IsLoggedIn"			SMALLINT, 
	"DriverStyle"			SMALLINT NOT NULL, 
	"LPCode"			INTEGER NOT NULL, 
	"LPText"			VARCHAR (9), 
	"CarNum1"			VARCHAR (2) NOT NULL, 
	"CarNum2"			VARCHAR (2) NOT NULL, 
	"CarNum3"			VARCHAR (2) NOT NULL, 
	"CarNum4"			VARCHAR (2) NOT NULL, 
	"CarNum5"			VARCHAR (2) NOT NULL, 
	"CarNum6"			VARCHAR (2) NOT NULL, 
	"DLNumber"			VARCHAR (20), 
	"Persona"			VARCHAR (30) NOT NULL, 
	"Address"			VARCHAR (128), 
	"Residence"			VARCHAR (20), 
	"VehicleID"			INTEGER, 
	"CurrentRaceID"			INTEGER, 
	"OfflineDriverSkill"			INTEGER, 
	"OfflineGrudge"			INTEGER, 
	"OfflineReputation"			INTEGER, 
	"TotalTimePlayed"			INTEGER, 
	"CarInfoSetting"			INTEGER, 
	"StockClassicClass"			SMALLINT, 
	"StockMuscleClass"			SMALLINT, 
	"ModifiedClassicClass"			SMALLINT, 
	"ModifiedMuscleClass"			SMALLINT, 
	"OutlawClass"			SMALLINT, 
	"DragClass"			SMALLINT, 
	"ChallengeRung"			INTEGER, 
	"OfflineAiCarClass"			SMALLINT, 
	"OfflineAiSkinID"			INTEGER, 
	"OfflineAiCarBptID"			INTEGER, 
	"OfflineAiState"			INTEGER, 
	"BodyType"			INTEGER, 
	"SkinColor"			INTEGER, 
	"HairColor"			INTEGER, 
	"ShirtColor"			INTEGER, 
	"PantsColor"			INTEGER, 
	"OfflineDriverStyle"			INTEGER, 
	"OfflineDriverAttitude"			INTEGER, 
	"EvadedFuzz"			INTEGER, 
	"PinksWon"			INTEGER, 
	"NumUnreadMail"			INTEGER, 
	"TOTALRACESRUN"			INTEGER, 
	"TOTALRACESWON"			INTEGER, 
	"TOTALRACESCOMPLETED"			INTEGER, 
	"TOTALWINNINGS"			INTEGER, 
	"INSURANCERISKPOINTS"			INTEGER, 
	"INSURANCERATING"			INTEGER, 
	"CHALLENGERACESRUN"			INTEGER, 
	"CHALLENGERACESWON"			INTEGER, 
	"CHALLENGERACESCOMPLETED"			INTEGER, 
	"CARSLOST"			INTEGER, 
	"CARSWON"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "Player_NumUnreadMail_idx" ON "Player" ("NumUnreadMail");
CREATE INDEX "Player_OfflineChallengeCarBptID_idx" ON "Player" ("OfflineAiCarBptID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_pkey" PRIMARY KEY ("PlayerID");

CREATE TABLE "PlayerType"
 (
	"PlayerTypeID"			INTEGER NOT NULL, 
	"PlayerType"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "PlayerType" ADD CONSTRAINT "PlayerType_pkey" PRIMARY KEY ("PlayerTypeID");

CREATE TABLE "PricingGuide"
 (
	"type"			VARCHAR (50) NOT NULL, 
	"damagePolyA"			REAL NOT NULL, 
	"damagePolyB"			REAL NOT NULL, 
	"wearPolyA"			REAL NOT NULL, 
	"wearPolyB"			REAL NOT NULL, 
	"Mod"			REAL NOT NULL, 
	"baseMin"			REAL NOT NULL, 
	"baseMax"			REAL NOT NULL
);

-- CREATE INDEXES ...

CREATE TABLE "PTSkin"
 (
	"SkinID"			SERIAL, 
	"CreatorID"			INTEGER, 
	"SkinTypeID"			INTEGER, 
	"PartTypeID"			INTEGER, 
	"ESkin"			VARCHAR (100), 
	"GSkin"			VARCHAR (20), 
	"FSkin"			VARCHAR (20), 
	"SSkin"			VARCHAR (20), 
	"ISkin"			VARCHAR (20), 
	"JSkin"			VARCHAR (20), 
	"SwSkin"			VARCHAR (20), 
	"BSkin"			VARCHAR (20), 
	"Price"			INTEGER NOT NULL, 
	"PartFilename"			VARCHAR (20), 
	"H0"			SMALLINT, 
	"S0"			SMALLINT, 
	"V0"			SMALLINT, 
	"C0"			SMALLINT, 
	"X0"			SMALLINT, 
	"Y0"			SMALLINT, 
	"H1"			SMALLINT, 
	"S1"			SMALLINT, 
	"V1"			SMALLINT, 
	"C1"			SMALLINT, 
	"X1"			SMALLINT, 
	"Y1"			SMALLINT, 
	"H2"			SMALLINT, 
	"S2"			SMALLINT, 
	"V2"			SMALLINT, 
	"C2"			SMALLINT, 
	"X2"			SMALLINT, 
	"Y2"			SMALLINT, 
	"H3"			SMALLINT, 
	"S3"			SMALLINT, 
	"V3"			SMALLINT, 
	"C3"			SMALLINT, 
	"X3"			SMALLINT, 
	"Y3"			SMALLINT, 
	"H4"			SMALLINT, 
	"S4"			SMALLINT, 
	"V4"			SMALLINT, 
	"C4"			SMALLINT, 
	"X4"			SMALLINT, 
	"Y4"			SMALLINT, 
	"H5"			SMALLINT, 
	"S5"			SMALLINT, 
	"V5"			SMALLINT, 
	"C5"			SMALLINT, 
	"X5"			SMALLINT, 
	"Y5"			SMALLINT, 
	"H6"			SMALLINT, 
	"S6"			SMALLINT, 
	"V6"			SMALLINT, 
	"C6"			SMALLINT, 
	"X6"			SMALLINT, 
	"Y6"			SMALLINT, 
	"H7"			SMALLINT, 
	"S7"			SMALLINT, 
	"V7"			SMALLINT, 
	"C7"			SMALLINT, 
	"X7"			SMALLINT, 
	"Y7"			SMALLINT, 
	"DEFAULTFLAG"			INTEGER, 
	"CreatorName"			VARCHAR (24), 
	"Comment_Text"			VARCHAR (128)
);

-- CREATE INDEXES ...
ALTER TABLE "PTSkin" ADD CONSTRAINT "PTSkin_pkey" PRIMARY KEY ("SkinID");
CREATE INDEX "PTSkin_PTSkinPartTypeID_idx" ON "PTSkin" ("PartTypeID");

CREATE TABLE "Race"
 (
	"RaceID"			SERIAL, 
	"TrackID"			INTEGER NOT NULL, 
	"RaceTypeID"			INTEGER NOT NULL, 
	"RaceStateID"			INTEGER NOT NULL, 
	"CurrRacers"			SMALLINT NOT NULL, 
	"EntryFee"			INTEGER NOT NULL, 
	"ScheduledStagingTime"			TIMESTAMP WITHOUT TIME ZONE, 
	"ScheduledStartTime"			TIMESTAMP WITHOUT TIME ZONE, 
	"ResultsReceived"			SMALLINT, 
	"RaceName"			VARCHAR (100), 
	"Comments"			VARCHAR (255), 
	"TotalPurse"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Race" ADD CONSTRAINT "Race_pkey" PRIMARY KEY ("RaceID");

CREATE TABLE "RaceHistory"
 (
	"RaceID"			SERIAL, 
	"RaceTime"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"TrackID"			INTEGER NOT NULL, 
	"RaceTypeID"			INTEGER, 
	"Restriction"			INTEGER NOT NULL, 
	"DriverClass"			INTEGER NOT NULL, 
	"Neigborhood"			VARCHAR (255), 
	"RaceName"			VARCHAR (50), 
	"WinningPurse"			VARCHAR (255), 
	"PlayerName0"			VARCHAR (50), 
	"PlayerName1"			VARCHAR (50), 
	"PlayerName2"			VARCHAR (50), 
	"PlayerName3"			VARCHAR (50), 
	"PlayerName4"			VARCHAR (50), 
	"PlayerName5"			VARCHAR (50), 
	"PlayerTime0"			INTEGER, 
	"PlayerTime1"			INTEGER, 
	"PlayerTime2"			INTEGER, 
	"PlayerTime3"			INTEGER, 
	"PlayerTime4"			INTEGER, 
	"PlayerTime5"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "RaceHistory" ADD CONSTRAINT "RaceHistory_pkey" PRIMARY KEY ("RaceID");

CREATE TABLE "Racer"
 (
	"RaceID"			INTEGER NOT NULL, 
	"RacerID"			INTEGER NOT NULL, 
	"VehicleID"			INTEGER, 
	"ElapsedTime"			INTEGER NOT NULL, 
	"Placement"			SMALLINT NOT NULL, 
	"BestLap"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Racer" ADD CONSTRAINT "Racer_pkey" PRIMARY KEY ("RaceID", "RacerID");

CREATE TABLE "RaceState"
 (
	"RaceStateID"			INTEGER NOT NULL, 
	"RaceState"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "RaceState" ADD CONSTRAINT "RaceState_pkey" PRIMARY KEY ("RaceStateID");

CREATE TABLE "RaceType"
 (
	"RaceTypeID"			INTEGER NOT NULL, 
	"RaceType"			VARCHAR (100) NOT NULL, 
	"ArcadeMode"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "RaceType" ADD CONSTRAINT "RaceType_pkey" PRIMARY KEY ("RaceTypeID");

CREATE TABLE "RecordType"
 (
	"RecordTypeID"			INTEGER NOT NULL, 
	"RecordType"			VARCHAR (30) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "RecordType" ADD CONSTRAINT "RecordType_pkey" PRIMARY KEY ("RecordTypeID");

CREATE TABLE "Season"
 (
	"SeasonID"			SERIAL, 
	"RaceTypeID"			INTEGER NOT NULL, 
	"StartDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"EndDate"			TIMESTAMP WITHOUT TIME ZONE NOT NULL, 
	"EntryFee"			INTEGER NOT NULL, 
	"MaxPlayers"			INTEGER NOT NULL, 
	"CurrPlayers"			INTEGER NOT NULL, 
	"DriverClassID"			SMALLINT NOT NULL, 
	"Rules"			VARCHAR (100), 
	"NumRaces"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Season" ADD CONSTRAINT "Season_pkey" PRIMARY KEY ("SeasonID");

CREATE TABLE "SeasonAwards"
 (
	"RaceTypeID"			INTEGER NOT NULL, 
	"DriverClassID"			INTEGER NOT NULL, 
	"CashPrize"			INTEGER, 
	"BrandedPartID"			INTEGER, 
	"SkinID"			INTEGER
);

-- CREATE INDEXES ...
CREATE INDEX "SeasonAwards_DriverClassID_idx" ON "SeasonAwards" ("DriverClassID");
CREATE INDEX "SeasonAwards_RaceTypeID_idx" ON "SeasonAwards" ("RaceTypeID");

CREATE TABLE "SeasonRacer"
 (
	"SeasonID"			INTEGER NOT NULL, 
	"RacerID"			INTEGER NOT NULL, 
	"TotalPoints"			INTEGER NOT NULL, 
	"Standing"			INTEGER NOT NULL, 
	"RacesCompleted"			INTEGER NOT NULL, 
	"RaceFirsts"			INTEGER, 
	"RacesWithHuman"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "SeasonRacer" ADD CONSTRAINT "SeasonRacer_pkey" PRIMARY KEY ("SeasonID", "RacerID");

CREATE TABLE "SkinType"
 (
	"SkinTypeID"			INTEGER NOT NULL, 
	"SkinType"			VARCHAR (100)
);

-- CREATE INDEXES ...
ALTER TABLE "SkinType" ADD CONSTRAINT "SkinType_pkey" PRIMARY KEY ("SkinTypeID");

CREATE TABLE "StockAssembly"
 (
	"ParentBrandedPartID"			INTEGER NOT NULL, 
	"ChildBrandedPartID"			INTEGER NOT NULL, 
	"AttachmentPointID"			INTEGER NOT NULL, 
	"ConfigDefault"			SMALLINT NOT NULL, 
	"PhysicsDefault"			SMALLINT NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "StockAssembly" ADD CONSTRAINT "StockAssembly_pkey" PRIMARY KEY ("ParentBrandedPartID", "ChildBrandedPartID", "AttachmentPointID");

CREATE TABLE "StockEngines"
 (
	"StockEngineID"			SERIAL, 
	"EEngineName"			VARCHAR (50) NOT NULL, 
	"EngineBlockBPT"			INTEGER, 
	"CamShaftBPT"			INTEGER, 
	"CarburetorBPT"			INTEGER, 
	"ConnectingRodsBPT"			INTEGER, 
	"CoolingSystemBPT"			INTEGER, 
	"CrankshaftBPT"			INTEGER, 
	"CylinderHeadBPT"			INTEGER, 
	"ElectricalSystemBPT"			INTEGER, 
	"ExhaustManifoldBPT"			INTEGER, 
	"IntakeManifoldBPT"			INTEGER, 
	"LubricationSystemBPT"			INTEGER, 
	"PistonsBPT"			INTEGER, 
	"ValveTrainBPT"			INTEGER, 
	"AirIntakeBPT"			INTEGER, 
	"BlowerBPT"			INTEGER, 
	"NitrosInjectorBPT"			INTEGER, 
	"CRT"			INTEGER
);
COMMENT ON COLUMN "StockEngines"."AirIntakeBPT" IS 'cleaner or scoop';
COMMENT ON COLUMN "StockEngines"."CRT" IS 'Todo, create CRT for validation';

-- CREATE INDEXES ...
ALTER TABLE "StockEngines" ADD CONSTRAINT "StockEngines_pkey" PRIMARY KEY ("StockEngineID");
CREATE INDEX "StockEngines_StockEngineID_idx" ON "StockEngines" ("StockEngineID");

CREATE TABLE "StockVehicleAttributes"
 (
	"BrandedPartID"			INTEGER NOT NULL, 
	"CarClass"			INTEGER, 
	"AIRestrictionClass"			INTEGER, 
	"ModeRestriction"			INTEGER, 
	"Sponsor"			INTEGER, 
	"VinBrandedPartID"			INTEGER, 
	"TrackID"			INTEGER, 
	"VinCrc"			INTEGER NOT NULL, 
	"RetailPrice"			INTEGER
);
COMMENT ON COLUMN "StockVehicleAttributes"."RetailPrice" IS 'Computed at prebuild time';

-- CREATE INDEXES ...
CREATE INDEX "StockVehicleAttributes_CarClass_idx" ON "StockVehicleAttributes" ("CarClass");
CREATE INDEX "StockVehicleAttributes_CopTrackID_idx" ON "StockVehicleAttributes" ("TrackID");
CREATE UNIQUE INDEX "StockVehicleAttributes_ParentBrandedPartID_idx" ON "StockVehicleAttributes" ("BrandedPartID");
ALTER TABLE "StockVehicleAttributes" ADD CONSTRAINT "StockVehicleAttributes_pkey" PRIMARY KEY ("BrandedPartID");
CREATE INDEX "StockVehicleAttributes_VinBrandedPartID_idx" ON "StockVehicleAttributes" ("VinBrandedPartID");

CREATE TABLE "SVA_CarClass"
 (
	"SVA_CarClass"			INTEGER, 
	"Description"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "SVA_CarClass" ADD CONSTRAINT "SVA_CarClass_pkey" PRIMARY KEY ("SVA_CarClass");

CREATE TABLE "SVA_ModeRestriction"
 (
	"SVA_ModeRestriction"			INTEGER NOT NULL, 
	"Description"			VARCHAR (100)
);

-- CREATE INDEXES ...
ALTER TABLE "SVA_ModeRestriction" ADD CONSTRAINT "SVA_ModeRestriction_pkey" PRIMARY KEY ("SVA_ModeRestriction");
CREATE UNIQUE INDEX "SVA_ModeRestriction_SVA_ModeRestriction_idx" ON "SVA_ModeRestriction" ("SVA_ModeRestriction");

CREATE TABLE "TmpSkin"
 (
	"SkinID"			SERIAL, 
	"CreatorID"			INTEGER, 
	"SkinTypeID"			INTEGER, 
	"PartTypeID"			INTEGER, 
	"ESkin"			VARCHAR (100), 
	"GSkin"			VARCHAR (20), 
	"FSkin"			VARCHAR (20), 
	"SSkin"			VARCHAR (20), 
	"ISkin"			VARCHAR (20), 
	"JSkin"			VARCHAR (20), 
	"SwSkin"			VARCHAR (20), 
	"BSkin"			VARCHAR (20), 
	"Price"			INTEGER NOT NULL, 
	"PartFilename"			VARCHAR (20), 
	"H0"			SMALLINT, 
	"S0"			SMALLINT, 
	"V0"			SMALLINT, 
	"C0"			SMALLINT, 
	"X0"			SMALLINT, 
	"Y0"			SMALLINT, 
	"H1"			SMALLINT, 
	"S1"			SMALLINT, 
	"V1"			SMALLINT, 
	"C1"			SMALLINT, 
	"X1"			SMALLINT, 
	"Y1"			SMALLINT, 
	"H2"			SMALLINT, 
	"S2"			SMALLINT, 
	"V2"			SMALLINT, 
	"C2"			SMALLINT, 
	"X2"			SMALLINT, 
	"Y2"			SMALLINT, 
	"H3"			SMALLINT, 
	"S3"			SMALLINT, 
	"V3"			SMALLINT, 
	"C3"			SMALLINT, 
	"X3"			SMALLINT, 
	"Y3"			SMALLINT, 
	"H4"			SMALLINT, 
	"S4"			SMALLINT, 
	"V4"			SMALLINT, 
	"C4"			SMALLINT, 
	"X4"			SMALLINT, 
	"Y4"			SMALLINT, 
	"H5"			SMALLINT, 
	"S5"			SMALLINT, 
	"V5"			SMALLINT, 
	"C5"			SMALLINT, 
	"X5"			SMALLINT, 
	"Y5"			SMALLINT, 
	"H6"			SMALLINT, 
	"S6"			SMALLINT, 
	"V6"			SMALLINT, 
	"C6"			SMALLINT, 
	"X6"			SMALLINT, 
	"Y6"			SMALLINT, 
	"H7"			SMALLINT, 
	"S7"			SMALLINT, 
	"V7"			SMALLINT, 
	"C7"			SMALLINT, 
	"X7"			SMALLINT, 
	"Y7"			SMALLINT, 
	"DEFAULTFLAG"			INTEGER, 
	"CreatorName"			VARCHAR (24), 
	"Comment_Text"			VARCHAR (128)
);

-- CREATE INDEXES ...
ALTER TABLE "TmpSkin" ADD CONSTRAINT "TmpSkin_pkey" PRIMARY KEY ("SkinID");
CREATE INDEX "TmpSkin_PTSkinPartTypeID_idx" ON "TmpSkin" ("PartTypeID");

CREATE TABLE "TrackLapTimeRecord"
 (
	"TrackLapTimeRecordID"			SERIAL, 
	"PersonaID"			INTEGER, 
	"PlayerName"			VARCHAR (30) NOT NULL, 
	"LapTime"			INTEGER NOT NULL, 
	"TrackID"			INTEGER NOT NULL, 
	"CarBrandedPartID"			INTEGER NOT NULL, 
	"Flags"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "TrackLapTimeRecord" ADD CONSTRAINT "TrackLapTimeRecord_pkey" PRIMARY KEY ("TrackLapTimeRecordID");

CREATE TABLE "Vehicle"
 (
	"VehicleID"			INTEGER NOT NULL, 
	"SkinID"			INTEGER NOT NULL, 
	"Flags"			INTEGER NOT NULL, 
	"Class"			SMALLINT NOT NULL, 
	"InfoSetting"			SMALLINT NOT NULL, 
	"DamageInfo"			BYTEA, 
	"DamageCached"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("VehicleID");

CREATE TABLE "VehicleRecords"
 (
	"carID"			INTEGER NOT NULL, 
	"trackID"			INTEGER NOT NULL, 
	"numberRaces"			INTEGER, 
	"numberWins"			INTEGER, 
	"topSpeed"			REAL, 
	"bestLapTime"			REAL, 
	"playerID"			INTEGER
);

-- CREATE INDEXES ...

CREATE TABLE "APTDealershipAudio"
 (
	"PlayerID"			INTEGER NOT NULL, 
	"AbstractPartTypeID"			INTEGER NOT NULL, 
	"AudioIndex"			INTEGER NOT NULL, 
	"Freq"			INTEGER NOT NULL, 
	"FilePath"			VARCHAR (255) NOT NULL, 
	"APTDealershipAudio"			VARCHAR (100)
);

-- CREATE INDEXES ...
ALTER TABLE "APTDealershipAudio" ADD CONSTRAINT "APTDealershipAudio_pkey" PRIMARY KEY ("PlayerID", "AbstractPartTypeID", "AudioIndex");

CREATE TABLE "BPDealershipAudio"
 (
	"PlayerID"			INTEGER NOT NULL, 
	"BrandedPartID"			INTEGER NOT NULL, 
	"AudioIndex"			INTEGER NOT NULL, 
	"Freq"			INTEGER NOT NULL, 
	"FilePath"			VARCHAR (255) NOT NULL, 
	"BPDealershipAudio"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "BPDealershipAudio" ADD CONSTRAINT "BPDealershipAudio_pkey" PRIMARY KEY ("PlayerID", "BrandedPartID", "AudioIndex");

CREATE TABLE "City"
 (
	"CityID"			INTEGER NOT NULL, 
	"City"			VARCHAR (100) NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "City" ADD CONSTRAINT "City_pkey" PRIMARY KEY ("CityID");

CREATE TABLE "EventInvitation"
 (
	"EventID"			INTEGER NOT NULL, 
	"PlayerID"			INTEGER NOT NULL, 
	"EventStatusID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "EventInvitation" ADD CONSTRAINT "EventInvitation_pkey" PRIMARY KEY ("EventID", "PlayerID");
CREATE INDEX "EventInvitation_XIF216EventInvitation_idx" ON "EventInvitation" ("EventID");
CREATE INDEX "EventInvitation_XIF217EventInvitation_idx" ON "EventInvitation" ("PlayerID");
CREATE INDEX "EventInvitation_XIF219EventInvitation_idx" ON "EventInvitation" ("EventStatusID");

CREATE TABLE "GameConfiguration"
 (
	"ConfigurationID"			INTEGER NOT NULL, 
	"Configuration"			VARCHAR (20), 
	"i_ConfigVal1"			INTEGER, 
	"i_ConfigVal2"			INTEGER, 
	"i_ConfigVal3"			INTEGER, 
	"f_ConfigVal1"			DOUBLE PRECISION, 
	"f_ConfigVal2"			DOUBLE PRECISION, 
	"f_ConfigVal3"			DOUBLE PRECISION, 
	"vc_ConfigVal1"			VARCHAR (20), 
	"vc_ConfigVal2"			VARCHAR (20), 
	"vc_ConfigVal3"			VARCHAR (20), 
	"ConfigurationTypeID"			INTEGER NOT NULL
);

-- CREATE INDEXES ...
ALTER TABLE "GameConfiguration" ADD CONSTRAINT "GameConfiguration_pkey" PRIMARY KEY ("ConfigurationID");

CREATE TABLE "Grade"
 (
	"GradeID"			INTEGER NOT NULL, 
	"EText"			VARCHAR (50), 
	"GText"			VARCHAR (50), 
	"FText"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "Grade" ADD CONSTRAINT "Grade_pkey" PRIMARY KEY ("GradeID");

CREATE TABLE "Pacejka_TireModel"
 (
	"TireTypeID"			INTEGER NOT NULL, 
	"Val1"			DOUBLE PRECISION NOT NULL, 
	"Val2"			DOUBLE PRECISION NOT NULL, 
	"Val3"			DOUBLE PRECISION NOT NULL, 
	"Val4"			DOUBLE PRECISION NOT NULL, 
	"Val5"			DOUBLE PRECISION NOT NULL, 
	"Val6"			DOUBLE PRECISION NOT NULL, 
	"Val7"			DOUBLE PRECISION NOT NULL, 
	"Val8"			DOUBLE PRECISION NOT NULL, 
	"Val9"			DOUBLE PRECISION NOT NULL, 
	"Val10"			DOUBLE PRECISION NOT NULL, 
	"Val11"			DOUBLE PRECISION NOT NULL, 
	"Val12"			DOUBLE PRECISION NOT NULL, 
	"Val13"			DOUBLE PRECISION NOT NULL, 
	"Val14"			DOUBLE PRECISION NOT NULL, 
	"Val15"			DOUBLE PRECISION NOT NULL, 
	"Val16"			DOUBLE PRECISION NOT NULL, 
	"Val17"			DOUBLE PRECISION NOT NULL, 
	"Val18"			DOUBLE PRECISION NOT NULL, 
	"Val19"			DOUBLE PRECISION NOT NULL, 
	"Val20"			DOUBLE PRECISION NOT NULL, 
	"Val21"			DOUBLE PRECISION NOT NULL, 
	"Val22"			DOUBLE PRECISION NOT NULL, 
	"Val23"			DOUBLE PRECISION NOT NULL, 
	"Val24"			DOUBLE PRECISION NOT NULL, 
	"Val25"			DOUBLE PRECISION NOT NULL, 
	"Val26"			DOUBLE PRECISION NOT NULL, 
	"Val27"			DOUBLE PRECISION NOT NULL, 
	"Val28"			DOUBLE PRECISION NOT NULL, 
	"Val29"			DOUBLE PRECISION NOT NULL, 
	"Val30"			DOUBLE PRECISION NOT NULL, 
	"Val31"			DOUBLE PRECISION NOT NULL, 
	"Val32"			DOUBLE PRECISION NOT NULL, 
	"Val33"			DOUBLE PRECISION NOT NULL, 
	"Val34"			DOUBLE PRECISION NOT NULL, 
	"Val35"			DOUBLE PRECISION NOT NULL, 
	"Val36"			DOUBLE PRECISION NOT NULL, 
	"TireType"			INTEGER, 
	"RainFlag"			INTEGER, 
	"Pacejka_TireModel"			VARCHAR (50), 
	"LatForce1"			DOUBLE PRECISION, 
	"LatForce2"			DOUBLE PRECISION, 
	"LatForce3"			DOUBLE PRECISION, 
	"LatForce4"			DOUBLE PRECISION, 
	"LatForce5"			DOUBLE PRECISION, 
	"LatForce6"			DOUBLE PRECISION, 
	"LatForce7"			DOUBLE PRECISION, 
	"LatForce8"			DOUBLE PRECISION, 
	"LatForce9"			DOUBLE PRECISION, 
	"LatForce10"			DOUBLE PRECISION, 
	"LatForce11"			DOUBLE PRECISION, 
	"LatForce12"			DOUBLE PRECISION, 
	"LatForce13"			DOUBLE PRECISION, 
	"LatForce14"			DOUBLE PRECISION, 
	"LatForce15"			DOUBLE PRECISION, 
	"LatForce16"			DOUBLE PRECISION, 
	"LatForce17"			DOUBLE PRECISION, 
	"LatForce18"			DOUBLE PRECISION, 
	"LatForce19"			DOUBLE PRECISION, 
	"LatForce20"			DOUBLE PRECISION, 
	"LatForce21"			DOUBLE PRECISION, 
	"LatForce22"			DOUBLE PRECISION, 
	"LatForce23"			DOUBLE PRECISION, 
	"LatForce24"			DOUBLE PRECISION, 
	"LatForce25"			DOUBLE PRECISION, 
	"AlignMom1"			DOUBLE PRECISION, 
	"AlignMom2"			DOUBLE PRECISION, 
	"AlignMom3"			DOUBLE PRECISION, 
	"AlignMom4"			DOUBLE PRECISION, 
	"AlignMom5"			DOUBLE PRECISION, 
	"AlignMom6"			DOUBLE PRECISION, 
	"AlignMom7"			DOUBLE PRECISION, 
	"AlignMom8"			DOUBLE PRECISION, 
	"AlignMom9"			DOUBLE PRECISION, 
	"AlignMom10"			DOUBLE PRECISION, 
	"AlignMom11"			DOUBLE PRECISION, 
	"AlignMom12"			DOUBLE PRECISION, 
	"AlignMom13"			DOUBLE PRECISION, 
	"AlignMom14"			DOUBLE PRECISION, 
	"AlignMom15"			DOUBLE PRECISION, 
	"AlignMom16"			DOUBLE PRECISION, 
	"AlignMom17"			DOUBLE PRECISION, 
	"AlignMom18"			DOUBLE PRECISION, 
	"AlignMom19"			DOUBLE PRECISION, 
	"AlignMom20"			DOUBLE PRECISION, 
	"AlignMom21"			DOUBLE PRECISION, 
	"AlignMom22"			DOUBLE PRECISION, 
	"AlignMom23"			DOUBLE PRECISION, 
	"AlignMom24"			DOUBLE PRECISION, 
	"AlignMom25"			DOUBLE PRECISION, 
	"RollingResistFactor"			DOUBLE PRECISION, 
	"GrowthFactor"			DOUBLE PRECISION, 
	"PeakFriction"			DOUBLE PRECISION, 
	"CamberCoefficient"			DOUBLE PRECISION, 
	"SectionWidth"			DOUBLE PRECISION
);
COMMENT ON COLUMN "Pacejka_TireModel"."Pacejka_TireModel" IS 'Debug - Text';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce1" IS 'Lateral force [N] generated by the tire at 1 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce2" IS 'Lateral force [N] generated by the tire at 2 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce3" IS 'Lateral force [N] generated by the tire at 3 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce4" IS 'Lateral force [N] generated by the tire at 4 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce5" IS 'Lateral force [N] generated by the tire at 5 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce6" IS 'Lateral force [N] generated by the tire at 6 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce7" IS 'Lateral force [N] generated by the tire at 7 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce8" IS 'Lateral force [N] generated by the tire at 8 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce9" IS 'Lateral force [N] generated by the tire at 9 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce10" IS 'Lateral force [N] generated by the tire at 10 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce11" IS 'Lateral force [N] generated by the tire at 11 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce12" IS 'Lateral force [N] generated by the tire at 12 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce13" IS 'Lateral force [N] generated by the tire at 13 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce14" IS 'Lateral force [N] generated by the tire at 14 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce15" IS 'Lateral force [N] generated by the tire at 15 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce16" IS 'Lateral force [N] generated by the tire at 16 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce17" IS 'Lateral force [N] generated by the tire at 17 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce18" IS 'Lateral force [N] generated by the tire at 18 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce19" IS 'Lateral force [N] generated by the tire at 19 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce20" IS 'Lateral force [N] generated by the tire at 20 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce21" IS 'Lateral force [N] generated by the tire at 21 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce22" IS 'Lateral force [N] generated by the tire at 22 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce23" IS 'Lateral force [N] generated by the tire at 23 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce24" IS 'Lateral force [N] generated by the tire at 24 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."LatForce25" IS 'Lateral force [N] generated by the tire at 25 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom1" IS 'Aligning moment [Nm] generated by the tire at 1 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom2" IS 'Aligning moment [Nm] generated by the tire at 2 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom3" IS 'Aligning moment [Nm] generated by the tire at 3 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom4" IS 'Aligning moment [Nm] generated by the tire at 4 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom5" IS 'Aligning moment [Nm] generated by the tire at 5 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom6" IS 'Aligning moment [Nm] generated by the tire at 6 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom7" IS 'Aligning moment [Nm] generated by the tire at 7 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom8" IS 'Aligning moment [Nm] generated by the tire at 8 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom9" IS 'Aligning moment [Nm] generated by the tire at 9 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom10" IS 'Aligning moment [Nm] generated by the tire at 10 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom11" IS 'Aligning moment [Nm] generated by the tire at 11 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom12" IS 'Aligning moment [Nm] generated by the tire at 12 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom13" IS 'Aligning moment [Nm] generated by the tire at 13 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom14" IS 'Aligning moment [Nm] generated by the tire at 14 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom15" IS 'Aligning moment [Nm] generated by the tire at 15 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom16" IS 'Aligning moment [Nm] generated by the tire at 16 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom17" IS 'Aligning moment [Nm] generated by the tire at 17 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom18" IS 'Aligning moment [Nm] generated by the tire at 18 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom19" IS 'Aligning moment [Nm] generated by the tire at 19 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom20" IS 'Aligning moment [Nm] generated by the tire at 20 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom21" IS 'Aligning moment [Nm] generated by the tire at 21 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom22" IS 'Aligning moment [Nm] generated by the tire at 22 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom23" IS 'Aligning moment [Nm] generated by the tire at 23 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom24" IS 'Aligning moment [Nm] generated by the tire at 24 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."AlignMom25" IS 'Aligning moment [Nm] generated by the tire at 25 deg of slip angle';
COMMENT ON COLUMN "Pacejka_TireModel"."RollingResistFactor" IS 'A linear quality factor used to place this tire''s rolling resistance relative to other tires of the same type';
COMMENT ON COLUMN "Pacejka_TireModel"."GrowthFactor" IS 'Growth in tire diameter in mm per 100 g''s of centrifugal acceleration';
COMMENT ON COLUMN "Pacejka_TireModel"."PeakFriction" IS 'Peak friction coefficient of the tire';
COMMENT ON COLUMN "Pacejka_TireModel"."CamberCoefficient" IS 'Camber coefficient of the tire in kg of lateral force produced per kg of normal load per degree of slip angle [kg/kg/deg]';
COMMENT ON COLUMN "Pacejka_TireModel"."SectionWidth" IS 'Section width [mm] of the tire that the tire model is based upon';

-- CREATE INDEXES ...
ALTER TABLE "Pacejka_TireModel" ADD CONSTRAINT "Pacejka_TireModel_pkey" PRIMARY KEY ("TireTypeID");

CREATE TABLE "Physics"
 (
	"PartTypeID"			INTEGER NOT NULL, 
	"Ordinal"			INTEGER NOT NULL, 
	"StatusID"			INTEGER, 
	"DutyRating"			INTEGER, 
	"MaxItemWear"			INTEGER, 
	"Mass"			DOUBLE PRECISION, 
	"Val1"			DOUBLE PRECISION, 
	"Val2"			DOUBLE PRECISION, 
	"Val3"			DOUBLE PRECISION, 
	"Val4"			DOUBLE PRECISION, 
	"Val5"			DOUBLE PRECISION, 
	"Val6"			DOUBLE PRECISION, 
	"Val7"			DOUBLE PRECISION, 
	"Val8"			DOUBLE PRECISION, 
	"Val9"			DOUBLE PRECISION, 
	"Val10"			DOUBLE PRECISION, 
	"Val11"			DOUBLE PRECISION, 
	"Val12"			DOUBLE PRECISION, 
	"Val13"			DOUBLE PRECISION, 
	"Val14"			DOUBLE PRECISION, 
	"Val15"			DOUBLE PRECISION, 
	"Val16"			DOUBLE PRECISION, 
	"Val17"			DOUBLE PRECISION, 
	"Val18"			DOUBLE PRECISION, 
	"Val19"			DOUBLE PRECISION, 
	"Val20"			DOUBLE PRECISION, 
	"Val21"			DOUBLE PRECISION, 
	"Val22"			DOUBLE PRECISION, 
	"Val23"			DOUBLE PRECISION, 
	"Val24"			DOUBLE PRECISION, 
	"Val25"			DOUBLE PRECISION, 
	"Val26"			DOUBLE PRECISION, 
	"Val27"			DOUBLE PRECISION, 
	"Val28"			DOUBLE PRECISION, 
	"Val29"			DOUBLE PRECISION, 
	"Val30"			DOUBLE PRECISION, 
	"Val31"			DOUBLE PRECISION, 
	"Val32"			DOUBLE PRECISION, 
	"Val33"			DOUBLE PRECISION, 
	"Val34"			DOUBLE PRECISION, 
	"Val35"			DOUBLE PRECISION, 
	"Val36"			DOUBLE PRECISION, 
	"Val37"			DOUBLE PRECISION, 
	"Val38"			DOUBLE PRECISION, 
	"Val39"			DOUBLE PRECISION, 
	"Val40"			DOUBLE PRECISION, 
	"Val41"			DOUBLE PRECISION, 
	"Val42"			DOUBLE PRECISION, 
	"Val43"			DOUBLE PRECISION, 
	"Val44"			DOUBLE PRECISION, 
	"Val45"			DOUBLE PRECISION, 
	"Val46"			DOUBLE PRECISION, 
	"Val47"			DOUBLE PRECISION, 
	"Val48"			DOUBLE PRECISION, 
	"Val49"			DOUBLE PRECISION, 
	"Val50"			DOUBLE PRECISION, 
	"TextVal1"			VARCHAR (20), 
	"TextVal2"			VARCHAR (20), 
	"TextVal3"			VARCHAR (20), 
	"TextVal4"			VARCHAR (20), 
	"TextVal5"			VARCHAR (20), 
	"TextVal6"			VARCHAR (20), 
	"TextVal7"			VARCHAR (20), 
	"TextVal8"			VARCHAR (20)
);

-- CREATE INDEXES ...
CREATE INDEX "Physics_Ordinal_idx" ON "Physics" ("Ordinal");
CREATE INDEX "Physics_PartTypeID_idx" ON "Physics" ("PartTypeID");
ALTER TABLE "Physics" ADD CONSTRAINT "Physics_pkey" PRIMARY KEY ("PartTypeID", "Ordinal");

CREATE TABLE "PhysicsStatus"
 (
	"StatusID"			INTEGER, 
	"Status"			VARCHAR (50)
);

-- CREATE INDEXES ...
ALTER TABLE "PhysicsStatus" ADD CONSTRAINT "PhysicsStatus_pkey" PRIMARY KEY ("StatusID");

CREATE TABLE "RaceTemplate"
 (
	"RaceTemplateID"			INTEGER NOT NULL, 
	"Laps"			SMALLINT NOT NULL, 
	"Backward"			BOOL NOT NULL, 
	"Mirrored"			BOOL NOT NULL, 
	"NightDriving"			BOOL NOT NULL, 
	"Weather"			BOOL NOT NULL, 
	"DifficultyRating"			INTEGER NOT NULL, 
	"RaceName"			VARCHAR (100)
);

-- CREATE INDEXES ...
ALTER TABLE "RaceTemplate" ADD CONSTRAINT "RaceTemplate_pkey" PRIMARY KEY ("RaceTemplateID");

CREATE TABLE "Street"
 (
	"ZoneID"			INTEGER NOT NULL, 
	"StreetNum"			INTEGER NOT NULL, 
	"Street"			VARCHAR (100)
);

-- CREATE INDEXES ...
CREATE INDEX "Street_StreetNum_idx" ON "Street" ("StreetNum");
CREATE INDEX "Street_ZoneID_idx" ON "Street" ("ZoneID");

CREATE TABLE "TrackSpeedRecord"
 (
	"TrackSpeedRecordID"			SERIAL, 
	"PersonaID"			INTEGER, 
	"PlayerName"			VARCHAR (30) NOT NULL, 
	"TopSpeed"			INTEGER NOT NULL, 
	"TrackID"			INTEGER NOT NULL, 
	"CarBrandedPartID"			INTEGER NOT NULL, 
	"Flags"			INTEGER
);

-- CREATE INDEXES ...
ALTER TABLE "TrackSpeedRecord" ADD CONSTRAINT "TrackSpeedRecord_pkey" PRIMARY KEY ("TrackSpeedRecordID");

CREATE TABLE "VehicleHistory"
 (
	"TrackID"			INTEGER, 
	"VehicleID"			INTEGER, 
	"RaceTime"			TIMESTAMP WITHOUT TIME ZONE, 
	"OppNum"			INTEGER, 
	"Place"			INTEGER, 
	"PlayerID"			INTEGER
);

-- CREATE INDEXES ...


-- CREATE Relationships ...
ALTER TABLE "AbstractAssembliesList" ADD CONSTRAINT "AbstractAssembliesList_AbstractTypeID_fk" FOREIGN KEY ("AbstractTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "CatalogIndexLevel" ADD CONSTRAINT "CatalogIndexLevel_AbstractPartTypeID_fk" FOREIGN KEY ("AbstractPartTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "CatalogIndexSubDivision" ADD CONSTRAINT "CatalogIndexSubDivision_AbstractPartTypeID_fk" FOREIGN KEY ("AbstractPartTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "PartType" ADD CONSTRAINT "PartType_AbstractPartTypeID_fk" FOREIGN KEY ("AbstractPartTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "StockAssembly" ADD CONSTRAINT "StockAssembly_AttachmentPointID_fk" FOREIGN KEY ("AttachmentPointID") REFERENCES "AttachmentPoint"("AttachmentPointID");
ALTER TABLE "Badge" ADD CONSTRAINT "Badge_BadgeTypeID_fk" FOREIGN KEY ("BadgeTypeID") REFERENCES "BadgeType"("BadgeTypeID") ON UPDATE CASCADE;
ALTER TABLE "Part" ADD CONSTRAINT "Part_BrandedPartID_fk" FOREIGN KEY ("BrandedPartID") REFERENCES "BrandedPart"("BrandedPartID");
ALTER TABLE "StockAssembly" ADD CONSTRAINT "StockAssembly_ChildBrandedPartID_fk" FOREIGN KEY ("ChildBrandedPartID") REFERENCES "BrandedPart"("BrandedPartID");
ALTER TABLE "StockAssembly" ADD CONSTRAINT "StockAssembly_ParentBrandedPartID_fk" FOREIGN KEY ("ParentBrandedPartID") REFERENCES "BrandedPart"("BrandedPartID");
ALTER TABLE "StockVehicleAttributes" ADD CONSTRAINT "StockVehicleAttributes_BrandedPartID_fk" FOREIGN KEY ("BrandedPartID") REFERENCES "BrandedPart"("BrandedPartID") ON DELETE CASCADE;
ALTER TABLE "StockVehicleAttributes" ADD CONSTRAINT "StockVehicleAttributes_VinBrandedPartID_fk" FOREIGN KEY ("VinBrandedPartID") REFERENCES "BrandedPart"("BrandedPartID");
ALTER TABLE "CatalogIndexLevel" ADD CONSTRAINT "CatalogIndexLevel_CatalogCriteriaMethodID_fk" FOREIGN KEY ("CatalogCriteriaMethodID") REFERENCES "CatalogCriteriaMethod"("CatalogCriteriaMethodID") ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE "Player" ADD CONSTRAINT "Player_StockMuscleClass_fk" FOREIGN KEY ("StockMuscleClass") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_ModifiedClassicClass_fk" FOREIGN KEY ("ModifiedClassicClass") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_ModifiedMuscleClass_fk" FOREIGN KEY ("ModifiedMuscleClass") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_OutlawClass_fk" FOREIGN KEY ("OutlawClass") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_DragClass_fk" FOREIGN KEY ("DragClass") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Season" ADD CONSTRAINT "Season_DriverClassID_fk" FOREIGN KEY ("DriverClassID") REFERENCES "DriverClass"("DriverClassID");
ALTER TABLE "Race" ADD CONSTRAINT "Race_TrackID_fk" FOREIGN KEY ("TrackID") REFERENCES "Element"("ElementID");
ALTER TABLE "RaceHistory" ADD CONSTRAINT "RaceHistory_TrackID_fk" FOREIGN KEY ("TrackID") REFERENCES "Element"("ElementID");
ALTER TABLE "TrackLapTimeRecord" ADD CONSTRAINT "TrackLapTimeRecord_TrackID_fk" FOREIGN KEY ("TrackID") REFERENCES "Element"("ElementID");
ALTER TABLE "TrackSpeedRecord" ADD CONSTRAINT "TrackSpeedRecord_TrackID_fk" FOREIGN KEY ("TrackID") REFERENCES "Element"("ElementID");
ALTER TABLE "EventInvitation" ADD CONSTRAINT "EventInvitation_EventID_fk" FOREIGN KEY ("EventID") REFERENCES "Event"("EventID") ON DELETE CASCADE;
ALTER TABLE "GameConfiguration" ADD CONSTRAINT "GameConfiguration_ConfigurationTypeID_fk" FOREIGN KEY ("ConfigurationTypeID") REFERENCES "GameConfigurationType"("ConfigurationTypeID");
ALTER TABLE "BrandedPart" ADD CONSTRAINT "BrandedPart_ModelID_fk" FOREIGN KEY ("ModelID") REFERENCES "Model"("ModelID");
ALTER TABLE "PartType" ADD CONSTRAINT "PartType_PartGradeID_fk" FOREIGN KEY ("PartGradeID") REFERENCES "PartGrade"("PartGradeID");
ALTER TABLE "BrandedPart" ADD CONSTRAINT "BrandedPart_PartTypeID_fk" FOREIGN KEY ("PartTypeID") REFERENCES "PartType"("PartTypeID");
ALTER TABLE "Physics" ADD CONSTRAINT "Physics_PartTypeID_fk" FOREIGN KEY ("PartTypeID") REFERENCES "PartType"("PartTypeID") ON DELETE CASCADE;
ALTER TABLE "PTSkin" ADD CONSTRAINT "PTSkin_PartTypeID_fk" FOREIGN KEY ("PartTypeID") REFERENCES "PartType"("PartTypeID");
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_VehicleID_fk" FOREIGN KEY ("VehicleID") REFERENCES "Part"("PartID") ON DELETE CASCADE;
ALTER TABLE "Vehicle" ADD CONSTRAINT "Vehicle_SkinID_fk" FOREIGN KEY ("SkinID") REFERENCES "PTSkin"("SkinID");
ALTER TABLE "Model" ADD CONSTRAINT "Model_BrandID_fk" FOREIGN KEY ("BrandID") REFERENCES "Brand"("BrandID");
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_VehicleID_fk" FOREIGN KEY ("VehicleID") REFERENCES "Vehicle"("VehicleID");
ALTER TABLE "Racer" ADD CONSTRAINT "Racer_VehicleID_fk" FOREIGN KEY ("VehicleID") REFERENCES "Vehicle"("VehicleID");
ALTER TABLE "Junkyard" ADD CONSTRAINT "Junkyard_VehicleID_fk" FOREIGN KEY ("VehicleID") REFERENCES "Vehicle"("VehicleID");
ALTER TABLE "AbstractPartType" ADD CONSTRAINT "AbstractPartType_DependsOn_fk" FOREIGN KEY ("DependsOn") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "Season" ADD CONSTRAINT "Season_RaceTypeID_fk" FOREIGN KEY ("RaceTypeID") REFERENCES "RaceType"("RaceTypeID");
ALTER TABLE "SeasonRacer" ADD CONSTRAINT "SeasonRacer_SeasonID_fk" FOREIGN KEY ("SeasonID") REFERENCES "Season"("SeasonID");
ALTER TABLE "Event" ADD CONSTRAINT "Event_RaceTypeID_fk" FOREIGN KEY ("RaceTypeID") REFERENCES "RaceType"("RaceTypeID");
ALTER TABLE "EventInvitation" ADD CONSTRAINT "EventInvitation_EventStatusID_fk" FOREIGN KEY ("EventStatusID") REFERENCES "EventStatus"("EventStatusID");
ALTER TABLE "Event" ADD CONSTRAINT "Event_EventStatusID_fk" FOREIGN KEY ("EventStatusID") REFERENCES "EventStatus"("EventStatusID");
ALTER TABLE "APTDealershipAudio" ADD CONSTRAINT "APTDealershipAudio_AbstractPartTypeID_fk" FOREIGN KEY ("AbstractPartTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_TrackID_fk" FOREIGN KEY ("TrackID") REFERENCES "Element"("ElementID");
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_HubID_fk" FOREIGN KEY ("HubID") REFERENCES "Element"("ElementID");
ALTER TABLE "AbstractPartType" ADD CONSTRAINT "AbstractPartType_ParentAbstractPartTypeID_fk" FOREIGN KEY ("ParentAbstractPartTypeID") REFERENCES "AbstractPartType"("AbstractPartTypeID");
ALTER TABLE "Part" ADD CONSTRAINT "Part_ParentPartID_fk" FOREIGN KEY ("ParentPartID") REFERENCES "Part"("PartID");
ALTER TABLE "PartTypeCompatibility" ADD CONSTRAINT "PartTypeCompatibility_ChildPartTypeID_fk" FOREIGN KEY ("ChildPartTypeID") REFERENCES "PartType"("PartTypeID");
ALTER TABLE "PartTypeCompatibility" ADD CONSTRAINT "PartTypeCompatibility_ParentPartTypeID_fk" FOREIGN KEY ("ParentPartTypeID") REFERENCES "PartType"("PartTypeID");
ALTER TABLE "Player" ADD CONSTRAINT "Player_PlayerTypeID_fk" FOREIGN KEY ("PlayerTypeID") REFERENCES "PlayerType"("PlayerTypeID");
ALTER TABLE "Racer" ADD CONSTRAINT "Racer_RaceID_fk" FOREIGN KEY ("RaceID") REFERENCES "Race"("RaceID");
ALTER TABLE "Race" ADD CONSTRAINT "Race_RaceStateID_fk" FOREIGN KEY ("RaceStateID") REFERENCES "RaceState"("RaceStateID");
ALTER TABLE "Race" ADD CONSTRAINT "Race_RaceTypeID_fk" FOREIGN KEY ("RaceTypeID") REFERENCES "RaceType"("RaceTypeID");
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_RaceTypeID_fk" FOREIGN KEY ("RaceTypeID") REFERENCES "RaceType"("RaceTypeID");
ALTER TABLE "GameRecord" ADD CONSTRAINT "GameRecord_RecordTypeID_fk" FOREIGN KEY ("RecordTypeID") REFERENCES "RecordType"("RecordTypeID");
ALTER TABLE "Part" ADD CONSTRAINT "Part_AttachmentPointID_fk" FOREIGN KEY ("AttachmentPointID") REFERENCES "AttachmentPoint"("AttachmentPointID");
ALTER TABLE "PTSkin" ADD CONSTRAINT "PTSkin_SkinTypeID_fk" FOREIGN KEY ("SkinTypeID") REFERENCES "SkinType"("SkinTypeID");
ALTER TABLE "StockVehicleAttributes" ADD CONSTRAINT "StockVehicleAttributes_CarClass_fk" FOREIGN KEY ("CarClass") REFERENCES "SVA_CarClass"("SVA_CarClass");
ALTER TABLE "StockVehicleAttributes" ADD CONSTRAINT "StockVehicleAttributes_ModeRestriction_fk" FOREIGN KEY ("ModeRestriction") REFERENCES "SVA_ModeRestriction"("SVA_ModeRestriction") ON UPDATE CASCADE ON DELETE CASCADE;