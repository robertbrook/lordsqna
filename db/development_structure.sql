CREATE TABLE "answer_groups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "anchor" varchar(255) DEFAULT NULL, "date" date DEFAULT NULL, "minor_subject_id" integer DEFAULT NULL, "subject_id" integer DEFAULT NULL, "url" varchar(255) DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE "answers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "member" varchar(255) DEFAULT NULL, "answer_group_id" integer DEFAULT NULL, "role" varchar(255) DEFAULT NULL, "text" varchar(255) DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE "questions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "member" varchar(255) DEFAULT NULL, "text" varchar(255) DEFAULT NULL, "uin" varchar(255) DEFAULT NULL, "answer_id" integer DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "subjects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");