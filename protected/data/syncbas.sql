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

CREATE TABLE "public"."_pgmdd_backup_tag_place_2013-11-10_14:40" AS
	SELECT * FROM public.tag_place;

ALTER TABLE "tag_place" 
	ADD COLUMN "weight" int4
		NOT NULL
		DEFAULT 1;

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

