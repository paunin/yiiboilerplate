

































ALTER TABLE "token"
	SET TABLESPACE pg_default;

ALTER TABLE "application"
	SET TABLESPACE pg_default;

ALTER TABLE "user_social"
	SET TABLESPACE pg_default;

ALTER TABLE "user_settings"
	SET TABLESPACE pg_default;

ALTER TABLE "user_place"
	SET TABLESPACE pg_default;

CREATE TABLE "public"."_pgmdd_backup_user_2013-12-10_20:57" AS
	SELECT * FROM public.user;

ALTER TABLE "user" 
	RENAME COLUMN "avatar_hash" TO "avatar_name";

ALTER TABLE "user"
	SET TABLESPACE pg_default;

ALTER TABLE "tag_post"
	SET TABLESPACE pg_default;

ALTER TABLE "tag_place"
	SET TABLESPACE pg_default;

ALTER TABLE "tag"
	SET TABLESPACE pg_default;

ALTER TABLE "smtp"
	SET TABLESPACE pg_default;

ALTER TABLE "post_name_user"
	SET TABLESPACE pg_default;

ALTER TABLE "post"
	SET TABLESPACE pg_default;

ALTER TABLE "message"
	SET TABLESPACE pg_default;

ALTER TABLE "favorite"
	SET TABLESPACE pg_default;

ALTER TABLE "cron_mail"
	SET TABLESPACE pg_default;

ALTER TABLE "content"
	SET TABLESPACE pg_default;

ALTER TABLE "AuthItemChild"
	SET TABLESPACE pg_default;

ALTER TABLE "AuthItem"
	SET TABLESPACE pg_default;

ALTER TABLE "AuthAssignment"
	SET TABLESPACE pg_default;

