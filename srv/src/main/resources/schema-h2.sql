
DROP VIEW IF EXISTS DevChallengeService_DraftAdministrativeData;
DROP VIEW IF EXISTS DevChallengeService_Questions_answers;
DROP VIEW IF EXISTS DevChallengeService_Questions;
DROP VIEW IF EXISTS DevChallengeService_Tests;
DROP TABLE IF EXISTS DevChallengeService_Questions_answers_drafts;
DROP TABLE IF EXISTS DevChallengeService_Questions_drafts;
DROP TABLE IF EXISTS DevChallengeService_Tests_drafts;
DROP TABLE IF EXISTS DRAFT_DraftAdministrativeData;
DROP TABLE IF EXISTS fullstack_dev_challenge_Questions_answers;
DROP TABLE IF EXISTS fullstack_dev_challenge_Questions;
DROP TABLE IF EXISTS fullstack_dev_challenge_Tests;

CREATE TABLE fullstack_dev_challenge_Tests (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  title NVARCHAR(30),
  description NVARCHAR(111),
  PRIMARY KEY(ID)
); 

CREATE TABLE fullstack_dev_challenge_Questions (
  ID NVARCHAR(36) NOT NULL,
  text NVARCHAR(111),
  test_ID NVARCHAR(36),
  PRIMARY KEY(ID)
); 

CREATE TABLE fullstack_dev_challenge_Questions_answers (
  up__ID NVARCHAR(36) NOT NULL,
  ID NVARCHAR(36) NOT NULL,
  text NVARCHAR(255),
  PRIMARY KEY(up__ID, ID)
); 

CREATE TABLE DRAFT_DraftAdministrativeData (
  DraftUUID NVARCHAR(36) NOT NULL,
  CreationDateTime TIMESTAMP(7),
  CreatedByUser NVARCHAR(256),
  DraftIsCreatedByMe BOOLEAN,
  LastChangeDateTime TIMESTAMP(7),
  LastChangedByUser NVARCHAR(256),
  InProcessByUser NVARCHAR(256),
  DraftIsProcessedByMe BOOLEAN,
  PRIMARY KEY(DraftUUID)
); 

CREATE TABLE DevChallengeService_Tests_drafts (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7) NULL,
  createdBy NVARCHAR(255) NULL,
  modifiedAt TIMESTAMP(7) NULL,
  modifiedBy NVARCHAR(255) NULL,
  title NVARCHAR(30) NULL,
  description NVARCHAR(111) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
); 

CREATE TABLE DevChallengeService_Questions_drafts (
  ID NVARCHAR(36) NOT NULL,
  text NVARCHAR(111) NULL,
  test_ID NVARCHAR(36) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
); 

CREATE TABLE DevChallengeService_Questions_answers_drafts (
  up__ID NVARCHAR(36) NOT NULL,
  ID NVARCHAR(36) NOT NULL,
  text NVARCHAR(255) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(up__ID, ID)
); 

CREATE VIEW DevChallengeService_Tests AS SELECT
  Tests_0.ID,
  Tests_0.createdAt,
  Tests_0.createdBy,
  Tests_0.modifiedAt,
  Tests_0.modifiedBy,
  Tests_0.title,
  Tests_0.description
FROM fullstack_dev_challenge_Tests AS Tests_0; 

CREATE VIEW DevChallengeService_Questions AS SELECT
  Questions_0.ID,
  Questions_0.text,
  Questions_0.test_ID
FROM fullstack_dev_challenge_Questions AS Questions_0; 

CREATE VIEW DevChallengeService_Questions_answers AS SELECT
  answers_0.up__ID,
  answers_0.ID,
  answers_0.text
FROM fullstack_dev_challenge_Questions_answers AS answers_0; 

CREATE VIEW DevChallengeService_DraftAdministrativeData AS SELECT
  DraftAdministrativeData.DraftUUID,
  DraftAdministrativeData.CreationDateTime,
  DraftAdministrativeData.CreatedByUser,
  DraftAdministrativeData.DraftIsCreatedByMe,
  DraftAdministrativeData.LastChangeDateTime,
  DraftAdministrativeData.LastChangedByUser,
  DraftAdministrativeData.InProcessByUser,
  DraftAdministrativeData.DraftIsProcessedByMe
FROM DRAFT_DraftAdministrativeData AS DraftAdministrativeData; 

