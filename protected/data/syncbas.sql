

































ALTER TABLE "media"
	SET TABLESPACE pg_default;

CREATE TABLE "public"."_pgmdd_backup_feed_external_item_2013-16-10_21:59" AS
	SELECT * FROM public.feed_external_item;

ALTER TABLE "feed_external_item" ALTER COLUMN "feed_external_id" SET NOT NULL;

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

CREATE TABLE "user_feed_external" (
	"id" SERIAL NOT NULL,
	"user_id" int4 NOT NULL,
	"last_published_id" int4,
	"feed_external_id" int4 NOT NULL,
	"created_at" timestamp NOT NULL DEFAULT NOW(),
	"updated_at" timestamp,
  PRIMARY KEY("id")
);


ALTER TABLE "user_feed_external" OWNER TO "placemeup";

ALTER TABLE "user_feed_external"
   ADD CONSTRAINT "Ref_user_feed_external_to_user" FOREIGN KEY ("user_id")
    REFERENCES "user"("id")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
      NOT DEFERRABLE,
   ADD CONSTRAINT "Ref_user_feed_external_to_feed_external" FOREIGN KEY ("feed_external_id")
    REFERENCES "feed_external"("id")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
      NOT DEFERRABLE;

