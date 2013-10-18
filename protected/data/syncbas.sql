DROP TYPE _tag_place;

DROP TYPE _user_place;

DROP TYPE _user_settings;

DROP TYPE _user_social;

DROP TYPE "_AuthAssignment";

DROP TYPE "_AuthItem";

DROP TYPE "_AuthItemChild";

DROP TYPE _content;

DROP TYPE _cron_mail;

DROP TYPE _favorite;

DROP TYPE _message;

DROP TYPE _post;

DROP TYPE _post_name_user;

DROP TYPE _smtp;

DROP TYPE _tag;

DROP TYPE _tag_post;

DROP TYPE _user;

ALTER TABLE "user_feed_external"
	SET TABLESPACE pg_default;

ALTER TABLE "media"
	SET TABLESPACE pg_default;

ALTER TABLE "feed_external_item"
	SET TABLESPACE pg_default;

ALTER TABLE "feed_external"
	SET TABLESPACE pg_default;

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

CREATE TABLE "public"."_pgmdd_backup_message_2013-18-10_13:57" AS
	SELECT * FROM public.message;

ALTER TABLE "message" 
	ALTER COLUMN "read_at" TYPE timestamp;

ALTER TABLE "message" 
	ADD COLUMN "from_deleted_at" timestamp;

ALTER TABLE "message" 
	ADD COLUMN "to_deleted_at" timestamp;

ALTER TABLE "public"."message" 
	DROP COLUMN "from_deleted" CASCADE;

ALTER TABLE "public"."message" 
	DROP COLUMN "to_deleted" CASCADE;

ALTER TABLE "public"."message" 
	DROP COLUMN "is_new" CASCADE;

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

