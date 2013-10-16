--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: AuthAssignment; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "AuthAssignment" (
    itemname character varying(64) NOT NULL,
    userid character varying(64) NOT NULL,
    bizrule text,
    data text
);


--
-- Name: AuthItem; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "AuthItem" (
    name character varying(64) NOT NULL,
    type integer NOT NULL,
    description text,
    bizrule text,
    data text
);


--
-- Name: AuthItemChild; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "AuthItemChild" (
    parent character varying(64) NOT NULL,
    child character varying(64) NOT NULL
);


--
-- Name: application; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE application (
    id integer NOT NULL,
    slug character varying(128) NOT NULL,
    name character varying(512) NOT NULL,
    description text,
    secret_key character varying(128) NOT NULL,
    publick_key character varying(128) NOT NULL,
    return_uri character varying(512),
    access_control_allow_origin character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: application_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE application_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE application_id_seq OWNED BY application.id;


--
-- Name: application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('application_id_seq', 3, true);


--
-- Name: content; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE content (
    id integer NOT NULL,
    title character varying(512) NOT NULL,
    slug character varying(255) NOT NULL,
    text text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE content_id_seq OWNED BY content.id;


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('content_id_seq', 100, false);


--
-- Name: cron_mail; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cron_mail (
    id integer NOT NULL,
    subject character varying(255) DEFAULT NULL::character varying,
    body text NOT NULL,
    body_alt text,
    to_mail character varying(512) NOT NULL,
    to_name character varying(512) DEFAULT NULL::character varying,
    from_mail character varying(512) NOT NULL,
    from_name character varying(512) DEFAULT NULL::character varying,
    is_sent boolean DEFAULT false NOT NULL,
    attachment_file character varying(512) DEFAULT NULL::character varying,
    attachment_name character varying(512) DEFAULT NULL::character varying
);


--
-- Name: cron_mail_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cron_mail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: cron_mail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cron_mail_id_seq OWNED BY cron_mail.id;


--
-- Name: cron_mail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cron_mail_id_seq', 1, false);


--
-- Name: favorite; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE favorite (
    id integer NOT NULL,
    user_id integer NOT NULL,
    favorite_id integer,
    type character varying(128),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: COLUMN favorite.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN favorite.type IS 'type of user favorite - users, posts, messages, etc';


--
-- Name: favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE favorite_id_seq OWNED BY favorite.id;


--
-- Name: favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('favorite_id_seq', 1, false);


--
-- Name: feed_external; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feed_external (
    id integer NOT NULL,
    parser_type character varying(164),
    name character varying(256),
    url character varying(1024),
    last_parsing timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    is_active boolean DEFAULT true NOT NULL
);


--
-- Name: COLUMN feed_external.parser_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN feed_external.parser_type IS 'rss, rss2, parser_sample,
vkontakte_user';


--
-- Name: feed_external_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feed_external_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: feed_external_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feed_external_id_seq OWNED BY feed_external.id;


--
-- Name: feed_external_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('feed_external_id_seq', 3, true);


--
-- Name: feed_external_item; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE feed_external_item (
    id integer NOT NULL,
    url character varying(2000) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    feed_external_id integer NOT NULL,
    title character varying(512),
    text text NOT NULL,
    date timestamp without time zone,
    updated_at timestamp without time zone,
    guid character varying(256)
);


--
-- Name: feed_external_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE feed_external_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: feed_external_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE feed_external_item_id_seq OWNED BY feed_external_item.id;


--
-- Name: feed_external_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('feed_external_item_id_seq', 310, true);


--
-- Name: media; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE media (
    id integer NOT NULL,
    type character varying NOT NULL,
    source character varying NOT NULL,
    data text
);


--
-- Name: COLUMN media.type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN media.type IS 'image
url
youtube';


--
-- Name: COLUMN media.source; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN media.source IS 'urls or ids';


--
-- Name: COLUMN media.data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN media.data IS 'serialized data for source';


--
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE media_id_seq OWNED BY media.id;


--
-- Name: media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('media_id_seq', 1, false);


--
-- Name: message; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE message (
    id integer NOT NULL,
    to_user_id integer NOT NULL,
    from_user_id integer,
    is_new boolean DEFAULT true NOT NULL,
    subject character varying(1024),
    text text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    read_at integer,
    to_deleted boolean DEFAULT false NOT NULL,
    from_deleted boolean DEFAULT false NOT NULL
);


--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE message_id_seq OWNED BY message.id;


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('message_id_seq', 1, false);


--
-- Name: post; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post (
    id integer NOT NULL,
    user_id integer,
    subject character varying(2048),
    text text NOT NULL,
    is_media boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    cx bigint,
    cy bigint,
    cx_p_cy bigint,
    cx_m_cy bigint,
    post_id integer,
    deleted_at timestamp without time zone
);


--
-- Name: TABLE post; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE post IS 'Users post';


--
-- Name: COLUMN post.post_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN post.post_id IS 'only two level tree';


--
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE post_id_seq OWNED BY post.id;


--
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('post_id_seq', 1, false);


--
-- Name: post_name_user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE post_name_user (
    post_id integer NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: smtp; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE smtp (
    id integer NOT NULL,
    host character varying NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    port character varying,
    encryption character varying,
    timeout character varying,
    "extensionHandlers" character varying,
    using_count integer DEFAULT 0 NOT NULL,
    banned integer DEFAULT 0 NOT NULL
);


--
-- Name: smtp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE smtp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: smtp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE smtp_id_seq OWNED BY smtp.id;


--
-- Name: smtp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('smtp_id_seq', 1, false);


--
-- Name: tag; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tag (
    id integer NOT NULL,
    name character varying(512) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tag_id_seq OWNED BY tag.id;


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tag_id_seq', 9, true);


--
-- Name: tag_place; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tag_place (
    id integer NOT NULL,
    user_id integer NOT NULL,
    tag_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    cx bigint NOT NULL,
    cy bigint NOT NULL,
    cx_p_cy bigint NOT NULL,
    cx_m_cy bigint NOT NULL,
    weight integer DEFAULT 1 NOT NULL
);


--
-- Name: tag_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tag_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tag_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tag_place_id_seq OWNED BY tag_place.id;


--
-- Name: tag_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('tag_place_id_seq', 2480, true);


--
-- Name: tag_post; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tag_post (
    post_id integer NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: token; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE token (
    id integer NOT NULL,
    application_id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(128) NOT NULL,
    expire_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE token_id_seq OWNED BY token.id;


--
-- Name: token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('token_id_seq', 1, false);


--
-- Name: user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying,
    key character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    role character varying DEFAULT 'user'::character varying NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    last_login timestamp without time zone,
    password character varying(255),
    avatar_name character varying(128),
    last_name character varying(128),
    middle_name character varying(128),
    first_name character varying(128)
);


--
-- Name: user_feed_external; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_feed_external (
    id integer NOT NULL,
    user_id integer NOT NULL,
    last_published_id integer,
    feed_external_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone
);


--
-- Name: user_feed_external_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_feed_external_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_feed_external_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_feed_external_id_seq OWNED BY user_feed_external.id;


--
-- Name: user_feed_external_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_feed_external_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_id_seq', 10000, true);


--
-- Name: user_place; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_place (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(512) DEFAULT 'Some place...'::character varying,
    cx bigint NOT NULL,
    cy bigint NOT NULL,
    cx_p_cy bigint NOT NULL,
    cx_m_cy bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone,
    radius integer,
    permissions integer NOT NULL,
    is_spirit boolean DEFAULT true NOT NULL
);


--
-- Name: COLUMN user_place.permissions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN user_place.permissions IS 'bits
1 = ?
10 = r
100 = w
1000 = ...';


--
-- Name: user_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_place_id_seq OWNED BY user_place.id;


--
-- Name: user_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_place_id_seq', 1915, true);


--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_settings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    radius bigint
);


--
-- Name: COLUMN user_settings.radius; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN user_settings.radius IS 'user area radius';


--
-- Name: user_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_settings_id_seq OWNED BY user_settings.id;


--
-- Name: user_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_settings_id_seq', 6, true);


--
-- Name: user_social; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_social (
    id integer NOT NULL,
    user_id integer NOT NULL,
    social_service character varying NOT NULL,
    user_social_id character varying NOT NULL,
    additional_data text
);


--
-- Name: TABLE user_social; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE user_social IS 'users from social accounts linked to users';


--
-- Name: user_social_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_social_id_seq
    START WITH 100
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: user_social_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_social_id_seq OWNED BY user_social.id;


--
-- Name: user_social_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_social_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE application ALTER COLUMN id SET DEFAULT nextval('application_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE content ALTER COLUMN id SET DEFAULT nextval('content_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE cron_mail ALTER COLUMN id SET DEFAULT nextval('cron_mail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE favorite ALTER COLUMN id SET DEFAULT nextval('favorite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE feed_external ALTER COLUMN id SET DEFAULT nextval('feed_external_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE feed_external_item ALTER COLUMN id SET DEFAULT nextval('feed_external_item_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE media ALTER COLUMN id SET DEFAULT nextval('media_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE message ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE post ALTER COLUMN id SET DEFAULT nextval('post_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE smtp ALTER COLUMN id SET DEFAULT nextval('smtp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tag ALTER COLUMN id SET DEFAULT nextval('tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE tag_place ALTER COLUMN id SET DEFAULT nextval('tag_place_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE token ALTER COLUMN id SET DEFAULT nextval('token_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE user_feed_external ALTER COLUMN id SET DEFAULT nextval('user_feed_external_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE user_place ALTER COLUMN id SET DEFAULT nextval('user_place_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE user_settings ALTER COLUMN id SET DEFAULT nextval('user_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE user_social ALTER COLUMN id SET DEFAULT nextval('user_social_id_seq'::regclass);


--
-- Data for Name: AuthAssignment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthAssignment" (itemname, userid, bizrule, data) FROM stdin;
admin	2	\N	\N
user	3	\N	\N
user	4	\N	\N
user	5	\N	\N
user	6	\N	\N
user	7	\N	\N
user	8	\N	\N
user	9	\N	\N
user	10	\N	\N
user	11	\N	\N
user	12	\N	\N
user	13	\N	\N
user	14	\N	\N
user	15	\N	\N
user	16	\N	\N
user	17	\N	\N
user	18	\N	\N
user	19	\N	\N
user	20	\N	\N
user	21	\N	\N
user	22	\N	\N
user	23	\N	\N
\.


--
-- Data for Name: AuthItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthItem" (name, type, description, bizrule, data) FROM stdin;
admin	2	Admin	\N	N;
user	2	User	\N	N;
filemanager	2	Filemanager	\N	N;
\.


--
-- Data for Name: AuthItemChild; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthItemChild" (parent, child) FROM stdin;
admin	user
admin	filemanager
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: -
--

COPY application (id, slug, name, description, secret_key, publick_key, return_uri, access_control_allow_origin, created_at, updated_at, is_active) FROM stdin;
3	placemeup	PlaceMeUp.com application	PlaceMeUp.com application	_pmu_secret	_pmu_public	\N	\N	2013-10-09 21:27:49.159	\N	t
\.


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY content (id, title, slug, text, created_at, updated_at) FROM stdin;
2	Тестовый контент 1	content_slug_1	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
3	Тестовый контент 2	content_slug_2	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
4	Тестовый контент 3	content_slug_3	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
5	Тестовый контент 4	content_slug_4	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
\.


--
-- Data for Name: cron_mail; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cron_mail (id, subject, body, body_alt, to_mail, to_name, from_mail, from_name, is_sent, attachment_file, attachment_name) FROM stdin;
\.


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: public; Owner: -
--

COPY favorite (id, user_id, favorite_id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: feed_external; Type: TABLE DATA; Schema: public; Owner: -
--

COPY feed_external (id, parser_type, name, url, last_parsing, created_at, updated_at, is_active) FROM stdin;
1	rss2	you2you rss 2.0	http://www.you2you.ru/rss	2013-10-16 19:02:12	2013-10-16 20:24:37.151	\N	t
2	rss2	zodroid.ru	http://zodroid.ru/content/rss/	2013-10-16 19:02:14	2013-10-16 21:31:37.695	\N	t
3	rss2	politprofi.ru	http://politprofi.ru/rss	2013-10-16 19:02:15	2013-10-16 21:33:58.346	\N	t
\.


--
-- Data for Name: feed_external_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY feed_external_item (id, url, created_at, feed_external_id, title, text, date, updated_at, guid) FROM stdin;
156	http://www.you2you.ru/news/kompaniya-canon-vyipustit-novyiy-zerkalnyiy-fotoapparat-canon-7d-mark-ii	2013-10-16 19:02:08	1	​Компания Canon выпустит новый зеркальный фотоаппарат Canon 7D Mark II	​Компания Canon выпустит новый зеркальный фотоаппарат Canon 7D Mark II. Сейчас устройство находится на стадии тестирования и сборки, однако ключевые характеристики известны уже.	2013-10-16 05:39:13	\N	news_14019
157	http://www.you2you.ru/news/do-rossii-dobralsya-smartfon-nokia-lumia-1020	2013-10-16 19:02:08	1	​До России добрался смартфон Nokia Lumia 1020	​До России добрался смартфон Nokia Lumia 1020. Новейший продукт от финской компании будет продаваться по цене в районе 24630 рублей на первых этапах продаж. Модель доступна в черном, белом и желтом цветовых решениях, получила прочный алюминиевый корпус со следующими габаритными размерами.	2013-10-16 05:10:28	\N	news_14018
158	http://www.you2you.ru/news/anonsirovan-novyiy-igrovoy-smartfon-much-i5-s-naborom-mehanicheskih-manipulyatorov	2013-10-16 19:02:08	1	​Анонсирован новый игровой смартфон Much i5 с набором механических манипуляторов	​Анонсирован новый игровой смартфон Much i5 с набором механических манипуляторов. Подобное устройство замечательно подходит для множества современных мобильных развлечений – благодаря отсутствию необходимость держать пальцы непосредственно на сенсорном экране, пользователь не упускает мелкие детали игр, проходит их успешно и получает от такого времяпрепровождения действительное удовольствие.	2013-10-16 04:54:31	\N	news_14017
159	http://www.you2you.ru/news/samsung-galaxy-s5-poluchit-metallicheskiy-korpus-i-64-razryadnyiy-protsessor	2013-10-16 19:02:08	1	Samsung Galaxy S5 получит металлический корпус и 64-разрядный процессор	​Бывший сотрудник южнокорейского бренда Samsung после ухода из компании поведал журналистам о том, каким южнокорейский бренд сделает новый Samsung Galaxy S5. Коммуникатор, выпуск которого планируется на февраль 2014 года, оснастят металлическим корпусом,  64-разрядным процессором Exynos 5430 и камерой с разрешением 16 МП и оптической стабилизацией.	2013-10-15 05:14:31	\N	news_14015
160	http://www.you2you.ru/news/acer-c720-chromebook-novyiy-portativnyiy-noutbuk-s-besplatnyim-softom-uje-anonsirovan	2013-10-16 19:02:08	1	Acer C720 Chromebook - новый портативный ноутбук с бесплатным софтом уже анонсирован!	​Портативный компьютер Acer C720 Chromebook, построенный на платформе Chrome OS от компании Google уже анонсирован тайваньским брендом. Устройство может стать одним из тех кирпичиков закладки фундамента будущего x86-систем, построенных для массового пользования на исключительно бесплатном программном обеспечении.	2013-10-15 04:57:38	\N	news_14014
161	http://www.you2you.ru/news/masshtabnoe-obnovlenie-operatsionnoy-sistemyi-windows-phone-anonsirovala-kompaniya-microsoft	2013-10-16 19:02:08	1	​Масштабное обновление операционной системы Windows Phone анонсировала компания Microsoft	​Масштабное обновление операционной системы Windows Phone анонсировала компания Microsoft. В новой версии своей операционной системы компания реализовала поддержку формата Full HD, что ныне особенно актуально – в эпоху больших смартфонов, оснащенных современными дисплеями высокого для нашего времени разрешения.	2013-10-15 04:37:58	\N	news_14013
162	http://www.you2you.ru/news/kompaniya-hp-namerena-vyipustit-novyiy-unikalnyiy-noutbuk-postroennyiy-na-baze-mobilnoy-operatsionnoy-sistemyi-google-android-42	2013-10-16 19:02:08	1	​Компания HP намерена выпустить новый уникальный ноутбук, построенный на базе мобильной операционной системы Google Android 4.2	​Компания HP намерена выпустить новый уникальный ноутбук, построенный на базе мобильной операционной системы Google Android 4.2. Устройство будет продаваться по цене 249 евро в странах Евросоюза, о российских продажах на сегодняшний день ничего не известно. Отметим, что форм-фактор ноутбука, как и его операционная система, также заслуживает внимания.	2013-10-14 05:18:41	\N	news_14011
163	http://www.you2you.ru/news/vladeltsyi-smartfonov-apple-iphone-5s-jaluyutsya-na-nekorrektnyie-sboi-programmnoy-proshivki	2013-10-16 19:02:08	1	​Владельцы смартфонов Apple iPhone 5S жалуются на некорректные сбои программной прошивки	​Владельцы смартфонов Apple iPhone 5S жалуются на некорректные сбои программной прошивки. Так, предустановленная в смартфоне операционная система iOS 7 часто «виснет», отображая при этом так называемый «синий экран смерти».	2013-10-14 04:48:59	\N	news_14010
164	http://www.you2you.ru/news/v-2014-godu-ojidaetsya-start-proizvodstva-windows-phone-smartfonov-s-dvumya-slotami-pod-kartochki-sim	2013-10-16 19:02:08	1	​В 2014 году ожидается старт производства Windows Phone смартфонов с двумя слотами под карточки SIM	​В 2014 году ожидается старт производства Windows Phone смартфонов с двумя слотами под карточки SIM. Информацию о возможном их появлении на рынке накануне уже распространял техноблог Evleaks, сообщивший о начале работы компании Nokia над особой модификацией одного из гаджетов из линейки Lumia.	2013-10-14 04:31:01	\N	news_14009
165	http://www.you2you.ru/news/predstavlena-obnovlennaya-versiya-samoy-nedorogoy-polnokadrovoy-zerkalnoy-kameryi-nikon-d610	2013-10-16 19:02:08	1	​Представлена обновленная версия самой недорогой полнокадровой зеркальной камеры – Nikon D610	​Представлена обновленная версия самой недорогой полнокадровой зеркальной камеры – Nikon D610. Устройство получило доработанный затвор и увеличенную до 6 кадров в секунду скорость серийной съемки. Камера оснащена 24,3-мегапиксельным сенсором формата FX. Максимальное разрешение фотографий, которые делает Nikon D610, составляет 6016×4016 пикселей, видео записывается в формате Full HD.	2013-10-11 05:17:48	\N	news_14007
166	http://www.you2you.ru/news/kompaniya-google-mojet-predstavit-novyiy-android-44-kitkat-i-obnovlennyiy-smartfon-google-nexus-5-uje-15-oktyabrya	2013-10-16 19:02:08	1	​Компания Google может представить новый Android 4.4 KitKat и обновленный смартфон Google Nexus 5 уже 15 октября	​Компания Google может представить новый Android 4.4 KitKat и обновленный смартфон Google Nexus 5 уже 15 октября. Такую информацию распространил накануне уважаемый техноблог TechManiacs.gr. Отметим, что со стороны компании Google никаких данных, подтверждающих это, пока еще не было, но еще не вечер, да и IT-гиганты имеют привычку сообщать о своих продуктах в последние дни до релиза.	2013-10-11 05:03:45	\N	news_14006
167	http://www.you2you.ru/news/ryinok-personalnyih-kompyuterov-v-klassicheskom-form-faktore-i-v-form-faktore-noutbuk-dostig-rekordnogo-minimuma-za-poslednie-pyat-let	2013-10-16 19:02:08	1	​Рынок персональных компьютеров в классическом форм-факторе и в форм-факторе «ноутбук» достиг рекордного минимума за последние пять лет	​Рынок персональных компьютеров в классическом форм-факторе и в форм-факторе «ноутбук» достиг рекордного минимума за последние пять лет. Так, в третьем квартале 2013 года, продажи настольных ПК просели на 8.6% в сравнении с периодом прошлого года.	2013-10-11 04:43:35	\N	news_14005
168	http://www.you2you.ru/news/kompaniya-apple-priznana-samyim-dorogim-brendom-v-mire-i-eto-nesmotrya-na-skeptichnyie-prognozyi-ekspertov	2013-10-16 19:02:08	1	​Компания Apple признана самым дорогим брендом в мире. И это несмотря на скептичные прогнозы экспертов	​Компания Apple признана самым дорогим брендом в мире. И это несмотря на скептичные прогнозы экспертов, которые из года в год сулят одно и то же – падение акций, давление конкурентов, потерю былого имиджа. Но удивительно – ничего такого с Apple не происходит. За Apple следует, как не трудно догадаться, поисковый гигант Google, а компания Coca-Cola закрепилась на третьей строчке рейтинга.	2013-10-10 05:00:14	\N	news_14003
169	http://www.you2you.ru/news/google-hischno-poglyadyivaet-na-stagniruyuschiy-ryinok-noutbukov-v-zakromah-u-kompanii-est-prostyie-no-ochen-vostrebovannyie-idei	2013-10-16 19:02:08	1	​Google хищно поглядывает на стагнирующий рынок ноутбуков. В закромах у компании есть простые, но очень востребованные идеи	​Google хищно поглядывает на стагнирующий рынок ноутбуков. Крупнейший гигант отрасли IT уже знает чем брать здесь своего покупателя – ставка целиком и полностью сделано на «Хромбуки», которые с каждым новым поколением становятся все более совершенными.	2013-10-10 04:53:33	\N	news_14002
170	http://www.you2you.ru/news/bolshaya-sdelka-kitayskiy-it-gigant-lenovo-mojet-poglotit-tayvanskuyu-kompaniyu-htc	2013-10-16 19:02:08	1	​Большая сделка. Китайский IT-гигант Lenovo может поглотить тайваньскую компанию HTC	​Большая сделка. Китайский IT-гигант Lenovo может поглотить тайваньскую компанию HTC. Вторые сегодня переживают далеко не самые лучшие времена: испытывают финансовый и технологический кризис; едва ли успеют за преуспевающими брендами сегмента.	2013-10-10 04:40:56	\N	news_14001
171	http://www.you2you.ru/news/kompaniya-lenovo-anonsirovala-novyie-planshetnyie-kompyuteryi-lineyki-ideapad-b8000-f-i-b6000-f-s-neobyichnoy-konstruktsiey-korpusa	2013-10-16 19:02:08	1	​Компания Lenovo анонсировала новые планшетные компьютеры линейки Ideapad – B8000-F и B6000-F с необычной конструкцией корпуса	​Компания Lenovo анонсировала новые планшетные компьютеры линейки Ideapad – B8000-F и B6000-F с необычной конструкцией корпуса, включающей в себя интегрированную подставку. Работают устройства на базе операционной системы Android 4.2.	2013-10-09 05:36:08	\N	news_13999
172	http://www.you2you.ru/news/google-odin-iz-osnovnyih-pretendentov-na-pokupku-kompanii-blackberry	2013-10-16 19:02:09	1	Google - один из основных претендентов на покупку компании Blackberry	​Компания BlackBerry может достаться Google – гиганту отрасли IT, заинтересованному в патентах бывшего лидера премиумных мобильных девайсов. Отметим, что помимо вероятности покупки бывшего лидера компанией Google, в высвобождающихся патентах могут быть заинтересованы LG и Samsung.	2013-10-09 05:14:17	\N	news_13998
256	http://zodroid.ru/content/znews-14/	2013-10-16 19:02:12	2	Znews #14	\r\n \r\nДоброго времени суток! С вами четырнадцатый выпуск ежедневной рубрики Znews! Сегодня как всегда будет интересно. Поехали!	\N	\N	http://zodroid.ru/content/znews-14/
173	http://www.you2you.ru/news/prezentatsiya-novogo-planshetnogo-kompyutera-lineyki-apple-ipad-mojet-sostoyatsya-uje-22-oktyabrya	2013-10-16 19:02:09	1	​Презентация нового планшетного компьютера линейки Apple iPad может состояться уже 22 октября	​Презентация нового планшетного компьютера линейки Apple iPad может состояться уже 22 октября. Такую информацию сейчас распространяет техноблог All Things Digital со ссылкой на личные информационные источники.	2013-10-09 04:42:50	\N	news_13997
174	http://www.you2you.ru/news/podderjka-operatsionnyih-sistem-meego-i-symbian-zavershaetsya-s-1-yanvarya-2014-goda	2013-10-16 19:02:09	1	​Поддержка операционных систем MeeGo и Symbian завершается с 1 января 2014 года	​Поддержка операционных систем MeeGo и Symbian завершается с 1 января 2014 года. Шаг, которого с неохотой ожидали многие, наступает. Nokia завершает какую-либо работу с продуктами, рожденными в недрах финского бренда.	2013-10-08 05:26:34	\N	news_13995
175	http://www.you2you.ru/news/tsenyi-na-planshetnyie-kompyuteryi-s-operatsionnoy-sistemoy-windows-na-bortu-prodoljat-obrushivatsya	2013-10-16 19:02:09	1	​Цены на планшетные компьютеры с операционной системой Windows на борту продолжат обрушиваться	​Цены на планшетные компьютеры с операционной системой Windows на борту продолжат обрушиваться. Такое состояние дел связано с тем, что устройства с Android намного дешевле, что не позволяет конкурентам даже близко приблизиться к популярности «зеленого робота».	2013-10-08 05:15:32	\N	news_13994
176	http://www.you2you.ru/news/reliz-novyih-smartfonov-s-gibkimi-ekranami-vse-blije-kompaniya-lg-gotovitsya-predstavit-svoi-novinki-v-nachale-2014-god	2013-10-16 19:02:09	1	​Релиз новых смартфонов с гибкими экранами все ближе. Компания LG готовится представить свои новинки в начале 2014 год	​Релиз новых смартфонов с гибкими экранами все ближе. Компания LG готовится представить свои новинки в начале 2014 года. Благодаря гибкой конструкции дисплеевпрочность устройств значительно повысится. Кроме того, производитель заявляет, что новый дисплей будет самым легким в мире - всего 7,2 г - даже при диагонали экрана в 6 дюймов.	2013-10-08 05:00:57	\N	news_13993
177	http://www.you2you.ru/news/kompaniya-sony-metit-v-troyku-krupneyshih-proizvoditeley-mobilnyih-ustroystv	2013-10-16 19:02:09	1	​Компания Sony метит в тройку крупнейших производителей мобильных устройств	​Компания Sony метит в тройку крупнейших производителей мобильных устройств. Как заявил накануне глава отдела продаж и маркетинга компании Деннис ван Ши (Dennis van Schie), подобные цели японский бренд ставит перед собой уже в краткосрочной перспективе.	2013-10-07 05:13:05	\N	news_13991
178	http://www.you2you.ru/news/operatsionnaya-sistema-windows-phone-nakonets-to-dopolnena-funktsionalnyim-i-rusifitsirovannyim-prilojeniem-facebook	2013-10-16 19:02:09	1	Операционная система Windows Phone наконец-то дополнена функциональным и русифицированным приложением Facebook	​Мобильное приложение Facebook для операционной системы Windows Phone 8 получила очередное обновление, которое пользователи ждали очень и очень долго. Программисты исправили множество ошибок, добавили поддержку множества языков, в том числе и русского; улучшили логику работы с изображениями.	2013-10-07 05:01:51	\N	news_13990
179	http://www.you2you.ru/news/microsoft-predlojila-kompanii-htc-ispolzovat-windows-phone-v-kachestve-vtoroy-operatsionnoy-sistemyi-android-gadjetov	2013-10-16 19:02:09	1	​Microsoft предложила компании HTC использовать Windows Phone в качестве второй операционной системы Android-гаджетов	​Microsoft предложила компании HTC использовать Windows Phone в качестве второй операционной системы Android-гаджетов. По информации Bloomberg, сейчас гиганты IT-отрасли ведут переговоры о возможности реализации подобного решения. Устанавливать ОС Windows Phone владельцам смартфонов HTC будет предложено либо по минимальной цене, либо бесплатно.	2013-10-07 04:36:10	\N	news_13989
180	http://www.you2you.ru/news/kompaniya-lenovo-spetsialno-dlya-rossiyskogo-ryinka-anonsirovala-noveyshiy-monoblok-lenovo-b750	2013-10-16 19:02:09	1	​Компания Lenovo специально для российского рынка анонсировала новейший моноблок Lenovo B750	​Компания Lenovo специально для российского рынка анонсировала новейший моноблок Lenovo B750. Чем же он примечателен? А тем, что в качестве экрана использован здесь сверх-широкоформатный экран с соотношением сторон 21:9. Диагональ данного экрана при этом составляет 29 дюймов.	2013-10-04 05:34:39	\N	news_13987
181	http://www.you2you.ru/news/canon-obyyavlyaet-o-starte-prodaj-fotokameryi-canon-powershot-s120	2013-10-16 19:02:09	1	​Canon объявляет о старте продаж фотокамеры Canon PowerShot S120	​Canon объявляет о старте продаж фотокамеры Canon PowerShot S120. Новое устройстыо отличается высокой скоростью фокусировки, наличием беспроводных систем связи, позволяющих передавать информацию не только на гаджеты владельца камеры, но и в социальные сети.	2013-10-04 05:20:30	\N	news_13986
182	http://www.you2you.ru/news/lg-gotovitsya-anonsirovat-svoy-pervyiy-smartfon-s-plastichnyim-ekranom-13984	2013-10-16 19:02:09	1	LG готовится анонсировать свой первый смартфон с пластичным экраном	​Много времени прошло с тех пор, как впервые появились первые упоминания о работе брендов над смартфонами с изогнутыми экранами. Но технология эта не канула в небытие, и вот, компания LG уже готовит к выпуску гаджет G Flex.  По неофициальным данным, его довольно крупный, 6-дюймовый дисплей будет изготовлен по технологии Plastic OLED (POLED). Релиз аппарата может состояться в ноябре.	2013-10-04 05:05:58	\N	news_13985
183	http://www.you2you.ru/news/anonsirovan-novyiy-chromebook-ot-acer-116-dyuymovyiy-noutbuk-rabotayuschiy-pod-upravleniem-operatsionnoy-sistemyi-chrome-os	2013-10-16 19:02:09	1	​Анонсирован новый Chromebook от Acer. 11,6-дюймовый ноутбук, работающий под управлением операционной системы Chrome OS	​Анонсирован новый Chromebook от Acer. 11,6-дюймовый ноутбук, работающий под управлением операционной системы Chrome OS, как ожидается, будет оснащаться процессором Intel Celeron 2955U Haswell. Это повысит производительность и увеличит срок службы батарей по сравнению с более ранними моделями.	2013-10-03 05:31:25	\N	news_13979
184	http://www.you2you.ru/news/kompaniya-sharp-obyyavila-chto-namerena-vyiyti-na-ryinok-planshetnyih-kompyuterov	2013-10-16 19:02:09	1	​Компания Sharp объявила, что намерена выйти на рынок планшетных компьютеров	​Компания Sharp объявила, что намерена выйти на рынок планшетных компьютеров. В качестве операционной системы для своей продукции бренд намерен использовать Microsoft Windows 8.1. В качестве подтверждения своих намерений представители Sharp на проходящей в Японии выставке CEATEC уже анонсировали модель планшетного компьютера Mebius Pad с IGZO-панелью и диагональю экрана 10.1 дюйма.	2013-10-03 05:17:59	\N	news_13978
185	http://www.you2you.ru/news/kompaniya-apple-otlojila-proizvodstvo-novyih-planshetnyih-kompyuterov-apple-ipad-mini-2-na-2014-god	2013-10-16 19:02:09	1	​Компания Apple отложила производство новых планшетных компьютеров Apple iPad mini 2 на 2014 год	​Компания Apple отложила производство новых планшетных компьютеров Apple iPad mini 2 на 2014 год. Для производства новых планшетов не хватает современных дисплеев Retina – партии удастся сформировать не ранее января 2014 года.	2013-10-03 05:05:55	\N	news_13977
186	http://www.you2you.ru/news/predstaviteli-kompanii-samsung-zayavili-o-dostijenii-novogo-rubeja-populyarnosti-ih-firmennogo-messendjera-chaton	2013-10-16 19:02:09	1	​Представители компании Samsung заявили о достижении нового рубежа популярности их фирменного мессенджера ChatON	​Представители компании Samsung заявили о достижении нового рубежа популярности их фирменного мессенджера ChatON. Сервис ныне используют около сотни миллионов человек. Интернет-сервис Samsung ChatON, представляющий собой приложение по отправке мгновенных сообщений (мессенджер, одним словом), заработал в октябре 2011 года. Тем не менее, он долгое время не мог называться популярным, так как имел множество аналогов от других разработчиков.	2013-10-02 04:52:20	\N	news_13975
187	http://www.you2you.ru/news/kompanii-canon-hp-samsung-electronics-i-xerox-nachali-rabotu-nad-standartizatsiey-osnov-besprovodnoy-pechati-snimkov	2013-10-16 19:02:09	1	​Компании Canon, HP, Samsung Electronics и Xerox начали работу над стандартизацией основ беспроводной печати снимков	​Компании Canon, HP, Samsung Electronics и Xerox заключили договор о создании неприбыльного альянса Mopria. Основной работой альянса станет работа над увеличением доступности беспроводной печати со смартфонов, планшетов и других мобильных устройств. Альянс будет заниматься созданием универсальных стандартов в печатной, мобильной и программной областях, которые позволят сделать печать со смартфонов и планшетов общедоступной.	2013-10-02 04:43:49	\N	news_13974
188	http://www.you2you.ru/news/dolya-operatsionnoy-sistemyi-windows-phone-prodoljaet-rasti	2013-10-16 19:02:09	1	​Доля операционной системы Windows Phone продолжает расти	​Доля операционной системы Windows Phone продолжает расти. Несмотря на печальные прогнозы рыночных аналитиков, уже только в Европе каждый девятый смартфон работает на базе мобильной операционной системы от Microsoft.	2013-10-02 04:31:47	\N	news_13973
189	http://www.you2you.ru/news/kompaniya-nikon-terpit-zametnyie-ubyitki-iz-za-poteri-sprosa-na-kompaktnyie-tsifrovyie-fotoapparatyi	2013-10-16 19:02:09	1	​Компания Nikon терпит заметные убытки из-за потери спроса на компактные цифровые фотоаппараты	​Компания Nikon терпит заметные убытки из-за потери спроса на компактные цифровые фотоаппараты. Согласно отчету, за три месяца доход известнейшего производителя фотокамер и аксессуаров составил 238,981 млрд. иен, что на 7,9% меньше, чем год назад. При этом операционная прибыль за год сократилась с 23,368 до 6,032 млрд. иен, то есть на 74,2%, а чистая прибыль — с 15,770 до 4,436 млрд. или на 71,9%.	2013-10-01 05:27:00	\N	news_13971
190	http://www.you2you.ru/news/vladeltsyi-smartfona-htc-one-jaluyutsya-na-problemyi-s-novoy-operatsionnoy-sistemoy-android-43-13969	2013-10-16 19:02:09	1	​Владельцы смартфона HTC One жалуются на проблемы с новой операционной системой Android 4.3	​Владельцы смартфона HTC One жалуются на проблемы с новой операционной системой Android 4.3. Новое обновление сулит владельцам данной модели гаджета проблемами с цветовосприятием фотосенсора, а именно, с появлением на снимкам избыточной фиолетовой гаммы.	2013-10-01 05:12:43	\N	news_13970
191	http://www.you2you.ru/news/sony-xperia-z1-mini-novyiy-smartfon-ot-yaponskogo-brenda-mojet-byit-anonsirovan-uje-v-blijayshee-vremya	2013-10-16 19:02:09	1	​Sony Xperia Z1 Mini – новый смартфон от японского бренда, может быть анонсирован уже в ближайшее время	​Sony Xperia Z1 Mini – новый смартфон от японского бренда, может быть анонсирован уже в ближайшее время. Устройство, как оно и понятно из названия, является уменьшенной смартфона Sony Xperia Z1.	2013-10-01 04:50:46	\N	news_13967
192	http://www.you2you.ru/news/anons-fotoapparata-pentax-k-3-mojet-sostoyatsya-uje-v-blijayshee-vremya	2013-10-16 19:02:09	1	Анонс фотоаппарата Pentax K-3 может состояться уже в ближайшее время	​Японская компания Pentax Ricoh Imaging Company, известная у нас, прежде всего как один из ведущих производителей фотокамер, объективов и другого оптического оборудования, планирует уже в самое ближайшее время анонсировать выпуск зеркального фотоаппарата получившего наименование Pentax K-3. Новинка внешне  напоминает модель Pentax K-5 2010 года, которая в свою очередь переняла свой дизайн у модели K-7.	2013-09-30 06:19:18	\N	news_13965
193	http://www.you2you.ru/news/kompaniya-lenovo-predstavila-novyiy-kompyuter-tolschinoy-97-millimetrov	2013-10-16 19:02:09	1	Компания Lenovo представила новый компьютер толщиной 9,7 миллиметров	Компания Lenovo представила новый компьютер толщиной 9,7 миллиметров – ноутбук вдвое тоньше, чем отец сегмента ультратонких ПК – Apple MacBook Air. Новый китайский компьютер может похвастать толщиной 9,7 мм, что примерно вдвое меньше толщины MacBook Air, сообщает The Verge со ссылкой на китайский ресурс Yesky. Толщина MacBook Air составляет 17 мм.	2013-09-30 06:01:52	\N	news_13964
194	http://www.you2you.ru/news/planshetnyiy-kompyuter-nokia-lumia-2520-sirius-mojet-poluchit-podderjku-setey-lte	2013-10-16 19:02:09	1	​Планшетный компьютер Nokia Lumia 2520 (Sirius) может получить поддержку сетей LTE	​Планшетный компьютер Nokia Lumia 2520 (Sirius) может получить поддержку сетей LTE. Информация эта подтверждена выдержками из официальных документов федеральных агентств, которые контролируют сферу связи.	2013-09-30 05:56:23	\N	news_13963
195	http://www.you2you.ru/news/novaya-tsifrovaya-fotokamera-sigma-dp3-merrill-poyavitsya-skoro-v-prodaje	2013-10-16 19:02:09	1	Новая цифровая фотокамера Sigma DP3 Merrill появится скоро в продаже	​Анонсированная несколько месяцев назад фотокамера Sigma DP3 Merrill, имеющая в своем конструктиве трехслойную матрицу APS-C с разрешеним 46 мегапикселей, в скором времени появится в интернет-магазине Ю2Ю.	2013-09-27 05:09:39	\N	news_13961
196	http://www.you2you.ru/news/sony-mobile-communications-predstavit-v-rossiyskoy-roznitse-novyiy-pyatidyuymovyiy-smartfon-sony-xperia-c-po-tsene-12990-rubley	2013-10-16 19:02:10	1	​Sony Mobile Communications представит в российской рознице новый пятидюймовый смартфон Sony Xperia C по цене 12990 рублей	​Sony Mobile Communications представит в российской рознице новый пятидюймовый смартфон Sony Xperia C по цене 12990 рублей.  Смартфон оснащен 5” сенсорным емкостным экраном с разрешением 960х540 точек (qHD), четырехъядерным процессором MediaTek MTK6589 с тактовой частотой 1,2 ГГц, основной 8-Мп камерой с сенсором Exmor R, автофокусом, светодиодной вспышкой и функцией видеозаписи с разрешением 1080p, фронтальной VGA-камерой для видеотелефонии.	2013-09-27 04:59:10	\N	news_13960
197	http://www.you2you.ru/news/kompaniya-htc-soobschila-ob-obnovlenii-proshivki-flagmana-htc-one	2013-10-16 19:02:10	1	​Компания HTC сообщила об обновлении прошивки флагмана HTC One	​Компания HTC сообщила об обновлении прошивки флагмана HTC One. Выпущенный в марте текущего года, флагман HTC One работал под управлением Android 4.1.2 и стал одним из первых аппаратов, получивших обновление до Android 4.2.2.	2013-09-27 04:51:55	\N	news_13959
198	http://www.you2you.ru/news/v-2014-godu-srednestatisticheskiy-smartfon-zametno-pribavit-v-svoey-moschnosti	2013-10-16 19:02:10	1	​В 2014 году среднестатистический смартфон заметно прибавит в своей мощности	​В 2014 году среднестатистический смартфон заметно прибавит в своей мощности. Компания Apple, первая применившая в своих мобильных аппаратах 64-битные процессоры, поставила очередную отправную точку, которая может значительно повлиять на рынок мобильной индустрии.	2013-09-26 07:14:43	\N	news_13958
258	http://zodroid.ru/content/obzor-igry-pulse-infiltrator-gde-zhe-tortik/	2013-10-16 19:02:12	2	Обзор игры Pulse Infiltrator-а где же тортик?	\r\nХей, ты любишь игру Portal так же как и я? Ты любишь красивые 3D-головоломки? Тогда прошу-к чтению обзора игры Pulse Infiltrator на ZoDroid!	\N	\N	http://zodroid.ru/content/obzor-igry-pulse-infiltrator-gde-zhe-tortik/
199	http://www.you2you.ru/news/novyiy-bezzerkalnyiy-fotoapparat-so-smennyimi-obyektivami-v-skorom-vremeni-anonsiruet-kompaniya-nikon	2013-10-16 19:02:10	1	​Новый беззеркальный фотоаппарат со сменными объективами в скором времени анонсирует компания Nikon	​Новый беззеркальный фотоаппарат со сменными объективами в скором времени анонсирует компания Nikon. Корпус фотоаппарата не пропускает воду, имеет должную защиту от ударов, и в то же время, обладает техническими характеристиками, достаточными для создания высококачественных снимков.	2013-09-26 04:28:01	\N	news_13957
200	http://www.you2you.ru/news/asus-fonepad-note-6-v-skorom-vremeni-v-prodaje-poyavitsya-stilnyiy-i-funktsionalnyiy-apparat-ot-tayvanskogo-brenda	2013-10-16 19:02:10	1	​Asus Fonepad Note 6 – в скором времени в продаже появится стильный и функциональный аппарат от тайваньского бренда	​Asus Fonepad Note 6 – в скором времени в продаже появится стильный и функциональный аппарат от тайваньского бренда. Гаджет поддерживает мультитач и работу со стилусом, имеет достаточную диагональ экрана для комфортной мобильной работы, и при этом, остается действительно компактным девайсом, который практически всегда можно брать с собой.	2013-09-26 04:19:47	\N	news_13956
201	http://www.you2you.ru/news/sovremennyie-smartfonyi-vse-bolee-stremyatsya-zamenit-soboy-kompaktnyie-tsifrovyie-fotokameryi	2013-10-16 19:02:10	1	Уникальный смартфон с объективом от Nikon готовится анонсирования компания BBK (Oppo и Vivo)	​Современные смартфоны все более стремятся заменить собой компактные цифровые фотокамеры. Новый рывок в этом направлении сделала компания BBK, владеющая такими марками смартфонов, как Oppo и Vivo.	2013-09-25 05:45:15	\N	news_13954
202	http://www.you2you.ru/news/kompaniya-apple-obnovila-lineyku-kompyuterov-apple-imac	2013-10-16 19:02:10	1	​Компания Apple обновила линейку компьютеров Apple iMac	​Компания Apple обновила линейку компьютеров Apple iMac. Теперь устройства оснащены производительными процессорами Intel Core четвертого поколения, имеют на своем борту современную графическую систему от Nvidia. Стоимость новых компьютеров Apple iMac теперь начинается от 1300 долларов США.	2013-09-25 04:41:45	\N	news_13953
203	http://www.you2you.ru/news/kompaniya-samsung-electronics-gotovitsya-popolnit-modelnyiy-ryad-smartfonov-samsung-galaxy-note	2013-10-16 19:02:10	1	​Компания Samsung Electronics готовится пополнить модельный ряд смартфонов Samsung Galaxy Note	​Компания Samsung Electronics готовится пополнить модельный ряд смартфонов Samsung Galaxy Note. Так, на уже на подходе еще одна третья версия этого гаджета, построенная на базе  Exynos 5 Octa и Qualcomm Snapdragon 800 (вариант с LTE).	2013-09-25 04:32:31	\N	news_13952
204	http://www.you2you.ru/news/tayvanskaya-kompaniya-asus-anonsirovala-novyiy-kompaktnyiy-planshetnyiy-kompyuter-asus-fonepad-7	2013-10-16 19:02:10	1	​Тайваньская компания Asus анонсировала новый компактный планшетный компьютер Asus Fonepad 7	​Тайваньская компания Asus анонсировала новый компактный планшетный компьютер Asus Fonepad 7. Обновленное устройство представляет собой гаджет с операционной системой Android на борту, 3G-модулем для поддержки работы с сетями сотовой связи, а также с весьма производительной начинкой и прекрасным экраном. В качестве процессора в планшетном компьютере используется современный чип Intel Atom Z2560, за отображение картинки же отвечает яркий IPS-дисплей с разрешением 1280x800 пикселей.	2013-09-24 05:05:53	\N	news_13950
205	http://www.you2you.ru/news/igrovaya-pristavka-sony-playstation-4-budet-prodavatsya-yaponskim-proizvoditelem-v-minus	2013-10-16 19:02:10	1	​Игровая приставка Sony PlayStation 4 будет продаваться японским производителем в минус	​Игровая приставка Sony PlayStation 4 будет продаваться японским производителем в минус. С каждой проданной консолью Sony потеряет 60 долларов. Отметим, такой ценовой демпинг позволит производителю очень серьезного конкурировать с игровой приставкой Xbox One, стоимость которой на 100 долларов выше, чем цена на японский вариант. Это обязательно поспособствует укреплению на рынке игровых консолей лидерство за японским производителем, позволит сформировать мощную аудиторию вокруг новой игровой приставки, и в конечном итоге, заработать куда больше денег.	2013-09-24 04:40:27	\N	news_13949
206	http://www.you2you.ru/news/microsoft-anonsirovala-novoe-pokolenie-planshetnyih-kompyuterov-microsoft-surface	2013-10-16 19:02:10	1	​Microsoft анонсировала новое поколение планшетных компьютеров Microsoft Surface	​Microsoft анонсировала новое поколение планшетных компьютеров Microsoft Surface. К счастью, не оправдалось мнение о том, что новое поколение лишится своей ARM-версии, как и ранее, Surface продаваться будет в двух экземплярах.	2013-09-24 04:24:19	\N	news_13948
259	http://zodroid.ru/content/znews-13/	2013-10-16 19:02:12	2	ZNews #13	 \r\n \r\nПривет друзья! Сегодня вас ждет 13 выпуск почти ежедневной программы "Znews", в которой мы расскажем о самом интересном из мира IT! Все как всегда:) Поехали!	\N	\N	http://zodroid.ru/content/znews-13/
207	http://www.you2you.ru/news/uroven-prodaj-kompaktnyih-tsifrovyih-fotoapparatov-upal-do-naimenshih-znacheniy-poslednego-desyatiletiya	2013-10-16 19:02:10	1	​Уровень продаж компактных цифровых фотоаппаратов упал до наименьших значений последнего десятилетия	​Уровень продаж компактных цифровых фотоаппаратов упал до наименьших значений последнего десятилетия – смартфоны все активнее вытесняют с рынка некогда популярнейший вид фототехники. Сейчас, чтобы привлечь покупателей, Nikon, второй по величине мировой производитель камер, снизил цену на свою продукцию. Аналитики полагают, что лидер сегмента Canon последует примеру и предупреждают, что более мелкие производители могут не выдержать усилившейся ценовой конкуренции и будут вынуждены покинуть рынок.	2013-09-23 05:06:46	\N	news_13946
208	http://www.you2you.ru/news/kompaniya-sony-obyyavila-o-starte-rossiyskih-prodaj-novogo-flagmanskogo-smartfona-sony-zperia-z1	2013-10-16 19:02:10	1	​Компания Sony объявила о старте российских продаж нового флагманского смартфона Sony Zperia Z1	​Компания Sony объявила о старте российских продаж нового флагманского смартфона Sony Zperia Z1. Xperia Z1, напоним, оснащается крупным 5-дюймовым экраном с разрешением Full HD,  высококлассной оптикой  “G Lens” с матрицей 1/2.3 дюйма “Exmor RS” для мобильных устройств с разрешением 20,7 МП и уникальным процессом обработки изображений BIONZ для мобильных устройств.	2013-09-23 04:59:44	\N	news_13945
209	http://www.you2you.ru/news/stiv-balmer-uveren-chto-glavnaya-oshibka-microsoft-nedostatochnoe-vnimanie-brenda-k-mobilnyim-tehnologiyam	2013-10-16 19:02:10	1	Стив Балмер уверен, что главная ошибка Microsoft - недостаточное внимание бренда к мобильным технологиям	​Генеральный директор компании Microsoft Стив Балмер выступил на собрании финансовых аналитиков с заявлением о главной ошибке ведомого им бренда. По мнению Стива Балмера, основной провал компании состоит в том, что мобильным технологиями Microsoft уделяет недостаточное внимание. Та же неспособность создать свой собственный смартфон и продвинуть планшетный компьютер Surface стоила огромной упущенной выгоды.	2013-09-23 04:46:01	\N	news_13944
210	http://www.you2you.ru/news/svejaya-lineyka-noutbukov-ot-kompanii-lenovo-mojet-poyavitsya-v-prodaje-uje-eoy-osenyu	2013-10-16 19:02:10	1	​Свежая линейка ноутбуков от компании Lenovo может появиться в продаже уже эой осенью	​Свежая линейка ноутбуков от компании Lenovo может появиться в продаже уже эой осенью. Так, в октябре в продажу поступят модели ThinkPad E440 и E540 (по цене от 20 тыс. руб.) и ThinkPad L440 и L540 (по цене от 23 тыс. руб.).	2013-09-20 05:16:14	\N	news_13942
211	http://www.you2you.ru/news/tayvanskie-proizvoditeli-tsifrovoy-elektroniki-mogut-slitsya-v-edinuyu-korporatsiyu	2013-10-16 19:02:10	1	​Тайваньские производители цифровой электроники могут слиться в единую корпорацию	​Тайваньские производители цифровой электроники могут слиться в единую корпорацию. Так, учитывая непрекращающийся спад на рынке персональных компьютеров, страдающем от растущей популярности планшетов, представители некоторых инвестиционных банков настаивают на целесообразности слияния тайваньских ПК-производителей Acer и Asustek Computer, а также выражают готовность выступить посредниками в такой сделке, утверждают местные источники из сферы финансов.	2013-09-20 05:12:50	\N	news_13941
212	http://www.you2you.ru/news/reliz-novoy-versii-operatsionnoy-sistemyi-apple-ios-7-byil-omrachen-problemyi-s-ee-ustanovkoy-na-mobilnyie-gadjetyi	2013-10-16 19:02:10	1	​Релиз новой версии операционной системы Apple IOS 7 был омрачен проблемы с ее установкой на мобильные гаджеты	​Релиз новой версии операционной системы Apple IOS 7 был омрачен проблемы с ее установкой на мобильные гаджеты.  При попытке обновить программное обеспечение владельцы продукции Apple получали сообщения об ошибке или невозможности загрузки. Те, кто все же смог загрузить новую версию отмечали медленную работу интерфейса, а также то, что обновление занимает слишком много памяти на их устройствах (около 3.1 Гб).	2013-09-20 05:05:37	\N	news_13940
213	http://www.you2you.ru/news/kompaniya-samsung-sokraschaet-kolichestvo-proizvodimyih-noutbukov	2013-10-16 19:02:10	1	​Компания Samsung сокращает количество производимых ноутбуков	​Компания Samsung сокращает количество производимых ноутбуков. Связано это с постепенной потерей спроса на компьютеры данного типа. Напомним, подобная ситуация развивается уже сравнительно долгий промежуток времени, и связана она с увеличением продолжительности срока замены старого железа на новое, а также с улучшением технологических качеств современных мобильных гаджетов.	2013-09-19 05:24:34	\N	news_13938
275	http://zodroid.ru/content/znews-7/	2013-10-16 19:02:13	2	ZNews #7	\r\n \r\nДоброго времени суток! Традиционна ежедневная рубрика ждет не дождется вашего прочтения. Так как материала сегодня много, то не буду отвлекать долгими вступлениями. Желаю всем читателям почерпнуть из дайджеста что-то новое для себя.	\N	\N	http://zodroid.ru/content/znews-7/
214	http://www.you2you.ru/news/novyiy-smartfon-planshet-asus-padfone-infinity-predstavlen-ofitsialno-13936	2013-10-16 19:02:10	1	​Новый смартфон-планшет Asus PadFone Infinity представлен официально	​Новый смартфон-планшет Asus PadFone Infinity представлен официально. Гаджет, в сравнении с предыдущими его версиями, получит обновленный процессор, куда более совершенную камеру, увеличенный объем встроенной памяти и свежую версию операционной системы. В то же время, док-станция, в которую вставляется смартфон осталась практически той же самой – это все тот же 10-дюймовый экран планшета с FullHD-разрешением и дополнительным аккумулятором.	2013-09-19 05:03:24	\N	news_13937
215	http://www.you2you.ru/news/smartfon-s-pyatidyuymovyim-ekranom-predstavila-kompaniya-blackberry	2013-10-16 19:02:10	1	​Смартфон с пятидюймовым экраном представила компания Blackberry	​Смартфон с пятидюймовым экраном представила компания Blackberry. Новая модель устройства, получившая индекс Z30, ныне является самой крупной, которую когда-либо выпускал знаменитый премиумный бренд. Однако более ничем устройство похвастать не может – увы, но аппарат не дотягивает до значений топовых флагманов 2013 года.	2013-09-19 04:46:12	\N	news_13934
216	http://www.you2you.ru/news/toshiba-anonsirovala-novyiy-vosmidyuymovyiy-planshetnyiy-kompyuter-pod-upravleniem-operatsionnoy-sistemyi-windows	2013-10-16 19:02:10	1	Toshiba анонсировала новый восьмидюймовый планшетный компьютер под управлением операционной системы Windows	​Японская компания Toshiba анонсировала новый восьмидюймовый планшетный компьютер под управлением операционной системы Windows. Устройство работает на базе процессоров Intel Bay Trail. Планшет Toshiba Encore, как ожидается, поступит в продажу по цене 330 долларов США, начиная с ноября текущего года.	2013-09-18 04:55:43	\N	news_13932
217	http://www.you2you.ru/news/kompaniya-sandisk-anonsirovala-novuyu-kartu-pamyati-extreme-pro-cfast-20-kotoraya-yavlyaetsya-byistreyshey-na-segodnyashniy-den	2013-10-16 19:02:10	1	​Компания SanDisk анонсировала новую карту памяти Extreme Pro CFast 2.0, которая является быстрейшей на сегодняшний день	​Компания SanDisk анонсировала новую карту памяти Extreme Pro CFast 2.0, которая является быстрейшей на сегодняшний день. Карта поставляться будет в двух версиях:  на 60 и на 120 гигабайт. Оба могут считывать данные со скоростью до 450 мегабайт в секунду, а вот скорость записи у них различна: у более емкой карты скорость записи равна 350 мегабайт в секунду, у малой версии – 225 мегабайт.	2013-09-18 04:34:02	\N	news_13931
218	http://www.you2you.ru/news/v-seti-poyavilis-novyie-izobrajeniya-esche-ne-vyipuschennogo-v-svet-pervogo-planshetnogo-kompyutera-pod-brendom-nokia	2013-10-16 19:02:10	1	​В сети появились новые изображения еще не выпущенного в свет первого планшетного компьютера под брендом Nokia	​В сети появились новые изображения еще не выпущенного в свет первого планшетного компьютера под брендом Nokia.  Но стоит сразу отметить, что информация эта непроверенна. Согласно новым слухам и к свежим изображениям, гаджет получит в свой арсенал 10-дюймовый экран и операционную систему Windows RT.	2013-09-18 04:27:54	\N	news_13930
219	http://www.you2you.ru/news/yaponskaya-kompaniya-sony-rasshirila-modelnyiy-ryad-portativnyih-igrovyih-konsoley-esche-odnoy-pristavkoy	2013-10-16 19:02:10	1	​Японская компания Sony расширила модельный ряд портативных игровых консолей еще одной приставкой	​Японская компания Sony расширила модельный ряд портативных игровых консолей еще одной приставкой. Новинке под названием Playstation Vita TV эксперты пророчат не меньшую популярность, чем знаменитому мультимедийному гаджету Apple TV. Официальную презентацию японцы уже провели на прошлой неделе, так что на прилавках магазинов Playstation Vita TV появится начиная с ноября этого года.	2013-09-17 05:32:54	\N	news_13928
220	http://www.you2you.ru/news/kompaktnyiy-planshetnyiy-kompyuter-s-protsessorom-atom-na-bortu-gotovitsya-vyipustit-na-ryinok-tayvanskiy-brend-asus	2013-10-16 19:02:11	1	​Компактный планшетный компьютер с процессором Atom на борту готовится выпустить на рынок тайваньский бренд Asus	​Компактный планшетный компьютер с процессором Atom на борту готовится выпустить на рынок тайваньский бренд Asus. В Сети уже появился рендер и некоторые характеристики ASUS Fonepad HD7.	2013-09-17 04:54:18	\N	news_13927
221	http://www.you2you.ru/news/planshetnyie-kompyuteryi-apple-ipad-novogo-pokoleniya-pokajut-15-oktyabrya	2013-10-16 19:02:11	1	Планшетные компьютеры Apple iPad нового поколения покажут 15 октября	​Планшетные компьютеры Apple iPad нового поколения могут быть представлены совсем скоро – 15 октября текущего года. По данным одного из французских изданий, Apple анонсирует новые модели планшетных компьютеров iPad 5 и iPad mini 2.	2013-09-17 04:43:11	\N	news_13926
273	http://zodroid.ru/content/znews-8/	2013-10-16 19:02:13	2	ZNews #8	\r\n \r\nВсем привет! С вами снова ZNews.День  выдался сложным — такого штиля в информационном поле я уже давно не видел. Это сказалось и на размере дайджеста. Однако, короткий — не значит неинтересный. Кликнув в подробнее вы…. а в прочем сами увидите.	\N	\N	http://zodroid.ru/content/znews-8/
222	http://www.you2you.ru/news/ell-v-skorom-vremeni-vyipustit-na-ryinok-novyiy-planshetnyiy-pk-s-windows-81-na-bortu	2013-10-16 19:02:11	1	Dell, в скором времени выпустит на рынок новый планшетный ПК с Windows 8.1 на борту	​Знаменитый американский производитель электроники – компания Dell, в скором времени выпустит на рынок новый планшетный ПК с Windows 8.1 на борту. Устройство должно получиться весьма конкурентным по одной простой причине – он будет действительно недорого стоить! Пару дней назад в ходе конференции Intel Developer Forum компания Dell сообщила о «реинкарнации» своего мобильного бренда Venue (ранее под ним выпускались смартфоны).	2013-09-16 06:04:01	\N	news_13924
223	http://www.you2you.ru/news/nokia-vyibivaetsya-v-lideryi-na-ryinke-rossii	2013-10-16 19:02:11	1	​Nokia выбивается в лидеры на рынке России	​Nokia выбивается в лидеры на рынке России. Финскому бренду удалось опередить своего главного конкурента – компанию Samsung, и в результате, суммарный объем продаж смартфонов и телефонов Nokia превысил планку в 29%, тогда как у Samsung сегодня лишь 27% рынка.	2013-09-16 04:37:54	\N	news_13923
224	http://www.you2you.ru/news/microsoft-surface-za-staryiy-apple-ipad-na-chto-tolko-oni-ne-poydut-chtobyi-prodat-svoi-win8-ustroystva	2013-10-16 19:02:11	1	Microsoft Surface за старый Apple iPad - на что только они не пойдут, чтобы продать свои Win8-устройства	​На что только не готова компания Microsoft, чтобы не дать погибнуть своему молодому и увы, не самому успешному мобильному подразделению. Новым шагом корпорации в стороны исправления сложившейся ситуации стал анонс акции от ряда американских фирменных магазинов, предлагающих стать свой старый планшетный компьютер iPad от второго поколения и выше, и получить взамен него подарочные карты с определенной суммой, которую тут же можно потратить на приобретение нового планшета Surface.	2013-09-16 04:24:36	\N	news_13922
225	http://www.you2you.ru/news/novyiy-sotsialnyiy-fotoapparat-predstavil-yaponskiy-proizvoditel-fototehniki-canon	2013-10-16 19:02:11	1	Новый "социальный" фотоаппарат представил японский производитель фототехники Canon	​Компания Canon представила новый ультра-современный фотоаппарат, оснащенный модулем беспроводной связи и системой публикации снимков в социальную сеть Facebook нажатием одной лишь кнопки. Отметим, социальная сеть Facebook, стремясь расширить свои интересы и за пределы Интернета, активно сотрудничает с производителями разнообразных устройств. В качестве примеров такого сотрудничества можно привести мобильный телефон HTC First или фотоаппарат Canon PowerShot N.	2013-09-13 05:41:09	\N	news_13920
226	http://www.you2you.ru/news/hrombuki-sleduyuschego-pokoleniya-anonsirovali-kompanii-hp-acer-i-toshiba	2013-10-16 19:02:11	1	«Хромбуки» следующего поколения анонсировали компании HP, Acer и Toshiba	​«Хромбуки» следующего поколения анонсировали компании HP, Acer и Toshiba. Новые устройства, разработанные совместно с Chipzilla и Google, сделаны в рамках основной их концепции  - дешевле некуда при высококлассном железе и современном дизайне.	2013-09-13 05:24:56	\N	news_13919
227	http://www.you2you.ru/news/smartfon-nokia-lumia-1020-nachal-prodavatsya-v-germanii-skoro-doberetsya-i-do-rossii	2013-10-16 19:02:11	1	​Смартфон  Nokia Lumia 1020 начал продаваться в Германии - скоро доберется и до России	​Смартфон  Nokia Lumia 1020 начал продаваться в Германии. Абсолютную новинку можно приобрести на немецком рынке почти за 700 евро (включая все налоги и без операторского контракта).	2013-09-13 05:04:34	\N	news_13918
228	http://www.you2you.ru/news/kompaniya-olympus-anonsirovala-kameru-om-d-e-m1-standarta-micro-43-prishedshuyu-na-smenu-prejney-topovoy-modeli-om-d-e-m5	2013-10-16 19:02:11	1	​Компания Olympus анонсировала камеру OM-D E-M1 стандарта Micro 4:3, пришедшую на смену прежней топовой модели OM-D E-M5	​Компания Olympus анонсировала камеру OM-D E-M1 стандарта Micro 4:3, пришедшую на смену прежней топовой модели OM-D E-M5, говорится в сообщении компании. Камера оснащена 16-мегапиксельным сенсором изображения Live MOS и мощным графическим процессором седьмого поколения TruePic, что, по заявлению производителя, обеспечит получение снимков наилучшего качества за всю историю Olympus.	2013-09-12 05:04:58	\N	news_13916
229	http://www.you2you.ru/news/kompaniya-sony-predstavit-v-2014-godu-novuyu-versiyu-igrovoy-pristavki-sony-ps-vita	2013-10-16 19:02:11	1	​Компания Sony представит в 2014 году новую версию игровой приставки Sony PS Vita	​Компания Sony представит в 2014 году новую версию игровой приставки Sony PS Vita. Новая приставка получит один гигабайт встроенной оперативной памяти, улучшенные процессорные характеристики, обновленный экран и другие улучшения, которые позволяет владельцу этой игровой приставки запускать самые продвинутые современные игры.	2013-09-12 04:54:26	\N	news_13915
274	http://zodroid.ru/content/obzor-igry-ultra4-offroad-racing/	2013-10-16 19:02:13	2	Обзор игры ULTRA4 Offroad Racing	Привет, читатель. Начало недели, а играть уже не во что. Но не беда, есть у нас для тебя кое-что, а именно-обзор игрушки ULTRA4 Offroad Racing-погоняем?  	\N	\N	http://zodroid.ru/content/obzor-igry-ultra4-offroad-racing/
230	http://www.you2you.ru/news/stoimost-aktsiy-kompanii-apple-obrushilis-v-tsene-posle-prezentatsii-modeley-novyih-smartfonov-apple-iphone	2013-10-16 19:02:11	1	Стоимость акций компании Apple обрушились в цене после презентации моделей новых смартфонов Apple iPhone	​Стоимость акций компании Apple обрушились в цене после презентации моделей новых смартфонов Apple iPhone.  Напомним, презентация сразу двух новых моделей состоялась во вторник. реемником традиционных Apple стала версия iPhone 5S и новый iPhone 5C с пластмассовым корпусом.	2013-09-12 04:47:32	\N	news_13914
231	http://www.you2you.ru/news/toshiba-predstavila-pervyiy-planshetnyiy-kompyuter-rabotayuschiy-na-os-windows-81	2013-10-16 19:02:11	1	Toshiba представила первый планшетный компьютер, работающий на ОС Windows 8.1	​Недавно стало известно, что компания Toshiba представила первый планшетный компьютер, работающий на ОС Windows 8.1 — Toshiba Encore. Разрешение 8-дюймового экрана традиционно составляет 1280×800 пикселей, зато процессор можно обозначить как «продвинутый». В отличие от Iconia W3, снабженного двухъядерной системой, работой Toshiba Encore управляет четырехъядерный чип Intel Bay Trail.	2013-09-11 08:46:56	\N	news_13912
232	http://www.you2you.ru/news/novyie-smartfonyi-apple-iphone-pokazanyi-shirokoy-auditorii	2013-10-16 19:02:11	1	​Новые смартфоны Apple iPhone показаны широкой аудитории	​Новые смартфоны Apple iPhone показаны широкой аудитории. Как и предполагалось, рынок представил сразу две новые модели своего гаджета – флагманский аппарат Apple iPhone 5S и его бюджетную версию Apple iPhone 5C. Стратегию вывода на рынок двух различных моделей одного устройства компания применила впервые.	2013-09-11 08:34:53	\N	news_13911
233	http://www.you2you.ru/news/prezentatsiya-planshetnogo-kompyutera-microsoft-surface-novogo-pokoleniya-mojet-sostoyatsya-23-sentyabrya	2013-10-16 19:02:11	1	​Презентация планшетного компьютера Microsoft Surface нового поколения может состояться 23 сентября	​Презентация планшетного компьютера Microsoft Surface нового поколения может состояться 23 сентября. Представители прессы уже получили приглашение на презентацию, которую затеяла американская корпорация.	2013-09-11 04:37:22	\N	news_13910
234	http://www.you2you.ru/news/mobilnyie-protsessoryi-nvidia-tegra-vozvraschayut-sebe-byilyie-vyisotyi	2013-10-16 19:02:11	1	​Мобильные процессоры Nvidia Tegra возвращают себе былые высоты	​Мобильные процессоры Nvidia Tegra возвращают себе былые высоты. Так, на чипы Tegra 4 начался заметный рост заказов. В настоящее время поставки чипов организованы для устройств производства ASUS, Toshiba, Hewlett-Packard и Xiaomi. Последняя использует Tegra 4 в своем флагманском аппарате Mi3.	2013-09-10 05:09:13	\N	news_13908
235	http://www.you2you.ru/news/pokupka-brenda-nokia-kompaniey-microsoft-po-mneniyu-ekspertov-byil-edinstvennyim-dlya-amerikanskoy-korporatsii-vyihodom	2013-10-16 19:02:11	1	​Покупка бренда Nokia компанией Microsoft, по мнению экспертов, был единственным для американской корпорации выходом	​Покупка бренда Nokia компанией Microsoft, по мнению экспертов, был единственным для американской корпорации выходом. Ведь, если бы Nokia отказалась от использования Windows Phone, с этой операционной системой было бы покончено, пишет независимый аналитик Бен Томпсон. Такого же мнения придерживаются и некоторые другие аналитики и обозреватели. А Nokia действительно могла отказаться.	2013-09-10 04:58:31	\N	news_13907
236	http://www.you2you.ru/news/prezentatsiya-novyih-apple-iphone-uje-zavtra-11-sentyabrya	2013-10-16 19:02:11	1	Презентация новых Apple iPhone. Уже завтра - 11 сентября!	​Уже завтра, 11 сентября, американская компания Apple покажет миру сразу два новых смартфона Apple iPhone нового поколения. Как и ранее, «Яблочный бренд» держит в секрете информацию о новых устройства, но благодаря утечкам – преднамеренным, или истинным, все-таки немного информации о новых устройства у нас имеется.	2013-09-10 04:44:56	\N	news_13906
237	http://www.you2you.ru/news/novaya-statya-13903	2013-10-16 19:02:11	1	Раскрыта часть информации о грядущему флагманском смартфоне Nokia Lumia 1520	​Появились первые изображения смартфона Nokia Lumia 1520. Аппарат до сих пор не анонсирован официально, однако информация о некоторых его фишках доступна уже. Смартфон станет первым среди WP-устройств, который будет поддерживать полноценное Full HD-разрешение.	2013-09-09 05:37:24	\N	news_13904
238	http://www.you2you.ru/news/kompaniya-asus-predstavila-novyiy-fonepad-note-6-s-6-dyuymovyim-ekranom	2013-10-16 19:02:11	1	​Компания Asus представила новый Fonepad Note 6 с 6-дюймовым экраном	​Компания Asus представила новый Fonepad Note 6 с 6-дюймовым экраном, поддерживающим полноценное Full HD - разрешение. Это устройство было разработано для пользователей, которые ищут мультимедийный табфон, сочетающий в себе возможности планшета и телефона.	2013-09-09 05:11:46	\N	news_13902
302	http://politprofi.ru/info/novosti-ryinka/skromnyiy-kommunalnyiy-resurs	2013-10-16 19:02:14	3	Новости рынка: Скромный коммунальный ресурс	На предвыборную кампанию Александра Ноговицына было потрачено более 30 млн казенных денег, утверждают местные СМИ.	2013-10-02 13:04:04	\N	news_1311
239	http://www.you2you.ru/news/kompaniya-microsoft-obvinila-finskiy-brend-nokia-v-sokryitii-informatsii-o-tehnologicheskih-razrabotkah-svoih-telefonov	2013-10-16 19:02:11	1	​Компания Microsoft обвинила финский бренд Nokia в сокрытии информации о технологических разработках своих телефонов	​Компания Microsoft обвинила финский бренд Nokia в сокрытии информации о технологических разработках своих телефонов. Как сообщил в интервью CNET вице-президент Microsoft Джо Бельфиор, отвечавший за работу над Windows Phone, за время сотрудничества двух гигантов своих отраслей менеджеры Microsoft неоднократно постфактум узнавали об изменениях, внесенных в разрабатываемые Nokia аппараты, и были вынуждены в последний момент корректировать программное обеспечение.	2013-09-09 04:39:48	\N	news_13901
240	http://www.you2you.ru/news/anonsirovan-ultraportativnyiy-noutbuk-asus-x102ba-osnaschennyiy-101-dyuymovyim-sensornyim-displeem	2013-10-16 19:02:11	1	​Анонсирован ультрапортативный ноутбук Asus X102BA, оснащенный 10,1-дюймовым сенсорным дисплеем	​Анонсирован ультрапортативный ноутбук Asus X102BA, оснащенный 10,1-дюймовым сенсорным дисплеем. Кажется, что тайваньский производитель решил вернуть нетбукам былую рыночную нишу, и вполне возможно, что у бренда задуманное получится.	2013-09-06 06:00:21	\N	news_13899
241	http://www.you2you.ru/news/poyavilas-pervaya-informatsiya-o-nadvigayuschemsya-anonse-planshetnogo-kompyutera-microsoft-surface-pro-2	2013-10-16 19:02:11	1	​Появилась первая информация о надвигающемся анонсе планшетного компьютера Microsoft Surface Pro 2	​Появилась первая информация о надвигающемся анонсе планшетного компьютера Microsoft Surface Pro 2. Устройство по имеющейся информации, собираться будет на базе процессоров Intel Haswell i5. Объем оперативной памяти гаджета составит от четырех до восьми гигабайт.	2013-09-06 05:51:00	\N	news_13898
242	http://www.you2you.ru/news/microsoft-xbox-360-budet-podderjivatsya-posle-vyihoda-novoy-konsoli-na-protyajenii-esche-neskolkih-le	2013-10-16 19:02:11	1	Microsoft Xbox 360 будет поддерживаться после выхода новой консоли на протяжении еще нескольких ле	​Игровая приставка Microsoft Xbox 360 будет поддерживаться после выхода новой консоли на протяжении еще нескольких лет. Шаг этот со стороны американской корпорации вполне логичный, ведь  за свое время бренду удалось реализовать 80 миллионов игровых приставок, а это признак весьма немаленькой аудитории бренда, с которой нельзя так просто взять и прекратить плотно работать.	2013-09-06 05:48:55	\N	news_13897
243	http://www.you2you.ru/news/sony-predstavila-osobennyiy-obyektiv-kotoryiy-mojno-zakrepit-na-lyuboy-sovremennyiy-kommunikator	2013-10-16 19:02:11	1	Sony представила особенный "объектив", который можно закрепить на любой современный коммуникатор	​Компания Sony анонсировала на выставке электроники IFA 2013, проходящей в Берлине, новый мобильный аксессуар – фотоприставку для современных смартфонов.  С помощью этого небольшого устройства на мобильный девайс пользователь может получать высококачественные снимки.	2013-09-05 05:10:58	\N	news_13895
244	http://www.you2you.ru/news/asus-vivobook-s301-tayvanskiy-brend-predstavil-novyiy-ultrabuk-s-priemlemoy-tsenoy-i-neplohimi-harakteristikami	2013-10-16 19:02:12	1	Asus Vivobook S301 - тайваньский бренд представил новый ультрабук с приемлемой ценой и неплохими характеристиками	​Ассортимент компании Asus вот-вот пополнится новой моделью ультрабука, которая позиционируется в качестве доступного продукта. Новинка называется Asus Vivobook S301, в зависимости от конкретной конфигурации её стоимость начитается с отметки в $700.	2013-09-05 05:05:13	\N	news_13894
245	http://www.you2you.ru/news/yujno-koreyskaya-kompaniya-samsung-predstavila-4-sentyabrya-umnyie-chasyi-samsung-galaxy-gear	2013-10-16 19:02:12	1	Южно-корейская компания Samsung представила 4 сентября умные часы Samsung Galaxy Gear	​Вот и свершилось! Южно-корейская компания Samsung представила 4 сентября умные часы Samsung Galaxy Gear. Кроме того, вместе с умными часами производителем были показаны: фаблет Galaxy Note 3 и планшетный компьютер Galaxy Note 10.1.	2013-09-05 04:48:25	\N	news_13893
246	http://www.you2you.ru/news/novyiy-monitor-s-ultra-hd-razresheniem-predstavila-nakanune-kompaniya-asus	2013-10-16 19:02:12	1	​Новый монитор с Ultra HD разрешением представила накануне компания Asus	​Новый монитор с Ultra HD разрешением представила накануне компания Asus. Экран построен на базе 31.5-дюймовой матрицы с разрешением 3840x2160 точек.  Яркость панели составляет 350 кд/кв. м, время отклика – 8 мс, углы обзора по вертикали и горизонтали — 176 градусов. Также сообщается о 2 Вт стереодинамиках, видеовходах DisplayPort и D-sub, аудиоразъемах и VESA-совместимом креплении.	2013-09-04 04:52:47	\N	news_13891
257	http://zodroid.ru/content/apple-22th-october-vashe-priglashenie-2/	2013-10-16 19:02:12	2	Apple 22th October - ваше приглашение? #2	\r\n \r\nДрузья, компания Apple разослала официальное приглашение на презентацию, которая пройдет 22 октября! Скорее всего на этой презентации Apple покажет новые iPad. А именно iPad 5 и iPad mini 2. Примечательно, что в этом году Apple могут нас приятно удивить аж два раза!	\N	\N	http://zodroid.ru/content/apple-22th-october-vashe-priglashenie-2/
247	http://www.you2you.ru/news/novaya-versiya-operatsionnoy-sistemyi-google-android-poluchit-shokoladnoe-nazvanie-android-44-kitkat	2013-10-16 19:02:12	1	​Новая версия операционной системы Google Android получит «шоколадное» название Android 4.4 KitKat	​Новая версия операционной системы Google Android получит «шоколадное» название Android 4.4 KitKat.  Глава по разработке Android и Chrome Сундар Пичаи подтвердил название KitKat в своем микроблоге в Twitter, опубликовав фотографию новой стилизованной статуи Android на территории кампуса Google. Он также сообщил, что число активированных Android-устройств, включая смартфоны и планшеты, превысило миллиард.	2013-09-04 04:48:01	\N	news_13890
248	http://www.you2you.ru/news/kompaniya-microsoft-pokupaet-mobilnoe-podrazdelenie-nokia-za-72-milliarda-dollarov	2013-10-16 19:02:12	1	​Компания Microsoft покупает мобильное подразделение Nokia за 7.2 миллиарда долларов	​Компания Microsoft покупает мобильное подразделение Nokia за 7.2 миллиарда долларов. Передача бизнеса в руки американского бренда будет завершена до окончания первого квартала 2014 года. После продажи мобильного подразделения Nokia планирует сосредоточиться на трех основных направлениях - развитии Nokia Solutions and Networks, навигационного сервиса HERE, а также Advanced Technologies, в том числе "облачных" и сенсорных технологий.	2013-09-04 04:35:30	\N	news_13889
249	http://www.you2you.ru/news/novaya-statya-13886	2013-10-16 19:02:12	1	Темпы развития магазина Android-приложений Google Play Store превысили темпы развития App Store компании Apple	Магазин Android-приложений Google Play Store развивается намного быстрее, чем App Store компании Apple. Согласно новейшим исследованиям, взятые темы роста сохранятся и в последующем, и вполне возможно, могут даже ускориться.  ABI Research полагает, что прибыль от продаж Android-приложений для смартфонов удвоится в этом году и достигнет 6,8 миллиарда долларов.	2013-09-03 05:16:31	\N	news_13887
250	http://www.you2you.ru/news/noveyshiy-flagmanskiy-smartfon-meizu-mx3-predstavlen-ofitsialno	2013-10-16 19:02:12	1	​Новейший флагманский смартфон Meizu MX3 представлен официально	​Новейший флагманский смартфон Meizu MX3 представлен официально. Новый продвинутый гаджет имеет не самые малые размеры и весьма производительную начинку, благодаря которой устройство может конкурировать с наилучшими решениями от конкурентных брендов.	2013-09-03 04:38:20	\N	news_13885
251	http://www.you2you.ru/news/korporatsiya-samsung-obognala-kompaniyu-apple-po-prodajam-planshetnyih-kompyuterov-na-rossiyskom-ryinke	2013-10-16 19:02:12	1	​Корпорация Samsung обогнала компанию Apple по продажам планшетных компьютеров на российском рынке	​Корпорация Samsung обогнала компанию Apple по продажам планшетных компьютеров на российском рынке. Так, согласно опубликованным данным, доля  продаж планшетных ПК у корпорации Samsung выросла до 17,3%, в то же время, вместо былых 30% у Apple сегодня 17% от рыночной доли.	2013-09-03 04:30:39	\N	news_13884
252	http://www.you2you.ru/news/v-nachale-sentyabrya-2013-goda-v-prodaje-poyavitsya-novyiy-prodvinutyiy-zerkalnyiy-fotoapparat-canon-eos-70d	2013-10-16 19:02:12	1	​В начале сентября 2013 года в продаже появится новый продвинутый зеркальный фотоаппарат Canon EOS 70D	​В начале сентября 2013 года в продаже появится новый продвинутый зеркальный фотоаппарат Canon EOS 70D. Устройство будет поставляться в комплекте с объективом 18-135 мм IS STM. Фотоаппарат наверняка будет интересен профессиональным фотографам благодаря своим во многом достойным характеристикам.	2013-09-02 05:31:35	\N	news_13882
253	http://www.you2you.ru/news/kompaniya-asus-gotova-predstavit-4-sentyabrya-novyiy-planshetnyiy-kompyuter-lineyki-transformer-pad	2013-10-16 19:02:12	1	​Компания Asus готова представить 4 сентября новый планшетный компьютер линейки Transformer Pad	​Компания Asus готова представить 4 сентября новый планшетный компьютер линейки Transformer Pad. Ожидается, что новый планшет будет работать на Android OS и процессоре Tegra 4. Вполне вероятно, что новый ASUS Transformer Pad получит 10,1-дюймовый дисплей.	2013-09-02 05:19:55	\N	news_13881
254	http://www.you2you.ru/news/v-obozrimom-buduschem-polzovateli-skype-smogut-obschatsya-drug-s-drugom-v-formate-3d	2013-10-16 19:02:12	1	В обозримом будущем пользователи Skype смогут общаться друг с другом в формате 3D	​Разработчики популярного во всем мире мессенджера Skype рассказали, что ведут разработку нового функционала программы для осуществления видеозвонков в формате 3D. Информацию подтвердили и представители компании Microsoft, курирующей Skype. Как выяснили журналисты Би-би-си, соответствующие технологии уже находятся в стадии активного тестирования.	2013-09-02 04:45:34	\N	news_13880
255	http://www.you2you.ru/news/novyiy-monitor-ultravyisokogo-razresheniya-predstavila-kompaniya-acer	2013-10-16 19:02:12	1	​Новый монитор ультравысокого разрешения представила компания Acer	​Новый монитор ультравысокого разрешения представила компания Acer. Новое устройство Acer T272HUL – это профессионального уровня монитор с 27-дюймовым сенсорным экраном формата WQHD (2560 х 1440 пикселей) и поддержкой 1,07 млрд цветов.	2013-08-30 05:29:24	\N	news_13878
260	http://zodroid.ru/content/chego-stoit-ozhidat-ot-prezentacii-google/	2013-10-16 19:02:12	2	Чего стоит ожидать от презентации Google	\r\n \r\nВсем привет! Вот вот компания Google должна представит свое новое детище под именем KitKat и в придачу к нему пару гаджетов. Чем же собирается нас удивлять компания добра? Давайте разбираться..	\N	\N	http://zodroid.ru/content/chego-stoit-ozhidat-ot-prezentacii-google/
261	http://zodroid.ru/content/znews-12/	2013-10-16 19:02:12	2	ZNews #12	\r\n \r\nВсем привет! Очередная порция свежего выпуска ZNewsпредстала пред ваши ясны очи. Нынче мы поговорим об утечках и анонсах — благо информации предостаточно. Итак,  жмем «подробнее» и наслаждаемся :	\N	\N	http://zodroid.ru/content/znews-12/
262	http://zodroid.ru/content/htc-one-max-biometricheskij-monstr/	2013-10-16 19:02:13	2	HTC One Max - биометрический монстр!	\r\n \r\nКомпания HTC наконец таки представила свой "плафон", конкурента Samsung Galaxy Note III. Смартфон, как и ожидалось, зовется HTC One Max.....	\N	\N	http://zodroid.ru/content/htc-one-max-biometricheskij-monstr/
263	http://zodroid.ru/content/pyat-prichin-provala-iphone-5c/	2013-10-16 19:02:13	2	Пять причин провала iPhone 5C	\r\n \r\nПривет друзья! Тех людей, которые страдают пюре головного мозга прошу отдалится от экранов! Сегодня мы поговорим о безоговорочном провале iPhone 5C.	\N	\N	http://zodroid.ru/content/pyat-prichin-provala-iphone-5c/
264	http://zodroid.ru/content/obzor-beta-versii-prilozheniya-themer/	2013-10-16 19:02:13	2	Обзор бета-версии приложения Themer	\r\n \r\nДоброго времени суток! Мы ведь знаем как вы любите кастомизировать рабочий стол своего android-девайса! И поэтому замутили новенькое видео на эту тему. На этот раз вас ждет обзор бета-версии приложения Themer, от создателей mycolorscreen! Приятного просмотра! 	\N	\N	http://zodroid.ru/content/obzor-beta-versii-prilozheniya-themer/
265	http://zodroid.ru/content/obzor-igry-deer-hunter-2014-vremya-strelyat/	2013-10-16 19:02:13	2	Обзор игры Deer Hunter 2014-время стрелять!	Осень, грибники собирают грибы, студенты ходят на пары, и только охотники веселятся на полную мощность! Пойдем и ты с нами, застрелим этого оленя! Да не в живую, не бойся! А в отличном симуляторе охоты Deer Hunter 2014! Как это не играл? Ну тогда читай обзор, и заряжай ружье! \r\n	\N	\N	http://zodroid.ru/content/obzor-igry-deer-hunter-2014-vremya-strelyat/
266	http://zodroid.ru/content/znews-11/	2013-10-16 19:02:13	2	ZNews #11	\r\n \r\n«Маленький, да удаленький». Именно так можно охарактеризовать сегодняшнюю подборку новостей с нафталиновым душком. Приятного прочтения ;)	\N	\N	http://zodroid.ru/content/znews-11/
267	http://zodroid.ru/content/igrovye-smartfony-nashe-budushee/	2013-10-16 19:02:13	2	Игровые смартфоны - наше будущее?	\r\n \r\nДоброго времени суток! Вы наверное знаете, что существуют, так называемые, игровые ноутбуки. От своих собратьев они отличаются в первую очередь производительностью, которая в некоторых случаях в разы выше! Но проблема в том, что рынок предпочитает компактные устройства, типа планшета или смартфона. Согласитесь, ноутбук с собой таскать не всегда удобно, а в игрушки поиграть хочется! Если вы еще не поняли, я говорю про "игровые" смартфоны, с физическими контролерами и  механически кнопками.	\N	\N	http://zodroid.ru/content/igrovye-smartfony-nashe-budushee/
268	http://zodroid.ru/content/pochemu-ya-otkazalsya-ot-pokupki-iphone-5s/	2013-10-16 19:02:13	2	Почему я отказался от покупки Iphone 5S	\r\n \r\nОдни называют его идеальным смартфон, другие упрекают его в явных недостатках. Неверно вы уже догадались о ком сегодня пойдёт речь - Iphone 5S. Нет, это не обзор, а лишь не большое чтиво  о том, почему я отказался от покупки яблочного флагмана\r\n!Осторожно слишком много имхо!	\N	\N	http://zodroid.ru/content/pochemu-ya-otkazalsya-ot-pokupki-iphone-5s/
269	http://zodroid.ru/content/znews-10-yubilejnyj-vypusk/	2013-10-16 19:02:13	2	ZNews #10 - юбилейный выпуск! 	\r\n \r\nВсем привет! Вашему вниманию представлен юбилейный десятый выпуск ZNews, как и обычно мы поведаем вам все самые интересные ITновости за день. Приятного прочтения;) 	\N	\N	http://zodroid.ru/content/znews-10-yubilejnyj-vypusk/
270	http://zodroid.ru/content/znews-9/	2013-10-16 19:02:13	2	Znews #9	\r\n \r\nПривет друзья! Сейчас вас ждет очередная порция IT новостей! Если вы готовы, то смело начинаем!:)	\N	\N	http://zodroid.ru/content/znews-9/
271	http://zodroid.ru/content/htc-vy-v-polnoj/	2013-10-16 19:02:13	2	HTC, все очень плохо....	\r\n \r\nПривет друзья! Сегодня речь пойдет о небезызвестной компании HTC, которая в данный момент переживает, мягко говоря, не лучшие времена......	\N	\N	http://zodroid.ru/content/htc-vy-v-polnoj/
272	http://zodroid.ru/content/nexus-5-google-ty-serezno/	2013-10-16 19:02:13	2	Nexus 5 - Google, ты серьезно?	\r\n \r\nПривет друзья! Сегодня, а точнее вчера, пришла информация о том, что Японская розничная сеть Redstar открыла на своем сайте предварительный заказ на LG Nexus 5!	\N	\N	http://zodroid.ru/content/nexus-5-google-ty-serezno/
276	http://zodroid.ru/content/5-prichin-pochemu-apple-ignoriruet-rossiyu/	2013-10-16 19:02:13	2	Пять причин почему Apple игнорирует Россию	\r\n \r\nПривет друзья! Вы все знаете, что компания Apple не очень любит тяжелую Российскую действительность. Русская душа видимо слишком глубока для американской корпорации. А Siri, уже несколько лет не может выучить богатый русский язык. В чем же дело? Неужели все это происки империалистов?:) Давайте разберемся и выведем пять причин, по которым Apple игнорирует Россию.	\N	\N	http://zodroid.ru/content/5-prichin-pochemu-apple-ignoriruet-rossiyu/
277	http://zodroid.ru/content/aviate/	2013-10-16 19:02:13	2	Aviate	\r\nМилости просим дорогие читатели. Свежая порция информации о том как украсить свой рабочий стол. И сделать еще кучу полезных вещей. Смотрим, и обязательно делимся своими мыслями в коментариях.	\N	\N	http://zodroid.ru/content/aviate/
278	http://zodroid.ru/content/obzor-contra-revolution-privet-iz-90-h/	2013-10-16 19:02:13	2	Обзор Contra Evolution-привет из 90-х!	Помните свою приставку с картриджами, провода к телевизору, и звук загрузки Dendy? Значит вы помните и одну из тех игр, после которой хотелось разбить джойстик-ContraRevolution! А теперь в нее можно играть и на мобильных девайсах, ну а у нас есть обзор! Посмотрим...\r\n 	\N	\N	http://zodroid.ru/content/obzor-contra-revolution-privet-iz-90-h/
279	http://zodroid.ru/content/mnenie-o-tvitter-klientah/	2013-10-16 19:02:13	2	Мнение о твиттер-клиентах 	\r\nЗдравствуй уважаемый читатель :)Так как я все время пользовался твиттер-клиентом Plume, то никак себя не мог заставить пересесть на другой клиент. Потому как чаще всего я сидел через виджет на рабочем столе, может вам и покажется это странным :)\r\n 	\N	\N	http://zodroid.ru/content/mnenie-o-tvitter-klientah/
280	http://zodroid.ru/content/znews-6/	2013-10-16 19:02:13	2	ZNews #6	\r\n \r\nЧто может быть лучше, чем самый лучший дайджест про новости из мира IT? Правильно, только самая свежая его версия.. Читаем и комментим, лайкаем, твиттим и +1-м.	\N	\N	http://zodroid.ru/content/znews-6/
281	http://zodroid.ru/content/siri-umnoe-ono/	2013-10-16 19:02:13	2	Siri - умное "оно"...	\r\n \r\nПривет друзья! Сегодня четвертое октября и это тот самый день, когда голосовой помощник Siri была включена в IOS. Тогда еще 5 версии. Т.е. у неё сегодня официальный день рождения!	\N	\N	http://zodroid.ru/content/siri-umnoe-ono/
282	http://zodroid.ru/content/znews-5/	2013-10-16 19:02:13	2	ZNews #5	\r\n \r\nВсем привет! Очередная порция свежего выпуска ZNewsпредстала пред ваши ясны очи. Нынче мы поговорим об утечках и анонсах — благо информации предостаточно. Итак,  жмем «подробнее» и наслаждаемся :)	\N	\N	http://zodroid.ru/content/znews-5/
283	http://zodroid.ru/content/freeze-horoshij-tajmkiller/	2013-10-16 19:02:13	2	Freeze - хороший таймкиллер!	\r\n \r\nПривет, уважаемый читатель! Любишь ли ты качественные игры, на логику, с графикой, да еще и с музыкой красивой? Думаю,да, и тогда мы предлагаем твоему вниманию обзор русской игры Freeze!	\N	\N	http://zodroid.ru/content/freeze-horoshij-tajmkiller/
284	http://zodroid.ru/content/znews-4/	2013-10-16 19:02:13	2	ZNews #4	\r\n \r\nПривет друзья! Сегодня вас ждет 4 выпуск почти ежедневной программы "Znews", в которой мы расскажем о самом интересном из мира IT! Все как всегда:) Поехали!	\N	\N	http://zodroid.ru/content/znews-4/
285	http://zodroid.ru/content/iwatch-ajfon-na-zapyaste/	2013-10-16 19:02:14	2	iWatch - айфон на запястье!	\r\nВсем привет! Ни для кого не секрет, что Apple работает над своими умными часами. Причем Apple должны сделать этот продукт как обычно качественным, способным перевернуть целую индустрию, которая, по правде говоря, застряла в эре E-link экранов и лагающих интерфейсов.....	\N	\N	http://zodroid.ru/content/iwatch-ajfon-na-zapyaste/
286	http://politprofi.ru/info/novosti-ryinka/v-altayskom-krae-popyitayutsya-vozrodit-rossiyu	2013-10-16 19:02:14	3	Новости рынка: В Алтайском крае попытаются возродить Россию	В Алтайском крае зарегистрировано отделение партии «Возрождения России». «Возрождение России» стала 52 зарегистрированной на территории Алтайского края партией.	2013-10-16 06:53:31	\N	news_1328
287	http://politprofi.ru/info/novosti-ryinka/v-permskom-krae-naznachili-datyi-vyiborov	2013-10-16 19:02:14	3	Новости рынка: В Пермском крае назначили даты выборов	8 сентября в Пермском крае прошли выборы глав различных поселений, муниципальных районов и городских округов.	2013-10-16 06:50:35	\N	news_1327
288	http://politprofi.ru/info/novosti-ryinka/vyiboryi-opredelili-gubernatorov-otlichnikov	2013-10-16 19:02:14	3	Новости рынка: Выборы определили губернаторов-отличников	Вышел тринадцатый по счету "рейтинг выживаемости губернаторов", составляемый группой экспертов.	2013-10-16 06:45:35	\N	news_1326
289	http://politprofi.ru/info/news/v-tomske-opredelili-mera	2013-10-16 19:02:14	3	Новости: В Томске определили мэра	Избирательная комиссия Томска утвердила итоги голосования на выборах мэра Томска и избрание единоросса Ивана Кляйна на этот пост, говорится в решении комиссии, опубликованном ее сайте.	2013-10-16 06:40:25	\N	news_1325
290	http://politprofi.ru/info/novosti-ryinka/s-sudimostyu-na-vyiboryi	2013-10-16 19:02:14	3	Новости рынка: С судимостью на выборы	Закон о выборах не соответствует Конституции Российской Федерации – таково постановление Конституционного суда, который, рассмотрев обращение пяти граждан из разных регионов страны, снятых с выборов 14 октября 2012 года из-за того, что они имели судимости по "тяжким" статьям, встал на сторону заявителей.	2013-10-16 06:35:24	\N	news_1324
291	http://politprofi.ru/info/novosti-ryinka/perevalilo-za-25	2013-10-16 19:02:14	3	Новости рынка: Перевалило за 25	С начала года в Калининградской области, по данным областного управления Министерства юстиции РФ, количество политических партий увеличилось на 25.	2013-10-16 06:30:38	\N	news_1323
292	http://politprofi.ru/info/novosti-ryinka/karernyiy-rost-na-kritike-gubernatora	2013-10-16 19:02:14	3	Новости рынка: Карьерный рост на критике губернатора	Региональное отделение партии «Родина» в Волгоградской области возглавил экс-единоросс Николай Чувальский, жестко раскритиковавший губернатора Сергея Боженова.	2013-10-16 06:23:58	\N	news_1322
293	http://politprofi.ru/info/novosti-ryinka/nerazluchna-s-prezidentom	2013-10-16 19:02:14	3	Новости рынка: Неразлучна с президентом	Cъезд «Единой России», прошедший в минувшие выходные, показал несколько тенденций, отмечают СМИ: партия продолжила избавляться от кадров вновь вернувшегося на работу в администрацию президента Владислава Суркова и стала копировать методы внепартийного движения Общероссийского народного фронта (ОНФ), с которым не хочет делить Владимира Путина.	2013-10-07 06:51:35	\N	news_1321
294	http://politprofi.ru/info/novosti-ryinka/er-vosstanovila-doverie	2013-10-16 19:02:14	3	Новости рынка: ЕР восстановила доверие	Результаты выборов показали, что "Единая Россия" восстановила доверие населения и это связано не с удачной кампанией, а с тем, что партия держит слово, заявил премьер-министр РФ, председатель ЕР Дмитрий Медведев на пленарном заседании съезда единороссов.	2013-10-07 06:49:14	\N	news_1320
295	http://politprofi.ru/info/novosti-ryinka/prejdevremennyie-vyiboryi-v-mosgordumu	2013-10-16 19:02:14	3	Новости рынка: Преждевременные выборы в Мосгордуму	Выборы в Московскую городскую думу запланированы на сентябрь следующего года, однако и партии, и будущие кандидаты уже начали готовиться к ним, при этом из территориальных избирательных комиссий поступает информация о том, что в декабре столичный парламент может самораспуститься и тогда голосование будет перенесено на март, пишут федеральные СМИ.	2013-10-07 06:47:26	\N	news_1319
296	http://politprofi.ru/info/novosti-ryinka/pochem-vzyali-moskvu	2013-10-16 19:02:14	3	Новости рынка: Почем взяли Москву	Мэр Москвы Сергей Собянин потратил на избирательную кампанию 107 млн рублей. При этом в борьбе за пост столичного градоначальника он не использовал собственные денежные средства.	2013-10-07 06:46:14	\N	news_1318
297	http://politprofi.ru/info/novosti-ryinka/sr-smenit-rukovodstvo	2013-10-16 19:02:14	3	Новости рынка: "СР" сменит руководство	Об этом СМИ заявил председатель справороссов Николай Левичев. По его словам, съезд пройдет в конце октября в соответствии с решением Президиума Центрального совета партии в связи с истечением сроков полномочий ее руководящих органов.	2013-10-07 06:45:19	\N	news_1317
298	http://politprofi.ru/info/novosti-ryinka/hinshteyn-nazval-kolleg-po-partii-izlishne-samouverennyimi	2013-10-16 19:02:14	3	Новости рынка: Хинштейн назвал коллег по партии излишне самоуверенными	Внутриэлитные конфликты и излишняя самоуверенность стали одними из причин проигрыша "Единой России" на выборах мэра в Екатеринбурге и Петрозаводске, считает депутат-единоросс Александр Хинштейн.	2013-10-07 06:44:16	\N	news_1316
299	http://politprofi.ru/info/novosti-ryinka/peredumali-s-boykotom	2013-10-16 19:02:14	3	Новости рынка: Передумали с бойкотом	Партия КПРФ планирует выдвинуть своего кандидата на выборы главы региона в следующем году, даже несмотря на непреодолимый муниципальный фильтр, сообщает Барнаульский городской комитет КПРФ.	2013-10-02 13:09:19	\N	news_1315
300	http://politprofi.ru/info/novosti-ryinka/tomskih-izbirateley-pereschitayut	2013-10-16 19:02:14	3	Новости рынка: Томских избирателей пересчитают	Участковые избирательные комиссии со среды начнут уточнять списки избирателей в рамках подготовки к голосованию на выборах мэра Томска, сообщила СМИ председатель горизбиркома Татьяна Арбузова.	2013-10-02 13:08:06	\N	news_1314
301	http://politprofi.ru/info/novosti-ryinka/vyiboryi-mera-novosibirska-obeschayut-byit-jarkimi	2013-10-16 19:02:14	3	Новости рынка: Выборы мэра Новосибирска обещают быть жаркими	Такого мнения придерживается вице-губернатор области Виктор Козодой.	2013-10-02 13:05:02	\N	news_1312
303	http://politprofi.ru/info/novosti-ryinka/informatsiyu-o-dne-vyiborov-propechatayut	2013-10-16 19:02:14	3	Новости рынка: Информацию о дне выборов пропечатают	В России должны расширить доступ к информации о назначении выборов. Предполагается, что официальная информация о выборах будет размещаться не только в интернете, но и в печати.	2013-10-02 13:06:51	\N	news_1313
304	http://politprofi.ru/info/novosti-ryinka/obschestvo-zdorovo	2013-10-16 19:02:15	3	Новости рынка: Общество здорово	Глава Администрации президента РФ Сергей Иванов высказался по поводу диалога власти и оппозиции, а также дал оценку прошедшим в начале сентября выборам мэра Москвы.	2013-10-02 13:02:39	\N	news_1310
305	http://politprofi.ru/info/novosti-ryinka/prokuratura-schitaet-chto-royzmana-vyibrali-nezakonno	2013-10-16 19:02:15	3	Новости рынка: Прокуратура считает что Ройзмана выбрали незаконно	Прокуратура обнаружила нарушения во время заседания городской думы Екатеринбурга, на нем мэром города был официально утвержден выигравший выборы Евгений Ройзман.	2013-10-02 13:01:35	\N	news_1309
306	http://politprofi.ru/info/novosti-ryinka/usekli-vyiboryi	2013-10-16 19:02:15	3	Новости рынка: Усекли выборы	Вчера за новый порядок выборов главы Новосибирска, отменяющий проведение второго тура, проголосовали члены городского Совета депутатов. В Устав муниципалитета были внесены изменения, отменяющие правило абсолютного большинства.	2013-09-29 18:44:41	\N	news_1308
307	http://politprofi.ru/info/novosti-ryinka/blagoveschensku-vernuli-pryamyie-vyiboryi-mera	2013-10-16 19:02:15	3	Новости рынка: Благовещенску вернули прямые выборы мэра	На заседании думы Благовещенска был рассмотрен вопрос о возвращении прямых выборов мэра и внесении изменений в Устав муниципального образования. Предложение народные избранники одобрили единогласно.	2013-09-29 18:43:28	\N	news_1307
308	http://politprofi.ru/info/novosti-ryinka/grafu-protiv-vseh-mogut-vernut	2013-10-16 19:02:15	3	Новости рынка: Графу "Против всех" могут вернуть	Спикер Совета Федерации Валентина Матвиенко предложила вернуть в избирательные бюллетени графу «против всех». Соответствующее заявление бывшая губернатор Петербурга сделала во время открытия первого заседания осенней сессии Совфеда.	2013-09-29 18:41:53	\N	news_1306
309	http://politprofi.ru/info/novosti-ryinka/v-pskovskoy-oblasti-naznachili-vyiboryi	2013-10-16 19:02:15	3	Новости рынка: В Псковской области назначили выборы	24 сентября на заседании Собрания депутатов Великолукского района был рассмотрен вопрос о назначении даты выборов главы Великолукского района. Датой досрочных выборов решено назначить 15 декабря 2013 года.	2013-09-29 18:39:23	\N	news_1305
310	http://politprofi.ru/info/novosti-ryinka/vyiboram-poka-esche-doveryayut	2013-10-16 19:02:15	3	Новости рынка: Выборам пока еще доверяют	Доверие к итогам выборов за последние годы выросло, сообщает ВЦИОМ. 48% людей из населенных пунктов, где проходили выборы, считают их достоверными.	2013-09-29 18:38:10	\N	news_1304
\.


--
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: -
--

COPY media (id, type, source, data) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: -
--

COPY message (id, to_user_id, from_user_id, is_new, subject, text, created_at, updated_at, read_at, to_deleted, from_deleted) FROM stdin;
\.


--
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: -
--

COPY post (id, user_id, subject, text, is_media, created_at, updated_at, cx, cy, cx_p_cy, cx_m_cy, post_id, deleted_at) FROM stdin;
\.


--
-- Data for Name: post_name_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY post_name_user (post_id, user_id) FROM stdin;
\.


--
-- Data for Name: smtp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY smtp (id, host, username, password, port, encryption, timeout, "extensionHandlers", using_count, banned) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tag (id, name, created_at, updated_at) FROM stdin;
1	tg	2013-10-11 17:28:05	\N
2	Taggg_with_maximal_length	2013-10-11 17:28:05	\N
3	Simple_tag	2013-10-11 17:28:05	\N
4	porno_is_here	2013-10-11 17:28:06	\N
5	666	2013-10-11 17:28:06	\N
6	porno_is_666	2013-10-11 17:39:39	\N
7	tg2	2013-10-11 17:39:39	\N
8	Simple_very_tag	2013-10-11 17:39:40	\N
9	Taggg_with_max_length	2013-10-11 17:39:40	\N
\.


--
-- Data for Name: tag_place; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tag_place (id, user_id, tag_id, created_at, updated_at, cx, cy, cx_p_cy, cx_m_cy, weight) FROM stdin;
33	16	3	2013-10-11 17:28:09	\N	-96	324	228	-420	5
53	24	3	2013-10-11 17:28:12	\N	-61	43	-18	-104	6
69	30	4	2013-10-11 17:28:14	\N	-11	39	28	-50	3
56	26	1	2013-10-11 17:28:12	\N	175	327	502	-152	9
32	16	2	2013-10-11 17:28:09	\N	132	3	135	129	3
41	20	1	2013-10-11 17:28:10	\N	92	206	298	-114	5
34	16	4	2013-10-11 17:28:09	\N	195	-39	156	234	2
1	4	1	2013-10-11 17:28:05	\N	-73	149	76	-222	5
78	34	3	2013-10-11 17:28:15	\N	-80	-50	-130	-30	36
9	6	4	2013-10-11 17:28:06	\N	186	148	334	38	5
39	18	4	2013-10-11 17:28:10	\N	-82	-4	-86	-78	24
38	18	3	2013-10-11 17:28:10	\N	50	347	397	-297	2
17	10	2	2013-10-11 17:28:07	\N	-29	119	90	-148	5
11	8	1	2013-10-11 17:28:06	\N	27	340	367	-313	4
26	14	1	2013-10-11 17:28:08	\N	131	336	467	-205	8
40	18	5	2013-10-11 17:28:10	\N	127	73	200	54	3
12	8	2	2013-10-11 17:28:07	\N	31	153	184	-122	8
25	12	5	2013-10-11 17:28:08	\N	66	65	131	1	3
54	24	4	2013-10-11 17:28:12	\N	166	-21	145	187	5
81	36	1	2013-10-11 17:28:16	\N	11	106	117	-95	5
43	20	3	2013-10-11 17:28:10	\N	7	201	208	-194	11
50	22	5	2013-10-11 17:28:11	\N	12	249	261	-237	10
71	32	1	2013-10-11 17:28:14	\N	-33	263	230	-296	12
45	20	5	2013-10-11 17:28:10	\N	129	27	156	102	8
48	22	3	2013-10-11 17:28:11	\N	-16	315	299	-331	4
55	24	5	2013-10-11 17:28:12	\N	6	125	131	-119	5
14	8	4	2013-10-11 17:28:07	\N	-33	133	100	-166	4
65	28	5	2013-10-11 17:28:13	\N	24	326	350	-302	8
74	32	4	2013-10-11 17:28:15	\N	123	310	433	-187	8
15	8	5	2013-10-11 17:28:07	\N	-94	-26	-120	-68	43
30	14	5	2013-10-11 17:28:09	\N	-24	283	259	-307	8
21	12	1	2013-10-11 17:28:08	\N	146	42	188	104	10
3	4	3	2013-10-11 17:28:05	\N	91	237	328	-146	5
35	16	5	2013-10-11 17:28:09	\N	90	324	414	-234	5
6	6	1	2013-10-11 17:28:06	\N	119	66	185	53	9
36	18	1	2013-10-11 17:28:09	\N	46	167	213	-121	3
77	34	2	2013-10-11 17:28:15	\N	-7	75	68	-82	6
75	32	5	2013-10-11 17:28:15	\N	-36	-33	-69	-3	15
5	4	5	2013-10-11 17:28:06	\N	21	38	59	-17	3
73	32	3	2013-10-11 17:28:15	\N	176	96	272	80	8
7	6	2	2013-10-11 17:28:06	\N	-45	226	181	-271	7
80	34	5	2013-10-11 17:28:16	\N	102	261	363	-159	1
70	30	5	2013-10-11 17:28:14	\N	81	18	99	63	7
51	24	1	2013-10-11 17:28:11	\N	165	261	426	-96	7
68	30	3	2013-10-11 17:28:14	\N	180	16	196	164	4
79	34	4	2013-10-11 17:28:16	\N	196	115	311	81	3
20	10	5	2013-10-11 17:28:07	\N	199	10	209	189	3
22	12	2	2013-10-11 17:28:08	\N	2	183	185	-181	7
19	10	4	2013-10-11 17:28:07	\N	68	63	131	5	9
23	12	3	2013-10-11 17:28:08	\N	-67	246	179	-313	10
61	28	1	2013-10-11 17:28:13	\N	-13	-10	-23	-3	5
59	26	4	2013-10-11 17:28:12	\N	19	155	174	-136	4
58	26	3	2013-10-11 17:28:12	\N	95	96	191	-1	2
27	14	2	2013-10-11 17:28:08	\N	154	41	195	113	6
67	30	2	2013-10-11 17:28:13	\N	-22	239	217	-261	9
44	20	4	2013-10-11 17:28:10	\N	113	139	252	-26	7
4	4	4	2013-10-11 17:28:06	\N	-65	111	46	-176	8
47	22	2	2013-10-11 17:28:11	\N	189	205	394	-16	5
13	8	3	2013-10-11 17:28:07	\N	106	290	396	-184	5
60	26	5	2013-10-11 17:28:12	\N	-37	31	-6	-68	8
31	16	1	2013-10-11 17:28:09	\N	-17	271	254	-288	7
16	10	1	2013-10-11 17:28:07	\N	74	335	409	-261	8
18	10	3	2013-10-11 17:28:07	\N	58	159	217	-101	8
37	18	2	2013-10-11 17:28:09	\N	111	75	186	36	7
10	6	5	2013-10-11 17:28:06	\N	-86	144	58	-230	3
46	22	1	2013-10-11 17:28:11	\N	168	218	386	-50	4
64	28	4	2013-10-11 17:28:13	\N	93	2	95	91	3
66	30	1	2013-10-11 17:28:13	\N	82	171	253	-89	9
62	28	2	2013-10-11 17:28:13	\N	3	230	233	-227	5
28	14	3	2013-10-11 17:28:08	\N	-20	23	3	-43	4
29	14	4	2013-10-11 17:28:09	\N	-56	-32	-88	-24	26
57	26	2	2013-10-11 17:28:12	\N	31	71	102	-40	8
2	4	2	2013-10-11 17:28:05	\N	199	84	283	115	6
8	6	3	2013-10-11 17:28:06	\N	134	305	439	-171	3
49	22	4	2013-10-11 17:28:11	\N	154	288	442	-134	5
52	24	2	2013-10-11 17:28:11	\N	182	205	387	-23	6
24	12	4	2013-10-11 17:28:08	\N	51	46	97	5	9
155	64	5	2013-10-11 17:28:27	\N	5	54	59	-49	7
109	46	4	2013-10-11 17:28:20	\N	79	91	170	-12	8
130	54	5	2013-10-11 17:28:22	\N	128	-27	101	155	6
141	60	1	2013-10-11 17:28:24	\N	158	220	378	-62	5
150	62	5	2013-10-11 17:28:26	\N	171	197	368	-26	6
99	42	4	2013-10-11 17:28:18	\N	133	254	387	-121	11
108	46	3	2013-10-11 17:28:19	\N	89	-39	50	128	4
94	40	4	2013-10-11 17:28:18	\N	-87	230	143	-317	8
107	46	2	2013-10-11 17:28:19	\N	8	85	93	-77	7
154	64	4	2013-10-11 17:28:26	\N	115	277	392	-162	9
143	60	3	2013-10-11 17:28:25	\N	194	89	283	105	6
114	48	4	2013-10-11 17:28:20	\N	13	155	168	-142	4
85	36	5	2013-10-11 17:28:16	\N	-86	286	200	-372	5
111	48	1	2013-10-11 17:28:20	\N	27	162	189	-135	5
91	40	1	2013-10-11 17:28:17	\N	97	169	266	-72	10
118	50	3	2013-10-11 17:28:21	\N	-51	248	197	-299	6
84	36	4	2013-10-11 17:28:16	\N	52	66	118	-14	10
125	52	5	2013-10-11 17:28:22	\N	24	202	226	-178	7
128	54	3	2013-10-11 17:28:22	\N	-2	-2	-4	0	6
124	52	4	2013-10-11 17:28:22	\N	172	-17	155	189	6
42	20	2	2013-10-11 17:28:10	\N	115	95	210	20	10
120	50	5	2013-10-11 17:28:21	\N	168	293	461	-125	8
152	64	2	2013-10-11 17:28:26	\N	133	135	268	-2	8
102	44	2	2013-10-11 17:28:19	\N	-73	223	150	-296	9
127	54	2	2013-10-11 17:28:22	\N	69	105	174	-36	7
87	38	2	2013-10-11 17:28:17	\N	-28	160	132	-188	9
121	52	1	2013-10-11 17:28:21	\N	168	-21	147	189	4
135	56	5	2013-10-11 17:28:23	\N	79	159	238	-80	3
115	48	5	2013-10-11 17:28:20	\N	-37	-34	-71	-3	15
131	56	1	2013-10-11 17:28:22	\N	36	270	306	-234	4
142	60	2	2013-10-11 17:28:24	\N	157	-36	121	193	5
149	62	4	2013-10-11 17:28:26	\N	65	149	214	-84	4
101	44	1	2013-10-11 17:28:19	\N	190	60	250	130	6
97	42	2	2013-10-11 17:28:18	\N	-99	89	-10	-188	6
116	50	1	2013-10-11 17:28:21	\N	101	271	372	-170	4
105	44	5	2013-10-11 17:28:19	\N	156	326	482	-170	8
95	40	5	2013-10-11 17:28:18	\N	-89	86	-3	-175	6
137	58	2	2013-10-11 17:28:23	\N	49	229	278	-180	8
138	58	3	2013-10-11 17:28:24	\N	129	211	340	-82	8
113	48	3	2013-10-11 17:28:20	\N	191	283	474	-92	4
96	42	1	2013-10-11 17:28:18	\N	-77	-6	-83	-71	21
153	64	3	2013-10-11 17:28:26	\N	133	126	259	7	6
106	46	1	2013-10-11 17:28:19	\N	35	-25	10	60	8
83	36	3	2013-10-11 17:28:16	\N	-65	123	58	-188	6
117	50	2	2013-10-11 17:28:21	\N	20	1	21	19	5
126	54	1	2013-10-11 17:28:22	\N	59	308	367	-249	8
140	58	5	2013-10-11 17:28:24	\N	-5	163	158	-168	5
136	58	1	2013-10-11 17:28:23	\N	20	103	123	-83	5
158	66	3	2013-10-11 17:28:31	\N	170	-45	125	215	3
156	66	1	2013-10-11 17:28:27	\N	172	270	442	-98	6
89	38	4	2013-10-11 17:28:17	\N	194	90	284	104	5
146	62	1	2013-10-11 17:28:25	\N	-83	310	227	-393	7
82	36	2	2013-10-11 17:28:16	\N	147	350	497	-203	7
104	44	4	2013-10-11 17:28:19	\N	-85	-37	-122	-48	41
122	52	2	2013-10-11 17:28:21	\N	96	-21	75	117	6
90	38	5	2013-10-11 17:28:17	\N	-71	94	23	-165	8
98	42	3	2013-10-11 17:28:18	\N	190	317	507	-127	2
144	60	4	2013-10-11 17:28:25	\N	-53	-41	-94	-12	25
110	46	5	2013-10-11 17:28:20	\N	-82	72	-10	-154	6
129	54	4	2013-10-11 17:28:22	\N	21	-2	19	23	6
123	52	3	2013-10-11 17:28:21	\N	164	310	474	-146	5
100	42	5	2013-10-11 17:28:18	\N	20	289	309	-269	9
92	40	2	2013-10-11 17:28:17	\N	121	-7	114	128	4
133	56	3	2013-10-11 17:28:23	\N	-42	105	63	-147	8
86	38	1	2013-10-11 17:28:17	\N	138	92	230	46	9
88	38	3	2013-10-11 17:28:17	\N	-27	65	38	-92	4
119	50	4	2013-10-11 17:28:21	\N	48	-12	36	60	5
134	56	4	2013-10-11 17:28:23	\N	4	-30	-26	34	4
132	56	2	2013-10-11 17:28:23	\N	-71	287	216	-358	6
159	66	4	2013-10-11 17:28:31	\N	-11	337	326	-348	5
148	62	3	2013-10-11 17:28:26	\N	-17	165	148	-182	6
103	44	3	2013-10-11 17:28:19	\N	156	280	436	-124	6
151	64	1	2013-10-11 17:28:26	\N	-57	253	196	-310	6
139	58	4	2013-10-11 17:28:24	\N	158	-22	136	180	6
229	94	4	2013-10-11 17:28:42	\N	51	302	353	-251	3
227	94	2	2013-10-11 17:28:42	\N	73	197	270	-124	5
165	68	5	2013-10-11 17:28:32	\N	-35	157	122	-192	6
192	80	2	2013-10-11 17:28:37	\N	187	108	295	79	8
205	84	5	2013-10-11 17:28:39	\N	114	226	340	-112	1
174	72	4	2013-10-11 17:28:34	\N	149	209	358	-60	8
169	70	4	2013-10-11 17:28:32	\N	-76	96	20	-172	6
222	92	2	2013-10-11 17:28:41	\N	92	-1	91	93	6
147	62	2	2013-10-11 17:28:26	\N	131	81	212	50	7
184	76	4	2013-10-11 17:28:36	\N	30	134	164	-104	6
175	72	5	2013-10-11 17:28:34	\N	181	283	464	-102	7
223	92	3	2013-10-11 17:28:41	\N	-64	-48	-112	-16	31
194	80	4	2013-10-11 17:28:38	\N	29	249	278	-220	6
219	90	4	2013-10-11 17:28:41	\N	47	332	379	-285	5
171	72	1	2013-10-11 17:28:32	\N	-6	317	311	-323	7
185	76	5	2013-10-11 17:28:36	\N	86	72	158	14	4
176	74	1	2013-10-11 17:28:35	\N	191	-36	155	227	2
208	86	3	2013-10-11 17:28:39	\N	18	-23	-5	41	6
172	72	2	2013-10-11 17:28:33	\N	93	9	102	84	5
167	70	2	2013-10-11 17:28:32	\N	114	86	200	28	6
204	84	4	2013-10-11 17:28:39	\N	-15	339	324	-354	6
199	82	4	2013-10-11 17:28:38	\N	-50	218	168	-268	1
230	94	5	2013-10-11 17:28:42	\N	88	344	432	-256	3
186	78	1	2013-10-11 17:28:37	\N	44	176	220	-132	4
211	88	1	2013-10-11 17:28:40	\N	-75	212	137	-287	3
233	96	3	2013-10-11 17:28:43	\N	-37	302	265	-339	5
190	78	5	2013-10-11 17:28:37	\N	-84	210	126	-294	4
203	84	3	2013-10-11 17:28:39	\N	80	222	302	-142	4
202	84	2	2013-10-11 17:28:39	\N	153	192	345	-39	4
163	68	3	2013-10-11 17:28:31	\N	134	-26	108	160	8
170	70	5	2013-10-11 17:28:32	\N	-40	-46	-86	6	9
187	78	2	2013-10-11 17:28:37	\N	-29	-30	-59	1	11
180	74	5	2013-10-11 17:28:35	\N	39	140	179	-101	4
193	80	3	2013-10-11 17:28:37	\N	71	62	133	9	4
209	86	4	2013-10-11 17:28:39	\N	142	320	462	-178	5
168	70	3	2013-10-11 17:28:32	\N	91	190	281	-99	3
217	90	2	2013-10-11 17:28:40	\N	70	120	190	-50	5
220	90	5	2013-10-11 17:28:41	\N	66	66	132	0	4
225	92	5	2013-10-11 17:28:42	\N	35	213	248	-178	9
181	76	1	2013-10-11 17:28:36	\N	77	-5	72	82	8
215	88	5	2013-10-11 17:28:40	\N	159	346	505	-187	6
236	98	1	2013-10-11 17:28:43	\N	-62	-12	-74	-50	20
212	88	2	2013-10-11 17:28:40	\N	-87	88	1	-175	7
237	98	2	2013-10-11 17:28:43	\N	54	244	298	-190	8
196	82	1	2013-10-11 17:28:38	\N	-16	243	227	-259	8
231	96	1	2013-10-11 17:28:42	\N	123	235	358	-112	5
207	86	2	2013-10-11 17:28:39	\N	114	236	350	-122	5
198	82	3	2013-10-11 17:28:38	\N	174	190	364	-16	5
183	76	3	2013-10-11 17:28:36	\N	178	-16	162	194	8
166	70	1	2013-10-11 17:28:32	\N	111	162	273	-51	8
160	66	5	2013-10-11 17:28:31	\N	139	85	224	54	3
179	74	4	2013-10-11 17:28:35	\N	-91	37	-54	-128	3
112	48	2	2013-10-11 17:28:20	\N	-57	347	290	-404	3
210	86	5	2013-10-11 17:28:40	\N	122	196	318	-74	5
161	68	1	2013-10-11 17:28:31	\N	97	70	167	27	8
173	72	3	2013-10-11 17:28:33	\N	-58	202	144	-260	4
224	92	4	2013-10-11 17:28:41	\N	-10	93	83	-103	2
214	88	4	2013-10-11 17:28:40	\N	109	295	404	-186	7
195	80	5	2013-10-11 17:28:38	\N	128	306	434	-178	5
200	82	5	2013-10-11 17:28:38	\N	136	151	287	-15	4
188	78	3	2013-10-11 17:28:37	\N	185	252	437	-67	7
189	78	4	2013-10-11 17:28:37	\N	-87	215	128	-302	10
157	66	2	2013-10-11 17:28:27	\N	177	341	518	-164	4
177	74	2	2013-10-11 17:28:35	\N	22	320	342	-298	7
213	88	3	2013-10-11 17:28:40	\N	21	-49	-28	70	5
216	90	1	2013-10-11 17:28:40	\N	-81	279	198	-360	8
235	96	5	2013-10-11 17:28:43	\N	125	317	442	-192	4
162	68	2	2013-10-11 17:28:31	\N	-56	344	288	-400	3
206	86	1	2013-10-11 17:28:39	\N	-45	0	-45	-45	10
228	94	3	2013-10-11 17:28:42	\N	11	177	188	-166	6
226	94	1	2013-10-11 17:28:42	\N	100	280	380	-180	5
178	74	3	2013-10-11 17:28:35	\N	152	228	380	-76	11
232	96	2	2013-10-11 17:28:42	\N	3	-15	-12	18	7
191	80	1	2013-10-11 17:28:37	\N	-24	318	294	-342	5
182	76	2	2013-10-11 17:28:36	\N	175	336	511	-161	4
254	104	4	2013-10-11 17:28:46	\N	131	85	216	46	8
265	108	5	2013-10-11 17:28:48	\N	-98	348	250	-446	0
298	122	3	2013-10-11 17:28:52	\N	88	290	378	-202	3
286	118	1	2013-10-11 17:28:51	\N	152	-12	140	164	4
282	116	2	2013-10-11 17:28:50	\N	24	302	326	-278	6
273	112	3	2013-10-11 17:28:49	\N	-29	209	180	-238	8
249	102	4	2013-10-11 17:28:45	\N	140	323	463	-183	5
308	126	3	2013-10-11 17:28:54	\N	-90	143	53	-233	2
241	100	1	2013-10-11 17:28:44	\N	142	349	491	-207	6
276	114	1	2013-10-11 17:28:49	\N	78	6	84	72	7
288	118	3	2013-10-11 17:28:51	\N	24	229	253	-205	6
279	114	4	2013-10-11 17:28:50	\N	192	68	260	124	3
274	112	4	2013-10-11 17:28:49	\N	-85	294	209	-379	4
251	104	1	2013-10-11 17:28:45	\N	145	281	426	-136	6
291	120	1	2013-10-11 17:28:51	\N	-67	141	74	-208	6
218	90	3	2013-10-11 17:28:41	\N	81	258	339	-177	8
259	106	4	2013-10-11 17:28:47	\N	161	277	438	-116	4
270	110	5	2013-10-11 17:28:48	\N	0	82	82	-82	7
307	126	2	2013-10-11 17:28:54	\N	123	138	261	-15	5
278	114	3	2013-10-11 17:28:50	\N	115	72	187	43	2
304	124	4	2013-10-11 17:28:53	\N	136	256	392	-120	11
283	116	3	2013-10-11 17:28:50	\N	138	193	331	-55	7
260	106	5	2013-10-11 17:28:47	\N	-8	125	117	-133	5
289	118	4	2013-10-11 17:28:51	\N	74	124	198	-50	8
310	126	5	2013-10-11 17:28:54	\N	97	197	294	-100	4
285	116	5	2013-10-11 17:28:51	\N	175	320	495	-145	11
295	120	5	2013-10-11 17:28:52	\N	-27	211	184	-238	8
297	122	2	2013-10-11 17:28:52	\N	3	125	128	-122	6
258	106	3	2013-10-11 17:28:47	\N	178	90	268	88	8
201	84	1	2013-10-11 17:28:38	\N	166	335	501	-169	11
262	108	2	2013-10-11 17:28:47	\N	168	82	250	86	7
240	98	5	2013-10-11 17:28:43	\N	162	50	212	112	4
244	100	4	2013-10-11 17:28:44	\N	86	294	380	-208	7
255	104	5	2013-10-11 17:28:46	\N	117	303	420	-186	5
312	128	2	2013-10-11 17:28:54	\N	-79	196	117	-275	3
301	124	1	2013-10-11 17:28:53	\N	19	-29	-10	48	6
238	98	3	2013-10-11 17:28:43	\N	45	82	127	-37	12
253	104	3	2013-10-11 17:28:45	\N	129	39	168	90	5
302	124	2	2013-10-11 17:28:53	\N	32	131	163	-99	9
256	106	1	2013-10-11 17:28:46	\N	176	199	375	-23	7
290	118	5	2013-10-11 17:28:51	\N	2	214	216	-212	6
72	32	2	2013-10-11 17:28:14	\N	43	154	197	-111	6
263	108	3	2013-10-11 17:28:47	\N	37	150	187	-113	8
261	108	1	2013-10-11 17:28:47	\N	-79	106	27	-185	6
252	104	2	2013-10-11 17:28:45	\N	-49	183	134	-232	4
269	110	4	2013-10-11 17:28:48	\N	200	177	377	23	6
164	68	4	2013-10-11 17:28:32	\N	-5	270	265	-275	6
275	112	5	2013-10-11 17:28:49	\N	88	120	208	-32	5
250	102	5	2013-10-11 17:28:45	\N	-4	293	289	-297	7
277	114	2	2013-10-11 17:28:49	\N	133	348	481	-215	8
284	116	4	2013-10-11 17:28:50	\N	-76	95	19	-171	6
271	112	1	2013-10-11 17:28:48	\N	-23	111	88	-134	4
294	120	4	2013-10-11 17:28:52	\N	28	130	158	-102	5
311	128	1	2013-10-11 17:28:54	\N	8	247	255	-239	6
287	118	2	2013-10-11 17:28:51	\N	68	23	91	45	6
303	124	3	2013-10-11 17:28:53	\N	80	-50	30	130	2
309	126	4	2013-10-11 17:28:54	\N	82	323	405	-241	8
281	116	1	2013-10-11 17:28:50	\N	-32	349	317	-381	1
300	122	5	2013-10-11 17:28:53	\N	56	325	381	-269	10
280	114	5	2013-10-11 17:28:50	\N	79	173	252	-94	4
306	126	1	2013-10-11 17:28:53	\N	149	284	433	-135	7
292	120	2	2013-10-11 17:28:52	\N	-43	97	54	-140	4
267	110	2	2013-10-11 17:28:48	\N	31	233	264	-202	8
246	102	1	2013-10-11 17:28:44	\N	106	254	360	-148	7
305	124	5	2013-10-11 17:28:53	\N	62	319	381	-257	10
248	102	3	2013-10-11 17:28:45	\N	9	173	182	-164	5
257	106	2	2013-10-11 17:28:47	\N	-69	-16	-85	-53	32
242	100	2	2013-10-11 17:28:44	\N	65	191	256	-126	6
266	110	1	2013-10-11 17:28:48	\N	176	23	199	153	7
264	108	4	2013-10-11 17:28:47	\N	25	37	62	-12	5
272	112	2	2013-10-11 17:28:49	\N	65	298	363	-233	6
245	100	5	2013-10-11 17:28:44	\N	6	139	145	-133	5
234	96	4	2013-10-11 17:28:43	\N	4	269	273	-265	7
293	120	3	2013-10-11 17:28:52	\N	176	83	259	93	6
145	60	5	2013-10-11 17:28:25	\N	73	155	228	-82	4
239	98	4	2013-10-11 17:28:43	\N	143	245	388	-102	12
243	100	3	2013-10-11 17:28:44	\N	82	235	317	-153	7
355	144	5	2013-10-11 17:29:06	\N	130	267	397	-137	3
377	154	2	2013-10-11 17:29:09	\N	-94	149	55	-243	3
347	142	2	2013-10-11 17:29:03	\N	139	234	373	-95	6
354	144	4	2013-10-11 17:29:06	\N	106	172	278	-66	3
352	144	2	2013-10-11 17:29:05	\N	193	159	352	34	1
357	146	2	2013-10-11 17:29:06	\N	179	137	316	42	2
313	128	3	2013-10-11 17:28:54	\N	161	21	182	140	7
356	146	1	2013-10-11 17:29:06	\N	86	64	150	22	5
329	134	4	2013-10-11 17:29:00	\N	193	248	441	-55	5
378	154	3	2013-10-11 17:29:09	\N	172	327	499	-155	2
341	140	1	2013-10-11 17:29:02	\N	144	58	202	86	9
320	130	5	2013-10-11 17:28:55	\N	181	20	201	161	8
361	148	1	2013-10-11 17:29:07	\N	-75	157	82	-232	4
340	138	5	2013-10-11 17:29:02	\N	65	96	161	-31	4
367	150	2	2013-10-11 17:29:07	\N	-64	142	78	-206	2
321	132	1	2013-10-11 17:28:55	\N	21	-13	8	34	6
369	150	4	2013-10-11 17:29:08	\N	176	68	244	108	7
360	146	5	2013-10-11 17:29:06	\N	-92	104	12	-196	4
353	144	3	2013-10-11 17:29:05	\N	2	208	210	-206	8
328	134	3	2013-10-11 17:29:00	\N	51	326	377	-275	4
335	136	5	2013-10-11 17:29:01	\N	83	17	100	66	7
380	154	5	2013-10-11 17:29:10	\N	-3	284	281	-287	5
334	136	4	2013-10-11 17:29:01	\N	184	256	440	-72	6
388	158	3	2013-10-11 17:29:11	\N	22	251	273	-229	6
373	152	3	2013-10-11 17:29:09	\N	146	224	370	-78	8
379	154	4	2013-10-11 17:29:10	\N	100	245	345	-145	7
315	128	5	2013-10-11 17:28:55	\N	-84	-47	-131	-37	38
343	140	3	2013-10-11 17:29:02	\N	-58	90	32	-148	8
323	132	3	2013-10-11 17:28:56	\N	130	29	159	101	5
345	140	5	2013-10-11 17:29:03	\N	61	210	271	-149	6
332	136	2	2013-10-11 17:29:01	\N	22	7	29	15	6
364	148	4	2013-10-11 17:29:07	\N	173	320	493	-147	5
349	142	4	2013-10-11 17:29:05	\N	-51	6	-45	-57	17
337	138	2	2013-10-11 17:29:01	\N	-85	-4	-89	-81	28
316	130	1	2013-10-11 17:28:55	\N	87	-48	39	135	4
376	154	1	2013-10-11 17:29:09	\N	-30	260	230	-290	10
385	156	5	2013-10-11 17:29:11	\N	7	92	99	-85	5
314	128	4	2013-10-11 17:28:55	\N	73	67	140	6	10
383	156	3	2013-10-11 17:29:10	\N	27	89	116	-62	10
319	130	4	2013-10-11 17:28:55	\N	-41	50	9	-91	4
326	134	1	2013-10-11 17:29:00	\N	186	116	302	70	10
325	132	5	2013-10-11 17:28:57	\N	-31	322	291	-353	4
363	148	3	2013-10-11 17:29:07	\N	-27	136	109	-163	3
330	134	5	2013-10-11 17:29:00	\N	-90	221	131	-311	4
372	152	2	2013-10-11 17:29:09	\N	-18	229	211	-247	7
374	152	4	2013-10-11 17:29:09	\N	-81	232	151	-313	9
318	130	3	2013-10-11 17:28:55	\N	-93	209	116	-302	2
375	152	5	2013-10-11 17:29:09	\N	-33	199	166	-232	8
342	140	2	2013-10-11 17:29:02	\N	181	12	193	169	2
370	150	5	2013-10-11 17:29:08	\N	13	243	256	-230	11
366	150	1	2013-10-11 17:29:07	\N	61	331	392	-270	9
247	102	2	2013-10-11 17:28:44	\N	-59	277	218	-336	12
350	142	5	2013-10-11 17:29:05	\N	131	-4	127	135	7
348	142	3	2013-10-11 17:29:05	\N	-51	46	-5	-97	4
333	136	3	2013-10-11 17:29:01	\N	-16	293	277	-309	3
76	34	1	2013-10-11 17:28:15	\N	116	53	169	63	7
387	158	2	2013-10-11 17:29:11	\N	25	110	135	-85	8
368	150	3	2013-10-11 17:29:08	\N	91	241	332	-150	6
351	144	1	2013-10-11 17:29:05	\N	20	301	321	-281	3
339	138	4	2013-10-11 17:29:02	\N	52	52	104	0	10
359	146	4	2013-10-11 17:29:06	\N	125	0	125	125	4
324	132	4	2013-10-11 17:28:56	\N	131	-32	99	163	2
346	142	1	2013-10-11 17:29:03	\N	141	7	148	134	6
327	134	2	2013-10-11 17:29:00	\N	189	87	276	102	7
365	148	5	2013-10-11 17:29:07	\N	-84	208	124	-292	4
338	138	3	2013-10-11 17:29:02	\N	-9	17	8	-26	6
371	152	1	2013-10-11 17:29:08	\N	149	-40	109	189	4
389	158	4	2013-10-11 17:29:11	\N	183	151	334	32	7
362	148	2	2013-10-11 17:29:07	\N	65	50	115	15	6
384	156	4	2013-10-11 17:29:10	\N	98	235	333	-137	5
296	122	1	2013-10-11 17:28:52	\N	121	-7	114	128	6
331	136	1	2013-10-11 17:29:01	\N	188	51	239	137	7
322	132	2	2013-10-11 17:28:56	\N	90	60	150	30	6
358	146	3	2013-10-11 17:29:06	\N	148	235	383	-87	7
393	160	3	2013-10-11 17:29:12	\N	47	340	387	-293	3
399	162	4	2013-10-11 17:29:13	\N	-100	132	32	-232	0
402	164	2	2013-10-11 17:29:13	\N	-84	345	261	-429	2
441	180	1	2013-10-11 17:29:19	\N	160	70	230	90	9
403	164	3	2013-10-11 17:29:13	\N	-51	23	-28	-74	6
421	172	1	2013-10-11 17:29:16	\N	173	350	523	-177	6
429	174	4	2013-10-11 17:29:17	\N	142	132	274	10	3
436	178	1	2013-10-11 17:29:18	\N	-19	149	130	-168	3
439	178	4	2013-10-11 17:29:18	\N	-80	229	149	-309	8
463	188	3	2013-10-11 17:29:22	\N	126	140	266	-14	5
426	174	1	2013-10-11 17:29:16	\N	177	334	511	-157	8
460	186	5	2013-10-11 17:29:22	\N	103	35	138	68	7
407	166	2	2013-10-11 17:29:14	\N	21	304	325	-283	7
394	160	4	2013-10-11 17:29:12	\N	182	310	492	-128	5
408	166	3	2013-10-11 17:29:14	\N	-81	258	177	-339	8
431	176	1	2013-10-11 17:29:17	\N	98	79	177	19	8
449	182	4	2013-10-11 17:29:20	\N	120	57	177	63	6
437	178	2	2013-10-11 17:29:18	\N	25	125	150	-100	7
462	188	2	2013-10-11 17:29:22	\N	-6	199	193	-205	5
93	40	3	2013-10-11 17:28:18	\N	-16	110	94	-126	5
433	176	3	2013-10-11 17:29:17	\N	147	203	350	-56	9
442	180	2	2013-10-11 17:29:19	\N	69	325	394	-256	5
430	174	5	2013-10-11 17:29:17	\N	36	284	320	-248	9
424	172	4	2013-10-11 17:29:16	\N	161	230	391	-69	9
459	186	4	2013-10-11 17:29:22	\N	-91	205	114	-296	11
432	176	2	2013-10-11 17:29:17	\N	7	13	20	-6	5
396	162	1	2013-10-11 17:29:12	\N	76	316	392	-240	9
400	162	5	2013-10-11 17:29:13	\N	-44	117	73	-161	3
391	160	1	2013-10-11 17:29:11	\N	19	124	143	-105	4
425	172	5	2013-10-11 17:29:16	\N	11	91	102	-80	4
444	180	4	2013-10-11 17:29:20	\N	21	229	250	-208	6
410	166	5	2013-10-11 17:29:14	\N	32	273	305	-241	8
414	168	4	2013-10-11 17:29:15	\N	-46	54	8	-100	3
457	186	2	2013-10-11 17:29:21	\N	-42	-50	-92	8	15
452	184	2	2013-10-11 17:29:21	\N	-7	243	236	-250	6
451	184	1	2013-10-11 17:29:21	\N	178	275	453	-97	4
443	180	3	2013-10-11 17:29:20	\N	-73	294	221	-367	10
382	156	2	2013-10-11 17:29:10	\N	69	94	163	-25	7
412	168	2	2013-10-11 17:29:14	\N	186	303	489	-117	1
299	122	4	2013-10-11 17:28:52	\N	17	273	290	-256	7
406	166	1	2013-10-11 17:29:14	\N	189	128	317	61	8
447	182	2	2013-10-11 17:29:20	\N	-45	12	-33	-57	4
422	172	2	2013-10-11 17:29:16	\N	-19	149	130	-168	10
455	184	5	2013-10-11 17:29:21	\N	-76	50	-26	-126	4
465	188	5	2013-10-11 17:29:22	\N	-41	228	187	-269	6
405	164	5	2013-10-11 17:29:13	\N	12	326	338	-314	7
401	164	1	2013-10-11 17:29:13	\N	-55	124	69	-179	6
434	176	4	2013-10-11 17:29:18	\N	-90	304	214	-394	2
464	188	4	2013-10-11 17:29:22	\N	-4	290	286	-294	5
416	170	1	2013-10-11 17:29:15	\N	139	144	283	-5	2
423	172	3	2013-10-11 17:29:16	\N	-18	81	63	-99	6
411	168	1	2013-10-11 17:29:14	\N	76	-16	60	92	9
415	168	5	2013-10-11 17:29:15	\N	-29	281	252	-310	8
409	166	4	2013-10-11 17:29:14	\N	185	125	310	60	5
390	158	5	2013-10-11 17:29:11	\N	-60	61	1	-121	5
386	158	1	2013-10-11 17:29:11	\N	72	322	394	-250	10
420	170	5	2013-10-11 17:29:16	\N	56	268	324	-212	5
413	168	3	2013-10-11 17:29:15	\N	176	262	438	-86	8
461	188	1	2013-10-11 17:29:22	\N	24	208	232	-184	2
419	170	4	2013-10-11 17:29:15	\N	106	22	128	84	4
448	182	3	2013-10-11 17:29:20	\N	103	105	208	-2	3
446	182	1	2013-10-11 17:29:20	\N	156	56	212	100	9
438	178	3	2013-10-11 17:29:18	\N	0	-10	-10	10	7
445	180	5	2013-10-11 17:29:20	\N	-63	-26	-89	-37	38
397	162	2	2013-10-11 17:29:12	\N	-66	51	-15	-117	3
427	174	2	2013-10-11 17:29:16	\N	56	-27	29	83	6
458	186	3	2013-10-11 17:29:22	\N	58	250	308	-192	5
435	176	5	2013-10-11 17:29:18	\N	175	81	256	94	3
395	160	5	2013-10-11 17:29:12	\N	191	105	296	86	4
417	170	2	2013-10-11 17:29:15	\N	116	307	423	-191	6
398	162	3	2013-10-11 17:29:12	\N	23	323	346	-300	3
453	184	3	2013-10-11 17:29:21	\N	-72	271	199	-343	11
440	178	5	2013-10-11 17:29:19	\N	-65	8	-57	-73	20
381	156	1	2013-10-11 17:29:10	\N	63	341	404	-278	8
521	212	1	2013-10-11 17:29:34	\N	62	220	282	-158	4
404	164	4	2013-10-11 17:29:13	\N	160	333	493	-173	4
498	202	3	2013-10-11 17:29:27	\N	138	337	475	-199	0
469	190	4	2013-10-11 17:29:23	\N	131	262	393	-131	8
520	210	5	2013-10-11 17:29:34	\N	83	287	370	-204	1
475	192	5	2013-10-11 17:29:24	\N	84	29	113	55	6
534	216	4	2013-10-11 17:29:38	\N	128	140	268	-12	5
467	190	2	2013-10-11 17:29:23	\N	-74	88	14	-162	7
479	194	4	2013-10-11 17:29:24	\N	17	186	203	-169	5
532	216	2	2013-10-11 17:29:38	\N	-76	-8	-84	-68	31
541	220	1	2013-10-11 17:29:39	\N	184	19	203	165	5
535	216	5	2013-10-11 17:29:38	\N	64	211	275	-147	5
470	190	5	2013-10-11 17:29:23	\N	-15	41	26	-56	7
487	198	2	2013-10-11 17:29:25	\N	162	204	366	-42	5
454	184	4	2013-10-11 17:29:21	\N	-91	217	126	-308	9
514	208	4	2013-10-11 17:29:33	\N	-99	243	144	-342	7
476	194	1	2013-10-11 17:29:24	\N	-17	222	205	-239	4
471	192	1	2013-10-11 17:29:23	\N	-96	343	247	-439	2
538	218	3	2013-10-11 17:29:39	\N	136	187	323	-51	6
515	208	5	2013-10-11 17:29:33	\N	-25	-40	-65	15	6
511	208	1	2013-10-11 17:29:33	\N	79	31	110	48	6
492	200	2	2013-10-11 17:29:26	\N	150	252	402	-102	4
536	218	1	2013-10-11 17:29:38	\N	64	-38	26	102	9
490	198	5	2013-10-11 17:29:26	\N	-54	17	-37	-71	13
519	210	4	2013-10-11 17:29:34	\N	-58	131	73	-189	7
483	196	3	2013-10-11 17:29:25	\N	33	70	103	-37	11
477	194	2	2013-10-11 17:29:24	\N	-91	148	57	-239	4
482	196	2	2013-10-11 17:29:25	\N	-81	228	147	-309	6
516	210	1	2013-10-11 17:29:34	\N	33	87	120	-54	4
499	202	4	2013-10-11 17:29:31	\N	73	39	112	34	8
527	214	2	2013-10-11 17:29:37	\N	61	326	387	-265	4
428	174	3	2013-10-11 17:29:17	\N	191	220	411	-29	5
486	198	1	2013-10-11 17:29:25	\N	123	232	355	-109	5
505	204	5	2013-10-11 17:29:32	\N	-65	273	208	-338	5
472	192	2	2013-10-11 17:29:23	\N	172	-48	124	220	2
528	214	3	2013-10-11 17:29:37	\N	-100	34	-66	-134	2
504	204	4	2013-10-11 17:29:32	\N	42	338	380	-296	3
494	200	4	2013-10-11 17:29:27	\N	172	119	291	53	3
466	190	1	2013-10-11 17:29:23	\N	8	-4	4	12	5
485	196	5	2013-10-11 17:29:25	\N	-47	161	114	-208	8
513	208	3	2013-10-11 17:29:33	\N	19	220	239	-201	6
524	212	4	2013-10-11 17:29:37	\N	120	263	383	-143	11
526	214	1	2013-10-11 17:29:37	\N	-75	91	16	-166	5
507	206	2	2013-10-11 17:29:32	\N	125	342	467	-217	10
539	218	4	2013-10-11 17:29:39	\N	127	160	287	-33	5
522	212	2	2013-10-11 17:29:35	\N	-14	22	8	-36	3
508	206	3	2013-10-11 17:29:32	\N	129	-20	109	149	9
537	218	2	2013-10-11 17:29:38	\N	135	301	436	-166	6
506	206	1	2013-10-11 17:29:32	\N	-58	-12	-70	-46	20
496	202	1	2013-10-11 17:29:27	\N	182	117	299	65	10
542	220	2	2013-10-11 17:29:39	\N	126	108	234	18	10
473	192	3	2013-10-11 17:29:24	\N	114	142	256	-28	7
502	204	2	2013-10-11 17:29:32	\N	51	65	116	-14	6
518	210	3	2013-10-11 17:29:34	\N	39	289	328	-250	5
501	204	1	2013-10-11 17:29:31	\N	5	335	340	-330	4
493	200	3	2013-10-11 17:29:26	\N	169	119	288	50	7
533	216	3	2013-10-11 17:29:38	\N	-91	-13	-104	-78	24
488	198	3	2013-10-11 17:29:26	\N	128	275	403	-147	5
503	204	3	2013-10-11 17:29:32	\N	-9	119	110	-128	3
344	140	4	2013-10-11 17:29:03	\N	58	23	81	35	4
481	196	1	2013-10-11 17:29:25	\N	-54	23	-31	-77	5
529	214	4	2013-10-11 17:29:37	\N	-54	23	-31	-77	7
491	200	1	2013-10-11 17:29:26	\N	122	296	418	-174	7
468	190	3	2013-10-11 17:29:23	\N	196	220	416	-24	5
489	198	4	2013-10-11 17:29:26	\N	165	306	471	-141	9
497	202	2	2013-10-11 17:29:27	\N	-6	314	308	-320	6
480	194	5	2013-10-11 17:29:24	\N	73	289	362	-216	4
474	192	4	2013-10-11 17:29:24	\N	174	189	363	-15	10
530	214	5	2013-10-11 17:29:37	\N	-27	176	149	-203	9
525	212	5	2013-10-11 17:29:37	\N	2	32	34	-30	6
495	200	5	2013-10-11 17:29:27	\N	154	33	187	121	9
484	196	4	2013-10-11 17:29:25	\N	15	186	201	-171	5
531	216	1	2013-10-11 17:29:38	\N	16	269	285	-253	5
512	208	2	2013-10-11 17:29:33	\N	-37	271	234	-308	7
540	218	5	2013-10-11 17:29:39	\N	139	18	157	121	10
523	212	3	2013-10-11 17:29:36	\N	177	85	262	92	6
553	224	3	2013-10-11 17:29:41	\N	120	82	202	38	3
555	224	5	2013-10-11 17:29:41	\N	141	298	439	-157	5
561	228	1	2013-10-11 17:29:42	\N	192	254	446	-62	3
594	240	4	2013-10-11 17:29:47	\N	-52	32	-20	-84	6
517	210	2	2013-10-11 17:29:34	\N	-48	307	259	-355	8
600	242	5	2013-10-11 17:29:48	\N	-28	88	60	-116	5
605	244	5	2013-10-11 17:29:48	\N	1	172	173	-171	4
588	238	3	2013-10-11 17:29:46	\N	199	255	454	-56	5
598	242	3	2013-10-11 17:29:47	\N	99	338	437	-239	2
610	246	5	2013-10-11 17:29:49	\N	191	213	404	-22	2
577	234	2	2013-10-11 17:29:44	\N	-100	160	60	-260	3
607	246	2	2013-10-11 17:29:49	\N	-96	164	68	-260	3
543	220	3	2013-10-11 17:29:39	\N	-15	-17	-32	2	5
554	224	4	2013-10-11 17:29:41	\N	165	170	335	-5	9
547	222	2	2013-10-11 17:29:40	\N	5	253	258	-248	4
565	228	5	2013-10-11 17:29:43	\N	51	131	182	-80	5
612	248	2	2013-10-11 17:29:49	\N	164	195	359	-31	6
63	28	3	2013-10-11 17:28:13	\N	-82	117	35	-199	7
566	230	1	2013-10-11 17:29:43	\N	186	319	505	-133	7
611	248	1	2013-10-11 17:29:49	\N	98	33	131	65	5
570	230	5	2013-10-11 17:29:43	\N	193	143	336	50	2
557	226	2	2013-10-11 17:29:42	\N	85	54	139	31	5
571	232	1	2013-10-11 17:29:44	\N	137	288	425	-151	6
597	242	2	2013-10-11 17:29:47	\N	-43	-45	-88	2	16
604	244	4	2013-10-11 17:29:48	\N	-34	294	260	-328	4
603	244	3	2013-10-11 17:29:48	\N	32	64	96	-32	10
614	248	4	2013-10-11 17:29:50	\N	-82	56	-26	-138	3
544	220	4	2013-10-11 17:29:39	\N	106	300	406	-194	8
616	250	1	2013-10-11 17:29:50	\N	106	181	287	-75	11
576	234	1	2013-10-11 17:29:44	\N	-2	304	302	-306	7
551	224	1	2013-10-11 17:29:40	\N	-88	219	131	-307	3
450	182	5	2013-10-11 17:29:20	\N	157	120	277	37	5
550	222	5	2013-10-11 17:29:40	\N	-14	250	236	-264	9
564	228	4	2013-10-11 17:29:43	\N	104	350	454	-246	3
618	250	3	2013-10-11 17:29:50	\N	-82	293	211	-375	9
578	234	3	2013-10-11 17:29:45	\N	-89	330	241	-419	4
593	240	3	2013-10-11 17:29:47	\N	-75	-50	-125	-25	36
589	238	4	2013-10-11 17:29:46	\N	102	247	349	-145	9
580	234	5	2013-10-11 17:29:45	\N	-59	-16	-75	-43	28
590	238	5	2013-10-11 17:29:46	\N	55	221	276	-166	6
591	240	1	2013-10-11 17:29:46	\N	51	-44	7	95	6
572	232	2	2013-10-11 17:29:44	\N	22	170	192	-148	6
587	238	2	2013-10-11 17:29:46	\N	66	307	373	-241	5
575	232	5	2013-10-11 17:29:44	\N	121	37	158	84	5
568	230	3	2013-10-11 17:29:43	\N	169	284	453	-115	5
549	222	4	2013-10-11 17:29:40	\N	186	263	449	-77	6
595	240	5	2013-10-11 17:29:47	\N	-47	78	31	-125	6
602	244	2	2013-10-11 17:29:48	\N	106	193	299	-87	4
545	220	5	2013-10-11 17:29:40	\N	95	200	295	-105	3
609	246	4	2013-10-11 17:29:49	\N	148	234	382	-86	11
478	194	3	2013-10-11 17:29:24	\N	-47	84	37	-131	8
563	228	3	2013-10-11 17:29:43	\N	-17	214	197	-231	12
583	236	3	2013-10-11 17:29:45	\N	-11	241	230	-252	5
392	160	2	2013-10-11 17:29:12	\N	47	85	132	-38	8
569	230	4	2013-10-11 17:29:43	\N	-70	-18	-88	-52	32
582	236	2	2013-10-11 17:29:45	\N	153	-14	139	167	5
560	226	5	2013-10-11 17:29:42	\N	122	284	406	-162	5
596	242	1	2013-10-11 17:29:47	\N	-75	24	-51	-99	7
573	232	3	2013-10-11 17:29:44	\N	47	170	217	-123	7
601	244	1	2013-10-11 17:29:48	\N	-13	201	188	-214	3
613	248	3	2013-10-11 17:29:50	\N	146	185	331	-39	6
608	246	3	2013-10-11 17:29:49	\N	166	-20	146	186	7
556	226	1	2013-10-11 17:29:42	\N	80	247	327	-167	3
558	226	3	2013-10-11 17:29:42	\N	36	95	131	-59	11
546	222	1	2013-10-11 17:29:40	\N	108	77	185	31	9
606	246	1	2013-10-11 17:29:49	\N	-77	274	197	-351	7
592	240	2	2013-10-11 17:29:47	\N	122	198	320	-76	5
615	248	5	2013-10-11 17:29:50	\N	187	126	313	61	4
562	228	2	2013-10-11 17:29:42	\N	-35	162	127	-197	10
552	224	2	2013-10-11 17:29:41	\N	66	85	151	-19	6
584	236	4	2013-10-11 17:29:45	\N	-73	341	268	-414	2
574	232	4	2013-10-11 17:29:44	\N	-91	208	117	-299	11
599	242	4	2013-10-11 17:29:48	\N	-83	183	100	-266	6
585	236	5	2013-10-11 17:29:46	\N	138	141	279	-3	6
586	238	1	2013-10-11 17:29:46	\N	-48	257	209	-305	5
617	250	2	2013-10-11 17:29:50	\N	42	102	144	-60	9
630	254	5	2013-10-11 17:29:52	\N	56	63	119	-7	2
635	256	5	2013-10-11 17:29:53	\N	19	57	76	-38	3
623	252	3	2013-10-11 17:29:51	\N	132	282	414	-150	6
675	272	5	2013-10-11 17:29:59	\N	137	147	284	-10	4
664	268	4	2013-10-11 17:29:58	\N	114	-39	75	153	1
650	262	5	2013-10-11 17:29:55	\N	60	326	386	-266	9
674	272	4	2013-10-11 17:29:59	\N	-98	291	193	-389	3
683	276	3	2013-10-11 17:30:01	\N	-17	344	327	-361	1
677	274	2	2013-10-11 17:30:00	\N	14	272	286	-258	3
657	266	2	2013-10-11 17:29:56	\N	54	152	206	-98	4
628	254	3	2013-10-11 17:29:52	\N	48	146	194	-98	9
684	276	4	2013-10-11 17:30:01	\N	-73	223	150	-296	9
626	254	1	2013-10-11 17:29:51	\N	97	273	370	-176	4
624	252	4	2013-10-11 17:29:51	\N	25	-12	13	37	6
653	264	3	2013-10-11 17:29:56	\N	151	-3	148	154	11
579	234	4	2013-10-11 17:29:45	\N	-37	310	273	-347	6
646	262	1	2013-10-11 17:29:55	\N	198	324	522	-126	6
643	260	3	2013-10-11 17:29:54	\N	25	92	117	-67	9
692	280	2	2013-10-11 17:30:06	\N	130	342	472	-212	9
634	256	4	2013-10-11 17:29:53	\N	-94	-15	-109	-79	35
197	82	2	2013-10-11 17:28:38	\N	71	-30	41	101	8
642	260	2	2013-10-11 17:29:54	\N	195	268	463	-73	1
690	278	5	2013-10-11 17:30:06	\N	136	-40	96	176	2
620	250	5	2013-10-11 17:29:51	\N	109	76	185	33	3
655	264	5	2013-10-11 17:29:56	\N	33	216	249	-183	9
670	270	5	2013-10-11 17:29:59	\N	-30	267	237	-297	7
622	252	2	2013-10-11 17:29:51	\N	-65	254	189	-319	7
662	268	2	2013-10-11 17:29:57	\N	56	166	222	-110	6
652	264	2	2013-10-11 17:29:56	\N	176	349	525	-173	4
632	256	2	2013-10-11 17:29:53	\N	20	314	334	-294	7
627	254	2	2013-10-11 17:29:51	\N	-32	166	134	-198	10
682	276	2	2013-10-11 17:30:00	\N	-99	-2	-101	-97	24
647	262	2	2013-10-11 17:29:55	\N	-71	80	9	-151	8
678	274	3	2013-10-11 17:30:00	\N	87	146	233	-59	6
654	264	4	2013-10-11 17:29:56	\N	132	300	432	-168	8
689	278	4	2013-10-11 17:30:05	\N	-88	196	108	-284	8
631	256	1	2013-10-11 17:29:53	\N	87	340	427	-253	8
661	268	1	2013-10-11 17:29:57	\N	-69	97	28	-166	8
648	262	3	2013-10-11 17:29:55	\N	56	283	339	-227	5
687	278	2	2013-10-11 17:30:01	\N	-41	338	297	-379	4
621	252	1	2013-10-11 17:29:51	\N	133	116	249	17	7
639	258	4	2013-10-11 17:29:54	\N	190	224	414	-34	5
680	274	5	2013-10-11 17:30:00	\N	173	336	509	-163	9
659	266	4	2013-10-11 17:29:57	\N	171	96	267	75	6
685	276	5	2013-10-11 17:30:01	\N	-34	262	228	-296	7
671	272	1	2013-10-11 17:29:59	\N	144	288	432	-144	6
645	260	5	2013-10-11 17:29:55	\N	-81	109	28	-190	5
456	186	1	2013-10-11 17:29:21	\N	112	347	459	-235	4
633	256	3	2013-10-11 17:29:53	\N	51	83	134	-32	11
660	266	5	2013-10-11 17:29:57	\N	168	208	376	-40	4
666	270	1	2013-10-11 17:29:58	\N	80	318	398	-238	9
681	276	1	2013-10-11 17:30:00	\N	31	95	126	-64	5
679	274	4	2013-10-11 17:30:00	\N	-96	273	177	-369	4
688	278	3	2013-10-11 17:30:05	\N	42	9	51	33	3
636	258	1	2013-10-11 17:29:53	\N	31	-8	23	39	5
640	258	5	2013-10-11 17:29:54	\N	18	307	325	-289	9
665	268	5	2013-10-11 17:29:58	\N	70	-3	67	73	4
629	254	4	2013-10-11 17:29:52	\N	29	84	113	-55	4
644	260	4	2013-10-11 17:29:54	\N	76	142	218	-66	5
676	274	1	2013-10-11 17:29:59	\N	183	336	519	-153	8
686	278	1	2013-10-11 17:30:01	\N	184	326	510	-142	8
510	206	5	2013-10-11 17:29:33	\N	200	324	524	-124	6
672	272	2	2013-10-11 17:29:59	\N	192	107	299	85	6
641	260	1	2013-10-11 17:29:54	\N	142	68	210	74	11
669	270	4	2013-10-11 17:29:58	\N	71	316	387	-245	9
656	266	1	2013-10-11 17:29:56	\N	54	-39	15	93	6
559	226	4	2013-10-11 17:29:42	\N	-25	307	282	-332	5
548	222	3	2013-10-11 17:29:40	\N	-60	107	47	-167	10
668	270	3	2013-10-11 17:29:58	\N	-66	23	-43	-89	7
658	266	3	2013-10-11 17:29:57	\N	51	154	205	-103	9
649	262	4	2013-10-11 17:29:55	\N	107	350	457	-243	3
673	272	3	2013-10-11 17:29:59	\N	179	12	191	167	5
625	252	5	2013-10-11 17:29:51	\N	-36	336	300	-372	4
691	280	1	2013-10-11 17:30:06	\N	69	23	92	46	7
651	264	1	2013-10-11 17:29:55	\N	83	-24	59	107	8
694	280	4	2013-10-11 17:30:06	\N	-96	25	-71	-121	1
743	300	3	2013-10-11 17:30:16	\N	194	232	426	-38	8
735	296	5	2013-10-11 17:30:14	\N	128	332	460	-204	5
729	294	4	2013-10-11 17:30:13	\N	-55	60	5	-115	4
737	298	2	2013-10-11 17:30:15	\N	141	-36	105	177	2
317	130	2	2013-10-11 17:28:55	\N	-33	273	240	-306	7
698	282	3	2013-10-11 17:30:08	\N	54	111	165	-57	7
745	300	5	2013-10-11 17:30:16	\N	187	77	264	110	2
693	280	3	2013-10-11 17:30:06	\N	139	-8	131	147	7
767	310	2	2013-10-11 17:30:19	\N	36	54	90	-18	7
756	306	1	2013-10-11 17:30:17	\N	-66	215	149	-281	4
713	288	3	2013-10-11 17:30:11	\N	70	8	78	62	3
741	300	1	2013-10-11 17:30:15	\N	-37	86	49	-123	5
723	292	3	2013-10-11 17:30:12	\N	2	231	233	-229	9
726	294	1	2013-10-11 17:30:13	\N	-69	124	55	-193	6
736	298	1	2013-10-11 17:30:14	\N	142	70	212	72	10
727	294	2	2013-10-11 17:30:13	\N	-16	198	182	-214	5
759	306	4	2013-10-11 17:30:18	\N	-56	287	231	-343	4
730	294	5	2013-10-11 17:30:13	\N	-62	22	-40	-84	11
749	302	4	2013-10-11 17:30:16	\N	-89	65	-24	-154	3
710	286	5	2013-10-11 17:30:10	\N	-34	216	182	-250	7
697	282	2	2013-10-11 17:30:08	\N	-73	64	-9	-137	6
732	296	2	2013-10-11 17:30:14	\N	192	-19	173	211	3
762	308	2	2013-10-11 17:30:18	\N	-83	81	-2	-164	7
750	302	5	2013-10-11 17:30:17	\N	-90	219	129	-309	4
708	286	3	2013-10-11 17:30:10	\N	76	45	121	31	2
720	290	5	2013-10-11 17:30:12	\N	113	-7	106	120	6
753	304	3	2013-10-11 17:30:17	\N	-98	284	186	-382	8
768	310	3	2013-10-11 17:30:19	\N	176	98	274	78	8
705	284	5	2013-10-11 17:30:09	\N	-29	273	244	-302	8
744	300	4	2013-10-11 17:30:16	\N	71	333	404	-262	8
638	258	3	2013-10-11 17:29:53	\N	-58	114	56	-172	9
752	304	2	2013-10-11 17:30:17	\N	156	297	453	-141	2
703	284	3	2013-10-11 17:30:09	\N	69	-50	19	119	3
717	290	2	2013-10-11 17:30:11	\N	104	348	452	-244	9
724	292	4	2013-10-11 17:30:12	\N	154	190	344	-36	7
757	306	2	2013-10-11 17:30:18	\N	190	89	279	101	7
725	292	5	2013-10-11 17:30:12	\N	164	-3	161	167	5
696	282	1	2013-10-11 17:30:06	\N	20	29	49	-9	1
702	284	2	2013-10-11 17:30:09	\N	66	285	351	-219	4
761	308	1	2013-10-11 17:30:18	\N	19	265	284	-246	5
733	296	3	2013-10-11 17:30:14	\N	98	129	227	-31	6
715	288	5	2013-10-11 17:30:11	\N	137	187	324	-50	3
695	280	5	2013-10-11 17:30:06	\N	49	227	276	-178	9
728	294	3	2013-10-11 17:30:13	\N	-70	275	205	-345	13
699	282	4	2013-10-11 17:30:08	\N	156	-9	147	165	6
751	304	1	2013-10-11 17:30:17	\N	200	-8	192	208	2
663	268	3	2013-10-11 17:29:57	\N	63	95	158	-32	6
742	300	2	2013-10-11 17:30:15	\N	14	124	138	-110	6
755	304	5	2013-10-11 17:30:17	\N	6	-21	-15	27	2
707	286	2	2013-10-11 17:30:10	\N	136	144	280	-8	5
722	292	2	2013-10-11 17:30:12	\N	68	122	190	-54	5
731	296	1	2013-10-11 17:30:13	\N	111	39	150	72	5
748	302	3	2013-10-11 17:30:16	\N	-82	25	-57	-107	7
719	290	4	2013-10-11 17:30:12	\N	10	55	65	-45	3
711	288	1	2013-10-11 17:30:10	\N	-21	126	105	-147	4
758	306	3	2013-10-11 17:30:18	\N	-56	241	185	-297	8
739	298	4	2013-10-11 17:30:15	\N	54	95	149	-41	9
704	284	4	2013-10-11 17:30:09	\N	172	247	419	-75	11
760	306	5	2013-10-11 17:30:18	\N	91	111	202	-20	5
764	308	4	2013-10-11 17:30:19	\N	9	-40	-31	49	2
766	310	1	2013-10-11 17:30:19	\N	26	198	224	-172	4
763	308	3	2013-10-11 17:30:19	\N	-79	93	14	-172	8
754	304	4	2013-10-11 17:30:17	\N	197	322	519	-125	3
738	298	3	2013-10-11 17:30:15	\N	51	111	162	-60	7
567	230	2	2013-10-11 17:29:43	\N	-39	294	255	-333	10
701	284	1	2013-10-11 17:30:09	\N	173	139	312	34	7
712	288	2	2013-10-11 17:30:10	\N	-50	295	245	-345	11
718	290	3	2013-10-11 17:30:11	\N	-92	262	170	-354	7
734	296	4	2013-10-11 17:30:14	\N	195	167	362	28	8
714	288	4	2013-10-11 17:30:11	\N	53	56	109	-3	8
746	302	1	2013-10-11 17:30:16	\N	193	125	318	68	8
716	290	1	2013-10-11 17:30:11	\N	82	164	246	-82	7
721	292	1	2013-10-11 17:30:12	\N	85	159	244	-74	6
747	302	2	2013-10-11 17:30:16	\N	-58	311	253	-369	8
830	334	5	2013-10-11 17:30:29	\N	148	17	165	131	8
784	316	4	2013-10-11 17:30:22	\N	54	233	287	-179	2
802	324	2	2013-10-11 17:30:24	\N	37	121	158	-84	5
816	330	1	2013-10-11 17:30:27	\N	156	179	335	-23	3
740	298	5	2013-10-11 17:30:15	\N	177	175	352	2	4
785	316	5	2013-10-11 17:30:22	\N	190	288	478	-98	6
823	332	3	2013-10-11 17:30:28	\N	146	203	349	-57	9
798	322	3	2013-10-11 17:30:24	\N	126	-41	85	167	4
832	336	2	2013-10-11 17:30:29	\N	-49	148	99	-197	5
787	318	2	2013-10-11 17:30:22	\N	-50	257	207	-307	9
268	110	3	2013-10-11 17:28:48	\N	140	243	383	-103	5
821	332	1	2013-10-11 17:30:28	\N	64	76	140	-12	3
842	340	2	2013-10-11 17:30:31	\N	-1	200	199	-201	4
818	330	3	2013-10-11 17:30:27	\N	95	53	148	42	5
812	328	2	2013-10-11 17:30:26	\N	182	4	186	178	4
771	312	1	2013-10-11 17:30:20	\N	199	214	413	-15	3
800	322	5	2013-10-11 17:30:24	\N	-32	226	194	-258	7
831	336	1	2013-10-11 17:30:29	\N	120	85	205	35	10
779	314	4	2013-10-11 17:30:21	\N	-44	261	217	-305	2
804	324	4	2013-10-11 17:30:25	\N	105	115	220	-10	5
808	326	3	2013-10-11 17:30:26	\N	-9	-3	-12	-6	6
781	316	1	2013-10-11 17:30:21	\N	56	270	326	-214	3
841	340	1	2013-10-11 17:30:31	\N	-9	260	251	-269	10
811	328	1	2013-10-11 17:30:26	\N	-26	-50	-76	24	4
796	322	1	2013-10-11 17:30:23	\N	132	317	449	-185	9
822	332	2	2013-10-11 17:30:28	\N	179	106	285	73	8
836	338	1	2013-10-11 17:30:30	\N	195	44	239	151	7
803	324	3	2013-10-11 17:30:25	\N	153	118	271	35	4
797	322	2	2013-10-11 17:30:23	\N	-8	26	18	-34	3
509	206	4	2013-10-11 17:29:33	\N	153	226	379	-73	10
826	334	1	2013-10-11 17:30:29	\N	81	197	278	-116	7
814	328	4	2013-10-11 17:30:27	\N	-69	114	45	-183	8
772	312	2	2013-10-11 17:30:20	\N	19	314	333	-295	7
837	338	2	2013-10-11 17:30:30	\N	9	-36	-27	45	4
777	314	2	2013-10-11 17:30:21	\N	3	-20	-17	23	6
782	316	2	2013-10-11 17:30:21	\N	-25	159	134	-184	9
786	318	1	2013-10-11 17:30:22	\N	157	103	260	54	8
809	326	4	2013-10-11 17:30:26	\N	17	134	151	-117	5
774	312	4	2013-10-11 17:30:20	\N	168	192	360	-24	10
807	326	2	2013-10-11 17:30:26	\N	39	246	285	-207	7
801	324	1	2013-10-11 17:30:24	\N	-42	84	42	-126	6
795	320	5	2013-10-11 17:30:23	\N	-70	0	-70	-70	29
806	326	1	2013-10-11 17:30:26	\N	44	156	200	-112	4
805	324	5	2013-10-11 17:30:25	\N	17	88	105	-71	4
794	320	4	2013-10-11 17:30:23	\N	98	233	331	-135	5
834	336	4	2013-10-11 17:30:30	\N	34	191	225	-157	5
789	318	4	2013-10-11 17:30:22	\N	124	20	144	104	4
828	334	3	2013-10-11 17:30:29	\N	171	-1	170	172	8
769	310	4	2013-10-11 17:30:20	\N	-17	341	324	-358	7
778	314	3	2013-10-11 17:30:21	\N	-31	200	169	-231	8
833	336	3	2013-10-11 17:30:30	\N	192	126	318	66	4
709	286	4	2013-10-11 17:30:10	\N	3	346	349	-343	5
820	330	5	2013-10-11 17:30:28	\N	83	323	406	-240	7
825	332	5	2013-10-11 17:30:28	\N	179	-6	173	185	5
824	332	4	2013-10-11 17:30:28	\N	-54	0	-54	-54	20
780	314	5	2013-10-11 17:30:21	\N	-49	-47	-96	-2	17
839	338	4	2013-10-11 17:30:31	\N	155	5	160	150	7
843	340	3	2013-10-11 17:30:32	\N	52	250	302	-198	5
793	320	3	2013-10-11 17:30:23	\N	34	-32	2	66	5
773	312	3	2013-10-11 17:30:20	\N	23	49	72	-26	7
788	318	3	2013-10-11 17:30:22	\N	178	226	404	-48	9
827	334	2	2013-10-11 17:30:29	\N	115	188	303	-73	4
776	314	1	2013-10-11 17:30:20	\N	-75	200	125	-275	5
790	318	5	2013-10-11 17:30:22	\N	161	149	310	12	8
775	312	5	2013-10-11 17:30:20	\N	97	12	109	85	9
813	328	3	2013-10-11 17:30:27	\N	45	162	207	-117	9
792	320	2	2013-10-11 17:30:23	\N	-81	245	164	-326	6
791	320	1	2013-10-11 17:30:23	\N	148	246	394	-98	6
810	326	5	2013-10-11 17:30:26	\N	55	340	395	-285	8
838	338	3	2013-10-11 17:30:30	\N	24	63	87	-39	11
770	310	5	2013-10-11 17:30:20	\N	-51	227	176	-278	6
706	286	1	2013-10-11 17:30:09	\N	130	100	230	30	7
835	336	5	2013-10-11 17:30:30	\N	135	228	363	-93	3
817	330	2	2013-10-11 17:30:27	\N	52	13	65	39	7
799	322	4	2013-10-11 17:30:24	\N	104	224	328	-120	5
840	338	5	2013-10-11 17:30:31	\N	165	8	173	157	9
915	368	5	2013-10-11 17:30:49	\N	-46	16	-30	-62	13
868	350	3	2013-10-11 17:30:40	\N	-18	21	3	-39	4
870	350	5	2013-10-11 17:30:40	\N	-29	266	237	-295	7
891	360	1	2013-10-11 17:30:44	\N	122	308	430	-186	8
874	352	4	2013-10-11 17:30:42	\N	198	252	450	-54	5
875	352	5	2013-10-11 17:30:42	\N	140	151	291	-11	4
878	354	3	2013-10-11 17:30:43	\N	49	237	286	-188	4
867	350	2	2013-10-11 17:30:40	\N	162	-12	150	174	4
857	346	2	2013-10-11 17:30:38	\N	-98	17	-81	-115	7
894	360	4	2013-10-11 17:30:45	\N	146	56	202	90	4
872	352	2	2013-10-11 17:30:42	\N	162	63	225	99	6
889	358	4	2013-10-11 17:30:44	\N	127	284	411	-157	10
895	360	5	2013-10-11 17:30:45	\N	42	177	219	-135	0
896	362	1	2013-10-11 17:30:45	\N	84	98	182	-14	3
902	364	2	2013-10-11 17:30:46	\N	172	253	425	-81	2
903	364	3	2013-10-11 17:30:46	\N	-11	287	276	-298	3
844	340	4	2013-10-11 17:30:33	\N	-3	3	0	-6	6
858	346	3	2013-10-11 17:30:38	\N	-64	100	36	-164	10
917	370	2	2013-10-11 17:30:49	\N	-96	50	-46	-146	1
221	92	1	2013-10-11 17:28:41	\N	-29	281	252	-310	10
846	342	1	2013-10-11 17:30:34	\N	-81	297	216	-378	8
882	356	2	2013-10-11 17:30:43	\N	44	249	293	-205	6
899	362	4	2013-10-11 17:30:46	\N	64	266	330	-202	2
901	364	1	2013-10-11 17:30:46	\N	-23	30	7	-53	1
906	366	1	2013-10-11 17:30:47	\N	-23	309	286	-332	6
879	354	4	2013-10-11 17:30:43	\N	183	285	468	-102	7
890	358	5	2013-10-11 17:30:44	\N	63	-36	27	99	2
888	358	3	2013-10-11 17:30:44	\N	198	-18	180	216	2
845	340	5	2013-10-11 17:30:34	\N	168	102	270	66	4
862	348	2	2013-10-11 17:30:38	\N	-76	214	138	-290	5
892	360	2	2013-10-11 17:30:45	\N	62	-13	49	75	7
850	342	5	2013-10-11 17:30:37	\N	4	205	209	-201	6
898	362	3	2013-10-11 17:30:46	\N	-51	302	251	-353	4
881	356	1	2013-10-11 17:30:43	\N	-4	61	57	-65	2
873	352	3	2013-10-11 17:30:42	\N	92	182	274	-90	4
914	368	4	2013-10-11 17:30:49	\N	-46	341	295	-387	3
911	368	1	2013-10-11 17:30:48	\N	174	32	206	142	9
861	348	1	2013-10-11 17:30:38	\N	141	170	311	-29	5
910	366	5	2013-10-11 17:30:48	\N	-85	-39	-124	-46	45
908	366	3	2013-10-11 17:30:48	\N	-39	-49	-88	10	15
854	344	4	2013-10-11 17:30:37	\N	-67	119	52	-186	9
819	330	4	2013-10-11 17:30:27	\N	132	241	373	-109	13
856	346	1	2013-10-11 17:30:37	\N	-93	304	211	-397	6
884	356	4	2013-10-11 17:30:43	\N	87	16	103	71	5
866	350	1	2013-10-11 17:30:40	\N	-67	172	105	-239	5
853	344	3	2013-10-11 17:30:37	\N	83	335	418	-252	2
863	348	3	2013-10-11 17:30:39	\N	105	-27	78	132	5
905	364	5	2013-10-11 17:30:46	\N	36	136	172	-100	6
887	358	2	2013-10-11 17:30:44	\N	123	327	450	-204	12
913	368	3	2013-10-11 17:30:48	\N	12	247	259	-235	6
849	342	4	2013-10-11 17:30:36	\N	71	116	187	-45	8
859	346	4	2013-10-11 17:30:38	\N	-52	-15	-67	-37	25
886	358	1	2013-10-11 17:30:44	\N	-96	-32	-128	-64	33
907	366	2	2013-10-11 17:30:47	\N	-29	177	148	-206	8
880	354	5	2013-10-11 17:30:43	\N	-31	316	285	-347	5
912	368	2	2013-10-11 17:30:48	\N	53	272	325	-219	6
916	370	1	2013-10-11 17:30:49	\N	-22	203	181	-225	3
876	354	1	2013-10-11 17:30:42	\N	-39	143	104	-182	6
918	370	3	2013-10-11 17:30:49	\N	117	38	155	79	5
893	360	3	2013-10-11 17:30:45	\N	-79	333	254	-412	3
848	342	3	2013-10-11 17:30:36	\N	91	157	248	-66	6
897	362	2	2013-10-11 17:30:45	\N	84	52	136	32	5
865	348	5	2013-10-11 17:30:39	\N	-51	190	139	-241	8
667	270	2	2013-10-11 17:29:58	\N	38	2	40	36	6
883	356	3	2013-10-11 17:30:43	\N	-41	216	175	-257	10
871	352	1	2013-10-11 17:30:42	\N	177	141	318	36	8
637	258	2	2013-10-11 17:29:53	\N	76	-16	60	92	9
852	344	2	2013-10-11 17:30:37	\N	-14	146	132	-160	9
904	364	4	2013-10-11 17:30:46	\N	156	233	389	-77	9
864	348	4	2013-10-11 17:30:39	\N	23	217	240	-194	5
877	354	2	2013-10-11 17:30:42	\N	108	346	454	-238	10
900	362	5	2013-10-11 17:30:46	\N	197	283	480	-86	5
860	346	5	2013-10-11 17:30:38	\N	143	-8	135	151	9
919	370	4	2013-10-11 17:30:49	\N	167	82	249	85	6
851	344	1	2013-10-11 17:30:37	\N	-96	-45	-141	-51	26
829	334	4	2013-10-11 17:30:29	\N	-33	4	-29	-37	12
928	374	3	2013-10-11 17:30:51	\N	-39	90	51	-129	7
991	400	1	2013-10-11 17:31:00	\N	13	-25	-12	38	7
932	376	2	2013-10-11 17:30:51	\N	180	-5	175	185	5
855	344	5	2013-10-11 17:30:37	\N	-45	292	247	-337	11
951	384	1	2013-10-11 17:30:54	\N	52	22	74	30	4
815	328	5	2013-10-11 17:30:27	\N	61	336	397	-275	10
950	382	5	2013-10-11 17:30:54	\N	7	179	186	-172	4
952	384	2	2013-10-11 17:30:54	\N	-96	206	110	-302	4
953	384	3	2013-10-11 17:30:54	\N	66	211	277	-145	2
955	384	5	2013-10-11 17:30:54	\N	-69	212	143	-281	6
962	388	2	2013-10-11 17:30:55	\N	95	-23	72	118	5
946	382	1	2013-10-11 17:30:53	\N	137	335	472	-198	9
989	398	4	2013-10-11 17:31:00	\N	155	76	231	79	6
987	398	2	2013-10-11 17:30:59	\N	141	22	163	119	3
979	394	4	2013-10-11 17:30:58	\N	4	209	213	-205	4
972	392	2	2013-10-11 17:30:57	\N	-29	310	281	-339	7
958	386	3	2013-10-11 17:30:55	\N	59	-6	53	65	3
984	396	4	2013-10-11 17:30:59	\N	-91	261	170	-352	3
985	396	5	2013-10-11 17:30:59	\N	112	191	303	-79	4
986	398	1	2013-10-11 17:30:59	\N	81	305	386	-224	4
988	398	3	2013-10-11 17:31:00	\N	-48	344	296	-392	0
982	396	2	2013-10-11 17:30:59	\N	-41	311	270	-352	8
964	388	4	2013-10-11 17:30:56	\N	116	80	196	36	7
700	282	5	2013-10-11 17:30:08	\N	3	249	252	-246	8
938	378	3	2013-10-11 17:30:52	\N	-37	170	133	-207	2
960	386	5	2013-10-11 17:30:55	\N	-18	-20	-38	2	6
920	370	5	2013-10-11 17:30:49	\N	-71	298	227	-369	6
961	388	1	2013-10-11 17:30:55	\N	-97	3	-94	-100	17
954	384	4	2013-10-11 17:30:54	\N	-48	-11	-59	-37	23
967	390	2	2013-10-11 17:30:56	\N	-8	124	116	-132	6
970	390	5	2013-10-11 17:30:57	\N	-7	103	96	-110	9
983	396	3	2013-10-11 17:30:59	\N	30	-6	24	36	6
926	374	1	2013-10-11 17:30:50	\N	165	53	218	112	12
931	376	1	2013-10-11 17:30:51	\N	177	47	224	130	10
975	392	5	2013-10-11 17:30:57	\N	-20	88	68	-108	6
956	386	1	2013-10-11 17:30:55	\N	-35	26	-9	-61	4
968	390	3	2013-10-11 17:30:56	\N	-100	77	-23	-177	2
993	400	3	2013-10-11 17:31:00	\N	97	162	259	-65	6
924	372	4	2013-10-11 17:30:50	\N	25	107	132	-82	6
992	400	2	2013-10-11 17:31:00	\N	115	124	239	-9	9
937	378	2	2013-10-11 17:30:52	\N	-51	238	187	-289	11
934	376	4	2013-10-11 17:30:51	\N	119	160	279	-41	5
965	388	5	2013-10-11 17:30:56	\N	11	331	342	-320	7
944	380	4	2013-10-11 17:30:53	\N	182	-6	176	188	6
921	372	1	2013-10-11 17:30:50	\N	144	114	258	30	7
963	388	3	2013-10-11 17:30:56	\N	-4	108	104	-112	4
957	386	2	2013-10-11 17:30:55	\N	159	110	269	49	5
976	394	1	2013-10-11 17:30:57	\N	-57	300	243	-357	7
885	356	5	2013-10-11 17:30:44	\N	-62	134	72	-196	6
930	374	5	2013-10-11 17:30:51	\N	-61	144	83	-205	6
941	380	1	2013-10-11 17:30:52	\N	106	-16	90	122	6
980	394	5	2013-10-11 17:30:58	\N	50	317	367	-267	11
974	392	4	2013-10-11 17:30:57	\N	-43	136	93	-179	6
939	378	4	2013-10-11 17:30:52	\N	-61	99	38	-160	6
942	380	2	2013-10-11 17:30:52	\N	133	263	396	-130	3
923	372	3	2013-10-11 17:30:50	\N	56	153	209	-97	9
969	390	4	2013-10-11 17:30:56	\N	52	63	115	-11	7
909	366	4	2013-10-11 17:30:48	\N	18	8	26	10	6
925	372	5	2013-10-11 17:30:50	\N	-11	29	18	-40	6
966	390	1	2013-10-11 17:30:56	\N	131	20	151	111	6
927	374	2	2013-10-11 17:30:50	\N	13	292	305	-279	8
981	396	1	2013-10-11 17:30:59	\N	2	64	66	-62	2
971	392	1	2013-10-11 17:30:57	\N	-97	297	200	-394	5
936	378	1	2013-10-11 17:30:52	\N	-70	336	266	-406	3
943	380	3	2013-10-11 17:30:53	\N	130	35	165	95	5
929	374	4	2013-10-11 17:30:51	\N	2	251	253	-249	8
947	382	2	2013-10-11 17:30:53	\N	-47	226	179	-273	8
922	372	2	2013-10-11 17:30:50	\N	120	224	344	-104	6
959	386	4	2013-10-11 17:30:55	\N	185	154	339	31	9
977	394	2	2013-10-11 17:30:58	\N	98	52	150	46	6
940	378	5	2013-10-11 17:30:52	\N	-32	21	-11	-53	8
949	382	4	2013-10-11 17:30:53	\N	21	-5	16	26	7
935	376	5	2013-10-11 17:30:51	\N	-49	162	113	-211	8
978	394	3	2013-10-11 17:30:58	\N	185	147	332	38	5
948	382	3	2013-10-11 17:30:53	\N	-55	237	182	-292	7
973	392	3	2013-10-11 17:30:57	\N	-54	235	181	-289	7
996	402	1	2013-10-11 17:31:01	\N	-33	337	304	-370	3
997	402	2	2013-10-11 17:31:01	\N	-66	30	-36	-96	2
998	402	3	2013-10-11 17:31:01	\N	-90	46	-44	-136	3
999	402	4	2013-10-11 17:31:01	\N	9	54	63	-45	3
1001	404	1	2013-10-11 17:31:01	\N	44	210	254	-166	3
1008	406	3	2013-10-11 17:31:02	\N	-54	164	110	-218	1
1016	410	1	2013-10-11 17:31:04	\N	175	315	490	-140	7
1013	408	3	2013-10-11 17:31:03	\N	95	12	107	83	2
1026	414	1	2013-10-11 17:31:09	\N	-50	108	58	-158	9
1025	412	5	2013-10-11 17:31:09	\N	50	134	184	-84	4
1028	414	3	2013-10-11 17:31:09	\N	84	321	405	-237	2
1029	414	4	2013-10-11 17:31:10	\N	-22	146	124	-168	2
1030	414	5	2013-10-11 17:31:10	\N	53	-39	14	92	1
1031	416	1	2013-10-11 17:31:10	\N	35	137	172	-102	3
1032	416	2	2013-10-11 17:31:10	\N	82	179	261	-97	4
1033	416	3	2013-10-11 17:31:10	\N	13	250	263	-237	6
1035	416	5	2013-10-11 17:31:11	\N	172	256	428	-84	1
581	236	1	2013-10-11 17:29:45	\N	77	238	315	-161	3
1021	412	1	2013-10-11 17:31:08	\N	83	7	90	76	7
1038	418	3	2013-10-11 17:31:11	\N	-98	189	91	-287	1
1018	410	3	2013-10-11 17:31:05	\N	35	139	174	-104	7
1036	418	1	2013-10-11 17:31:11	\N	60	243	303	-183	5
1058	426	3	2013-10-11 17:31:16	\N	26	282	308	-256	4
1041	420	1	2013-10-11 17:31:11	\N	160	64	224	96	9
1043	420	3	2013-10-11 17:31:12	\N	47	-41	6	88	3
1000	402	5	2013-10-11 17:31:01	\N	100	97	197	3	5
1010	406	5	2013-10-11 17:31:03	\N	62	126	188	-64	8
1045	420	5	2013-10-11 17:31:14	\N	71	109	180	-38	6
1047	422	2	2013-10-11 17:31:14	\N	84	303	387	-219	5
1065	428	5	2013-10-11 17:31:17	\N	9	-10	-1	19	2
1060	426	5	2013-10-11 17:31:16	\N	149	190	339	-41	4
1050	422	5	2013-10-11 17:31:15	\N	-33	116	83	-149	6
1055	424	5	2013-10-11 17:31:15	\N	183	155	338	28	5
1046	422	1	2013-10-11 17:31:14	\N	-23	150	127	-173	4
1052	424	2	2013-10-11 17:31:15	\N	-67	298	231	-365	8
1057	426	2	2013-10-11 17:31:16	\N	49	203	252	-154	5
1054	424	4	2013-10-11 17:31:15	\N	23	246	269	-223	7
1019	410	4	2013-10-11 17:31:08	\N	106	83	189	23	8
1034	416	4	2013-10-11 17:31:10	\N	89	142	231	-53	5
1056	426	1	2013-10-11 17:31:15	\N	71	-24	47	95	9
1063	428	3	2013-10-11 17:31:16	\N	-92	221	129	-313	2
1061	428	1	2013-10-11 17:31:16	\N	128	199	327	-71	4
1062	428	2	2013-10-11 17:31:16	\N	140	108	248	32	9
1011	408	1	2013-10-11 17:31:03	\N	146	339	485	-193	9
765	308	5	2013-10-11 17:30:19	\N	29	269	298	-240	11
1042	420	2	2013-10-11 17:31:12	\N	131	94	225	37	9
1051	424	1	2013-10-11 17:31:15	\N	186	183	369	3	3
1049	422	4	2013-10-11 17:31:14	\N	-55	148	93	-203	6
1012	408	2	2013-10-11 17:31:03	\N	73	235	308	-162	3
1015	408	5	2013-10-11 17:31:04	\N	178	45	223	133	4
1002	404	2	2013-10-11 17:31:02	\N	-21	-37	-58	16	7
1017	410	2	2013-10-11 17:31:04	\N	-78	267	189	-345	6
1009	406	4	2013-10-11 17:31:03	\N	74	110	184	-36	7
1022	412	2	2013-10-11 17:31:08	\N	5	74	79	-69	6
1023	412	3	2013-10-11 17:31:08	\N	104	-12	92	116	5
1004	404	4	2013-10-11 17:31:02	\N	-69	172	103	-241	4
1064	428	4	2013-10-11 17:31:17	\N	-93	187	94	-280	7
1066	430	1	2013-10-11 17:31:17	\N	-15	264	249	-279	8
1007	406	2	2013-10-11 17:31:02	\N	-84	-1	-85	-83	27
1067	430	2	2013-10-11 17:31:17	\N	-80	-37	-117	-43	37
1027	414	2	2013-10-11 17:31:09	\N	-23	108	85	-131	4
1037	418	2	2013-10-11 17:31:11	\N	-16	-19	-35	3	7
1024	412	4	2013-10-11 17:31:08	\N	152	200	352	-48	7
1068	430	3	2013-10-11 17:31:17	\N	162	-17	145	179	8
1044	420	4	2013-10-11 17:31:12	\N	-7	-24	-31	17	4
500	202	5	2013-10-11 17:29:31	\N	23	227	250	-204	13
1014	408	4	2013-10-11 17:31:04	\N	191	184	375	7	11
1006	406	1	2013-10-11 17:31:02	\N	-57	276	219	-333	11
1059	426	4	2013-10-11 17:31:16	\N	54	333	387	-279	7
1039	418	4	2013-10-11 17:31:11	\N	97	338	435	-241	6
869	350	4	2013-10-11 17:30:40	\N	73	310	383	-237	9
1053	424	3	2013-10-11 17:31:15	\N	158	152	310	6	2
1048	422	3	2013-10-11 17:31:14	\N	104	268	372	-164	8
1005	404	5	2013-10-11 17:31:02	\N	196	289	485	-93	6
1020	410	5	2013-10-11 17:31:08	\N	191	322	513	-131	6
994	400	4	2013-10-11 17:31:00	\N	181	207	388	-26	7
1075	432	5	2013-10-11 17:31:18	\N	195	14	209	181	4
1077	434	2	2013-10-11 17:31:19	\N	-72	101	29	-173	6
1131	456	1	2013-10-11 17:31:27	\N	192	216	408	-24	4
1079	434	4	2013-10-11 17:31:19	\N	78	264	342	-186	4
1083	436	3	2013-10-11 17:31:20	\N	116	39	155	77	5
1084	436	4	2013-10-11 17:31:20	\N	115	177	292	-62	3
1087	438	2	2013-10-11 17:31:21	\N	-8	-34	-42	26	6
1091	440	1	2013-10-11 17:31:21	\N	158	249	407	-91	4
1098	442	3	2013-10-11 17:31:23	\N	68	272	340	-204	5
1076	434	1	2013-10-11 17:31:19	\N	-50	163	113	-213	7
1100	442	5	2013-10-11 17:31:23	\N	61	236	297	-175	5
1103	444	3	2013-10-11 17:31:23	\N	17	93	110	-76	7
1105	444	5	2013-10-11 17:31:24	\N	159	223	382	-64	3
1101	444	1	2013-10-11 17:31:23	\N	160	-50	110	210	3
1106	446	1	2013-10-11 17:31:24	\N	146	-44	102	190	2
1136	458	1	2013-10-11 17:31:28	\N	-43	289	246	-332	8
847	342	2	2013-10-11 17:30:35	\N	108	321	429	-213	10
1093	440	3	2013-10-11 17:31:22	\N	-96	-17	-113	-79	23
1111	448	1	2013-10-11 17:31:24	\N	-33	-4	-37	-29	7
1113	448	3	2013-10-11 17:31:25	\N	108	139	247	-31	7
1114	448	4	2013-10-11 17:31:25	\N	23	93	116	-70	2
1081	436	1	2013-10-11 17:31:19	\N	-65	74	9	-139	5
1116	450	1	2013-10-11 17:31:25	\N	-71	82	11	-153	5
1117	450	2	2013-10-11 17:31:25	\N	154	286	440	-132	2
1119	450	4	2013-10-11 17:31:26	\N	191	303	494	-112	5
1120	450	5	2013-10-11 17:31:26	\N	-62	118	56	-180	6
1121	452	1	2013-10-11 17:31:26	\N	86	64	150	22	5
1070	430	5	2013-10-11 17:31:17	\N	-23	315	292	-338	6
1109	446	4	2013-10-11 17:31:24	\N	118	129	247	-11	6
1134	456	4	2013-10-11 17:31:28	\N	111	340	451	-229	4
1112	448	2	2013-10-11 17:31:25	\N	141	108	249	33	9
1129	454	4	2013-10-11 17:31:27	\N	174	41	215	133	1
1086	438	1	2013-10-11 17:31:21	\N	184	88	272	96	7
1003	404	3	2013-10-11 17:31:02	\N	-83	282	199	-365	10
945	380	5	2013-10-11 17:30:53	\N	28	243	271	-215	12
1040	418	5	2013-10-11 17:31:11	\N	19	263	282	-244	11
1080	434	5	2013-10-11 17:31:19	\N	23	257	280	-234	11
995	400	5	2013-10-11 17:31:01	\N	35	251	286	-216	12
1069	430	4	2013-10-11 17:31:17	\N	77	293	370	-216	8
1139	458	4	2013-10-11 17:31:29	\N	62	96	158	-34	9
1097	442	2	2013-10-11 17:31:22	\N	102	216	318	-114	6
1115	448	5	2013-10-11 17:31:25	\N	-91	-10	-101	-81	32
1074	432	4	2013-10-11 17:31:18	\N	-10	99	89	-109	2
1104	444	4	2013-10-11 17:31:23	\N	-94	-16	-110	-78	36
1110	446	5	2013-10-11 17:31:24	\N	-33	53	20	-86	5
1132	456	2	2013-10-11 17:31:28	\N	198	231	429	-33	3
1085	436	5	2013-10-11 17:31:20	\N	193	328	521	-135	7
1137	458	2	2013-10-11 17:31:28	\N	139	158	297	-19	4
1138	458	3	2013-10-11 17:31:28	\N	183	208	391	-25	6
1135	456	5	2013-10-11 17:31:28	\N	166	-43	123	209	2
1095	440	5	2013-10-11 17:31:22	\N	53	301	354	-248	8
1118	450	3	2013-10-11 17:31:26	\N	166	276	442	-110	6
1072	432	2	2013-10-11 17:31:18	\N	61	-32	29	93	7
1102	444	2	2013-10-11 17:31:23	\N	108	54	162	54	6
1122	452	2	2013-10-11 17:31:26	\N	-26	253	227	-279	8
1078	434	3	2013-10-11 17:31:19	\N	36	303	339	-267	7
1130	454	5	2013-10-11 17:31:27	\N	-59	-9	-68	-50	24
1127	454	2	2013-10-11 17:31:27	\N	126	123	249	3	10
1088	438	3	2013-10-11 17:31:21	\N	-14	53	39	-67	4
1071	432	1	2013-10-11 17:31:18	\N	-58	-33	-91	-25	16
1099	442	4	2013-10-11 17:31:23	\N	131	244	375	-113	12
1089	438	4	2013-10-11 17:31:21	\N	116	96	212	20	6
1124	452	4	2013-10-11 17:31:26	\N	111	103	214	8	7
1096	442	1	2013-10-11 17:31:22	\N	144	325	469	-181	8
1082	436	2	2013-10-11 17:31:20	\N	165	68	233	97	6
1123	452	3	2013-10-11 17:31:26	\N	-29	212	183	-241	9
1094	440	4	2013-10-11 17:31:22	\N	143	20	163	123	5
1133	456	3	2013-10-11 17:31:28	\N	148	60	208	88	2
1092	440	2	2013-10-11 17:31:22	\N	121	317	438	-196	9
1128	454	3	2013-10-11 17:31:27	\N	199	146	345	53	4
418	170	3	2013-10-11 17:29:15	\N	-65	302	237	-367	9
1073	432	3	2013-10-11 17:31:18	\N	-80	298	218	-378	11
1125	452	5	2013-10-11 17:31:27	\N	-61	-39	-100	-22	32
1126	454	1	2013-10-11 17:31:27	\N	-78	-4	-82	-74	21
1090	438	5	2013-10-11 17:31:21	\N	-77	-26	-103	-51	43
1140	458	5	2013-10-11 17:31:29	\N	20	262	282	-242	11
1141	460	1	2013-10-11 17:31:29	\N	-56	187	131	-243	4
1146	462	1	2013-10-11 17:31:30	\N	-21	228	207	-249	4
1148	462	3	2013-10-11 17:31:30	\N	119	185	304	-66	6
1149	462	4	2013-10-11 17:31:30	\N	95	296	391	-201	8
1151	464	1	2013-10-11 17:31:31	\N	91	145	236	-54	5
1154	464	4	2013-10-11 17:31:31	\N	-69	137	68	-206	6
1156	466	1	2013-10-11 17:31:32	\N	2	-36	-34	38	5
1159	466	4	2013-10-11 17:31:32	\N	-72	87	15	-159	6
1163	468	3	2013-10-11 17:31:33	\N	-87	250	163	-337	6
1165	468	5	2013-10-11 17:31:33	\N	99	40	139	59	6
1167	470	2	2013-10-11 17:31:33	\N	-60	250	190	-310	9
1168	470	3	2013-10-11 17:31:34	\N	-95	150	55	-245	1
1216	490	1	2013-10-11 17:31:46	\N	131	21	152	110	5
1170	470	5	2013-10-11 17:31:34	\N	-65	304	239	-369	4
1171	472	1	2013-10-11 17:31:34	\N	-36	98	62	-134	4
1172	472	2	2013-10-11 17:31:34	\N	53	-4	49	57	7
1174	472	4	2013-10-11 17:31:36	\N	-24	79	55	-103	2
1176	474	1	2013-10-11 17:31:38	\N	196	19	215	177	5
1177	474	2	2013-10-11 17:31:39	\N	43	263	306	-220	6
1179	474	4	2013-10-11 17:31:39	\N	200	-15	185	215	3
1180	474	5	2013-10-11 17:31:39	\N	-22	49	27	-71	7
1182	476	2	2013-10-11 17:31:40	\N	184	208	392	-24	5
1184	476	4	2013-10-11 17:31:40	\N	-67	190	123	-257	6
1160	466	5	2013-10-11 17:31:32	\N	-28	187	159	-215	7
1187	478	2	2013-10-11 17:31:40	\N	158	167	325	-9	3
1205	484	5	2013-10-11 17:31:44	\N	90	-44	46	134	1
1188	478	3	2013-10-11 17:31:40	\N	182	227	409	-45	8
1189	478	4	2013-10-11 17:31:41	\N	-28	309	281	-337	4
1190	478	5	2013-10-11 17:31:41	\N	175	171	346	4	4
1142	460	2	2013-10-11 17:31:29	\N	-22	177	155	-199	11
1195	480	5	2013-10-11 17:31:42	\N	178	-39	139	217	1
783	316	3	2013-10-11 17:30:21	\N	144	220	364	-76	9
1153	464	3	2013-10-11 17:31:31	\N	174	247	421	-73	10
1198	482	3	2013-10-11 17:31:43	\N	156	250	406	-94	9
1183	476	3	2013-10-11 17:31:40	\N	195	141	336	54	4
1201	484	1	2013-10-11 17:31:43	\N	166	127	293	39	9
1202	484	2	2013-10-11 17:31:43	\N	-98	83	-15	-181	5
1204	484	4	2013-10-11 17:31:44	\N	159	241	400	-82	11
1206	486	1	2013-10-11 17:31:44	\N	-6	275	269	-281	10
1208	486	3	2013-10-11 17:31:44	\N	60	174	234	-114	6
1200	482	5	2013-10-11 17:31:43	\N	-54	-14	-68	-40	23
1212	488	2	2013-10-11 17:31:45	\N	80	94	174	-14	5
1157	466	2	2013-10-11 17:31:32	\N	54	219	273	-165	9
1214	488	4	2013-10-11 17:31:45	\N	197	166	363	31	7
1150	462	5	2013-10-11 17:31:31	\N	-66	279	213	-345	6
1215	488	5	2013-10-11 17:31:45	\N	-81	269	188	-350	4
1147	462	2	2013-10-11 17:31:30	\N	80	344	424	-264	5
619	250	4	2013-10-11 17:29:50	\N	-14	322	308	-336	8
1217	490	2	2013-10-11 17:31:46	\N	77	-50	27	127	3
1155	464	5	2013-10-11 17:31:31	\N	-88	83	-5	-171	6
1144	460	4	2013-10-11 17:31:29	\N	9	255	264	-246	8
1210	486	5	2013-10-11 17:31:45	\N	168	347	515	-179	5
1162	468	2	2013-10-11 17:31:32	\N	130	215	345	-85	7
1181	476	1	2013-10-11 17:31:39	\N	113	251	364	-138	7
1193	480	3	2013-10-11 17:31:42	\N	46	66	112	-20	11
1213	488	3	2013-10-11 17:31:45	\N	-21	211	190	-232	10
1175	472	5	2013-10-11 17:31:37	\N	-9	321	312	-330	9
1145	460	5	2013-10-11 17:31:29	\N	31	340	371	-309	8
1197	482	2	2013-10-11 17:31:43	\N	161	51	212	110	5
1191	480	1	2013-10-11 17:31:41	\N	121	98	219	23	8
1185	476	5	2013-10-11 17:31:40	\N	-47	186	139	-233	8
1199	482	4	2013-10-11 17:31:43	\N	-75	-3	-78	-72	23
1196	482	1	2013-10-11 17:31:43	\N	12	59	71	-47	4
1192	480	2	2013-10-11 17:31:42	\N	-5	158	153	-163	10
1178	474	3	2013-10-11 17:31:39	\N	-91	83	-8	-174	3
1209	486	4	2013-10-11 17:31:44	\N	80	-7	73	87	3
1161	468	1	2013-10-11 17:31:32	\N	-64	295	231	-359	10
1173	472	3	2013-10-11 17:31:35	\N	131	-2	129	133	6
1143	460	3	2013-10-11 17:31:29	\N	11	172	183	-161	5
1186	478	1	2013-10-11 17:31:40	\N	185	140	325	45	8
1194	480	4	2013-10-11 17:31:42	\N	75	210	285	-135	1
1207	486	2	2013-10-11 17:31:44	\N	-83	-7	-90	-76	30
1169	470	4	2013-10-11 17:31:34	\N	190	194	384	-4	8
1152	464	2	2013-10-11 17:31:31	\N	7	66	73	-59	7
1166	470	1	2013-10-11 17:31:33	\N	110	198	308	-88	7
1203	484	3	2013-10-11 17:31:44	\N	-43	-9	-52	-34	15
1158	466	3	2013-10-11 17:31:32	\N	-50	23	-27	-73	6
1220	490	5	2013-10-11 17:31:48	\N	-90	40	-50	-130	1
1221	492	1	2013-10-11 17:31:48	\N	-83	292	209	-375	9
1234	496	4	2013-10-11 17:31:50	\N	79	59	138	20	9
1274	21	4	2013-10-11 17:31:57	\N	102	60	162	42	5
1226	494	1	2013-10-11 17:31:49	\N	-67	349	282	-416	2
1227	494	2	2013-10-11 17:31:49	\N	58	-48	10	106	4
1229	494	4	2013-10-11 17:31:50	\N	-15	267	252	-282	6
1232	496	2	2013-10-11 17:31:50	\N	-26	244	218	-270	10
1223	492	3	2013-10-11 17:31:48	\N	43	115	158	-72	8
1233	496	3	2013-10-11 17:31:50	\N	38	133	171	-95	9
1236	498	1	2013-10-11 17:31:51	\N	51	271	322	-220	3
1237	498	2	2013-10-11 17:31:51	\N	41	28	69	13	5
1238	498	3	2013-10-11 17:31:51	\N	174	-8	166	182	9
1240	498	5	2013-10-11 17:31:51	\N	147	112	259	35	4
1242	3	2	2013-10-11 17:31:52	\N	43	153	196	-110	6
1230	494	5	2013-10-11 17:31:50	\N	183	313	496	-130	11
1263	15	3	2013-10-11 17:31:55	\N	43	292	335	-249	5
1247	6	2	2013-10-11 17:31:53	\N	126	235	361	-109	6
1275	21	5	2013-10-11 17:31:57	\N	-27	232	205	-259	6
1250	6	5	2013-10-11 17:31:53	\N	26	204	230	-178	6
1251	9	1	2013-10-11 17:31:53	\N	-53	43	-10	-96	3
1252	9	2	2013-10-11 17:31:54	\N	-16	46	30	-62	3
1228	494	3	2013-10-11 17:31:49	\N	25	51	76	-26	7
1248	6	3	2013-10-11 17:31:53	\N	6	43	49	-37	6
1253	9	3	2013-10-11 17:31:54	\N	36	40	76	-4	6
1255	9	5	2013-10-11 17:31:54	\N	-59	84	25	-143	6
1241	3	1	2013-10-11 17:31:51	\N	44	328	372	-284	6
1256	12	1	2013-10-11 17:31:54	\N	59	329	388	-270	9
1218	490	3	2013-10-11 17:31:46	\N	137	119	256	18	4
1239	498	4	2013-10-11 17:31:51	\N	31	192	223	-161	5
1259	12	4	2013-10-11 17:31:55	\N	40	177	217	-137	4
1260	12	5	2013-10-11 17:31:55	\N	66	317	383	-251	11
1261	15	1	2013-10-11 17:31:55	\N	78	189	267	-111	8
1262	15	2	2013-10-11 17:31:55	\N	-35	87	52	-122	3
1264	15	4	2013-10-11 17:31:55	\N	119	89	208	30	6
1266	18	1	2013-10-11 17:31:56	\N	-91	32	-59	-123	2
1267	18	2	2013-10-11 17:31:56	\N	87	144	231	-57	2
1258	12	3	2013-10-11 17:31:54	\N	154	105	259	49	8
1268	18	3	2013-10-11 17:31:56	\N	178	96	274	82	8
990	398	5	2013-10-11 17:31:00	\N	49	329	378	-280	11
1265	15	5	2013-10-11 17:31:55	\N	0	329	329	-329	7
1270	18	5	2013-10-11 17:31:56	\N	23	318	341	-295	9
1271	21	1	2013-10-11 17:31:56	\N	127	328	455	-201	8
1257	12	2	2013-10-11 17:31:54	\N	170	62	232	108	6
1272	21	2	2013-10-11 17:31:56	\N	150	57	207	93	5
1273	21	3	2013-10-11 17:31:57	\N	139	-45	94	184	3
1276	24	1	2013-10-11 17:31:57	\N	181	217	398	-36	5
1277	24	2	2013-10-11 17:31:57	\N	-61	301	240	-362	8
1278	24	3	2013-10-11 17:31:57	\N	-15	193	178	-208	10
1254	9	4	2013-10-11 17:31:54	\N	164	170	334	-6	8
1279	24	4	2013-10-11 17:31:58	\N	-17	18	1	-35	4
1245	3	5	2013-10-11 17:31:53	\N	138	347	485	-209	4
1280	24	5	2013-10-11 17:31:58	\N	166	343	509	-177	7
1282	27	2	2013-10-11 17:31:58	\N	120	41	161	79	3
1283	27	3	2013-10-11 17:31:58	\N	-8	-43	-51	35	2
1284	27	4	2013-10-11 17:31:58	\N	73	332	405	-259	7
1286	30	1	2013-10-11 17:31:59	\N	116	105	221	11	7
1287	30	2	2013-10-11 17:31:59	\N	180	321	501	-141	4
1288	30	4	2013-10-11 17:31:59	\N	184	-47	137	231	1
1269	18	4	2013-10-11 17:31:56	\N	68	100	168	-32	7
1281	27	1	2013-10-11 17:31:58	\N	55	-30	25	85	8
1290	33	1	2013-10-11 17:31:59	\N	69	-48	21	117	7
1291	33	2	2013-10-11 17:31:59	\N	110	108	218	2	6
1292	33	3	2013-10-11 17:32:00	\N	176	47	223	129	2
1293	33	4	2013-10-11 17:32:00	\N	3	344	347	-341	5
1249	6	4	2013-10-11 17:31:53	\N	-93	-21	-114	-72	40
1225	492	5	2013-10-11 17:31:49	\N	-52	-17	-69	-35	27
1231	496	1	2013-10-11 17:31:50	\N	13	331	344	-318	6
1289	30	5	2013-10-11 17:31:59	\N	-44	-4	-48	-40	20
1222	492	2	2013-10-11 17:31:48	\N	-44	-25	-69	-19	18
1235	496	5	2013-10-11 17:31:51	\N	83	156	239	-73	4
1285	27	5	2013-10-11 17:31:58	\N	141	56	197	85	7
1246	6	1	2013-10-11 17:31:53	\N	199	103	302	96	6
1243	3	3	2013-10-11 17:31:52	\N	-13	196	183	-209	9
1164	468	4	2013-10-11 17:31:33	\N	-38	-11	-49	-27	15
1219	490	4	2013-10-11 17:31:48	\N	-43	-23	-66	-20	21
336	138	1	2013-10-11 17:29:01	\N	130	-15	115	145	5
1295	36	1	2013-10-11 17:32:00	\N	118	-9	109	127	5
1296	36	2	2013-10-11 17:32:00	\N	124	310	434	-186	6
1297	36	3	2013-10-11 17:32:00	\N	100	256	356	-156	5
1299	36	5	2013-10-11 17:32:01	\N	-62	179	117	-241	4
1300	39	1	2013-10-11 17:32:01	\N	22	89	111	-67	5
1301	39	2	2013-10-11 17:32:02	\N	14	178	192	-164	6
1302	39	3	2013-10-11 17:32:02	\N	-73	101	28	-174	8
1298	36	4	2013-10-11 17:32:01	\N	42	-8	34	50	6
1303	39	4	2013-10-11 17:32:02	\N	61	-26	35	87	3
1304	39	5	2013-10-11 17:32:02	\N	137	258	395	-121	3
1305	42	1	2013-10-11 17:32:02	\N	-52	283	231	-335	10
1107	446	2	2013-10-11 17:31:24	\N	130	333	463	-203	12
1306	42	2	2013-10-11 17:32:02	\N	108	347	455	-239	9
1307	42	3	2013-10-11 17:32:02	\N	133	7	140	126	7
1308	42	4	2013-10-11 17:32:03	\N	59	125	184	-66	9
1309	42	5	2013-10-11 17:32:03	\N	2	146	148	-144	5
1312	45	3	2013-10-11 17:32:04	\N	19	-25	-6	44	5
1313	45	4	2013-10-11 17:32:04	\N	139	43	182	96	4
1315	48	1	2013-10-11 17:32:04	\N	194	164	358	30	3
1316	48	2	2013-10-11 17:32:04	\N	200	99	299	101	6
1317	48	3	2013-10-11 17:32:05	\N	181	169	350	12	5
1318	48	4	2013-10-11 17:32:05	\N	69	212	281	-143	2
1319	48	5	2013-10-11 17:32:05	\N	-91	155	64	-246	1
1320	51	1	2013-10-11 17:32:05	\N	5	331	336	-326	6
1321	51	2	2013-10-11 17:32:05	\N	75	17	92	58	4
1322	51	3	2013-10-11 17:32:05	\N	122	285	407	-163	5
1323	51	4	2013-10-11 17:32:05	\N	-43	338	295	-381	5
1314	45	5	2013-10-11 17:32:04	\N	121	-6	115	127	7
1324	51	5	2013-10-11 17:32:06	\N	121	0	121	121	8
1325	54	1	2013-10-11 17:32:06	\N	72	14	86	58	7
1327	54	5	2013-10-11 17:32:06	\N	187	299	486	-112	10
1328	57	1	2013-10-11 17:32:07	\N	127	230	357	-103	4
1329	57	2	2013-10-11 17:32:07	\N	28	318	346	-290	6
1330	57	3	2013-10-11 17:32:07	\N	40	296	336	-256	5
1331	57	4	2013-10-11 17:32:07	\N	163	192	355	-29	10
1332	57	5	2013-10-11 17:32:07	\N	98	131	229	-33	3
1333	60	1	2013-10-11 17:32:07	\N	10	172	182	-162	2
1334	60	2	2013-10-11 17:32:08	\N	46	208	254	-162	6
933	376	3	2013-10-11 17:30:51	\N	-28	240	212	-268	10
1335	60	3	2013-10-11 17:32:08	\N	-53	254	201	-307	9
1336	60	4	2013-10-11 17:32:08	\N	111	239	350	-128	10
1337	60	5	2013-10-11 17:32:08	\N	157	31	188	126	9
1338	63	1	2013-10-11 17:32:08	\N	198	85	283	113	3
1311	45	2	2013-10-11 17:32:04	\N	26	69	95	-43	8
1339	63	2	2013-10-11 17:32:09	\N	22	82	104	-60	10
1340	63	3	2013-10-11 17:32:09	\N	16	185	201	-169	6
1341	63	4	2013-10-11 17:32:09	\N	156	81	237	75	6
1342	63	5	2013-10-11 17:32:09	\N	64	12	76	52	4
1211	488	1	2013-10-11 17:31:45	\N	97	194	291	-97	8
1343	66	1	2013-10-11 17:32:10	\N	125	182	307	-57	7
1344	66	2	2013-10-11 17:32:10	\N	181	-44	137	225	3
1108	446	3	2013-10-11 17:31:24	\N	-82	314	232	-396	8
1345	66	3	2013-10-11 17:32:10	\N	-84	303	219	-387	10
1351	6	1	2013-10-11 17:32:36	\N	-63	-116	-179	53	29
1363	10	4	2013-10-11 17:32:38	\N	-97	-87	-184	-10	33
1350	4	5	2013-10-11 17:32:36	\N	-101	-128	-229	27	36
1358	8	4	2013-10-11 17:32:37	\N	-127	-122	-249	-5	27
1362	10	3	2013-10-11 17:32:38	\N	-58	-31	-89	-27	28
1353	6	3	2013-10-11 17:32:36	\N	-101	-40	-141	-61	31
1364	10	5	2013-10-11 17:32:38	\N	-115	-21	-136	-94	35
1365	12	1	2013-10-11 17:32:38	\N	-126	-126	-252	0	33
1294	33	5	2013-10-11 17:32:00	\N	-53	-3	-56	-50	20
1352	6	2	2013-10-11 17:32:36	\N	-125	-146	-271	21	16
1244	3	4	2013-10-11 17:31:52	\N	-28	-17	-45	-11	9
1310	45	1	2013-10-11 17:32:04	\N	-36	-10	-46	-26	9
1355	8	1	2013-10-11 17:32:37	\N	-105	-27	-132	-78	32
1356	8	2	2013-10-11 17:32:37	\N	-94	-126	-220	32	35
1366	12	2	2013-10-11 17:32:38	\N	-144	-11	-155	-133	17
1354	6	5	2013-10-11 17:32:37	\N	-125	-147	-272	22	18
1349	4	4	2013-10-11 17:32:36	\N	-119	-49	-168	-70	46
1348	4	3	2013-10-11 17:32:36	\N	-132	-114	-246	-18	34
1361	10	2	2013-10-11 17:32:38	\N	-104	-46	-150	-58	40
1346	4	1	2013-10-11 17:32:35	\N	-82	-128	-210	46	28
1347	4	2	2013-10-11 17:32:35	\N	-93	-20	-113	-73	41
1224	492	4	2013-10-11 17:31:49	\N	-40	4	-36	-44	16
1326	54	4	2013-10-11 17:32:06	\N	-56	-21	-77	-35	26
1419	32	5	2013-10-11 17:32:48	\N	-109	-32	-141	-77	42
1413	30	4	2013-10-11 17:32:47	\N	-79	-109	-188	30	24
1402	26	3	2013-10-11 17:32:44	\N	-110	-118	-228	8	35
1387	20	3	2013-10-11 17:32:42	\N	-68	-143	-211	75	14
1391	22	2	2013-10-11 17:32:42	\N	-116	-144	-260	28	17
1397	24	3	2013-10-11 17:32:43	\N	-81	-35	-116	-46	38
1386	20	2	2013-10-11 17:32:42	\N	-118	-75	-193	-43	29
1426	36	2	2013-10-11 17:32:49	\N	-51	-20	-71	-31	23
1421	34	2	2013-10-11 17:32:48	\N	-50	-53	-103	3	19
1432	38	3	2013-10-11 17:32:49	\N	-140	-61	-201	-79	29
1407	28	3	2013-10-11 17:32:45	\N	-80	-6	-86	-74	26
1429	36	5	2013-10-11 17:32:49	\N	-63	-82	-145	19	18
1383	18	4	2013-10-11 17:32:41	\N	-62	-136	-198	74	13
1398	24	4	2013-10-11 17:32:44	\N	-111	-98	-209	-13	33
1368	12	4	2013-10-11 17:32:39	\N	-139	-28	-167	-111	37
1408	28	4	2013-10-11 17:32:45	\N	-115	-41	-156	-74	47
1380	18	1	2013-10-11 17:32:41	\N	-57	-64	-121	7	20
1376	16	2	2013-10-11 17:32:40	\N	-126	-57	-183	-69	34
1411	30	2	2013-10-11 17:32:46	\N	-78	-103	-181	25	28
1374	14	5	2013-10-11 17:32:40	\N	-89	-107	-196	18	35
1433	38	4	2013-10-11 17:32:50	\N	-130	-77	-207	-53	32
1385	20	1	2013-10-11 17:32:41	\N	-150	-6	-156	-144	10
1405	28	1	2013-10-11 17:32:45	\N	-100	-136	-236	36	27
1420	34	1	2013-10-11 17:32:48	\N	-123	-23	-146	-100	31
1377	16	3	2013-10-11 17:32:40	\N	-56	-69	-125	13	20
1416	32	2	2013-10-11 17:32:47	\N	-124	-127	-251	3	27
1434	38	5	2013-10-11 17:32:50	\N	-70	-37	-107	-33	39
1360	10	1	2013-10-11 17:32:37	\N	-73	-93	-166	20	37
1439	40	5	2013-10-11 17:32:50	\N	-114	-142	-256	28	22
1425	36	1	2013-10-11 17:32:49	\N	-101	-20	-121	-81	32
1414	30	5	2013-10-11 17:32:47	\N	-119	-17	-136	-102	31
1417	32	3	2013-10-11 17:32:47	\N	-69	-66	-135	-3	25
1401	26	2	2013-10-11 17:32:44	\N	-97	-86	-183	-11	30
1440	42	1	2013-10-11 17:32:51	\N	-112	-136	-248	24	27
1370	14	1	2013-10-11 17:32:39	\N	-59	-108	-167	49	28
1390	22	1	2013-10-11 17:32:42	\N	-54	-37	-91	-17	16
1430	38	1	2013-10-11 17:32:49	\N	-94	-89	-183	-5	38
1435	40	1	2013-10-11 17:32:50	\N	-94	-41	-135	-53	28
1395	24	1	2013-10-11 17:32:43	\N	-118	-106	-224	-12	27
1431	38	2	2013-10-11 17:32:49	\N	-111	-90	-201	-21	27
1371	14	2	2013-10-11 17:32:39	\N	-132	-45	-177	-87	36
1389	20	5	2013-10-11 17:32:42	\N	-52	-138	-190	86	8
1415	32	1	2013-10-11 17:32:47	\N	-136	-18	-154	-118	21
1404	26	5	2013-10-11 17:32:45	\N	-71	-123	-194	52	28
1392	22	3	2013-10-11 17:32:43	\N	-103	-117	-220	14	33
1403	26	4	2013-10-11 17:32:45	\N	-54	-80	-134	26	17
1381	18	2	2013-10-11 17:32:41	\N	-53	-40	-93	-13	25
1375	16	1	2013-10-11 17:32:40	\N	-150	-150	-300	0	13
1422	34	3	2013-10-11 17:32:48	\N	-111	-92	-203	-19	32
1367	12	3	2013-10-11 17:32:39	\N	-130	-36	-166	-94	31
1410	30	1	2013-10-11 17:32:46	\N	-136	-146	-282	10	22
1388	20	4	2013-10-11 17:32:42	\N	-56	-135	-191	79	13
1393	22	4	2013-10-11 17:32:43	\N	-110	-9	-119	-101	24
1396	24	2	2013-10-11 17:32:43	\N	-79	-28	-107	-51	40
1359	8	5	2013-10-11 17:32:37	\N	-141	-23	-164	-118	28
1384	18	5	2013-10-11 17:32:41	\N	-148	-64	-212	-84	20
1372	14	3	2013-10-11 17:32:39	\N	-96	-12	-108	-84	21
1428	36	4	2013-10-11 17:32:49	\N	-95	-18	-113	-77	39
1357	8	3	2013-10-11 17:32:37	\N	-144	-58	-202	-86	28
1382	18	3	2013-10-11 17:32:41	\N	-89	-107	-196	18	29
1394	22	5	2013-10-11 17:32:43	\N	-141	-29	-170	-112	27
1378	16	4	2013-10-11 17:32:40	\N	-93	-82	-175	-11	36
1436	40	2	2013-10-11 17:32:50	\N	-95	-37	-132	-58	39
1412	30	3	2013-10-11 17:32:47	\N	-132	-85	-217	-47	39
1373	14	4	2013-10-11 17:32:40	\N	-145	-144	-289	-1	12
1423	34	4	2013-10-11 17:32:48	\N	-111	-121	-232	10	31
1400	26	1	2013-10-11 17:32:44	\N	-71	-100	-171	29	38
1438	40	4	2013-10-11 17:32:50	\N	-91	-33	-124	-58	44
1424	34	5	2013-10-11 17:32:48	\N	-148	-21	-169	-127	17
1492	62	4	2013-10-11 17:32:59	\N	-82	-120	-202	38	27
1442	42	3	2013-10-11 17:32:51	\N	-74	-21	-95	-53	36
1459	48	5	2013-10-11 17:32:53	\N	-112	-57	-169	-55	36
1493	62	5	2013-10-11 17:32:59	\N	-118	-84	-202	-34	27
1455	48	1	2013-10-11 17:32:53	\N	-70	-93	-163	23	37
1484	58	5	2013-10-11 17:32:57	\N	-143	-111	-254	-32	22
1463	50	4	2013-10-11 17:32:54	\N	-50	-58	-108	8	16
1464	50	5	2013-10-11 17:32:54	\N	-81	-63	-144	-18	32
1462	50	3	2013-10-11 17:32:54	\N	-148	-79	-227	-69	23
1447	44	3	2013-10-11 17:32:52	\N	-133	-55	-188	-78	34
1446	44	2	2013-10-11 17:32:51	\N	-76	-137	-213	61	26
1458	48	4	2013-10-11 17:32:53	\N	-65	-12	-77	-53	30
1444	42	5	2013-10-11 17:32:51	\N	-149	-127	-276	-22	16
1479	56	5	2013-10-11 17:32:56	\N	-58	-11	-69	-47	24
1451	46	2	2013-10-11 17:32:52	\N	-66	-93	-159	27	18
1406	28	2	2013-10-11 17:32:45	\N	-79	-14	-93	-65	34
1441	42	2	2013-10-11 17:32:51	\N	-65	-3	-68	-62	17
1471	54	2	2013-10-11 17:32:55	\N	-92	-50	-142	-42	34
1481	58	2	2013-10-11 17:32:56	\N	-72	-69	-141	-3	26
1485	60	1	2013-10-11 17:32:58	\N	-121	-86	-207	-35	30
1467	52	3	2013-10-11 17:32:54	\N	-51	-53	-104	2	24
1509	70	1	2013-10-11 17:33:05	\N	-96	-9	-105	-87	26
1457	48	3	2013-10-11 17:32:53	\N	-89	-6	-95	-83	21
1473	54	4	2013-10-11 17:32:55	\N	-108	-32	-140	-76	49
1418	32	4	2013-10-11 17:32:48	\N	-92	-81	-173	-11	36
1483	58	4	2013-10-11 17:32:57	\N	-111	-112	-223	1	32
1452	46	3	2013-10-11 17:32:52	\N	-93	-120	-213	27	28
1461	50	2	2013-10-11 17:32:53	\N	-112	-73	-185	-39	24
1454	46	5	2013-10-11 17:32:52	\N	-122	-52	-174	-70	37
1478	56	4	2013-10-11 17:32:56	\N	-138	-94	-232	-44	22
1469	52	5	2013-10-11 17:32:55	\N	-117	-9	-126	-108	26
1487	60	3	2013-10-11 17:32:58	\N	-125	-75	-200	-50	39
1470	54	1	2013-10-11 17:32:55	\N	-150	-148	-298	-2	15
1427	36	3	2013-10-11 17:32:49	\N	-124	-46	-170	-78	36
1450	46	1	2013-10-11 17:32:52	\N	-100	-68	-168	-32	33
1486	60	2	2013-10-11 17:32:58	\N	-133	-103	-236	-30	27
1498	64	5	2013-10-11 17:33:00	\N	-86	-33	-119	-53	44
1480	58	1	2013-10-11 17:32:56	\N	-138	-38	-176	-100	25
1477	56	3	2013-10-11 17:32:56	\N	-130	-120	-250	-10	35
1456	48	2	2013-10-11 17:32:53	\N	-124	-106	-230	-18	33
1448	44	4	2013-10-11 17:32:52	\N	-134	-3	-137	-131	19
1475	56	1	2013-10-11 17:32:56	\N	-112	-144	-256	32	23
1496	64	3	2013-10-11 17:32:59	\N	-122	-148	-270	26	14
1510	70	2	2013-10-11 17:33:05	\N	-90	-128	-218	38	35
1495	64	2	2013-10-11 17:32:59	\N	-86	-31	-117	-55	40
1488	60	5	2013-10-11 17:32:58	\N	-111	-116	-227	5	41
1499	66	1	2013-10-11 17:33:00	\N	-130	-125	-255	-5	29
1512	70	4	2013-10-11 17:33:05	\N	-61	-54	-115	-7	24
1494	64	1	2013-10-11 17:32:59	\N	-133	-12	-145	-121	21
1468	52	4	2013-10-11 17:32:54	\N	-145	-24	-169	-121	26
1507	68	4	2013-10-11 17:33:04	\N	-124	-46	-170	-78	43
1449	44	5	2013-10-11 17:32:52	\N	-115	-140	-255	25	23
1443	42	4	2013-10-11 17:32:51	\N	-113	-77	-190	-36	38
1491	62	3	2013-10-11 17:32:59	\N	-93	-6	-99	-87	20
1453	46	4	2013-10-11 17:32:52	\N	-94	-59	-153	-35	41
1472	54	3	2013-10-11 17:32:55	\N	-140	-10	-150	-130	14
1445	44	1	2013-10-11 17:32:51	\N	-127	-136	-263	9	32
1504	68	1	2013-10-11 17:33:02	\N	-119	-13	-132	-106	25
1513	70	5	2013-10-11 17:33:05	\N	-83	-130	-213	47	30
1502	66	4	2013-10-11 17:33:00	\N	-117	-23	-140	-94	49
1474	54	5	2013-10-11 17:32:55	\N	-113	-78	-191	-35	30
1460	50	1	2013-10-11 17:32:53	\N	-143	-133	-276	-10	23
1511	70	3	2013-10-11 17:33:05	\N	-101	-9	-110	-92	20
1476	56	2	2013-10-11 17:32:56	\N	-111	-127	-238	16	33
1465	52	1	2013-10-11 17:32:54	\N	-109	-93	-202	-16	30
1482	58	3	2013-10-11 17:32:57	\N	-146	-5	-151	-141	12
1466	52	2	2013-10-11 17:32:54	\N	-74	-129	-203	55	27
1437	40	3	2013-10-11 17:32:50	\N	-137	-28	-165	-109	23
1490	62	2	2013-10-11 17:32:58	\N	-93	-124	-217	31	33
1501	66	3	2013-10-11 17:33:00	\N	-147	-7	-154	-140	12
1508	68	5	2013-10-11 17:33:04	\N	-148	-85	-233	-63	15
1575	96	2	2013-10-11 17:33:17	\N	-149	-67	-216	-82	16
1536	80	3	2013-10-11 17:33:11	\N	-118	-41	-159	-77	31
1576	96	3	2013-10-11 17:33:17	\N	-69	-79	-148	10	24
1537	80	4	2013-10-11 17:33:11	\N	-121	-87	-208	-34	36
1543	82	5	2013-10-11 17:33:12	\N	-100	-44	-144	-56	40
1527	76	4	2013-10-11 17:33:09	\N	-71	-32	-103	-39	36
1500	66	2	2013-10-11 17:33:00	\N	-57	-44	-101	-13	29
1564	92	1	2013-10-11 17:33:15	\N	-79	-46	-125	-33	27
1546	84	3	2013-10-11 17:33:12	\N	-114	-146	-260	32	18
1517	72	4	2013-10-11 17:33:06	\N	-131	-34	-165	-97	42
1549	86	1	2013-10-11 17:33:13	\N	-79	-9	-88	-70	22
1551	86	3	2013-10-11 17:33:13	\N	-146	-147	-293	1	10
1572	94	4	2013-10-11 17:33:16	\N	-121	-103	-224	-18	33
1525	76	2	2013-10-11 17:33:09	\N	-129	-122	-251	-7	27
1518	72	5	2013-10-11 17:33:06	\N	-64	-150	-214	86	11
1521	74	3	2013-10-11 17:33:08	\N	-146	-14	-160	-132	15
1526	76	3	2013-10-11 17:33:09	\N	-50	-40	-90	-10	25
1532	78	4	2013-10-11 17:33:10	\N	-109	-23	-132	-86	42
1535	80	2	2013-10-11 17:33:11	\N	-76	-136	-212	60	26
1505	68	2	2013-10-11 17:33:03	\N	-85	-40	-125	-45	37
1534	80	1	2013-10-11 17:33:10	\N	-53	-144	-197	91	8
1533	78	5	2013-10-11 17:33:10	\N	-117	-6	-123	-111	23
1539	82	1	2013-10-11 17:33:11	\N	-60	-81	-141	21	25
1570	94	2	2013-10-11 17:33:16	\N	-99	-17	-116	-82	40
1554	88	1	2013-10-11 17:33:14	\N	-148	-68	-216	-80	15
1560	90	2	2013-10-11 17:33:14	\N	-74	-144	-218	70	23
1552	86	4	2013-10-11 17:33:13	\N	-103	-80	-183	-23	36
1559	90	1	2013-10-11 17:33:14	\N	-85	-5	-90	-80	23
1540	82	2	2013-10-11 17:33:12	\N	-128	-90	-218	-38	27
1553	86	5	2013-10-11 17:33:13	\N	-132	-94	-226	-38	27
1522	74	4	2013-10-11 17:33:09	\N	-50	-60	-110	10	16
1409	28	5	2013-10-11 17:32:46	\N	-146	-22	-168	-124	22
1579	98	2	2013-10-11 17:33:17	\N	-67	-92	-159	25	22
1524	76	1	2013-10-11 17:33:09	\N	-120	-75	-195	-45	32
1369	12	5	2013-10-11 17:32:39	\N	-147	-38	-185	-109	22
1503	66	5	2013-10-11 17:33:00	\N	-120	-106	-226	-14	38
1497	64	4	2013-10-11 17:33:00	\N	-120	-49	-169	-71	45
1544	84	1	2013-10-11 17:33:12	\N	-114	-71	-185	-43	31
1519	74	1	2013-10-11 17:33:08	\N	-91	-64	-155	-27	30
1567	92	4	2013-10-11 17:33:15	\N	-125	-21	-146	-104	46
1555	88	2	2013-10-11 17:33:14	\N	-82	-133	-215	51	30
1529	78	1	2013-10-11 17:33:10	\N	-111	-92	-203	-19	31
1581	98	4	2013-10-11 17:33:17	\N	-62	-119	-181	57	18
1516	72	3	2013-10-11 17:33:06	\N	-84	-111	-195	27	24
1530	78	2	2013-10-11 17:33:10	\N	-122	-65	-187	-57	32
1563	90	5	2013-10-11 17:33:15	\N	-51	-82	-133	31	9
1578	96	5	2013-10-11 17:33:17	\N	-125	-116	-241	-9	32
1582	98	5	2013-10-11 17:33:18	\N	-130	-46	-176	-84	34
1573	94	5	2013-10-11 17:33:16	\N	-137	-117	-254	-20	26
1566	92	3	2013-10-11 17:33:15	\N	-113	-98	-211	-15	37
1568	92	5	2013-10-11 17:33:16	\N	-70	-108	-178	38	26
1556	88	3	2013-10-11 17:33:14	\N	-136	-122	-258	-14	30
1561	90	3	2013-10-11 17:33:15	\N	-79	-20	-99	-59	36
1523	74	5	2013-10-11 17:33:09	\N	-105	-33	-138	-72	45
1520	74	2	2013-10-11 17:33:08	\N	-142	-39	-181	-103	29
1558	88	5	2013-10-11 17:33:14	\N	-116	-109	-225	-7	39
1545	84	2	2013-10-11 17:33:12	\N	-92	-65	-157	-27	31
1571	94	3	2013-10-11 17:33:16	\N	-63	-23	-86	-40	28
1531	78	3	2013-10-11 17:33:10	\N	-55	-20	-75	-35	23
1541	82	3	2013-10-11 17:33:12	\N	-129	-133	-262	4	27
1580	98	3	2013-10-11 17:33:17	\N	-112	-117	-229	5	36
1379	16	5	2013-10-11 17:32:40	\N	-145	-45	-190	-100	24
1548	84	5	2013-10-11 17:33:13	\N	-87	-85	-172	-2	36
1565	92	2	2013-10-11 17:33:15	\N	-89	-29	-118	-60	40
1538	80	5	2013-10-11 17:33:11	\N	-55	-45	-100	-10	25
1574	96	1	2013-10-11 17:33:16	\N	-132	-83	-215	-49	23
1557	88	4	2013-10-11 17:33:14	\N	-136	-3	-139	-133	20
1528	76	5	2013-10-11 17:33:10	\N	-75	-101	-176	26	29
1550	86	2	2013-10-11 17:33:13	\N	-89	-44	-133	-45	34
1547	84	4	2013-10-11 17:33:13	\N	-101	-11	-112	-90	28
1399	24	5	2013-10-11 17:32:44	\N	-150	-40	-190	-110	21
1603	108	1	2013-10-11 17:33:21	\N	-120	-50	-170	-70	38
1590	102	3	2013-10-11 17:33:19	\N	-144	-69	-213	-75	25
1604	108	2	2013-10-11 17:33:21	\N	-148	-48	-196	-100	22
1621	114	4	2013-10-11 17:33:24	\N	-66	-30	-96	-36	33
1542	82	4	2013-10-11 17:33:12	\N	-96	-29	-125	-67	45
1596	104	4	2013-10-11 17:33:20	\N	-114	-74	-188	-40	38
1631	118	4	2013-10-11 17:33:25	\N	-141	-5	-146	-136	17
1605	108	3	2013-10-11 17:33:21	\N	-60	-143	-203	83	14
1634	120	2	2013-10-11 17:33:26	\N	-61	-15	-76	-46	28
1626	116	4	2013-10-11 17:33:25	\N	-111	-105	-216	-6	34
1600	106	3	2013-10-11 17:33:21	\N	-140	-111	-251	-29	30
1610	110	3	2013-10-11 17:33:22	\N	-127	-15	-142	-112	22
1637	120	5	2013-10-11 17:33:26	\N	-75	-117	-192	42	26
1584	100	2	2013-10-11 17:33:18	\N	-105	-131	-236	26	34
1612	110	5	2013-10-11 17:33:22	\N	-76	-50	-126	-26	35
1622	114	5	2013-10-11 17:33:24	\N	-148	-144	-292	-4	11
1593	104	1	2013-10-11 17:33:20	\N	-80	-12	-92	-68	23
1639	122	2	2013-10-11 17:33:27	\N	-69	-34	-103	-35	40
1583	100	1	2013-10-11 17:33:18	\N	-63	-80	-143	17	28
1643	124	1	2013-10-11 17:33:27	\N	-129	-141	-270	12	27
1617	112	5	2013-10-11 17:33:23	\N	-69	-3	-72	-66	30
1614	112	2	2013-10-11 17:33:23	\N	-135	-35	-170	-100	31
1647	124	5	2013-10-11 17:33:28	\N	-84	-101	-185	17	37
1635	120	3	2013-10-11 17:33:26	\N	-94	-133	-227	39	24
1515	72	2	2013-10-11 17:33:05	\N	-76	-37	-113	-39	36
1589	102	2	2013-10-11 17:33:19	\N	-69	-15	-84	-54	33
1648	126	1	2013-10-11 17:33:28	\N	-141	-53	-194	-88	20
1607	108	5	2013-10-11 17:33:22	\N	-135	-55	-190	-80	26
1587	100	5	2013-10-11 17:33:18	\N	-79	-147	-226	68	18
1602	106	5	2013-10-11 17:33:21	\N	-147	-60	-207	-87	20
1585	100	3	2013-10-11 17:33:18	\N	-107	-61	-168	-46	33
1633	120	1	2013-10-11 17:33:26	\N	-53	-25	-78	-28	17
1632	118	5	2013-10-11 17:33:26	\N	-84	-44	-128	-40	38
1598	106	1	2013-10-11 17:33:20	\N	-85	-118	-203	33	32
1591	102	4	2013-10-11 17:33:19	\N	-91	-121	-212	30	26
1645	124	3	2013-10-11 17:33:28	\N	-78	-104	-182	26	23
1613	112	1	2013-10-11 17:33:23	\N	-126	-74	-200	-52	29
1650	126	3	2013-10-11 17:33:28	\N	-102	-28	-130	-74	33
1623	116	1	2013-10-11 17:33:24	\N	-86	-115	-201	29	34
1618	114	1	2013-10-11 17:33:23	\N	-94	-89	-183	-5	38
1597	104	5	2013-10-11 17:33:20	\N	-77	-126	-203	49	29
1620	114	3	2013-10-11 17:33:24	\N	-148	-1	-149	-147	10
1588	102	1	2013-10-11 17:33:18	\N	-139	-93	-232	-46	19
1615	112	3	2013-10-11 17:33:23	\N	-135	-64	-199	-71	34
1595	104	3	2013-10-11 17:33:20	\N	-106	-128	-234	22	30
1616	112	4	2013-10-11 17:33:23	\N	-128	-62	-190	-66	33
1630	118	3	2013-10-11 17:33:25	\N	-88	-150	-238	62	15
1619	114	2	2013-10-11 17:33:24	\N	-96	-61	-157	-35	32
1586	100	4	2013-10-11 17:33:18	\N	-62	-27	-89	-35	28
1641	122	4	2013-10-11 17:33:27	\N	-90	-120	-210	30	26
1569	94	1	2013-10-11 17:33:16	\N	-76	-61	-137	-15	28
1594	104	2	2013-10-11 17:33:20	\N	-110	-15	-125	-95	31
1629	118	2	2013-10-11 17:33:25	\N	-120	-69	-189	-51	34
1625	116	3	2013-10-11 17:33:25	\N	-122	-44	-166	-78	35
1514	72	1	2013-10-11 17:33:05	\N	-78	-63	-141	-15	33
1638	122	1	2013-10-11 17:33:26	\N	-92	-12	-104	-80	26
1627	116	5	2013-10-11 17:33:25	\N	-105	-103	-208	-2	41
1601	106	4	2013-10-11 17:33:21	\N	-110	-59	-169	-51	46
1592	102	5	2013-10-11 17:33:19	\N	-96	-85	-181	-11	36
1642	122	5	2013-10-11 17:33:27	\N	-90	-17	-107	-73	39
1562	90	4	2013-10-11 17:33:15	\N	-91	-51	-142	-40	38
1611	110	4	2013-10-11 17:33:22	\N	-107	-40	-147	-67	49
1489	62	1	2013-10-11 17:32:58	\N	-62	-58	-120	-4	21
1577	96	4	2013-10-11 17:33:17	\N	-91	-46	-137	-45	38
1609	110	2	2013-10-11 17:33:22	\N	-135	-51	-186	-84	35
1606	108	4	2013-10-11 17:33:22	\N	-64	-91	-155	27	21
1640	122	3	2013-10-11 17:33:27	\N	-114	-103	-217	-11	38
1599	106	2	2013-10-11 17:33:20	\N	-116	-40	-156	-76	40
1608	110	1	2013-10-11 17:33:22	\N	-119	-113	-232	-6	31
1644	124	2	2013-10-11 17:33:27	\N	-110	-17	-127	-93	33
1682	138	5	2013-10-11 17:33:38	\N	-144	-82	-226	-62	17
1678	138	1	2013-10-11 17:33:33	\N	-133	-36	-169	-97	30
1683	140	1	2013-10-11 17:33:38	\N	-150	-118	-268	-32	19
1685	140	3	2013-10-11 17:33:38	\N	-97	-81	-178	-16	33
1680	138	3	2013-10-11 17:33:34	\N	-52	-115	-167	63	7
1689	142	2	2013-10-11 17:33:39	\N	-53	-145	-198	92	12
1624	116	2	2013-10-11 17:33:24	\N	-117	-47	-164	-70	38
1654	128	2	2013-10-11 17:33:29	\N	-53	-58	-111	5	19
1662	130	5	2013-10-11 17:33:31	\N	-84	-13	-97	-71	31
1714	152	2	2013-10-11 17:33:44	\N	-144	-87	-231	-57	17
1715	152	3	2013-10-11 17:33:44	\N	-127	-20	-147	-107	23
1657	128	5	2013-10-11 17:33:30	\N	-110	-116	-226	6	40
1670	134	3	2013-10-11 17:33:32	\N	-107	-131	-238	24	28
1652	126	5	2013-10-11 17:33:29	\N	-119	-124	-243	5	39
1718	154	1	2013-10-11 17:33:44	\N	-63	-70	-133	7	28
1666	132	4	2013-10-11 17:33:31	\N	-100	-13	-113	-87	30
1690	142	3	2013-10-11 17:33:39	\N	-64	-118	-182	54	17
1700	146	3	2013-10-11 17:33:42	\N	-66	-36	-102	-30	32
1659	130	2	2013-10-11 17:33:30	\N	-69	-109	-178	40	28
1674	136	2	2013-10-11 17:33:33	\N	-79	-118	-197	39	34
1669	134	2	2013-10-11 17:33:32	\N	-147	-27	-174	-120	24
1649	126	2	2013-10-11 17:33:28	\N	-125	-20	-145	-105	34
1681	138	4	2013-10-11 17:33:37	\N	-74	-119	-193	45	25
1721	154	4	2013-10-11 17:33:45	\N	-75	-3	-78	-72	23
1667	132	5	2013-10-11 17:33:31	\N	-76	-83	-159	7	27
1693	144	1	2013-10-11 17:33:41	\N	-142	-22	-164	-120	20
1668	134	1	2013-10-11 17:33:31	\N	-107	-30	-137	-77	33
1692	142	5	2013-10-11 17:33:39	\N	-138	-25	-163	-113	30
1717	152	5	2013-10-11 17:33:44	\N	-134	-73	-207	-61	27
1661	130	4	2013-10-11 17:33:30	\N	-131	-108	-239	-23	28
1686	140	4	2013-10-11 17:33:38	\N	-57	-73	-130	16	18
1656	128	4	2013-10-11 17:33:29	\N	-149	-16	-165	-133	18
1694	144	2	2013-10-11 17:33:41	\N	-58	-67	-125	9	23
1673	136	1	2013-10-11 17:33:32	\N	-53	-116	-169	63	23
1655	128	3	2013-10-11 17:33:29	\N	-59	-146	-205	87	12
1713	152	1	2013-10-11 17:33:43	\N	-58	-117	-175	59	26
1684	140	2	2013-10-11 17:33:38	\N	-142	-73	-215	-69	23
1706	148	4	2013-10-11 17:33:43	\N	-140	-100	-240	-40	24
1664	132	2	2013-10-11 17:33:31	\N	-132	-40	-172	-92	35
1675	136	3	2013-10-11 17:33:33	\N	-54	-36	-90	-18	29
1671	134	4	2013-10-11 17:33:32	\N	-139	-118	-257	-21	23
1660	130	3	2013-10-11 17:33:30	\N	-127	-57	-184	-70	35
1696	144	4	2013-10-11 17:33:41	\N	-100	-40	-140	-60	47
1665	132	3	2013-10-11 17:33:31	\N	-110	-89	-199	-21	32
1705	148	3	2013-10-11 17:33:42	\N	-75	-141	-216	66	16
1691	142	4	2013-10-11 17:33:39	\N	-65	-128	-193	63	19
1651	126	4	2013-10-11 17:33:29	\N	-79	-62	-141	-17	34
1709	150	2	2013-10-11 17:33:43	\N	-113	-61	-174	-52	34
1672	134	5	2013-10-11 17:33:32	\N	-114	-17	-131	-97	31
1676	136	4	2013-10-11 17:33:33	\N	-59	-8	-67	-51	23
1506	68	3	2013-10-11 17:33:04	\N	-110	-23	-133	-87	32
1646	124	4	2013-10-11 17:33:28	\N	-92	-68	-160	-24	32
1711	150	4	2013-10-11 17:33:43	\N	-52	-61	-113	9	17
1653	128	1	2013-10-11 17:33:29	\N	-103	-56	-159	-47	31
1688	142	1	2013-10-11 17:33:39	\N	-134	-76	-210	-58	25
1720	154	3	2013-10-11 17:33:45	\N	-95	-18	-113	-77	23
1677	136	5	2013-10-11 17:33:33	\N	-101	-117	-218	16	39
1719	154	2	2013-10-11 17:33:44	\N	-91	-70	-161	-21	27
1663	132	1	2013-10-11 17:33:31	\N	-54	-80	-134	26	22
1707	148	5	2013-10-11 17:33:43	\N	-100	-49	-149	-51	38
1708	150	1	2013-10-11 17:33:43	\N	-82	-104	-186	22	34
1695	144	3	2013-10-11 17:33:41	\N	-58	-28	-86	-30	27
1701	146	4	2013-10-11 17:33:42	\N	-55	-127	-182	72	14
1697	144	5	2013-10-11 17:33:41	\N	-114	-22	-136	-92	37
1628	118	1	2013-10-11 17:33:25	\N	-90	-61	-151	-29	33
1698	146	1	2013-10-11 17:33:41	\N	-150	-24	-174	-126	18
1716	152	4	2013-10-11 17:33:44	\N	-80	-37	-117	-43	40
1702	146	5	2013-10-11 17:33:42	\N	-79	-8	-87	-71	29
1658	130	1	2013-10-11 17:33:30	\N	-50	-95	-145	45	22
1703	148	1	2013-10-11 17:33:42	\N	-138	-53	-191	-85	22
1710	150	3	2013-10-11 17:33:43	\N	-79	-21	-100	-58	38
1712	150	5	2013-10-11 17:33:43	\N	-91	-13	-104	-78	35
1772	174	5	2013-10-11 17:33:53	\N	-117	-149	-266	32	17
1735	160	3	2013-10-11 17:33:47	\N	-108	-40	-148	-68	32
1736	160	4	2013-10-11 17:33:47	\N	-93	-84	-177	-9	34
1750	166	3	2013-10-11 17:33:49	\N	-149	-110	-259	-39	22
1731	158	4	2013-10-11 17:33:46	\N	-56	-66	-122	10	18
1785	180	3	2013-10-11 17:33:55	\N	-57	-93	-150	36	13
1761	170	4	2013-10-11 17:33:50	\N	-83	-141	-224	58	20
1741	162	4	2013-10-11 17:33:48	\N	-145	-16	-161	-129	21
1764	172	2	2013-10-11 17:33:51	\N	-145	-60	-205	-85	22
1722	154	5	2013-10-11 17:33:45	\N	-90	-113	-203	23	35
1687	140	5	2013-10-11 17:33:38	\N	-95	-107	-202	12	38
1768	174	1	2013-10-11 17:33:52	\N	-135	-29	-164	-106	28
1729	158	2	2013-10-11 17:33:46	\N	-95	-26	-121	-69	46
1784	180	2	2013-10-11 17:33:55	\N	-57	-38	-95	-19	29
1767	172	5	2013-10-11 17:33:52	\N	-132	-84	-216	-48	25
1762	170	5	2013-10-11 17:33:51	\N	-90	-10	-100	-80	33
1744	164	2	2013-10-11 17:33:48	\N	-71	-8	-79	-63	31
1769	174	2	2013-10-11 17:33:52	\N	-132	-138	-270	6	16
1734	160	2	2013-10-11 17:33:47	\N	-87	-121	-208	34	33
1737	160	5	2013-10-11 17:33:47	\N	-76	-10	-86	-66	31
1758	170	1	2013-10-11 17:33:50	\N	-127	-57	-184	-70	27
1742	162	5	2013-10-11 17:33:48	\N	-145	-145	-290	0	12
1746	164	4	2013-10-11 17:33:48	\N	-142	-122	-264	-20	20
1749	166	2	2013-10-11 17:33:49	\N	-119	-131	-250	12	28
1753	168	1	2013-10-11 17:33:49	\N	-52	-88	-140	36	22
1765	172	3	2013-10-11 17:33:52	\N	-141	-93	-234	-48	34
1679	138	2	2013-10-11 17:33:33	\N	-131	-23	-154	-108	32
1740	162	3	2013-10-11 17:33:47	\N	-97	-4	-101	-93	19
1728	158	1	2013-10-11 17:33:46	\N	-126	-135	-261	9	34
1791	182	4	2013-10-11 17:33:56	\N	-77	-80	-157	3	23
1755	168	3	2013-10-11 17:33:50	\N	-129	-24	-153	-105	23
1751	166	4	2013-10-11 17:33:49	\N	-114	-50	-164	-64	50
1760	170	3	2013-10-11 17:33:50	\N	-91	-123	-214	32	26
1730	158	3	2013-10-11 17:33:46	\N	-137	-97	-234	-40	33
1776	176	4	2013-10-11 17:33:53	\N	-136	-110	-246	-26	27
1759	170	2	2013-10-11 17:33:50	\N	-81	-37	-118	-44	36
1771	174	4	2013-10-11 17:33:53	\N	-139	-106	-245	-33	26
1775	176	3	2013-10-11 17:33:53	\N	-129	-110	-239	-19	37
1754	168	2	2013-10-11 17:33:49	\N	-99	-108	-207	9	35
1777	176	5	2013-10-11 17:33:53	\N	-94	-72	-166	-22	38
1747	164	5	2013-10-11 17:33:48	\N	-75	-67	-142	-8	32
1733	160	1	2013-10-11 17:33:46	\N	-138	-126	-264	-12	29
1783	180	1	2013-10-11 17:33:54	\N	-121	-104	-225	-17	27
1779	178	2	2013-10-11 17:33:54	\N	-80	-141	-221	61	25
1724	156	2	2013-10-11 17:33:45	\N	-108	-5	-113	-103	25
1725	156	3	2013-10-11 17:33:45	\N	-145	-59	-204	-86	26
1723	156	1	2013-10-11 17:33:45	\N	-73	-120	-193	47	30
1752	166	5	2013-10-11 17:33:49	\N	-97	-67	-164	-30	37
1773	176	1	2013-10-11 17:33:53	\N	-150	-140	-290	-10	20
1787	180	5	2013-10-11 17:33:55	\N	-100	-31	-131	-69	41
1782	178	5	2013-10-11 17:33:54	\N	-95	-55	-150	-40	37
1770	174	3	2013-10-11 17:33:52	\N	-115	-68	-183	-47	40
1636	120	4	2013-10-11 17:33:26	\N	-97	-54	-151	-43	44
1774	176	2	2013-10-11 17:33:53	\N	-68	-126	-194	58	28
1745	164	3	2013-10-11 17:33:48	\N	-149	-22	-171	-127	15
1732	158	5	2013-10-11 17:33:46	\N	-105	-131	-236	26	35
1726	156	4	2013-10-11 17:33:45	\N	-150	-60	-210	-90	12
1743	164	1	2013-10-11 17:33:48	\N	-143	-79	-222	-64	17
1781	178	4	2013-10-11 17:33:54	\N	-77	-138	-215	61	23
1756	168	4	2013-10-11 17:33:50	\N	-69	-67	-136	-2	28
1789	182	2	2013-10-11 17:33:55	\N	-69	-118	-187	49	32
1738	162	1	2013-10-11 17:33:47	\N	-74	-113	-187	39	32
1748	166	1	2013-10-11 17:33:49	\N	-76	-109	-185	33	32
1786	180	4	2013-10-11 17:33:55	\N	-92	-140	-232	48	19
1727	156	5	2013-10-11 17:33:46	\N	-73	-142	-215	69	16
1788	182	1	2013-10-11 17:33:55	\N	-72	-126	-198	54	28
1766	172	4	2013-10-11 17:33:52	\N	-80	-139	-219	59	21
1778	178	1	2013-10-11 17:33:54	\N	-100	-101	-201	1	35
1757	168	5	2013-10-11 17:33:50	\N	-70	-46	-116	-24	31
1699	146	2	2013-10-11 17:33:42	\N	-120	-12	-132	-108	29
1704	148	2	2013-10-11 17:33:42	\N	-114	-19	-133	-95	34
1780	178	3	2013-10-11 17:33:54	\N	-147	-118	-265	-29	22
1852	206	5	2013-10-11 17:34:09	\N	-91	-104	-195	13	36
1810	190	3	2013-10-11 17:33:58	\N	-54	-60	-114	6	22
1821	194	4	2013-10-11 17:34:00	\N	-107	-83	-190	-24	32
1793	184	1	2013-10-11 17:33:56	\N	-111	-73	-184	-38	29
1860	210	3	2013-10-11 17:34:11	\N	-90	-106	-196	16	28
1820	194	3	2013-10-11 17:34:00	\N	-98	0	-98	-98	18
1797	184	5	2013-10-11 17:33:56	\N	-56	-84	-140	28	13
1861	210	4	2013-10-11 17:34:11	\N	-125	-134	-259	9	23
1807	188	5	2013-10-11 17:33:58	\N	-90	-129	-219	39	33
1858	210	1	2013-10-11 17:34:10	\N	-89	-79	-168	-10	36
1833	200	1	2013-10-11 17:34:02	\N	-72	-72	-144	0	33
1824	196	2	2013-10-11 17:34:00	\N	-77	-67	-144	-10	24
1739	162	2	2013-10-11 17:33:47	\N	-123	-27	-150	-96	39
1863	212	1	2013-10-11 17:34:11	\N	-77	-144	-221	67	19
1804	188	2	2013-10-11 17:33:57	\N	-58	-146	-204	88	13
1825	196	3	2013-10-11 17:34:00	\N	-50	-28	-78	-22	24
1854	208	2	2013-10-11 17:34:10	\N	-60	-96	-156	36	17
1857	208	5	2013-10-11 17:34:10	\N	-119	-37	-156	-82	40
1809	190	2	2013-10-11 17:33:58	\N	-69	-37	-106	-32	39
1845	204	3	2013-10-11 17:34:05	\N	-87	-74	-161	-13	29
1798	186	1	2013-10-11 17:33:56	\N	-60	-74	-134	14	24
1844	204	2	2013-10-11 17:34:04	\N	-106	-85	-191	-21	29
1848	206	1	2013-10-11 17:34:06	\N	-150	-69	-219	-81	13
1829	198	2	2013-10-11 17:34:01	\N	-120	-102	-222	-18	36
1842	202	5	2013-10-11 17:34:04	\N	-146	-109	-255	-37	20
1799	186	2	2013-10-11 17:33:57	\N	-85	-127	-212	42	32
1816	192	4	2013-10-11 17:33:59	\N	-75	-59	-134	-16	35
1813	192	1	2013-10-11 17:33:59	\N	-98	-131	-229	33	30
1817	192	5	2013-10-11 17:33:59	\N	-134	-50	-184	-84	27
1795	184	3	2013-10-11 17:33:56	\N	-139	-99	-238	-40	31
1792	182	5	2013-10-11 17:33:56	\N	-108	-88	-196	-20	37
1796	184	4	2013-10-11 17:33:56	\N	-50	-26	-76	-24	23
1806	188	4	2013-10-11 17:33:58	\N	-112	-70	-182	-42	42
1837	200	5	2013-10-11 17:34:03	\N	-102	-59	-161	-43	42
1808	190	1	2013-10-11 17:33:58	\N	-50	-31	-81	-19	13
1832	198	5	2013-10-11 17:34:02	\N	-77	-95	-172	18	30
1826	196	4	2013-10-11 17:34:01	\N	-142	-125	-267	-17	18
1849	206	2	2013-10-11 17:34:08	\N	-77	-86	-163	9	23
1827	196	5	2013-10-11 17:34:01	\N	-127	-39	-166	-88	35
1847	204	5	2013-10-11 17:34:05	\N	-141	-141	-282	0	19
1836	200	4	2013-10-11 17:34:03	\N	-73	-86	-159	13	24
1818	194	1	2013-10-11 17:33:59	\N	-106	-5	-111	-101	26
1814	192	2	2013-10-11 17:33:59	\N	-148	-53	-201	-95	21
1838	202	1	2013-10-11 17:34:03	\N	-92	-32	-124	-60	30
1811	190	4	2013-10-11 17:33:58	\N	-134	-37	-171	-97	41
1862	210	5	2013-10-11 17:34:11	\N	-64	-1	-65	-63	28
1843	204	1	2013-10-11 17:34:04	\N	-68	0	-68	-68	20
1800	186	3	2013-10-11 17:33:57	\N	-81	-97	-178	16	26
1790	182	3	2013-10-11 17:33:55	\N	-137	-124	-261	-13	25
1830	198	3	2013-10-11 17:34:01	\N	-135	-40	-175	-95	32
1839	202	2	2013-10-11 17:34:03	\N	-79	-26	-105	-53	40
1853	208	1	2013-10-11 17:34:09	\N	-128	-21	-149	-107	28
1856	208	4	2013-10-11 17:34:10	\N	-119	-59	-178	-60	43
1805	188	3	2013-10-11 17:33:57	\N	-65	0	-65	-65	22
1803	188	1	2013-10-11 17:33:57	\N	-107	-36	-143	-71	35
1834	200	2	2013-10-11 17:34:03	\N	-112	-32	-144	-80	41
1855	208	3	2013-10-11 17:34:10	\N	-109	-63	-172	-46	36
1831	198	4	2013-10-11 17:34:01	\N	-145	-99	-244	-46	17
1828	198	1	2013-10-11 17:34:01	\N	-66	-144	-210	78	14
1835	200	3	2013-10-11 17:34:03	\N	-62	-3	-65	-59	22
1840	202	3	2013-10-11 17:34:04	\N	-144	-114	-258	-30	23
1851	206	4	2013-10-11 17:34:09	\N	-101	-47	-148	-54	47
1815	192	3	2013-10-11 17:33:59	\N	-109	-77	-186	-32	33
1801	186	4	2013-10-11 17:33:57	\N	-109	-29	-138	-80	47
1823	196	1	2013-10-11 17:34:00	\N	-97	-39	-136	-58	27
1841	202	4	2013-10-11 17:34:04	\N	-144	-20	-164	-124	23
1819	194	2	2013-10-11 17:34:00	\N	-144	-33	-177	-111	27
1802	186	5	2013-10-11 17:33:57	\N	-70	-125	-195	55	24
1822	194	5	2013-10-11 17:34:00	\N	-57	-92	-149	35	12
1794	184	2	2013-10-11 17:33:56	\N	-146	-4	-150	-142	12
1901	226	4	2013-10-11 17:34:19	\N	-60	-51	-111	-9	23
1872	214	5	2013-10-11 17:34:14	\N	-105	-137	-242	32	29
1882	218	5	2013-10-11 17:34:16	\N	-122	-14	-136	-108	25
1878	218	1	2013-10-11 17:34:15	\N	-122	-100	-222	-22	32
1915	232	3	2013-10-11 17:34:21	\N	-64	-29	-93	-35	30
1929	238	2	2013-10-11 17:34:23	\N	-135	-101	-236	-34	24
1888	222	1	2013-10-11 17:34:17	\N	-87	-98	-185	11	37
1893	224	1	2013-10-11 17:34:17	\N	-94	-46	-140	-48	27
1890	222	3	2013-10-11 17:34:17	\N	-137	-66	-203	-71	31
1925	236	3	2013-10-11 17:34:22	\N	-133	-120	-253	-13	33
1885	220	3	2013-10-11 17:34:16	\N	-63	-122	-185	59	17
1916	232	4	2013-10-11 17:34:21	\N	-116	-30	-146	-86	51
1906	228	4	2013-10-11 17:34:19	\N	-118	-90	-208	-28	33
1864	212	2	2013-10-11 17:34:11	\N	-103	-84	-187	-19	30
1899	226	2	2013-10-11 17:34:18	\N	-76	-10	-86	-66	32
1871	214	4	2013-10-11 17:34:14	\N	-140	-10	-150	-130	21
1880	218	3	2013-10-11 17:34:15	\N	-91	-8	-99	-83	21
1911	230	4	2013-10-11 17:34:20	\N	-63	-111	-174	48	19
1912	230	5	2013-10-11 17:34:20	\N	-62	-21	-83	-41	37
1867	212	5	2013-10-11 17:34:13	\N	-129	-119	-248	-10	35
1902	226	5	2013-10-11 17:34:19	\N	-106	-109	-215	3	39
1930	238	3	2013-10-11 17:34:23	\N	-147	-81	-228	-66	26
1910	230	3	2013-10-11 17:34:20	\N	-73	-68	-141	-5	26
1920	234	3	2013-10-11 17:34:21	\N	-113	-104	-217	-9	40
1850	206	3	2013-10-11 17:34:09	\N	-128	-90	-218	-38	38
1896	224	4	2013-10-11 17:34:18	\N	-110	-16	-126	-94	34
1935	240	3	2013-10-11 17:34:24	\N	-92	-84	-176	-8	29
1895	224	3	2013-10-11 17:34:18	\N	-99	-13	-112	-86	25
1923	236	1	2013-10-11 17:34:22	\N	-130	-126	-256	-4	30
1897	224	5	2013-10-11 17:34:18	\N	-77	-39	-116	-38	43
1914	232	2	2013-10-11 17:34:20	\N	-135	-119	-254	-16	25
1870	214	3	2013-10-11 17:34:14	\N	-55	-41	-96	-14	29
1874	216	2	2013-10-11 17:34:14	\N	-71	-139	-210	68	23
1918	234	1	2013-10-11 17:34:21	\N	-144	-91	-235	-53	16
1931	238	4	2013-10-11 17:34:23	\N	-134	-125	-259	-9	21
1909	230	2	2013-10-11 17:34:20	\N	-128	-25	-153	-103	36
1868	214	1	2013-10-11 17:34:13	\N	-116	-110	-226	-6	30
1919	234	2	2013-10-11 17:34:21	\N	-74	-118	-192	44	31
1876	216	4	2013-10-11 17:34:15	\N	-74	-85	-159	11	24
1936	240	4	2013-10-11 17:34:25	\N	-109	-29	-138	-80	48
1866	212	4	2013-10-11 17:34:12	\N	-96	-136	-232	40	21
1927	236	5	2013-10-11 17:34:22	\N	-87	-144	-231	57	21
1859	210	2	2013-10-11 17:34:10	\N	-105	-59	-164	-46	36
1898	226	1	2013-10-11 17:34:18	\N	-110	-22	-132	-88	33
1869	214	2	2013-10-11 17:34:14	\N	-98	-90	-188	-8	28
1875	216	3	2013-10-11 17:34:14	\N	-123	-30	-153	-93	27
1889	222	2	2013-10-11 17:34:17	\N	-119	-41	-160	-78	39
1883	220	1	2013-10-11 17:34:16	\N	-136	-24	-160	-112	26
1865	212	3	2013-10-11 17:34:12	\N	-94	-97	-191	3	26
1873	216	1	2013-10-11 17:34:14	\N	-101	-76	-177	-25	30
1886	220	4	2013-10-11 17:34:16	\N	-82	-37	-119	-45	42
1891	222	4	2013-10-11 17:34:17	\N	-95	-145	-240	50	17
1922	234	5	2013-10-11 17:34:22	\N	-145	-36	-181	-109	22
1877	216	5	2013-10-11 17:34:15	\N	-142	-133	-275	-9	21
1884	220	2	2013-10-11 17:34:16	\N	-148	-119	-267	-29	18
1894	224	2	2013-10-11 17:34:18	\N	-141	-104	-245	-37	18
1903	228	1	2013-10-11 17:34:19	\N	-52	-98	-150	46	24
1887	220	5	2013-10-11 17:34:16	\N	-91	-52	-143	-39	34
1907	228	5	2013-10-11 17:34:20	\N	-51	-137	-188	86	8
1928	238	1	2013-10-11 17:34:23	\N	-129	-12	-141	-117	24
1908	230	1	2013-10-11 17:34:20	\N	-142	-18	-160	-124	19
1921	234	4	2013-10-11 17:34:22	\N	-96	-140	-236	44	18
1937	240	5	2013-10-11 17:34:25	\N	-77	-65	-142	-12	33
1900	226	3	2013-10-11 17:34:19	\N	-147	-87	-234	-60	28
1917	232	5	2013-10-11 17:34:21	\N	-150	-136	-286	-14	14
1904	228	2	2013-10-11 17:34:19	\N	-90	-125	-215	35	34
1926	236	4	2013-10-11 17:34:22	\N	-111	-18	-129	-93	37
1879	218	2	2013-10-11 17:34:15	\N	-132	-71	-203	-61	28
1881	218	4	2013-10-11 17:34:16	\N	-70	-41	-111	-29	33
1892	222	5	2013-10-11 17:34:17	\N	-123	-131	-254	8	30
1932	238	5	2013-10-11 17:34:23	\N	-139	-114	-253	-25	24
1959	250	3	2013-10-11 17:34:28	\N	-59	-26	-85	-33	27
1913	232	1	2013-10-11 17:34:20	\N	-118	-24	-142	-94	33
1956	248	5	2013-10-11 17:34:28	\N	-87	-26	-113	-61	43
1960	250	4	2013-10-11 17:34:28	\N	-71	-94	-165	23	21
1955	248	4	2013-10-11 17:34:28	\N	-96	-9	-105	-87	31
1984	260	3	2013-10-11 17:34:32	\N	-121	-65	-186	-56	39
1970	254	4	2013-10-11 17:34:30	\N	-114	-93	-207	-21	31
1933	240	1	2013-10-11 17:34:24	\N	-118	-51	-169	-67	38
1953	248	2	2013-10-11 17:34:27	\N	-54	-60	-114	6	19
1977	258	1	2013-10-11 17:34:31	\N	-128	-22	-150	-106	29
1968	254	2	2013-10-11 17:34:30	\N	-147	-13	-160	-134	16
1945	244	4	2013-10-11 17:34:26	\N	-149	-31	-180	-118	25
1950	246	4	2013-10-11 17:34:27	\N	-123	-145	-268	22	16
1939	242	3	2013-10-11 17:34:25	\N	-82	-61	-143	-21	30
1962	252	1	2013-10-11 17:34:28	\N	-113	-121	-234	8	37
2008	270	2	2013-10-11 17:34:40	\N	-129	-119	-248	-10	28
1965	252	4	2013-10-11 17:34:29	\N	-64	-126	-190	62	19
1947	246	1	2013-10-11 17:34:26	\N	-61	-138	-199	77	13
1981	258	5	2013-10-11 17:34:31	\N	-73	-60	-133	-13	32
1964	252	3	2013-10-11 17:34:29	\N	-77	-55	-132	-22	30
1963	252	2	2013-10-11 17:34:29	\N	-79	-4	-83	-75	28
1954	248	3	2013-10-11 17:34:27	\N	-73	-120	-193	47	21
1969	254	3	2013-10-11 17:34:30	\N	-136	-116	-252	-20	29
1979	258	3	2013-10-11 17:34:31	\N	-146	-6	-152	-140	12
1966	252	5	2013-10-11 17:34:29	\N	-94	-51	-145	-43	36
1983	260	2	2013-10-11 17:34:32	\N	-52	-55	-107	3	20
2003	268	2	2013-10-11 17:34:35	\N	-143	-27	-170	-116	26
2006	268	5	2013-10-11 17:34:39	\N	-74	-29	-103	-45	43
1996	264	5	2013-10-11 17:34:33	\N	-96	-40	-136	-56	39
1948	246	2	2013-10-11 17:34:27	\N	-137	-51	-188	-86	31
1957	250	1	2013-10-11 17:34:28	\N	-86	-19	-105	-67	32
1951	246	5	2013-10-11 17:34:27	\N	-119	-97	-216	-22	37
1958	250	2	2013-10-11 17:34:28	\N	-98	-18	-116	-80	42
2002	268	1	2013-10-11 17:34:35	\N	-101	-79	-180	-22	29
1980	258	4	2013-10-11 17:34:31	\N	-94	-77	-171	-17	33
1982	260	1	2013-10-11 17:34:32	\N	-107	-78	-185	-29	34
1978	258	2	2013-10-11 17:34:31	\N	-77	-48	-125	-29	37
1987	262	1	2013-10-11 17:34:32	\N	-140	-113	-253	-27	27
1938	242	2	2013-10-11 17:34:25	\N	-103	-40	-143	-63	42
2005	268	4	2013-10-11 17:34:38	\N	-137	-134	-271	-3	17
1985	260	4	2013-10-11 17:34:32	\N	-118	-97	-215	-21	33
2007	270	1	2013-10-11 17:34:40	\N	-57	-12	-69	-45	20
1942	244	1	2013-10-11 17:34:26	\N	-62	-89	-151	27	33
1961	250	5	2013-10-11 17:34:28	\N	-129	-114	-243	-15	30
1975	256	4	2013-10-11 17:34:31	\N	-53	-69	-122	16	17
2000	266	4	2013-10-11 17:34:35	\N	-129	-50	-179	-79	42
1952	248	1	2013-10-11 17:34:27	\N	-78	-84	-162	6	39
1986	260	5	2013-10-11 17:34:32	\N	-129	-98	-227	-31	30
1949	246	3	2013-10-11 17:34:27	\N	-100	-53	-153	-47	27
1994	264	3	2013-10-11 17:34:33	\N	-84	-59	-143	-25	29
1998	266	2	2013-10-11 17:34:34	\N	-88	-25	-113	-63	41
1990	262	4	2013-10-11 17:34:33	\N	-112	-48	-160	-64	47
1992	264	1	2013-10-11 17:34:33	\N	-70	-99	-169	29	38
2009	270	3	2013-10-11 17:34:40	\N	-132	-28	-160	-104	23
1973	256	2	2013-10-11 17:34:30	\N	-62	-119	-181	57	27
1944	244	3	2013-10-11 17:34:26	\N	-88	-130	-218	42	27
1993	264	2	2013-10-11 17:34:33	\N	-62	-74	-136	12	20
1997	266	1	2013-10-11 17:34:34	\N	-124	-131	-255	7	33
1972	256	1	2013-10-11 17:34:30	\N	-92	-142	-234	50	19
1976	256	5	2013-10-11 17:34:31	\N	-121	-74	-195	-47	31
1967	254	1	2013-10-11 17:34:29	\N	-85	-18	-103	-67	32
1946	244	5	2013-10-11 17:34:26	\N	-89	-118	-207	29	34
1941	242	5	2013-10-11 17:34:26	\N	-91	-113	-204	22	36
1940	242	4	2013-10-11 17:34:25	\N	-120	-91	-211	-29	33
1988	262	2	2013-10-11 17:34:32	\N	-79	-131	-210	52	28
1934	240	2	2013-10-11 17:34:24	\N	-108	-94	-202	-14	27
1989	262	3	2013-10-11 17:34:33	\N	-60	-88	-148	28	15
1924	236	2	2013-10-11 17:34:22	\N	-81	-104	-185	23	33
2004	268	3	2013-10-11 17:34:37	\N	-99	-43	-142	-56	28
1943	244	2	2013-10-11 17:34:26	\N	-94	-118	-212	24	38
1974	256	3	2013-10-11 17:34:30	\N	-59	-52	-111	-7	29
2010	270	4	2013-10-11 17:34:40	\N	-57	-68	-125	11	19
1991	262	5	2013-10-11 17:34:33	\N	-69	-145	-214	76	13
2049	286	4	2013-10-11 17:34:49	\N	-54	-102	-156	48	13
2027	278	2	2013-10-11 17:34:43	\N	-55	-150	-205	95	9
2013	272	2	2013-10-11 17:34:41	\N	-126	-120	-246	-6	28
2073	296	3	2013-10-11 17:34:52	\N	-90	-20	-110	-70	27
2023	276	3	2013-10-11 17:34:43	\N	-117	-52	-169	-65	36
2017	274	1	2013-10-11 17:34:41	\N	-136	-62	-198	-74	22
2071	296	1	2013-10-11 17:34:52	\N	-95	-86	-181	-9	34
2048	286	3	2013-10-11 17:34:49	\N	-133	-64	-197	-69	34
2045	284	5	2013-10-11 17:34:48	\N	-88	-100	-188	12	37
2068	294	3	2013-10-11 17:34:52	\N	-105	-121	-226	16	30
2044	284	4	2013-10-11 17:34:48	\N	-122	-43	-165	-79	46
2067	294	2	2013-10-11 17:34:51	\N	-147	-29	-176	-118	23
2039	282	4	2013-10-11 17:34:45	\N	-140	-64	-204	-76	24
2053	288	3	2013-10-11 17:34:49	\N	-111	-53	-164	-58	33
2014	272	3	2013-10-11 17:34:41	\N	-62	-22	-84	-40	27
2057	290	2	2013-10-11 17:34:50	\N	-122	-106	-228	-16	35
2020	274	4	2013-10-11 17:34:42	\N	-101	-134	-235	33	25
2058	290	3	2013-10-11 17:34:50	\N	-131	-111	-242	-20	34
2061	292	1	2013-10-11 17:34:50	\N	-104	-14	-118	-90	30
2025	276	5	2013-10-11 17:34:43	\N	-113	-27	-140	-86	39
2062	292	2	2013-10-11 17:34:51	\N	-96	-103	-199	7	34
2078	298	3	2013-10-11 17:34:53	\N	-58	-34	-92	-24	29
2042	284	2	2013-10-11 17:34:48	\N	-123	-42	-165	-81	38
2028	278	3	2013-10-11 17:34:44	\N	-145	-110	-255	-35	25
2018	274	2	2013-10-11 17:34:41	\N	-145	-48	-193	-97	26
2034	280	4	2013-10-11 17:34:45	\N	-150	-129	-279	-21	14
2019	274	3	2013-10-11 17:34:41	\N	-124	-90	-214	-34	39
2052	288	2	2013-10-11 17:34:49	\N	-118	-142	-260	24	18
2037	282	2	2013-10-11 17:34:45	\N	-120	-35	-155	-85	42
2011	270	5	2013-10-11 17:34:40	\N	-85	-129	-214	44	33
2046	286	1	2013-10-11 17:34:48	\N	-102	-72	-174	-30	34
2066	294	1	2013-10-11 17:34:51	\N	-72	-16	-88	-56	24
2076	298	1	2013-10-11 17:34:53	\N	-135	-43	-178	-92	27
2035	280	5	2013-10-11 17:34:45	\N	-128	-100	-228	-28	30
2026	278	1	2013-10-11 17:34:43	\N	-98	-134	-232	36	28
2063	292	3	2013-10-11 17:34:51	\N	-137	-33	-170	-104	26
2016	272	5	2013-10-11 17:34:41	\N	-71	-76	-147	5	26
2001	266	5	2013-10-11 17:34:35	\N	-118	-58	-176	-60	35
2056	290	1	2013-10-11 17:34:50	\N	-84	-50	-134	-34	25
2024	276	4	2013-10-11 17:34:43	\N	-66	-136	-202	70	20
2077	298	2	2013-10-11 17:34:53	\N	-131	-97	-228	-34	29
1905	228	3	2013-10-11 17:34:19	\N	-107	-92	-199	-15	33
2050	286	5	2013-10-11 17:34:49	\N	-105	-49	-154	-56	40
2031	280	1	2013-10-11 17:34:44	\N	-120	-143	-263	23	30
2060	290	5	2013-10-11 17:34:50	\N	-98	-8	-106	-90	29
2032	280	2	2013-10-11 17:34:44	\N	-80	-63	-143	-17	29
2022	276	1	2013-10-11 17:34:43	\N	-130	-94	-224	-36	21
2079	298	4	2013-10-11 17:34:53	\N	-82	-144	-226	62	18
2055	288	5	2013-10-11 17:34:50	\N	-75	-9	-84	-66	31
2033	280	3	2013-10-11 17:34:44	\N	-88	-149	-237	61	16
1812	190	5	2013-10-11 17:33:59	\N	-92	-112	-204	20	39
2074	296	4	2013-10-11 17:34:52	\N	-70	-14	-84	-56	33
2081	300	1	2013-10-11 17:34:54	\N	-141	-38	-179	-103	24
2080	298	5	2013-10-11 17:34:53	\N	-58	-88	-146	30	16
2015	272	4	2013-10-11 17:34:41	\N	-145	-3	-148	-142	15
2054	288	4	2013-10-11 17:34:49	\N	-108	-38	-146	-70	51
2082	300	2	2013-10-11 17:34:54	\N	-100	-9	-109	-91	30
2021	274	5	2013-10-11 17:34:42	\N	-87	-82	-169	-5	32
1971	254	5	2013-10-11 17:34:30	\N	-114	-80	-194	-34	30
2030	278	5	2013-10-11 17:34:44	\N	-119	-84	-203	-35	29
2059	290	4	2013-10-11 17:34:50	\N	-149	-15	-164	-134	18
2070	294	5	2013-10-11 17:34:52	\N	-112	-6	-118	-106	21
2064	292	4	2013-10-11 17:34:51	\N	-113	-62	-175	-51	45
2041	284	1	2013-10-11 17:34:47	\N	-68	-102	-170	34	33
2036	282	1	2013-10-11 17:34:45	\N	-73	-118	-191	45	31
2012	272	1	2013-10-11 17:34:40	\N	-88	-136	-224	48	22
2029	278	4	2013-10-11 17:34:44	\N	-130	-57	-187	-73	34
2069	294	4	2013-10-11 17:34:52	\N	-138	-55	-193	-83	27
2126	318	1	2013-10-11 17:35:01	\N	-98	-127	-225	29	36
2104	308	4	2013-10-11 17:34:58	\N	-84	-111	-195	27	29
2095	304	5	2013-10-11 17:34:56	\N	-100	-136	-236	36	28
2136	322	1	2013-10-11 17:35:03	\N	-83	-94	-177	11	34
2103	308	3	2013-10-11 17:34:58	\N	-95	0	-95	-95	19
2124	316	4	2013-10-11 17:35:01	\N	-93	-104	-197	11	30
2116	314	1	2013-10-11 17:35:00	\N	-131	-49	-180	-82	28
2088	302	3	2013-10-11 17:34:55	\N	-109	-52	-161	-57	33
2100	306	5	2013-10-11 17:34:57	\N	-85	-51	-136	-34	35
1846	204	4	2013-10-11 17:34:05	\N	-108	-61	-169	-47	43
2090	302	5	2013-10-11 17:34:55	\N	-112	-131	-243	19	34
2105	308	5	2013-10-11 17:34:58	\N	-133	-136	-269	3	24
2110	310	5	2013-10-11 17:34:59	\N	-133	-134	-267	1	27
2142	324	2	2013-10-11 17:35:04	\N	-75	-62	-137	-13	28
2138	322	3	2013-10-11 17:35:03	\N	-99	-101	-200	2	31
2086	302	1	2013-10-11 17:34:54	\N	-146	-128	-274	-18	23
2096	306	1	2013-10-11 17:34:56	\N	-113	-55	-168	-58	32
2098	306	3	2013-10-11 17:34:57	\N	-54	-14	-68	-40	21
1995	264	4	2013-10-11 17:34:33	\N	-111	-85	-196	-26	31
2114	312	4	2013-10-11 17:34:59	\N	-68	-4	-72	-64	26
2119	314	4	2013-10-11 17:35:00	\N	-58	-31	-89	-27	26
2094	304	4	2013-10-11 17:34:56	\N	-90	-36	-126	-54	44
2091	304	1	2013-10-11 17:34:55	\N	-110	-110	-220	0	32
2107	310	2	2013-10-11 17:34:58	\N	-66	-8	-74	-58	24
2130	318	5	2013-10-11 17:35:02	\N	-68	-16	-84	-52	35
2134	320	4	2013-10-11 17:35:03	\N	-69	-8	-77	-61	28
2043	284	3	2013-10-11 17:34:48	\N	-88	-84	-172	-4	28
2135	320	5	2013-10-11 17:35:03	\N	-58	-102	-160	44	15
2038	282	3	2013-10-11 17:34:45	\N	-58	-54	-112	-4	27
2087	302	2	2013-10-11 17:34:54	\N	-82	-118	-200	36	35
2101	308	1	2013-10-11 17:34:57	\N	-91	-138	-229	47	21
2113	312	3	2013-10-11 17:34:59	\N	-129	-128	-257	-1	31
2143	324	3	2013-10-11 17:35:04	\N	-126	-120	-246	-6	33
2131	320	1	2013-10-11 17:35:02	\N	-102	-146	-248	44	20
2122	316	2	2013-10-11 17:35:01	\N	-117	-8	-125	-109	22
2132	320	2	2013-10-11 17:35:02	\N	-130	-9	-139	-121	21
2085	300	5	2013-10-11 17:34:54	\N	-128	-47	-175	-81	33
2084	300	4	2013-10-11 17:34:54	\N	-144	-17	-161	-127	22
2115	312	5	2013-10-11 17:35:00	\N	-87	-55	-142	-32	39
2125	316	5	2013-10-11 17:35:01	\N	-118	-8	-126	-110	26
2102	308	2	2013-10-11 17:34:57	\N	-144	-104	-248	-40	17
2106	310	1	2013-10-11 17:34:58	\N	-84	-75	-159	-9	37
2148	326	3	2013-10-11 17:35:05	\N	-118	-122	-240	4	32
2099	306	4	2013-10-11 17:34:57	\N	-119	-132	-251	13	26
2141	324	1	2013-10-11 17:35:04	\N	-54	-44	-98	-10	16
2128	318	3	2013-10-11 17:35:02	\N	-73	-148	-221	75	13
2089	302	4	2013-10-11 17:34:55	\N	-120	-77	-197	-43	36
2083	300	3	2013-10-11 17:34:54	\N	-68	-69	-137	1	26
2137	322	2	2013-10-11 17:35:03	\N	-76	-97	-173	21	29
2120	314	5	2013-10-11 17:35:00	\N	-144	-36	-180	-108	22
2072	296	2	2013-10-11 17:34:52	\N	-95	-142	-237	47	26
2140	322	5	2013-10-11 17:35:03	\N	-138	-47	-185	-91	25
2117	314	2	2013-10-11 17:35:00	\N	-100	-13	-113	-87	34
2093	304	3	2013-10-11 17:34:56	\N	-145	-66	-211	-79	24
2047	286	2	2013-10-11 17:34:48	\N	-111	-122	-233	11	35
2075	296	5	2013-10-11 17:34:53	\N	-136	-27	-163	-109	31
2097	306	2	2013-10-11 17:34:56	\N	-77	-71	-148	-6	25
2109	310	4	2013-10-11 17:34:59	\N	-101	-104	-205	3	29
1999	266	3	2013-10-11 17:34:34	\N	-92	-71	-163	-21	30
2111	312	1	2013-10-11 17:34:59	\N	-144	-131	-275	-13	22
1763	172	1	2013-10-11 17:33:51	\N	-127	-138	-265	11	31
2129	318	4	2013-10-11 17:35:02	\N	-143	-40	-183	-103	30
2092	304	2	2013-10-11 17:34:55	\N	-131	-98	-229	-33	29
2139	322	4	2013-10-11 17:35:03	\N	-143	-26	-169	-117	28
2127	318	2	2013-10-11 17:35:01	\N	-113	-64	-177	-49	33
2108	310	3	2013-10-11 17:34:58	\N	-130	-61	-191	-69	33
2133	320	3	2013-10-11 17:35:02	\N	-139	-65	-204	-74	29
2112	312	2	2013-10-11 17:34:59	\N	-126	-76	-202	-50	32
2123	316	3	2013-10-11 17:35:01	\N	-73	-87	-160	14	23
2144	324	4	2013-10-11 17:35:04	\N	-100	-25	-125	-75	40
2118	314	3	2013-10-11 17:35:00	\N	-141	-146	-287	5	13
2145	324	5	2013-10-11 17:35:04	\N	-142	-20	-162	-122	28
2147	326	2	2013-10-11 17:35:05	\N	-118	-124	-242	6	33
2190	342	5	2013-10-11 17:35:16	\N	-130	-43	-173	-87	34
2051	288	1	2013-10-11 17:34:49	\N	-118	-136	-254	18	30
2121	316	1	2013-10-11 17:35:01	\N	-123	-125	-248	2	34
2146	326	1	2013-10-11 17:35:04	\N	-122	-115	-237	-7	35
2156	330	1	2013-10-11 17:35:06	\N	-142	-133	-275	-9	23
2152	328	2	2013-10-11 17:35:05	\N	-72	-95	-167	23	24
2171	336	1	2013-10-11 17:35:10	\N	-51	-61	-112	10	17
2160	330	5	2013-10-11 17:35:07	\N	-52	-3	-55	-49	20
2161	332	1	2013-10-11 17:35:08	\N	-54	-130	-184	76	14
2166	334	1	2013-10-11 17:35:09	\N	-59	-24	-83	-35	21
2162	332	2	2013-10-11 17:35:08	\N	-106	-40	-146	-66	45
2167	334	2	2013-10-11 17:35:09	\N	-121	-54	-175	-67	36
2153	328	3	2013-10-11 17:35:06	\N	-128	-81	-209	-47	38
2168	334	3	2013-10-11 17:35:09	\N	-130	-68	-198	-62	35
2176	338	1	2013-10-11 17:35:11	\N	-75	-27	-102	-48	32
2191	344	1	2013-10-11 17:35:16	\N	-62	-43	-105	-19	18
2169	334	4	2013-10-11 17:35:09	\N	-95	-51	-146	-44	43
2170	334	5	2013-10-11 17:35:09	\N	-130	-7	-137	-123	18
2158	330	3	2013-10-11 17:35:07	\N	-64	-63	-127	-1	27
2173	336	3	2013-10-11 17:35:10	\N	-87	-68	-155	-19	27
2174	336	4	2013-10-11 17:35:10	\N	-104	-147	-251	43	16
2150	326	5	2013-10-11 17:35:05	\N	-50	-45	-95	-5	19
2155	328	5	2013-10-11 17:35:06	\N	-60	-51	-111	-9	25
2175	336	5	2013-10-11 17:35:10	\N	-76	-56	-132	-20	35
2204	324	7	2013-10-11 17:39:39	\N	249	-74	175	323	0
2178	338	3	2013-10-11 17:35:14	\N	-147	-119	-266	-28	22
2192	344	2	2013-10-11 17:35:16	\N	-58	-47	-105	-11	26
2180	338	5	2013-10-11 17:35:15	\N	-90	-16	-106	-74	38
2206	332	6	2013-10-11 17:39:40	\N	-45	218	173	-263	0
2163	332	3	2013-10-11 17:35:08	\N	-83	-149	-232	66	15
2164	332	4	2013-10-11 17:35:08	\N	-101	-46	-147	-55	46
2183	340	3	2013-10-11 17:35:15	\N	-79	-147	-226	68	15
2065	292	5	2013-10-11 17:34:51	\N	-121	-78	-199	-43	29
2181	340	1	2013-10-11 17:35:15	\N	-114	-22	-136	-92	35
2186	342	1	2013-10-11 17:35:15	\N	-124	-23	-147	-101	30
2187	342	2	2013-10-11 17:35:15	\N	-50	-12	-62	-38	17
2188	342	3	2013-10-11 17:35:16	\N	-120	-142	-262	22	21
2179	338	4	2013-10-11 17:35:14	\N	-138	-50	-188	-88	28
2159	330	4	2013-10-11 17:35:07	\N	-139	-18	-157	-121	27
2149	326	4	2013-10-11 17:35:05	\N	-125	-41	-166	-84	47
2184	340	4	2013-10-11 17:35:15	\N	-118	-25	-143	-93	49
2189	342	4	2013-10-11 17:35:16	\N	-131	-42	-173	-89	40
2193	344	3	2013-10-11 17:35:16	\N	-72	-149	-221	77	13
2040	282	5	2013-10-11 17:34:47	\N	-109	-88	-197	-21	35
2165	332	5	2013-10-11 17:35:08	\N	-103	-73	-176	-30	35
2185	340	5	2013-10-11 17:35:15	\N	-113	-96	-209	-17	37
2195	344	5	2013-10-11 17:35:17	\N	-97	-97	-194	0	34
2151	328	1	2013-10-11 17:35:05	\N	-78	-87	-165	9	39
2196	346	1	2013-10-11 17:35:17	\N	-79	-106	-185	27	33
2157	330	2	2013-10-11 17:35:06	\N	-98	-105	-203	7	34
2172	336	2	2013-10-11 17:35:10	\N	-110	-101	-211	-9	35
2177	338	2	2013-10-11 17:35:12	\N	-126	-120	-246	-6	28
2182	340	2	2013-10-11 17:35:15	\N	-138	-119	-257	-19	24
2197	346	2	2013-10-11 17:35:17	\N	-108	-118	-226	10	38
2198	346	3	2013-10-11 17:35:18	\N	-51	-18	-69	-33	21
2154	328	4	2013-10-11 17:35:06	\N	-126	-127	-253	1	23
2194	344	4	2013-10-11 17:35:17	\N	-127	-104	-231	-23	32
2199	346	4	2013-10-11 17:35:18	\N	-124	-124	-248	0	25
2211	352	8	2013-10-11 17:39:40	\N	-145	48	-97	-193	0
2214	376	9	2013-10-11 17:39:41	\N	57	140	197	-83	0
2215	384	8	2013-10-11 17:39:41	\N	249	10	259	239	0
2216	388	6	2013-10-11 17:39:41	\N	103	218	321	-115	0
2217	396	9	2013-10-11 17:39:41	\N	162	166	328	-4	0
2218	400	8	2013-10-11 17:39:42	\N	219	-34	185	253	0
2219	404	9	2013-10-11 17:39:42	\N	123	13	136	110	0
2202	312	6	2013-10-11 17:39:39	\N	242	191	433	51	2
2213	372	6	2013-10-11 17:39:41	\N	221	68	289	153	1
2222	416	8	2013-10-11 17:39:42	\N	90	-96	-6	186	1
2200	304	6	2013-10-11 17:39:39	\N	-15	-3	-18	-12	3
2207	336	7	2013-10-11 17:39:40	\N	188	229	417	-41	1
2221	412	9	2013-10-11 17:39:42	\N	-123	-135	-258	12	1
2209	344	7	2013-10-11 17:39:40	\N	144	189	333	-45	1
2205	328	6	2013-10-11 17:39:40	\N	178	-79	99	257	1
2201	308	6	2013-10-11 17:39:39	\N	-96	31	-65	-127	2
2220	408	7	2013-10-11 17:39:42	\N	171	62	233	109	1
2212	360	6	2013-10-11 17:39:41	\N	204	-117	87	321	2
2203	320	6	2013-10-11 17:39:39	\N	-144	246	102	-390	2
2208	340	8	2013-10-11 17:39:40	\N	-80	-109	-189	29	2
2210	348	9	2013-10-11 17:39:40	\N	-84	20	-64	-104	3
2224	424	9	2013-10-11 17:39:42	\N	-101	144	43	-245	0
2228	448	6	2013-10-11 17:39:43	\N	-130	234	104	-364	1
2229	452	8	2013-10-11 17:39:43	\N	72	-100	-28	172	1
2232	472	8	2013-10-11 17:39:44	\N	129	110	239	19	0
2237	492	8	2013-10-11 17:39:45	\N	-14	231	217	-245	0
2239	500	8	2013-10-11 17:39:45	\N	-56	77	21	-133	0
2223	420	8	2013-10-11 17:39:42	\N	-88	-92	-180	4	2
2240	512	8	2013-10-11 17:39:46	\N	-68	-76	-144	8	1
2241	524	6	2013-10-11 17:39:46	\N	57	143	200	-86	0
2225	432	9	2013-10-11 17:39:43	\N	-125	71	-54	-196	1
2244	536	9	2013-10-11 17:39:46	\N	169	-79	90	248	0
2245	540	7	2013-10-11 17:39:47	\N	144	110	254	34	0
2246	544	8	2013-10-11 17:39:47	\N	109	174	283	-65	0
2248	556	8	2013-10-11 17:39:48	\N	34	-94	-60	128	0
2252	572	7	2013-10-11 17:39:48	\N	160	229	389	-69	1
2254	584	9	2013-10-11 17:39:48	\N	-137	-122	-259	-15	1
2255	592	8	2013-10-11 17:39:49	\N	59	81	140	-22	0
2257	600	6	2013-10-11 17:39:49	\N	87	129	216	-42	0
2260	612	7	2013-10-11 17:39:49	\N	128	-147	-19	275	0
2261	616	7	2013-10-11 17:39:50	\N	163	169	332	-6	1
2262	620	6	2013-10-11 17:39:50	\N	-100	67	-33	-167	0
2231	468	7	2013-10-11 17:39:44	\N	66	-2	64	68	1
2264	628	8	2013-10-11 17:39:50	\N	79	16	95	63	0
2265	636	9	2013-10-11 17:39:50	\N	149	-10	139	159	0
2266	640	9	2013-10-11 17:39:50	\N	-121	238	117	-359	0
2267	644	6	2013-10-11 17:39:51	\N	150	-89	61	239	1
2299	812	9	2013-10-11 17:39:56	\N	-66	6	-60	-72	2
2268	648	8	2013-10-11 17:39:51	\N	185	-107	78	292	1
2269	652	8	2013-10-11 17:39:51	\N	12	30	42	-18	0
2253	576	6	2013-10-11 17:39:48	\N	186	104	290	82	1
2274	676	9	2013-10-11 17:39:52	\N	9	30	39	-21	0
2275	692	7	2013-10-11 17:39:52	\N	26	-65	-39	91	0
2276	696	6	2013-10-11 17:39:52	\N	-92	3	-89	-95	1
2227	444	8	2013-10-11 17:39:43	\N	-101	-24	-125	-77	1
2277	700	8	2013-10-11 17:39:52	\N	-112	-53	-165	-59	1
2280	716	8	2013-10-11 17:39:53	\N	188	66	254	122	0
2281	720	6	2013-10-11 17:39:53	\N	39	-130	-91	169	0
2282	728	8	2013-10-11 17:39:53	\N	225	104	329	121	0
2283	732	6	2013-10-11 17:39:53	\N	143	92	235	51	0
2285	744	6	2013-10-11 17:39:54	\N	129	-37	92	166	0
2259	608	9	2013-10-11 17:39:49	\N	40	-77	-37	117	1
2288	764	9	2013-10-11 17:39:54	\N	83	-126	-43	209	0
2249	560	6	2013-10-11 17:39:48	\N	-89	-118	-207	29	1
2289	768	6	2013-10-11 17:39:54	\N	-62	-123	-185	61	1
2290	772	6	2013-10-11 17:39:54	\N	220	-94	126	314	1
2291	776	6	2013-10-11 17:39:55	\N	-72	110	38	-182	0
2279	712	9	2013-10-11 17:39:53	\N	212	154	366	58	1
2294	788	9	2013-10-11 17:39:55	\N	220	130	350	90	1
2295	792	8	2013-10-11 17:39:55	\N	171	241	412	-70	0
2296	796	6	2013-10-11 17:39:55	\N	-60	-22	-82	-38	0
2256	596	6	2013-10-11 17:39:49	\N	136	194	330	-58	1
2297	804	6	2013-10-11 17:39:55	\N	126	188	314	-62	1
2298	808	9	2013-10-11 17:39:56	\N	106	244	350	-138	0
2263	624	7	2013-10-11 17:39:50	\N	52	25	77	27	2
2300	816	7	2013-10-11 17:39:56	\N	27	18	45	9	1
2301	824	6	2013-10-11 17:39:56	\N	193	-4	189	197	0
2302	828	6	2013-10-11 17:39:56	\N	178	-123	55	301	1
2293	784	7	2013-10-11 17:39:55	\N	158	-50	108	208	1
2234	480	7	2013-10-11 17:39:44	\N	167	-98	69	265	1
2271	660	9	2013-10-11 17:39:51	\N	190	4	194	186	1
2243	532	9	2013-10-11 17:39:46	\N	-125	94	-31	-219	2
2230	464	8	2013-10-11 17:39:44	\N	197	-94	103	291	2
2270	656	8	2013-10-11 17:39:51	\N	-37	-60	-97	23	1
2247	552	7	2013-10-11 17:39:47	\N	-28	249	221	-277	1
2226	436	7	2013-10-11 17:39:43	\N	-49	2	-47	-51	1
2278	704	6	2013-10-11 17:39:52	\N	-125	36	-89	-161	2
2258	604	8	2013-10-11 17:39:49	\N	138	153	291	-15	1
2272	668	9	2013-10-11 17:39:51	\N	4	152	156	-148	1
2242	528	6	2013-10-11 17:39:46	\N	-114	-62	-176	-52	3
2292	780	7	2013-10-11 17:39:55	\N	83	70	153	13	1
2235	484	6	2013-10-11 17:39:45	\N	63	-38	25	101	1
2250	564	6	2013-10-11 17:39:48	\N	87	-14	73	101	1
2284	736	7	2013-10-11 17:39:53	\N	244	107	351	137	1
2238	496	8	2013-10-11 17:39:45	\N	146	54	200	92	1
2273	672	6	2013-10-11 17:39:51	\N	175	123	298	52	2
2251	568	6	2013-10-11 17:39:48	\N	188	166	354	22	2
2303	832	7	2013-10-11 17:39:56	\N	-87	99	12	-186	1
2233	476	9	2013-10-11 17:39:44	\N	-70	-106	-176	36	1
2236	488	6	2013-10-11 17:39:45	\N	-20	4	-16	-24	2
2287	756	6	2013-10-11 17:39:54	\N	7	-19	-12	26	2
2305	844	6	2013-10-11 17:39:57	\N	-14	-7	-21	-7	3
2306	848	6	2013-10-11 17:39:57	\N	70	-80	-10	150	0
2307	852	7	2013-10-11 17:39:57	\N	161	-37	124	198	1
2308	856	8	2013-10-11 17:39:58	\N	-112	91	-21	-203	0
2309	864	8	2013-10-11 17:39:58	\N	41	197	238	-156	0
2310	868	7	2013-10-11 17:39:58	\N	-148	115	-33	-263	0
2312	876	8	2013-10-11 17:39:58	\N	72	141	213	-69	0
2314	884	9	2013-10-11 17:39:59	\N	-62	-62	-124	0	0
2315	888	7	2013-10-11 17:39:59	\N	36	-106	-70	142	0
2316	892	9	2013-10-11 17:39:59	\N	58	-73	-15	131	1
2317	896	6	2013-10-11 17:39:59	\N	195	196	391	-1	1
2318	300	6	2013-10-11 17:40:24	\N	297	421	718	-124	0
2319	306	7	2013-10-11 17:40:24	\N	324	302	626	22	0
2320	309	7	2013-10-11 17:40:24	\N	112	230	342	-118	0
2322	318	9	2013-10-11 17:40:24	\N	232	524	756	-292	0
2323	321	8	2013-10-11 17:40:25	\N	452	500	952	-48	0
2324	327	7	2013-10-11 17:40:25	\N	-132	473	341	-605	0
2325	336	7	2013-10-11 17:40:25	\N	502	-118	384	620	0
2326	342	7	2013-10-11 17:40:25	\N	512	122	634	390	0
2327	345	8	2013-10-11 17:40:25	\N	225	-107	118	332	1
2328	348	8	2013-10-11 17:40:26	\N	105	504	609	-399	0
2330	354	9	2013-10-11 17:40:26	\N	-66	27	-39	-93	2
2331	357	6	2013-10-11 17:40:26	\N	30	57	87	-27	0
2332	360	8	2013-10-11 17:40:26	\N	38	424	462	-386	0
2333	363	7	2013-10-11 17:40:27	\N	229	342	571	-113	0
2335	369	6	2013-10-11 17:40:27	\N	331	459	790	-128	0
2336	372	7	2013-10-11 17:40:27	\N	135	439	574	-304	0
2337	375	6	2013-10-11 17:40:28	\N	439	34	473	405	0
2338	378	6	2013-10-11 17:40:28	\N	511	105	616	406	0
2340	387	9	2013-10-11 17:40:29	\N	531	-48	483	579	0
2341	390	8	2013-10-11 17:40:29	\N	206	164	370	42	0
2342	393	9	2013-10-11 17:40:29	\N	329	-133	196	462	0
2343	396	8	2013-10-11 17:40:29	\N	195	-63	132	258	0
2344	399	7	2013-10-11 17:40:29	\N	-24	255	231	-279	1
2345	402	7	2013-10-11 17:40:29	\N	-74	13	-61	-87	1
2346	405	7	2013-10-11 17:40:29	\N	-128	32	-96	-160	0
2347	411	7	2013-10-11 17:40:30	\N	48	243	291	-195	0
2348	414	6	2013-10-11 17:40:30	\N	214	489	703	-275	0
2349	417	9	2013-10-11 17:40:30	\N	137	-124	13	261	0
2350	420	9	2013-10-11 17:40:30	\N	358	510	868	-152	0
2351	423	7	2013-10-11 17:40:31	\N	-138	517	379	-655	0
2329	351	8	2013-10-11 17:40:26	\N	9	367	376	-358	1
2352	426	8	2013-10-11 17:40:31	\N	17	372	389	-355	1
2353	432	7	2013-10-11 17:40:31	\N	247	249	496	-2	0
2354	435	7	2013-10-11 17:40:31	\N	163	65	228	98	1
2355	438	7	2013-10-11 17:40:31	\N	-114	-97	-211	-17	0
2356	441	6	2013-10-11 17:40:31	\N	-128	269	141	-397	1
2358	447	8	2013-10-11 17:40:32	\N	-116	531	415	-647	0
2359	450	7	2013-10-11 17:40:32	\N	-141	179	38	-320	0
2360	453	7	2013-10-11 17:40:32	\N	472	-78	394	550	0
2361	456	9	2013-10-11 17:40:32	\N	71	61	132	10	0
2362	459	7	2013-10-11 17:40:32	\N	356	328	684	28	0
2363	462	6	2013-10-11 17:40:32	\N	415	346	761	69	0
2364	465	6	2013-10-11 17:40:32	\N	-130	34	-96	-164	1
2365	471	9	2013-10-11 17:40:32	\N	-68	516	448	-584	0
2366	474	8	2013-10-11 17:40:33	\N	433	375	808	58	0
2367	477	6	2013-10-11 17:40:33	\N	498	2	500	496	0
2368	480	6	2013-10-11 17:40:33	\N	98	456	554	-358	0
2339	381	8	2013-10-11 17:40:28	\N	487	326	813	161	1
2369	483	8	2013-10-11 17:40:33	\N	507	312	819	195	1
2370	486	6	2013-10-11 17:40:33	\N	-100	380	280	-480	0
2371	489	7	2013-10-11 17:40:33	\N	263	218	481	45	0
2372	492	8	2013-10-11 17:40:34	\N	490	390	880	100	0
2373	495	8	2013-10-11 17:40:34	\N	217	437	654	-220	0
2374	498	6	2013-10-11 17:40:34	\N	470	523	993	-53	0
2375	501	6	2013-10-11 17:40:34	\N	-136	356	220	-492	0
2376	504	6	2013-10-11 17:40:34	\N	254	139	393	115	0
2377	507	8	2013-10-11 17:40:34	\N	367	389	756	-22	0
2378	510	8	2013-10-11 17:40:34	\N	474	255	729	219	0
2379	513	7	2013-10-11 17:40:35	\N	335	100	435	235	0
2357	444	9	2013-10-11 17:40:31	\N	223	305	528	-82	1
2380	516	9	2013-10-11 17:40:35	\N	207	297	504	-90	1
2381	519	7	2013-10-11 17:40:35	\N	519	314	833	205	0
2382	522	8	2013-10-11 17:40:35	\N	-16	-19	-35	3	0
2334	366	8	2013-10-11 17:40:27	\N	-22	-87	-109	65	2
2304	836	8	2013-10-11 17:39:57	\N	227	66	293	161	1
2313	880	9	2013-10-11 17:39:59	\N	117	-88	29	205	1
2321	312	9	2013-10-11 17:40:24	\N	527	-99	428	626	1
2383	525	8	2013-10-11 17:40:35	\N	133	144	277	-11	1
2384	528	6	2013-10-11 17:40:35	\N	266	192	458	74	1
2385	531	7	2013-10-11 17:40:36	\N	125	342	467	-217	0
2386	534	9	2013-10-11 17:40:36	\N	246	284	530	-38	0
2387	537	7	2013-10-11 17:40:36	\N	480	129	609	351	0
2388	540	9	2013-10-11 17:40:36	\N	50	-27	23	77	0
2389	543	6	2013-10-11 17:40:36	\N	-52	330	278	-382	0
2390	546	8	2013-10-11 17:40:36	\N	349	541	890	-192	0
2391	549	8	2013-10-11 17:40:36	\N	442	301	743	141	0
2392	552	7	2013-10-11 17:40:37	\N	307	-139	168	446	0
2393	564	9	2013-10-11 17:40:37	\N	-93	99	6	-192	0
2394	567	9	2013-10-11 17:40:37	\N	-118	442	324	-560	0
2395	570	9	2013-10-11 17:40:37	\N	-11	475	464	-486	0
2396	573	8	2013-10-11 17:40:38	\N	-90	-136	-226	46	1
2397	576	6	2013-10-11 17:40:38	\N	25	362	387	-337	0
2398	582	6	2013-10-11 17:40:38	\N	167	446	613	-279	0
2399	594	6	2013-10-11 17:40:39	\N	235	187	422	48	1
2400	597	7	2013-10-11 17:40:39	\N	305	415	720	-110	0
2401	600	7	2013-10-11 17:40:39	\N	354	65	419	289	0
2402	603	9	2013-10-11 17:40:39	\N	23	159	182	-136	1
2403	606	9	2013-10-11 17:40:39	\N	408	416	824	-8	0
2286	752	6	2013-10-11 17:39:54	\N	-105	-84	-189	-21	3
2311	872	6	2013-10-11 17:39:58	\N	-112	-75	-187	-37	3
2406	615	6	2013-10-11 17:40:40	\N	-87	-64	-151	-23	3
2407	618	9	2013-10-11 17:40:40	\N	490	371	861	119	0
2408	624	8	2013-10-11 17:40:40	\N	-29	361	332	-390	0
2409	627	8	2013-10-11 17:40:40	\N	208	207	415	1	0
2410	639	8	2013-10-11 17:40:41	\N	488	489	977	-1	0
2411	642	6	2013-10-11 17:40:41	\N	174	320	494	-146	0
2412	648	6	2013-10-11 17:40:41	\N	285	-110	175	395	0
2413	651	8	2013-10-11 17:40:42	\N	1	-95	-94	96	1
2414	654	6	2013-10-11 17:40:42	\N	243	66	309	177	1
2415	657	6	2013-10-11 17:40:42	\N	424	202	626	222	0
2416	660	7	2013-10-11 17:40:42	\N	139	-96	43	235	1
2417	663	7	2013-10-11 17:40:42	\N	518	433	951	85	0
2418	666	7	2013-10-11 17:40:42	\N	271	327	598	-56	0
2419	669	9	2013-10-11 17:40:42	\N	426	-107	319	533	0
2420	672	7	2013-10-11 17:40:43	\N	445	115	560	330	0
2421	675	6	2013-10-11 17:40:43	\N	440	327	767	113	0
2422	681	8	2013-10-11 17:40:43	\N	170	538	708	-368	0
2423	687	7	2013-10-11 17:40:43	\N	254	-15	239	269	0
2424	693	8	2013-10-11 17:40:43	\N	-83	161	78	-244	0
2425	699	9	2013-10-11 17:40:44	\N	202	399	601	-197	0
2426	702	8	2013-10-11 17:40:44	\N	240	55	295	185	1
2427	705	8	2013-10-11 17:40:44	\N	380	153	533	227	0
2428	708	8	2013-10-11 17:40:44	\N	441	453	894	-12	0
2429	711	9	2013-10-11 17:40:44	\N	192	22	214	170	1
2430	714	8	2013-10-11 17:40:45	\N	475	293	768	182	0
2431	717	7	2013-10-11 17:40:45	\N	113	63	176	50	1
2432	720	7	2013-10-11 17:40:45	\N	244	284	528	-40	0
2433	723	7	2013-10-11 17:40:45	\N	330	148	478	182	0
2434	726	6	2013-10-11 17:40:45	\N	396	-104	292	500	0
2435	729	6	2013-10-11 17:40:45	\N	76	-37	39	113	2
2436	735	7	2013-10-11 17:40:46	\N	542	371	913	171	0
2437	738	7	2013-10-11 17:40:46	\N	159	461	620	-302	0
2438	741	8	2013-10-11 17:40:46	\N	314	-55	259	369	0
2405	612	8	2013-10-11 17:40:40	\N	404	-66	338	470	1
2439	747	8	2013-10-11 17:40:46	\N	404	-73	331	477	1
2440	753	7	2013-10-11 17:40:46	\N	244	110	354	134	1
2441	756	6	2013-10-11 17:40:47	\N	24	307	331	-283	0
2442	759	7	2013-10-11 17:40:47	\N	506	539	1045	-33	0
2443	762	8	2013-10-11 17:40:47	\N	134	321	455	-187	0
2444	765	9	2013-10-11 17:40:47	\N	102	-82	20	184	1
2445	771	9	2013-10-11 17:40:47	\N	-39	-31	-70	-8	0
2446	774	9	2013-10-11 17:40:47	\N	524	-103	421	627	1
2447	777	8	2013-10-11 17:40:47	\N	-134	257	123	-391	0
2448	780	8	2013-10-11 17:40:48	\N	2	189	191	-187	0
2449	783	7	2013-10-11 17:40:48	\N	-45	419	374	-464	0
2450	786	6	2013-10-11 17:40:48	\N	41	98	139	-57	0
2451	789	9	2013-10-11 17:40:48	\N	-102	6	-96	-108	1
2452	795	6	2013-10-11 17:40:48	\N	123	352	475	-229	0
2453	798	9	2013-10-11 17:40:48	\N	5	-31	-26	36	0
2454	801	9	2013-10-11 17:40:49	\N	147	41	188	106	0
2455	807	8	2013-10-11 17:40:49	\N	139	49	188	90	1
2456	810	6	2013-10-11 17:40:49	\N	331	-8	323	339	0
2457	813	6	2013-10-11 17:40:49	\N	184	147	331	37	2
2458	819	9	2013-10-11 17:40:49	\N	-105	188	83	-293	0
2459	822	9	2013-10-11 17:40:49	\N	-134	118	-16	-252	1
2460	825	7	2013-10-11 17:40:50	\N	278	550	828	-272	0
2461	828	9	2013-10-11 17:40:50	\N	-58	322	264	-380	0
2462	834	8	2013-10-11 17:40:50	\N	411	481	892	-70	0
2463	840	7	2013-10-11 17:40:50	\N	412	398	810	14	0
2464	843	6	2013-10-11 17:40:50	\N	313	198	511	115	0
2465	846	7	2013-10-11 17:40:50	\N	250	-118	132	368	0
2466	852	6	2013-10-11 17:40:51	\N	115	518	633	-403	0
2467	855	9	2013-10-11 17:40:51	\N	-128	491	363	-619	0
2404	609	9	2013-10-11 17:40:39	\N	288	221	509	67	1
2468	858	9	2013-10-11 17:40:51	\N	288	241	529	47	1
2469	861	6	2013-10-11 17:40:51	\N	235	404	639	-169	0
2470	864	8	2013-10-11 17:40:51	\N	121	353	474	-232	0
2471	870	9	2013-10-11 17:40:51	\N	394	226	620	168	0
2472	873	7	2013-10-11 17:40:52	\N	-72	88	16	-160	1
2473	876	9	2013-10-11 17:40:52	\N	-52	-129	-181	77	1
2474	879	7	2013-10-11 17:40:53	\N	213	466	679	-253	0
2475	882	8	2013-10-11 17:40:53	\N	114	455	569	-341	0
2476	885	8	2013-10-11 17:40:54	\N	19	-131	-112	150	0
2477	888	9	2013-10-11 17:40:54	\N	311	424	735	-113	0
2478	891	6	2013-10-11 17:40:55	\N	128	257	385	-129	0
2479	894	9	2013-10-11 17:40:55	\N	277	362	639	-85	0
2480	897	8	2013-10-11 17:40:56	\N	549	-20	529	569	0
\.


--
-- Data for Name: tag_post; Type: TABLE DATA; Schema: public; Owner: -
--

COPY tag_post (post_id, tag_id) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: -
--

COPY token (id, application_id, user_id, token, expire_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "user" (id, username, email, key, created_at, updated_at, role, is_active, last_login, password, avatar_name, last_name, middle_name, first_name) FROM stdin;
9	user9	user9@user.com	\N	2013-09-29 02:32:20	2013-10-29 02:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
10	user10	user10@user.com	\N	2013-09-28 01:31:20	\N	user	t	2013-11-12 01:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
11	user11	user11@user.com	\N	2013-09-27 00:30:20	2013-10-27 00:30:20	user	t	2013-11-11 00:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
12	user12	user12@user.com	\N	2013-09-25 23:29:20	2013-10-25 23:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
13	user13	user13@user.com	\N	2013-09-24 22:28:20	2013-10-24 22:28:20	user	t	2013-11-08 22:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
14	user14	user14@user.com	\N	2013-09-23 21:27:20	2013-10-23 21:27:20	user	t	2013-11-07 21:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
15	user15	user15@user.com	\N	2013-09-22 20:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
16	user16	user16@user.com	\N	2013-09-21 19:25:20	2013-10-21 19:25:20	user	t	2013-11-05 19:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
17	user17	user17@user.com	\N	2013-09-20 18:24:20	2013-10-20 18:24:20	user	t	2013-11-04 18:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
18	user18	user18@user.com	\N	2013-09-19 17:23:20	2013-10-19 17:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
19	user19	user19@user.com	\N	2013-09-18 16:22:20	2013-10-18 16:22:20	user	t	2013-11-02 16:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
20	user20	user20@user.com	\N	2013-09-17 15:21:20	\N	user	t	2013-11-01 15:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
21	user21	user21@user.com	\N	2013-09-16 14:20:20	2013-10-16 14:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
22	user22	user22@user.com	\N	2013-09-15 13:19:20	2013-10-15 13:19:20	user	t	2013-10-30 13:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
23	user23	user23@user.com	\N	2013-09-14 12:18:20	2013-10-14 12:18:20	user	t	2013-10-29 12:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
24	user24	user24@user.com	\N	2013-09-13 11:17:20	2013-10-13 11:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
25	user25	user25@user.com	\N	2013-09-12 10:16:20	\N	user	t	2013-10-27 10:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
26	user26	user26@user.com	\N	2013-09-11 09:15:20	2013-10-11 09:15:20	user	t	2013-10-26 09:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
27	user27	user27@user.com	\N	2013-09-10 08:14:20	2013-10-10 08:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
28	user28	user28@user.com	\N	2013-09-09 07:13:20	2013-10-09 07:13:20	user	t	2013-10-24 07:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
29	user29	user29@user.com	\N	2013-09-08 06:12:20	2013-10-08 06:12:20	user	t	2013-10-23 06:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
30	user30	user30@user.com	\N	2013-09-07 05:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
31	user31	user31@user.com	\N	2013-09-06 04:10:20	2013-10-06 04:10:20	user	t	2013-10-21 04:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
32	user32	user32@user.com	\N	2013-09-05 03:09:20	2013-10-05 03:09:20	user	t	2013-10-20 03:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
33	user33	user33@user.com	\N	2013-09-04 02:08:20	2013-10-04 02:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
34	user34	user34@user.com	\N	2013-09-03 01:07:20	2013-10-03 01:07:20	user	t	2013-10-18 01:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
35	user35	user35@user.com	\N	2013-09-02 00:06:20	\N	user	t	2013-10-17 00:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
36	user36	user36@user.com	\N	2013-08-31 23:05:20	2013-09-30 23:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
37	user37	user37@user.com	\N	2013-08-30 22:04:20	2013-09-29 22:04:20	user	t	2013-10-14 22:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
38	user38	user38@user.com	\N	2013-08-29 21:03:20	2013-09-28 21:03:20	user	t	2013-10-13 21:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
39	user39	user39@user.com	\N	2013-08-28 20:02:20	2013-09-27 20:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
40	user40	user40@user.com	\N	2013-08-27 19:01:20	\N	user	t	2013-10-11 19:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
41	user41	user41@user.com	\N	2013-08-26 18:00:20	2013-09-25 18:00:20	user	t	2013-10-10 18:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
42	user42	user42@user.com	\N	2013-08-25 16:59:20	2013-09-24 16:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
43	user43	user43@user.com	\N	2013-08-24 15:58:20	2013-09-23 15:58:20	user	t	2013-10-08 15:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
44	user44	user44@user.com	\N	2013-08-23 14:57:20	2013-09-22 14:57:20	user	t	2013-10-07 14:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
45	user45	user45@user.com	\N	2013-08-22 13:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
46	user46	user46@user.com	\N	2013-08-21 12:55:20	2013-09-20 12:55:20	user	t	2013-10-05 12:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
47	user47	user47@user.com	\N	2013-08-20 11:54:20	2013-09-19 11:54:20	user	t	2013-10-04 11:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
48	user48	user48@user.com	\N	2013-08-19 10:53:20	2013-09-18 10:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
49	user49	user49@user.com	\N	2013-08-18 09:52:20	2013-09-17 09:52:20	user	t	2013-10-02 09:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
50	user50	user50@user.com	\N	2013-08-17 08:51:20	\N	user	t	2013-10-01 08:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
51	user51	user51@user.com	\N	2013-08-16 07:50:20	2013-09-15 07:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
52	user52	user52@user.com	\N	2013-08-15 06:49:20	2013-09-14 06:49:20	user	t	2013-09-29 06:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
53	user53	user53@user.com	\N	2013-08-14 05:48:20	2013-09-13 05:48:20	user	t	2013-09-28 05:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
54	user54	user54@user.com	\N	2013-08-13 04:47:20	2013-09-12 04:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
55	user55	user55@user.com	\N	2013-08-12 03:46:20	\N	user	t	2013-09-26 03:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
56	user56	user56@user.com	\N	2013-08-11 02:45:20	2013-09-10 02:45:20	user	t	2013-09-25 02:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
57	user57	user57@user.com	\N	2013-08-10 01:44:20	2013-09-09 01:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
58	user58	user58@user.com	\N	2013-08-09 00:43:20	2013-09-08 00:43:20	user	t	2013-09-23 00:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
59	user59	user59@user.com	\N	2013-08-07 23:42:20	2013-09-06 23:42:20	user	t	2013-09-21 23:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
60	user60	user60@user.com	\N	2013-08-06 22:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
61	user61	user61@user.com	\N	2013-08-05 21:40:20	2013-09-04 21:40:20	user	t	2013-09-19 21:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
2	admin	admin@admin.com	\N	2013-09-16 11:47:38	2013-10-07 12:42:38	admin	t	2013-10-07 12:42:38	1341215dbe9acab4361fd6417b2b11bc	2.jpg	\N	\N	\N
3	user3	user3@user.com	\N	2013-10-05 08:38:20	2013-11-04 08:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	3.jpg	\N	\N	\N
4	user4	user4@user.com	\N	2013-10-04 07:37:20	2013-11-03 07:37:20	user	t	2013-11-18 07:37:20	87dc1e131a1369fdf8f1c824a6a62dff	4.jpg	\N	\N	\N
5	user5	user5@user.com	\N	2013-10-03 06:36:20	\N	user	t	2013-11-17 06:36:20	87dc1e131a1369fdf8f1c824a6a62dff	5.jpg	\N	\N	\N
6	user6	user6@user.com	\N	2013-10-02 05:35:20	2013-11-01 05:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	6.jpg	\N	\N	\N
7	user7	user7@user.com	\N	2013-10-01 04:34:20	2013-10-31 04:34:20	user	t	2013-11-15 04:34:20	87dc1e131a1369fdf8f1c824a6a62dff	7.jpg	\N	\N	\N
8	user8	user8@user.com	\N	2013-09-30 03:33:20	2013-10-30 03:33:20	user	t	2013-11-14 03:33:20	87dc1e131a1369fdf8f1c824a6a62dff	8.jpg	\N	\N	\N
62	user62	user62@user.com	\N	2013-08-04 20:39:20	2013-09-03 20:39:20	user	t	2013-09-18 20:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
63	user63	user63@user.com	\N	2013-08-03 19:38:20	2013-09-02 19:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
64	user64	user64@user.com	\N	2013-08-02 18:37:20	2013-09-01 18:37:20	user	t	2013-09-16 18:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
65	user65	user65@user.com	\N	2013-08-01 17:36:20	\N	user	t	2013-09-15 17:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
66	user66	user66@user.com	\N	2013-07-31 16:35:20	2013-08-30 16:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
67	user67	user67@user.com	\N	2013-07-30 15:34:20	2013-08-29 15:34:20	user	t	2013-09-13 15:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
68	user68	user68@user.com	\N	2013-07-29 14:33:20	2013-08-28 14:33:20	user	t	2013-09-12 14:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
69	user69	user69@user.com	\N	2013-07-28 13:32:20	2013-08-27 13:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
70	user70	user70@user.com	\N	2013-07-27 12:31:20	\N	user	t	2013-09-10 12:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
71	user71	user71@user.com	\N	2013-07-26 11:30:20	2013-08-25 11:30:20	user	t	2013-09-09 11:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
72	user72	user72@user.com	\N	2013-07-25 10:29:20	2013-08-24 10:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
73	user73	user73@user.com	\N	2013-07-24 09:28:20	2013-08-23 09:28:20	user	t	2013-09-07 09:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
74	user74	user74@user.com	\N	2013-07-23 08:27:20	2013-08-22 08:27:20	user	t	2013-09-06 08:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
75	user75	user75@user.com	\N	2013-07-22 07:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
76	user76	user76@user.com	\N	2013-07-21 06:25:20	2013-08-20 06:25:20	user	t	2013-09-04 06:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
77	user77	user77@user.com	\N	2013-07-20 05:24:20	2013-08-19 05:24:20	user	t	2013-09-03 05:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
78	user78	user78@user.com	\N	2013-07-19 04:23:20	2013-08-18 04:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
79	user79	user79@user.com	\N	2013-07-18 03:22:20	2013-08-17 03:22:20	user	t	2013-09-01 03:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
80	user80	user80@user.com	\N	2013-07-17 02:21:20	\N	user	t	2013-08-31 02:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
81	user81	user81@user.com	\N	2013-07-16 01:20:20	2013-08-15 01:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
82	user82	user82@user.com	\N	2013-07-15 00:19:20	2013-08-14 00:19:20	user	t	2013-08-29 00:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
83	user83	user83@user.com	\N	2013-07-13 23:18:20	2013-08-12 23:18:20	user	t	2013-08-27 23:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
84	user84	user84@user.com	\N	2013-07-12 22:17:20	2013-08-11 22:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
85	user85	user85@user.com	\N	2013-07-11 21:16:20	\N	user	t	2013-08-25 21:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
86	user86	user86@user.com	\N	2013-07-10 20:15:20	2013-08-09 20:15:20	user	t	2013-08-24 20:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
87	user87	user87@user.com	\N	2013-07-09 19:14:20	2013-08-08 19:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
88	user88	user88@user.com	\N	2013-07-08 18:13:20	2013-08-07 18:13:20	user	t	2013-08-22 18:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
89	user89	user89@user.com	\N	2013-07-07 17:12:20	2013-08-06 17:12:20	user	t	2013-08-21 17:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
90	user90	user90@user.com	\N	2013-07-06 16:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
91	user91	user91@user.com	\N	2013-07-05 15:10:20	2013-08-04 15:10:20	user	t	2013-08-19 15:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
92	user92	user92@user.com	\N	2013-07-04 14:09:20	2013-08-03 14:09:20	user	t	2013-08-18 14:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
93	user93	user93@user.com	\N	2013-07-03 13:08:20	2013-08-02 13:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
94	user94	user94@user.com	\N	2013-07-02 12:07:20	2013-08-01 12:07:20	user	t	2013-08-16 12:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
95	user95	user95@user.com	\N	2013-07-01 11:06:20	\N	user	t	2013-08-15 11:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
96	user96	user96@user.com	\N	2013-06-30 10:05:20	2013-07-30 10:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
97	user97	user97@user.com	\N	2013-06-29 09:04:20	2013-07-29 09:04:20	user	t	2013-08-13 09:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
98	user98	user98@user.com	\N	2013-06-28 08:03:20	2013-07-28 08:03:20	user	t	2013-08-12 08:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
99	user99	user99@user.com	\N	2013-06-27 07:02:20	2013-07-27 07:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
100	user100	user100@user.com	\N	2013-06-26 06:01:20	\N	user	t	2013-08-10 06:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
101	user101	user101@user.com	\N	2013-06-25 05:00:20	2013-07-25 05:00:20	user	t	2013-08-09 05:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
102	user102	user102@user.com	\N	2013-06-24 03:59:20	2013-07-24 03:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
103	user103	user103@user.com	\N	2013-06-23 02:58:20	2013-07-23 02:58:20	user	t	2013-08-07 02:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
104	user104	user104@user.com	\N	2013-06-22 01:57:20	2013-07-22 01:57:20	user	t	2013-08-06 01:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
105	user105	user105@user.com	\N	2013-06-21 00:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
106	user106	user106@user.com	\N	2013-06-19 23:55:20	2013-07-19 23:55:20	user	t	2013-08-03 23:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
107	user107	user107@user.com	\N	2013-06-18 22:54:20	2013-07-18 22:54:20	user	t	2013-08-02 22:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
108	user108	user108@user.com	\N	2013-06-17 21:53:20	2013-07-17 21:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
109	user109	user109@user.com	\N	2013-06-16 20:52:20	2013-07-16 20:52:20	user	t	2013-07-31 20:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
110	user110	user110@user.com	\N	2013-06-15 19:51:20	\N	user	t	2013-07-30 19:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
111	user111	user111@user.com	\N	2013-06-14 18:50:20	2013-07-14 18:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
112	user112	user112@user.com	\N	2013-06-13 17:49:20	2013-07-13 17:49:20	user	t	2013-07-28 17:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
113	user113	user113@user.com	\N	2013-06-12 16:48:20	2013-07-12 16:48:20	user	t	2013-07-27 16:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
114	user114	user114@user.com	\N	2013-06-11 15:47:20	2013-07-11 15:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
115	user115	user115@user.com	\N	2013-06-10 14:46:20	\N	user	t	2013-07-25 14:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
116	user116	user116@user.com	\N	2013-06-09 13:45:20	2013-07-09 13:45:20	user	t	2013-07-24 13:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
117	user117	user117@user.com	\N	2013-06-08 12:44:20	2013-07-08 12:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
118	user118	user118@user.com	\N	2013-06-07 11:43:20	2013-07-07 11:43:20	user	t	2013-07-22 11:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
119	user119	user119@user.com	\N	2013-06-06 10:42:20	2013-07-06 10:42:20	user	t	2013-07-21 10:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
120	user120	user120@user.com	\N	2013-06-05 09:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
121	user121	user121@user.com	\N	2013-06-04 08:40:20	2013-07-04 08:40:20	user	t	2013-07-19 08:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
122	user122	user122@user.com	\N	2013-06-03 07:39:20	2013-07-03 07:39:20	user	t	2013-07-18 07:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
123	user123	user123@user.com	\N	2013-06-02 06:38:20	2013-07-02 06:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
124	user124	user124@user.com	\N	2013-06-01 05:37:20	2013-07-01 05:37:20	user	t	2013-07-16 05:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
125	user125	user125@user.com	\N	2013-05-31 04:36:20	\N	user	t	2013-07-15 04:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
126	user126	user126@user.com	\N	2013-05-30 03:35:20	2013-06-29 03:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
127	user127	user127@user.com	\N	2013-05-29 02:34:20	2013-06-28 02:34:20	user	t	2013-07-13 02:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
128	user128	user128@user.com	\N	2013-05-28 01:33:20	2013-06-27 01:33:20	user	t	2013-07-12 01:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
129	user129	user129@user.com	\N	2013-05-27 00:32:20	2013-06-26 00:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
130	user130	user130@user.com	\N	2013-05-25 23:31:20	\N	user	t	2013-07-09 23:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
131	user131	user131@user.com	\N	2013-05-24 22:30:20	2013-06-23 22:30:20	user	t	2013-07-08 22:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
132	user132	user132@user.com	\N	2013-05-23 21:29:20	2013-06-22 21:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
133	user133	user133@user.com	\N	2013-05-22 20:28:20	2013-06-21 20:28:20	user	t	2013-07-06 20:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
134	user134	user134@user.com	\N	2013-05-21 19:27:20	2013-06-20 19:27:20	user	t	2013-07-05 19:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
135	user135	user135@user.com	\N	2013-05-20 18:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
136	user136	user136@user.com	\N	2013-05-19 17:25:20	2013-06-18 17:25:20	user	t	2013-07-03 17:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
137	user137	user137@user.com	\N	2013-05-18 16:24:20	2013-06-17 16:24:20	user	t	2013-07-02 16:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
138	user138	user138@user.com	\N	2013-05-17 15:23:20	2013-06-16 15:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
139	user139	user139@user.com	\N	2013-05-16 14:22:20	2013-06-15 14:22:20	user	t	2013-06-30 14:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
140	user140	user140@user.com	\N	2013-05-15 13:21:20	\N	user	t	2013-06-29 13:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
141	user141	user141@user.com	\N	2013-05-14 12:20:20	2013-06-13 12:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
142	user142	user142@user.com	\N	2013-05-13 11:19:20	2013-06-12 11:19:20	user	t	2013-06-27 11:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
143	user143	user143@user.com	\N	2013-05-12 10:18:20	2013-06-11 10:18:20	user	t	2013-06-26 10:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
144	user144	user144@user.com	\N	2013-05-11 09:17:20	2013-06-10 09:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
145	user145	user145@user.com	\N	2013-05-10 08:16:20	\N	user	t	2013-06-24 08:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
146	user146	user146@user.com	\N	2013-05-09 07:15:20	2013-06-08 07:15:20	user	t	2013-06-23 07:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
147	user147	user147@user.com	\N	2013-05-08 06:14:20	2013-06-07 06:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
148	user148	user148@user.com	\N	2013-05-07 05:13:20	2013-06-06 05:13:20	user	t	2013-06-21 05:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
149	user149	user149@user.com	\N	2013-05-06 04:12:20	2013-06-05 04:12:20	user	t	2013-06-20 04:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
150	user150	user150@user.com	\N	2013-05-05 03:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
151	user151	user151@user.com	\N	2013-05-04 02:10:20	2013-06-03 02:10:20	user	t	2013-06-18 02:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
152	user152	user152@user.com	\N	2013-05-03 01:09:20	2013-06-02 01:09:20	user	t	2013-06-17 01:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
153	user153	user153@user.com	\N	2013-05-02 00:08:20	2013-06-01 00:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
154	user154	user154@user.com	\N	2013-04-30 23:07:20	2013-05-30 23:07:20	user	t	2013-06-14 23:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
155	user155	user155@user.com	\N	2013-04-29 22:06:20	\N	user	t	2013-06-13 22:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
156	user156	user156@user.com	\N	2013-04-28 21:05:20	2013-05-28 21:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
157	user157	user157@user.com	\N	2013-04-27 20:04:20	2013-05-27 20:04:20	user	t	2013-06-11 20:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
158	user158	user158@user.com	\N	2013-04-26 19:03:20	2013-05-26 19:03:20	user	t	2013-06-10 19:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
159	user159	user159@user.com	\N	2013-04-25 18:02:20	2013-05-25 18:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
160	user160	user160@user.com	\N	2013-04-24 17:01:20	\N	user	t	2013-06-08 17:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
161	user161	user161@user.com	\N	2013-04-23 16:00:20	2013-05-23 16:00:20	user	t	2013-06-07 16:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
162	user162	user162@user.com	\N	2013-04-22 14:59:20	2013-05-22 14:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
163	user163	user163@user.com	\N	2013-04-21 13:58:20	2013-05-21 13:58:20	user	t	2013-06-05 13:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
164	user164	user164@user.com	\N	2013-04-20 12:57:20	2013-05-20 12:57:20	user	t	2013-06-04 12:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
165	user165	user165@user.com	\N	2013-04-19 11:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
166	user166	user166@user.com	\N	2013-04-18 10:55:20	2013-05-18 10:55:20	user	t	2013-06-02 10:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
167	user167	user167@user.com	\N	2013-04-17 09:54:20	2013-05-17 09:54:20	user	t	2013-06-01 09:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
168	user168	user168@user.com	\N	2013-04-16 08:53:20	2013-05-16 08:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
169	user169	user169@user.com	\N	2013-04-15 07:52:20	2013-05-15 07:52:20	user	t	2013-05-30 07:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
170	user170	user170@user.com	\N	2013-04-14 06:51:20	\N	user	t	2013-05-29 06:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
171	user171	user171@user.com	\N	2013-04-13 05:50:20	2013-05-13 05:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
172	user172	user172@user.com	\N	2013-04-12 04:49:20	2013-05-12 04:49:20	user	t	2013-05-27 04:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
173	user173	user173@user.com	\N	2013-04-11 03:48:20	2013-05-11 03:48:20	user	t	2013-05-26 03:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
174	user174	user174@user.com	\N	2013-04-10 02:47:20	2013-05-10 02:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
175	user175	user175@user.com	\N	2013-04-09 01:46:20	\N	user	t	2013-05-24 01:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
176	user176	user176@user.com	\N	2013-04-08 00:45:20	2013-05-08 00:45:20	user	t	2013-05-23 00:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
177	user177	user177@user.com	\N	2013-04-06 23:44:20	2013-05-06 23:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
178	user178	user178@user.com	\N	2013-04-05 22:43:20	2013-05-05 22:43:20	user	t	2013-05-20 22:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
179	user179	user179@user.com	\N	2013-04-04 21:42:20	2013-05-04 21:42:20	user	t	2013-05-19 21:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
180	user180	user180@user.com	\N	2013-04-03 20:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
181	user181	user181@user.com	\N	2013-04-02 19:40:20	2013-05-02 19:40:20	user	t	2013-05-17 19:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
182	user182	user182@user.com	\N	2013-04-01 18:39:20	2013-05-01 18:39:20	user	t	2013-05-16 18:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
183	user183	user183@user.com	\N	2013-03-31 17:38:20	2013-04-30 17:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
184	user184	user184@user.com	\N	2013-03-30 16:37:20	2013-04-29 16:37:20	user	t	2013-05-14 16:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
185	user185	user185@user.com	\N	2013-03-29 15:36:20	\N	user	t	2013-05-13 15:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
186	user186	user186@user.com	\N	2013-03-28 14:35:20	2013-04-27 14:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
187	user187	user187@user.com	\N	2013-03-27 13:34:20	2013-04-26 13:34:20	user	t	2013-05-11 13:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
188	user188	user188@user.com	\N	2013-03-26 12:33:20	2013-04-25 12:33:20	user	t	2013-05-10 12:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
189	user189	user189@user.com	\N	2013-03-25 11:32:20	2013-04-24 11:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
190	user190	user190@user.com	\N	2013-03-24 10:31:20	\N	user	t	2013-05-08 10:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
191	user191	user191@user.com	\N	2013-03-23 09:30:20	2013-04-22 09:30:20	user	t	2013-05-07 09:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
192	user192	user192@user.com	\N	2013-03-22 08:29:20	2013-04-21 08:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
193	user193	user193@user.com	\N	2013-03-21 07:28:20	2013-04-20 07:28:20	user	t	2013-05-05 07:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
194	user194	user194@user.com	\N	2013-03-20 06:27:20	2013-04-19 06:27:20	user	t	2013-05-04 06:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
195	user195	user195@user.com	\N	2013-03-19 05:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
196	user196	user196@user.com	\N	2013-03-18 04:25:20	2013-04-17 04:25:20	user	t	2013-05-02 04:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
197	user197	user197@user.com	\N	2013-03-17 03:24:20	2013-04-16 03:24:20	user	t	2013-05-01 03:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
198	user198	user198@user.com	\N	2013-03-16 02:23:20	2013-04-15 02:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
199	user199	user199@user.com	\N	2013-03-15 01:22:20	2013-04-14 01:22:20	user	t	2013-04-29 01:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
200	user200	user200@user.com	\N	2013-03-14 00:21:20	\N	user	t	2013-04-28 00:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
201	user201	user201@user.com	\N	2013-03-12 23:20:20	2013-04-11 23:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
202	user202	user202@user.com	\N	2013-03-11 22:19:20	2013-04-10 22:19:20	user	t	2013-04-25 22:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
203	user203	user203@user.com	\N	2013-03-10 21:18:20	2013-04-09 21:18:20	user	t	2013-04-24 21:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
204	user204	user204@user.com	\N	2013-03-09 20:17:20	2013-04-08 20:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
205	user205	user205@user.com	\N	2013-03-08 19:16:20	\N	user	t	2013-04-22 19:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
206	user206	user206@user.com	\N	2013-03-07 18:15:20	2013-04-06 18:15:20	user	t	2013-04-21 18:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
207	user207	user207@user.com	\N	2013-03-06 17:14:20	2013-04-05 17:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
208	user208	user208@user.com	\N	2013-03-05 16:13:20	2013-04-04 16:13:20	user	t	2013-04-19 16:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
209	user209	user209@user.com	\N	2013-03-04 15:12:20	2013-04-03 15:12:20	user	t	2013-04-18 15:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
210	user210	user210@user.com	\N	2013-03-03 14:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
211	user211	user211@user.com	\N	2013-03-02 13:10:20	2013-04-01 13:10:20	user	t	2013-04-16 13:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
212	user212	user212@user.com	\N	2013-03-01 12:09:20	2013-03-31 12:09:20	user	t	2013-04-15 12:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
213	user213	user213@user.com	\N	2013-02-28 11:08:20	2013-03-30 11:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
214	user214	user214@user.com	\N	2013-02-27 10:07:20	2013-03-29 10:07:20	user	t	2013-04-13 10:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
215	user215	user215@user.com	\N	2013-02-26 09:06:20	\N	user	t	2013-04-12 09:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
216	user216	user216@user.com	\N	2013-02-25 08:05:20	2013-03-27 08:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
217	user217	user217@user.com	\N	2013-02-24 07:04:20	2013-03-26 07:04:20	user	t	2013-04-10 07:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
218	user218	user218@user.com	\N	2013-02-23 06:03:20	2013-03-25 06:03:20	user	t	2013-04-09 06:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
219	user219	user219@user.com	\N	2013-02-22 05:02:20	2013-03-24 05:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
220	user220	user220@user.com	\N	2013-02-21 04:01:20	\N	user	t	2013-04-07 04:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
221	user221	user221@user.com	\N	2013-02-20 03:00:20	2013-03-22 03:00:20	user	t	2013-04-06 03:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
222	user222	user222@user.com	\N	2013-02-19 01:59:20	2013-03-21 01:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
223	user223	user223@user.com	\N	2013-02-18 00:58:20	2013-03-20 00:58:20	user	t	2013-04-04 00:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
224	user224	user224@user.com	\N	2013-02-16 23:57:20	2013-03-18 23:57:20	user	t	2013-04-02 23:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
225	user225	user225@user.com	\N	2013-02-15 22:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
226	user226	user226@user.com	\N	2013-02-14 21:55:20	2013-03-16 21:55:20	user	t	2013-03-31 21:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
227	user227	user227@user.com	\N	2013-02-13 20:54:20	2013-03-15 20:54:20	user	t	2013-03-30 20:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
228	user228	user228@user.com	\N	2013-02-12 19:53:20	2013-03-14 19:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
229	user229	user229@user.com	\N	2013-02-11 18:52:20	2013-03-13 18:52:20	user	t	2013-03-28 18:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
230	user230	user230@user.com	\N	2013-02-10 17:51:20	\N	user	t	2013-03-27 17:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
231	user231	user231@user.com	\N	2013-02-09 16:50:20	2013-03-11 16:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
232	user232	user232@user.com	\N	2013-02-08 15:49:20	2013-03-10 15:49:20	user	t	2013-03-25 15:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
233	user233	user233@user.com	\N	2013-02-07 14:48:20	2013-03-09 14:48:20	user	t	2013-03-24 14:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
234	user234	user234@user.com	\N	2013-02-06 13:47:20	2013-03-08 13:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
235	user235	user235@user.com	\N	2013-02-05 12:46:20	\N	user	t	2013-03-22 12:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
236	user236	user236@user.com	\N	2013-02-04 11:45:20	2013-03-06 11:45:20	user	t	2013-03-21 11:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
237	user237	user237@user.com	\N	2013-02-03 10:44:20	2013-03-05 10:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
238	user238	user238@user.com	\N	2013-02-02 09:43:20	2013-03-04 09:43:20	user	t	2013-03-19 09:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
239	user239	user239@user.com	\N	2013-02-01 08:42:20	2013-03-03 08:42:20	user	t	2013-03-18 08:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
240	user240	user240@user.com	\N	2013-01-31 07:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
241	user241	user241@user.com	\N	2013-01-30 06:40:20	2013-03-01 06:40:20	user	t	2013-03-16 06:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
242	user242	user242@user.com	\N	2013-01-29 05:39:20	2013-02-28 05:39:20	user	t	2013-03-15 05:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
243	user243	user243@user.com	\N	2013-01-28 04:38:20	2013-02-27 04:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
244	user244	user244@user.com	\N	2013-01-27 03:37:20	2013-02-26 03:37:20	user	t	2013-03-13 03:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
245	user245	user245@user.com	\N	2013-01-26 02:36:20	\N	user	t	2013-03-12 02:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
246	user246	user246@user.com	\N	2013-01-25 01:35:20	2013-02-24 01:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
247	user247	user247@user.com	\N	2013-01-24 00:34:20	2013-02-23 00:34:20	user	t	2013-03-10 00:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
248	user248	user248@user.com	\N	2013-01-22 23:33:20	2013-02-21 23:33:20	user	t	2013-03-08 23:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
249	user249	user249@user.com	\N	2013-01-21 22:32:20	2013-02-20 22:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
250	user250	user250@user.com	\N	2013-01-20 21:31:20	\N	user	t	2013-03-06 21:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
251	user251	user251@user.com	\N	2013-01-19 20:30:20	2013-02-18 20:30:20	user	t	2013-03-05 20:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
252	user252	user252@user.com	\N	2013-01-18 19:29:20	2013-02-17 19:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
253	user253	user253@user.com	\N	2013-01-17 18:28:20	2013-02-16 18:28:20	user	t	2013-03-03 18:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
254	user254	user254@user.com	\N	2013-01-16 17:27:20	2013-02-15 17:27:20	user	t	2013-03-02 17:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
255	user255	user255@user.com	\N	2013-01-15 16:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
256	user256	user256@user.com	\N	2013-01-14 15:25:20	2013-02-13 15:25:20	user	t	2013-02-28 15:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
257	user257	user257@user.com	\N	2013-01-13 14:24:20	2013-02-12 14:24:20	user	t	2013-02-27 14:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
258	user258	user258@user.com	\N	2013-01-12 13:23:20	2013-02-11 13:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
259	user259	user259@user.com	\N	2013-01-11 12:22:20	2013-02-10 12:22:20	user	t	2013-02-25 12:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
260	user260	user260@user.com	\N	2013-01-10 11:21:20	\N	user	t	2013-02-24 11:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
261	user261	user261@user.com	\N	2013-01-09 10:20:20	2013-02-08 10:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
262	user262	user262@user.com	\N	2013-01-08 09:19:20	2013-02-07 09:19:20	user	t	2013-02-22 09:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
263	user263	user263@user.com	\N	2013-01-07 08:18:20	2013-02-06 08:18:20	user	t	2013-02-21 08:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
264	user264	user264@user.com	\N	2013-01-06 07:17:20	2013-02-05 07:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
265	user265	user265@user.com	\N	2013-01-05 06:16:20	\N	user	t	2013-02-19 06:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
266	user266	user266@user.com	\N	2013-01-04 05:15:20	2013-02-03 05:15:20	user	t	2013-02-18 05:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
267	user267	user267@user.com	\N	2013-01-03 04:14:20	2013-02-02 04:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
268	user268	user268@user.com	\N	2013-01-02 03:13:20	2013-02-01 03:13:20	user	t	2013-02-16 03:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
269	user269	user269@user.com	\N	2013-01-01 02:12:20	2013-01-31 02:12:20	user	t	2013-02-15 02:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
270	user270	user270@user.com	\N	2012-12-31 01:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
271	user271	user271@user.com	\N	2012-12-30 00:10:20	2013-01-29 00:10:20	user	t	2013-02-13 00:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
272	user272	user272@user.com	\N	2012-12-28 23:09:20	2013-01-27 23:09:20	user	t	2013-02-11 23:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
273	user273	user273@user.com	\N	2012-12-27 22:08:20	2013-01-26 22:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
274	user274	user274@user.com	\N	2012-12-26 21:07:20	2013-01-25 21:07:20	user	t	2013-02-09 21:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
275	user275	user275@user.com	\N	2012-12-25 20:06:20	\N	user	t	2013-02-08 20:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
276	user276	user276@user.com	\N	2012-12-24 19:05:20	2013-01-23 19:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
277	user277	user277@user.com	\N	2012-12-23 18:04:20	2013-01-22 18:04:20	user	t	2013-02-06 18:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
278	user278	user278@user.com	\N	2012-12-22 17:03:20	2013-01-21 17:03:20	user	t	2013-02-05 17:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
279	user279	user279@user.com	\N	2012-12-21 16:02:20	2013-01-20 16:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
280	user280	user280@user.com	\N	2012-12-20 15:01:20	\N	user	t	2013-02-03 15:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
281	user281	user281@user.com	\N	2012-12-19 14:00:20	2013-01-18 14:00:20	user	t	2013-02-02 14:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
282	user282	user282@user.com	\N	2012-12-18 12:59:20	2013-01-17 12:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
283	user283	user283@user.com	\N	2012-12-17 11:58:20	2013-01-16 11:58:20	user	t	2013-01-31 11:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
284	user284	user284@user.com	\N	2012-12-16 10:57:20	2013-01-15 10:57:20	user	t	2013-01-30 10:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
285	user285	user285@user.com	\N	2012-12-15 09:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
286	user286	user286@user.com	\N	2012-12-14 08:55:20	2013-01-13 08:55:20	user	t	2013-01-28 08:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
287	user287	user287@user.com	\N	2012-12-13 07:54:20	2013-01-12 07:54:20	user	t	2013-01-27 07:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
288	user288	user288@user.com	\N	2012-12-12 06:53:20	2013-01-11 06:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
289	user289	user289@user.com	\N	2012-12-11 05:52:20	2013-01-10 05:52:20	user	t	2013-01-25 05:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
290	user290	user290@user.com	\N	2012-12-10 04:51:20	\N	user	t	2013-01-24 04:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
291	user291	user291@user.com	\N	2012-12-09 03:50:20	2013-01-08 03:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
292	user292	user292@user.com	\N	2012-12-08 02:49:20	2013-01-07 02:49:20	user	t	2013-01-22 02:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
293	user293	user293@user.com	\N	2012-12-07 01:48:20	2013-01-06 01:48:20	user	t	2013-01-21 01:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
294	user294	user294@user.com	\N	2012-12-06 00:47:20	2013-01-05 00:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
295	user295	user295@user.com	\N	2012-12-04 23:46:20	\N	user	t	2013-01-18 23:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
296	user296	user296@user.com	\N	2012-12-03 22:45:20	2013-01-02 22:45:20	user	t	2013-01-17 22:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
297	user297	user297@user.com	\N	2012-12-02 21:44:20	2013-01-01 21:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
298	user298	user298@user.com	\N	2012-12-01 20:43:20	2012-12-31 20:43:20	user	t	2013-01-15 20:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
299	user299	user299@user.com	\N	2012-11-30 19:42:20	2012-12-30 19:42:20	user	t	2013-01-14 19:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
300	user300	user300@user.com	\N	2012-11-29 18:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
301	user301	user301@user.com	\N	2012-11-28 17:40:20	2012-12-28 17:40:20	user	t	2013-01-12 17:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
302	user302	user302@user.com	\N	2012-11-27 16:39:20	2012-12-27 16:39:20	user	t	2013-01-11 16:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
303	user303	user303@user.com	\N	2012-11-26 15:38:20	2012-12-26 15:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
304	user304	user304@user.com	\N	2012-11-25 14:37:20	2012-12-25 14:37:20	user	t	2013-01-09 14:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
305	user305	user305@user.com	\N	2012-11-24 13:36:20	\N	user	t	2013-01-08 13:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
306	user306	user306@user.com	\N	2012-11-23 12:35:20	2012-12-23 12:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
307	user307	user307@user.com	\N	2012-11-22 11:34:20	2012-12-22 11:34:20	user	t	2013-01-06 11:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
308	user308	user308@user.com	\N	2012-11-21 10:33:20	2012-12-21 10:33:20	user	t	2013-01-05 10:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
309	user309	user309@user.com	\N	2012-11-20 09:32:20	2012-12-20 09:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
310	user310	user310@user.com	\N	2012-11-19 08:31:20	\N	user	t	2013-01-03 08:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
311	user311	user311@user.com	\N	2012-11-18 07:30:20	2012-12-18 07:30:20	user	t	2013-01-02 07:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
312	user312	user312@user.com	\N	2012-11-17 06:29:20	2012-12-17 06:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
313	user313	user313@user.com	\N	2012-11-16 05:28:20	2012-12-16 05:28:20	user	t	2012-12-31 05:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
314	user314	user314@user.com	\N	2012-11-15 04:27:20	2012-12-15 04:27:20	user	t	2012-12-30 04:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
315	user315	user315@user.com	\N	2012-11-14 03:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
316	user316	user316@user.com	\N	2012-11-13 02:25:20	2012-12-13 02:25:20	user	t	2012-12-28 02:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
317	user317	user317@user.com	\N	2012-11-12 01:24:20	2012-12-12 01:24:20	user	t	2012-12-27 01:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
318	user318	user318@user.com	\N	2012-11-11 00:23:20	2012-12-11 00:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
319	user319	user319@user.com	\N	2012-11-09 23:22:20	2012-12-09 23:22:20	user	t	2012-12-24 23:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
320	user320	user320@user.com	\N	2012-11-08 22:21:20	\N	user	t	2012-12-23 22:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
321	user321	user321@user.com	\N	2012-11-07 21:20:20	2012-12-07 21:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
322	user322	user322@user.com	\N	2012-11-06 20:19:20	2012-12-06 20:19:20	user	t	2012-12-21 20:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
323	user323	user323@user.com	\N	2012-11-05 19:18:20	2012-12-05 19:18:20	user	t	2012-12-20 19:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
324	user324	user324@user.com	\N	2012-11-04 18:17:20	2012-12-04 18:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
325	user325	user325@user.com	\N	2012-11-03 17:16:20	\N	user	t	2012-12-18 17:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
326	user326	user326@user.com	\N	2012-11-02 16:15:20	2012-12-02 16:15:20	user	t	2012-12-17 16:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
327	user327	user327@user.com	\N	2012-11-01 15:14:20	2012-12-01 15:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
328	user328	user328@user.com	\N	2012-10-31 14:13:20	2012-11-30 14:13:20	user	t	2012-12-15 14:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
329	user329	user329@user.com	\N	2012-10-30 13:12:20	2012-11-29 13:12:20	user	t	2012-12-14 13:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
330	user330	user330@user.com	\N	2012-10-29 12:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
331	user331	user331@user.com	\N	2012-10-28 11:10:20	2012-11-27 11:10:20	user	t	2012-12-12 11:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
332	user332	user332@user.com	\N	2012-10-27 10:09:20	2012-11-26 10:09:20	user	t	2012-12-11 10:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
333	user333	user333@user.com	\N	2012-10-26 09:08:20	2012-11-25 09:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
334	user334	user334@user.com	\N	2012-10-25 08:07:20	2012-11-24 08:07:20	user	t	2012-12-09 08:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
335	user335	user335@user.com	\N	2012-10-24 07:06:20	\N	user	t	2012-12-08 07:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
336	user336	user336@user.com	\N	2012-10-23 06:05:20	2012-11-22 06:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
337	user337	user337@user.com	\N	2012-10-22 05:04:20	2012-11-21 05:04:20	user	t	2012-12-06 05:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
338	user338	user338@user.com	\N	2012-10-21 04:03:20	2012-11-20 04:03:20	user	t	2012-12-05 04:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
339	user339	user339@user.com	\N	2012-10-20 03:02:20	2012-11-19 03:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
340	user340	user340@user.com	\N	2012-10-19 02:01:20	\N	user	t	2012-12-03 02:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
341	user341	user341@user.com	\N	2012-10-18 01:00:20	2012-11-17 01:00:20	user	t	2012-12-02 01:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
342	user342	user342@user.com	\N	2012-10-16 23:59:20	2012-11-15 23:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
343	user343	user343@user.com	\N	2012-10-15 22:58:20	2012-11-14 22:58:20	user	t	2012-11-29 22:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
344	user344	user344@user.com	\N	2012-10-14 21:57:20	2012-11-13 21:57:20	user	t	2012-11-28 21:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
345	user345	user345@user.com	\N	2012-10-13 20:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
346	user346	user346@user.com	\N	2012-10-12 19:55:20	2012-11-11 19:55:20	user	t	2012-11-26 19:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
347	user347	user347@user.com	\N	2012-10-11 18:54:20	2012-11-10 18:54:20	user	t	2012-11-25 18:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
348	user348	user348@user.com	\N	2012-10-10 17:53:20	2012-11-09 17:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
349	user349	user349@user.com	\N	2012-10-09 16:52:20	2012-11-08 16:52:20	user	t	2012-11-23 16:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
350	user350	user350@user.com	\N	2012-10-08 15:51:20	\N	user	t	2012-11-22 15:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
351	user351	user351@user.com	\N	2012-10-07 14:50:20	2012-11-06 14:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
352	user352	user352@user.com	\N	2012-10-06 13:49:20	2012-11-05 13:49:20	user	t	2012-11-20 13:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
353	user353	user353@user.com	\N	2012-10-05 12:48:20	2012-11-04 12:48:20	user	t	2012-11-19 12:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
354	user354	user354@user.com	\N	2012-10-04 11:47:20	2012-11-03 11:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
355	user355	user355@user.com	\N	2012-10-03 10:46:20	\N	user	t	2012-11-17 10:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
356	user356	user356@user.com	\N	2012-10-02 09:45:20	2012-11-01 09:45:20	user	t	2012-11-16 09:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
357	user357	user357@user.com	\N	2012-10-01 08:44:20	2012-10-31 08:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
358	user358	user358@user.com	\N	2012-09-30 07:43:20	2012-10-30 07:43:20	user	t	2012-11-14 07:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
359	user359	user359@user.com	\N	2012-09-29 06:42:20	2012-10-29 06:42:20	user	t	2012-11-13 06:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
360	user360	user360@user.com	\N	2012-09-28 05:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
361	user361	user361@user.com	\N	2012-09-27 04:40:20	2012-10-27 04:40:20	user	t	2012-11-11 04:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
362	user362	user362@user.com	\N	2012-09-26 03:39:20	2012-10-26 03:39:20	user	t	2012-11-10 03:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
363	user363	user363@user.com	\N	2012-09-25 02:38:20	2012-10-25 02:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
364	user364	user364@user.com	\N	2012-09-24 01:37:20	2012-10-24 01:37:20	user	t	2012-11-08 01:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
365	user365	user365@user.com	\N	2012-09-23 00:36:20	\N	user	t	2012-11-07 00:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
366	user366	user366@user.com	\N	2012-09-21 23:35:20	2012-10-21 23:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
367	user367	user367@user.com	\N	2012-09-20 22:34:20	2012-10-20 22:34:20	user	t	2012-11-04 22:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
368	user368	user368@user.com	\N	2012-09-19 21:33:20	2012-10-19 21:33:20	user	t	2012-11-03 21:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
369	user369	user369@user.com	\N	2012-09-18 20:32:20	2012-10-18 20:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
370	user370	user370@user.com	\N	2012-09-17 19:31:20	\N	user	t	2012-11-01 19:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
371	user371	user371@user.com	\N	2012-09-16 18:30:20	2012-10-16 18:30:20	user	t	2012-10-31 18:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
372	user372	user372@user.com	\N	2012-09-15 17:29:20	2012-10-15 17:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
373	user373	user373@user.com	\N	2012-09-14 16:28:20	2012-10-14 16:28:20	user	t	2012-10-29 16:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
374	user374	user374@user.com	\N	2012-09-13 15:27:20	2012-10-13 15:27:20	user	t	2012-10-28 15:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
375	user375	user375@user.com	\N	2012-09-12 14:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
376	user376	user376@user.com	\N	2012-09-11 13:25:20	2012-10-11 13:25:20	user	t	2012-10-26 13:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
377	user377	user377@user.com	\N	2012-09-10 12:24:20	2012-10-10 12:24:20	user	t	2012-10-25 12:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
378	user378	user378@user.com	\N	2012-09-09 11:23:20	2012-10-09 11:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
379	user379	user379@user.com	\N	2012-09-08 10:22:20	2012-10-08 10:22:20	user	t	2012-10-23 10:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
380	user380	user380@user.com	\N	2012-09-07 09:21:20	\N	user	t	2012-10-22 09:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
381	user381	user381@user.com	\N	2012-09-06 08:20:20	2012-10-06 08:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
382	user382	user382@user.com	\N	2012-09-05 07:19:20	2012-10-05 07:19:20	user	t	2012-10-20 07:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
383	user383	user383@user.com	\N	2012-09-04 06:18:20	2012-10-04 06:18:20	user	t	2012-10-19 06:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
384	user384	user384@user.com	\N	2012-09-03 05:17:20	2012-10-03 05:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
385	user385	user385@user.com	\N	2012-09-02 04:16:20	\N	user	t	2012-10-17 04:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
386	user386	user386@user.com	\N	2012-09-01 03:15:20	2012-10-01 03:15:20	user	t	2012-10-16 03:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
387	user387	user387@user.com	\N	2012-08-31 02:14:20	2012-09-30 02:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
388	user388	user388@user.com	\N	2012-08-30 01:13:20	2012-09-29 01:13:20	user	t	2012-10-14 01:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
389	user389	user389@user.com	\N	2012-08-29 00:12:20	2012-09-28 00:12:20	user	t	2012-10-13 00:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
390	user390	user390@user.com	\N	2012-08-27 23:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
391	user391	user391@user.com	\N	2012-08-26 22:10:20	2012-09-25 22:10:20	user	t	2012-10-10 22:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
392	user392	user392@user.com	\N	2012-08-25 21:09:20	2012-09-24 21:09:20	user	t	2012-10-09 21:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
393	user393	user393@user.com	\N	2012-08-24 20:08:20	2012-09-23 20:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
394	user394	user394@user.com	\N	2012-08-23 19:07:20	2012-09-22 19:07:20	user	t	2012-10-07 19:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
395	user395	user395@user.com	\N	2012-08-22 18:06:20	\N	user	t	2012-10-06 18:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
396	user396	user396@user.com	\N	2012-08-21 17:05:20	2012-09-20 17:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
397	user397	user397@user.com	\N	2012-08-20 16:04:20	2012-09-19 16:04:20	user	t	2012-10-04 16:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
398	user398	user398@user.com	\N	2012-08-19 15:03:20	2012-09-18 15:03:20	user	t	2012-10-03 15:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
399	user399	user399@user.com	\N	2012-08-18 14:02:20	2012-09-17 14:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
400	user400	user400@user.com	\N	2012-08-17 13:01:20	\N	user	t	2012-10-01 13:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
401	user401	user401@user.com	\N	2012-08-16 12:00:20	2012-09-15 12:00:20	user	t	2012-09-30 12:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
402	user402	user402@user.com	\N	2012-08-15 10:59:20	2012-09-14 10:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
403	user403	user403@user.com	\N	2012-08-14 09:58:20	2012-09-13 09:58:20	user	t	2012-09-28 09:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
404	user404	user404@user.com	\N	2012-08-13 08:57:20	2012-09-12 08:57:20	user	t	2012-09-27 08:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
405	user405	user405@user.com	\N	2012-08-12 07:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
406	user406	user406@user.com	\N	2012-08-11 06:55:20	2012-09-10 06:55:20	user	t	2012-09-25 06:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
407	user407	user407@user.com	\N	2012-08-10 05:54:20	2012-09-09 05:54:20	user	t	2012-09-24 05:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
408	user408	user408@user.com	\N	2012-08-09 04:53:20	2012-09-08 04:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
409	user409	user409@user.com	\N	2012-08-08 03:52:20	2012-09-07 03:52:20	user	t	2012-09-22 03:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
410	user410	user410@user.com	\N	2012-08-07 02:51:20	\N	user	t	2012-09-21 02:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
411	user411	user411@user.com	\N	2012-08-06 01:50:20	2012-09-05 01:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
412	user412	user412@user.com	\N	2012-08-05 00:49:20	2012-09-04 00:49:20	user	t	2012-09-19 00:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
413	user413	user413@user.com	\N	2012-08-03 23:48:20	2012-09-02 23:48:20	user	t	2012-09-17 23:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
414	user414	user414@user.com	\N	2012-08-02 22:47:20	2012-09-01 22:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
415	user415	user415@user.com	\N	2012-08-01 21:46:20	\N	user	t	2012-09-15 21:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
416	user416	user416@user.com	\N	2012-07-31 20:45:20	2012-08-30 20:45:20	user	t	2012-09-14 20:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
417	user417	user417@user.com	\N	2012-07-30 19:44:20	2012-08-29 19:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
418	user418	user418@user.com	\N	2012-07-29 18:43:20	2012-08-28 18:43:20	user	t	2012-09-12 18:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
419	user419	user419@user.com	\N	2012-07-28 17:42:20	2012-08-27 17:42:20	user	t	2012-09-11 17:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
420	user420	user420@user.com	\N	2012-07-27 16:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
421	user421	user421@user.com	\N	2012-07-26 15:40:20	2012-08-25 15:40:20	user	t	2012-09-09 15:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
422	user422	user422@user.com	\N	2012-07-25 14:39:20	2012-08-24 14:39:20	user	t	2012-09-08 14:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
423	user423	user423@user.com	\N	2012-07-24 13:38:20	2012-08-23 13:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
424	user424	user424@user.com	\N	2012-07-23 12:37:20	2012-08-22 12:37:20	user	t	2012-09-06 12:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
425	user425	user425@user.com	\N	2012-07-22 11:36:20	\N	user	t	2012-09-05 11:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
426	user426	user426@user.com	\N	2012-07-21 10:35:20	2012-08-20 10:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
427	user427	user427@user.com	\N	2012-07-20 09:34:20	2012-08-19 09:34:20	user	t	2012-09-03 09:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
428	user428	user428@user.com	\N	2012-07-19 08:33:20	2012-08-18 08:33:20	user	t	2012-09-02 08:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
429	user429	user429@user.com	\N	2012-07-18 07:32:20	2012-08-17 07:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
430	user430	user430@user.com	\N	2012-07-17 06:31:20	\N	user	t	2012-08-31 06:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
431	user431	user431@user.com	\N	2012-07-16 05:30:20	2012-08-15 05:30:20	user	t	2012-08-30 05:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
432	user432	user432@user.com	\N	2012-07-15 04:29:20	2012-08-14 04:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
433	user433	user433@user.com	\N	2012-07-14 03:28:20	2012-08-13 03:28:20	user	t	2012-08-28 03:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
434	user434	user434@user.com	\N	2012-07-13 02:27:20	2012-08-12 02:27:20	user	t	2012-08-27 02:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
435	user435	user435@user.com	\N	2012-07-12 01:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
436	user436	user436@user.com	\N	2012-07-11 00:25:20	2012-08-10 00:25:20	user	t	2012-08-25 00:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
437	user437	user437@user.com	\N	2012-07-09 23:24:20	2012-08-08 23:24:20	user	t	2012-08-23 23:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
438	user438	user438@user.com	\N	2012-07-08 22:23:20	2012-08-07 22:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
439	user439	user439@user.com	\N	2012-07-07 21:22:20	2012-08-06 21:22:20	user	t	2012-08-21 21:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
440	user440	user440@user.com	\N	2012-07-06 20:21:20	\N	user	t	2012-08-20 20:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
441	user441	user441@user.com	\N	2012-07-05 19:20:20	2012-08-04 19:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
442	user442	user442@user.com	\N	2012-07-04 18:19:20	2012-08-03 18:19:20	user	t	2012-08-18 18:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
443	user443	user443@user.com	\N	2012-07-03 17:18:20	2012-08-02 17:18:20	user	t	2012-08-17 17:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
444	user444	user444@user.com	\N	2012-07-02 16:17:20	2012-08-01 16:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
445	user445	user445@user.com	\N	2012-07-01 15:16:20	\N	user	t	2012-08-15 15:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
446	user446	user446@user.com	\N	2012-06-30 14:15:20	2012-07-30 14:15:20	user	t	2012-08-14 14:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
447	user447	user447@user.com	\N	2012-06-29 13:14:20	2012-07-29 13:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
448	user448	user448@user.com	\N	2012-06-28 12:13:20	2012-07-28 12:13:20	user	t	2012-08-12 12:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
449	user449	user449@user.com	\N	2012-06-27 11:12:20	2012-07-27 11:12:20	user	t	2012-08-11 11:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
450	user450	user450@user.com	\N	2012-06-26 10:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
451	user451	user451@user.com	\N	2012-06-25 09:10:20	2012-07-25 09:10:20	user	t	2012-08-09 09:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
452	user452	user452@user.com	\N	2012-06-24 08:09:20	2012-07-24 08:09:20	user	t	2012-08-08 08:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
453	user453	user453@user.com	\N	2012-06-23 07:08:20	2012-07-23 07:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
454	user454	user454@user.com	\N	2012-06-22 06:07:20	2012-07-22 06:07:20	user	t	2012-08-06 06:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
455	user455	user455@user.com	\N	2012-06-21 05:06:20	\N	user	t	2012-08-05 05:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
456	user456	user456@user.com	\N	2012-06-20 04:05:20	2012-07-20 04:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
457	user457	user457@user.com	\N	2012-06-19 03:04:20	2012-07-19 03:04:20	user	t	2012-08-03 03:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
458	user458	user458@user.com	\N	2012-06-18 02:03:20	2012-07-18 02:03:20	user	t	2012-08-02 02:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
459	user459	user459@user.com	\N	2012-06-17 01:02:20	2012-07-17 01:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
460	user460	user460@user.com	\N	2012-06-16 00:01:20	\N	user	t	2012-07-31 00:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
461	user461	user461@user.com	\N	2012-06-14 23:00:20	2012-07-14 23:00:20	user	t	2012-07-29 23:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
462	user462	user462@user.com	\N	2012-06-13 21:59:20	2012-07-13 21:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
463	user463	user463@user.com	\N	2012-06-12 20:58:20	2012-07-12 20:58:20	user	t	2012-07-27 20:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
464	user464	user464@user.com	\N	2012-06-11 19:57:20	2012-07-11 19:57:20	user	t	2012-07-26 19:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
465	user465	user465@user.com	\N	2012-06-10 18:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
466	user466	user466@user.com	\N	2012-06-09 17:55:20	2012-07-09 17:55:20	user	t	2012-07-24 17:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
467	user467	user467@user.com	\N	2012-06-08 16:54:20	2012-07-08 16:54:20	user	t	2012-07-23 16:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
468	user468	user468@user.com	\N	2012-06-07 15:53:20	2012-07-07 15:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
469	user469	user469@user.com	\N	2012-06-06 14:52:20	2012-07-06 14:52:20	user	t	2012-07-21 14:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
470	user470	user470@user.com	\N	2012-06-05 13:51:20	\N	user	t	2012-07-20 13:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
471	user471	user471@user.com	\N	2012-06-04 12:50:20	2012-07-04 12:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
472	user472	user472@user.com	\N	2012-06-03 11:49:20	2012-07-03 11:49:20	user	t	2012-07-18 11:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
473	user473	user473@user.com	\N	2012-06-02 10:48:20	2012-07-02 10:48:20	user	t	2012-07-17 10:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
474	user474	user474@user.com	\N	2012-06-01 09:47:20	2012-07-01 09:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
475	user475	user475@user.com	\N	2012-05-31 08:46:20	\N	user	t	2012-07-15 08:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
476	user476	user476@user.com	\N	2012-05-30 07:45:20	2012-06-29 07:45:20	user	t	2012-07-14 07:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
477	user477	user477@user.com	\N	2012-05-29 06:44:20	2012-06-28 06:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
478	user478	user478@user.com	\N	2012-05-28 05:43:20	2012-06-27 05:43:20	user	t	2012-07-12 05:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
479	user479	user479@user.com	\N	2012-05-27 04:42:20	2012-06-26 04:42:20	user	t	2012-07-11 04:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
480	user480	user480@user.com	\N	2012-05-26 03:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
481	user481	user481@user.com	\N	2012-05-25 02:40:20	2012-06-24 02:40:20	user	t	2012-07-09 02:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
482	user482	user482@user.com	\N	2012-05-24 01:39:20	2012-06-23 01:39:20	user	t	2012-07-08 01:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
483	user483	user483@user.com	\N	2012-05-23 00:38:20	2012-06-22 00:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
484	user484	user484@user.com	\N	2012-05-21 23:37:20	2012-06-20 23:37:20	user	t	2012-07-05 23:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
485	user485	user485@user.com	\N	2012-05-20 22:36:20	\N	user	t	2012-07-04 22:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
486	user486	user486@user.com	\N	2012-05-19 21:35:20	2012-06-18 21:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
487	user487	user487@user.com	\N	2012-05-18 20:34:20	2012-06-17 20:34:20	user	t	2012-07-02 20:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
488	user488	user488@user.com	\N	2012-05-17 19:33:20	2012-06-16 19:33:20	user	t	2012-07-01 19:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
489	user489	user489@user.com	\N	2012-05-16 18:32:20	2012-06-15 18:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
490	user490	user490@user.com	\N	2012-05-15 17:31:20	\N	user	t	2012-06-29 17:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
491	user491	user491@user.com	\N	2012-05-14 16:30:20	2012-06-13 16:30:20	user	t	2012-06-28 16:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
492	user492	user492@user.com	\N	2012-05-13 15:29:20	2012-06-12 15:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
493	user493	user493@user.com	\N	2012-05-12 14:28:20	2012-06-11 14:28:20	user	t	2012-06-26 14:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
494	user494	user494@user.com	\N	2012-05-11 13:27:20	2012-06-10 13:27:20	user	t	2012-06-25 13:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
495	user495	user495@user.com	\N	2012-05-10 12:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
496	user496	user496@user.com	\N	2012-05-09 11:25:20	2012-06-08 11:25:20	user	t	2012-06-23 11:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
497	user497	user497@user.com	\N	2012-05-08 10:24:20	2012-06-07 10:24:20	user	t	2012-06-22 10:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
498	user498	user498@user.com	\N	2012-05-07 09:23:20	2012-06-06 09:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
499	user499	user499@user.com	\N	2012-05-06 08:22:20	2012-06-05 08:22:20	user	t	2012-06-20 08:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
500	user500	user500@user.com	\N	2012-05-05 07:21:20	\N	user	t	2012-06-19 07:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
501	user501	user501@user.com	\N	2012-05-04 06:20:20	2012-06-03 06:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
502	user502	user502@user.com	\N	2012-05-03 05:19:20	2012-06-02 05:19:20	user	t	2012-06-17 05:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
503	user503	user503@user.com	\N	2012-05-02 04:18:20	2012-06-01 04:18:20	user	t	2012-06-16 04:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
504	user504	user504@user.com	\N	2012-05-01 03:17:20	2012-05-31 03:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
505	user505	user505@user.com	\N	2012-04-30 02:16:20	\N	user	t	2012-06-14 02:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
506	user506	user506@user.com	\N	2012-04-29 01:15:20	2012-05-29 01:15:20	user	t	2012-06-13 01:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
507	user507	user507@user.com	\N	2012-04-28 00:14:20	2012-05-28 00:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
508	user508	user508@user.com	\N	2012-04-26 23:13:20	2012-05-26 23:13:20	user	t	2012-06-10 23:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
509	user509	user509@user.com	\N	2012-04-25 22:12:20	2012-05-25 22:12:20	user	t	2012-06-09 22:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
510	user510	user510@user.com	\N	2012-04-24 21:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
511	user511	user511@user.com	\N	2012-04-23 20:10:20	2012-05-23 20:10:20	user	t	2012-06-07 20:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
512	user512	user512@user.com	\N	2012-04-22 19:09:20	2012-05-22 19:09:20	user	t	2012-06-06 19:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
513	user513	user513@user.com	\N	2012-04-21 18:08:20	2012-05-21 18:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
514	user514	user514@user.com	\N	2012-04-20 17:07:20	2012-05-20 17:07:20	user	t	2012-06-04 17:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
515	user515	user515@user.com	\N	2012-04-19 16:06:20	\N	user	t	2012-06-03 16:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
516	user516	user516@user.com	\N	2012-04-18 15:05:20	2012-05-18 15:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
517	user517	user517@user.com	\N	2012-04-17 14:04:20	2012-05-17 14:04:20	user	t	2012-06-01 14:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
518	user518	user518@user.com	\N	2012-04-16 13:03:20	2012-05-16 13:03:20	user	t	2012-05-31 13:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
519	user519	user519@user.com	\N	2012-04-15 12:02:20	2012-05-15 12:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
520	user520	user520@user.com	\N	2012-04-14 11:01:20	\N	user	t	2012-05-29 11:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
521	user521	user521@user.com	\N	2012-04-13 10:00:20	2012-05-13 10:00:20	user	t	2012-05-28 10:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
522	user522	user522@user.com	\N	2012-04-12 08:59:20	2012-05-12 08:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
523	user523	user523@user.com	\N	2012-04-11 07:58:20	2012-05-11 07:58:20	user	t	2012-05-26 07:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
524	user524	user524@user.com	\N	2012-04-10 06:57:20	2012-05-10 06:57:20	user	t	2012-05-25 06:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
525	user525	user525@user.com	\N	2012-04-09 05:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
526	user526	user526@user.com	\N	2012-04-08 04:55:20	2012-05-08 04:55:20	user	t	2012-05-23 04:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
527	user527	user527@user.com	\N	2012-04-07 03:54:20	2012-05-07 03:54:20	user	t	2012-05-22 03:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
528	user528	user528@user.com	\N	2012-04-06 02:53:20	2012-05-06 02:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
529	user529	user529@user.com	\N	2012-04-05 01:52:20	2012-05-05 01:52:20	user	t	2012-05-20 01:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
530	user530	user530@user.com	\N	2012-04-04 00:51:20	\N	user	t	2012-05-19 00:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
531	user531	user531@user.com	\N	2012-04-02 23:50:20	2012-05-02 23:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
532	user532	user532@user.com	\N	2012-04-01 22:49:20	2012-05-01 22:49:20	user	t	2012-05-16 22:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
533	user533	user533@user.com	\N	2012-03-31 21:48:20	2012-04-30 21:48:20	user	t	2012-05-15 21:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
534	user534	user534@user.com	\N	2012-03-30 20:47:20	2012-04-29 20:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
535	user535	user535@user.com	\N	2012-03-29 19:46:20	\N	user	t	2012-05-13 19:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
536	user536	user536@user.com	\N	2012-03-28 18:45:20	2012-04-27 18:45:20	user	t	2012-05-12 18:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
537	user537	user537@user.com	\N	2012-03-27 17:44:20	2012-04-26 17:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
538	user538	user538@user.com	\N	2012-03-26 16:43:20	2012-04-25 16:43:20	user	t	2012-05-10 16:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
539	user539	user539@user.com	\N	2012-03-25 15:42:20	2012-04-24 15:42:20	user	t	2012-05-09 15:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
540	user540	user540@user.com	\N	2012-03-24 14:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
541	user541	user541@user.com	\N	2012-03-23 13:40:20	2012-04-22 13:40:20	user	t	2012-05-07 13:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
542	user542	user542@user.com	\N	2012-03-22 12:39:20	2012-04-21 12:39:20	user	t	2012-05-06 12:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
543	user543	user543@user.com	\N	2012-03-21 11:38:20	2012-04-20 11:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
544	user544	user544@user.com	\N	2012-03-20 10:37:20	2012-04-19 10:37:20	user	t	2012-05-04 10:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
545	user545	user545@user.com	\N	2012-03-19 09:36:20	\N	user	t	2012-05-03 09:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
546	user546	user546@user.com	\N	2012-03-18 08:35:20	2012-04-17 08:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
547	user547	user547@user.com	\N	2012-03-17 07:34:20	2012-04-16 07:34:20	user	t	2012-05-01 07:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
548	user548	user548@user.com	\N	2012-03-16 06:33:20	2012-04-15 06:33:20	user	t	2012-04-30 06:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
549	user549	user549@user.com	\N	2012-03-15 05:32:20	2012-04-14 05:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
550	user550	user550@user.com	\N	2012-03-14 04:31:20	\N	user	t	2012-04-28 04:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
551	user551	user551@user.com	\N	2012-03-13 03:30:20	2012-04-12 03:30:20	user	t	2012-04-27 03:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
552	user552	user552@user.com	\N	2012-03-12 02:29:20	2012-04-11 02:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
553	user553	user553@user.com	\N	2012-03-11 01:28:20	2012-04-10 01:28:20	user	t	2012-04-25 01:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
554	user554	user554@user.com	\N	2012-03-10 00:27:20	2012-04-09 00:27:20	user	t	2012-04-24 00:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
555	user555	user555@user.com	\N	2012-03-08 23:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
556	user556	user556@user.com	\N	2012-03-07 22:25:20	2012-04-06 22:25:20	user	t	2012-04-21 22:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
557	user557	user557@user.com	\N	2012-03-06 21:24:20	2012-04-05 21:24:20	user	t	2012-04-20 21:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
558	user558	user558@user.com	\N	2012-03-05 20:23:20	2012-04-04 20:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
559	user559	user559@user.com	\N	2012-03-04 19:22:20	2012-04-03 19:22:20	user	t	2012-04-18 19:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
560	user560	user560@user.com	\N	2012-03-03 18:21:20	\N	user	t	2012-04-17 18:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
561	user561	user561@user.com	\N	2012-03-02 17:20:20	2012-04-01 17:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
562	user562	user562@user.com	\N	2012-03-01 16:19:20	2012-03-31 16:19:20	user	t	2012-04-15 16:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
563	user563	user563@user.com	\N	2012-02-29 15:18:20	2012-03-30 15:18:20	user	t	2012-04-14 15:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
564	user564	user564@user.com	\N	2012-02-28 14:17:20	2012-03-29 14:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
565	user565	user565@user.com	\N	2012-02-27 13:16:20	\N	user	t	2012-04-12 13:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
566	user566	user566@user.com	\N	2012-02-26 12:15:20	2012-03-27 12:15:20	user	t	2012-04-11 12:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
567	user567	user567@user.com	\N	2012-02-25 11:14:20	2012-03-26 11:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
568	user568	user568@user.com	\N	2012-02-24 10:13:20	2012-03-25 10:13:20	user	t	2012-04-09 10:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
569	user569	user569@user.com	\N	2012-02-23 09:12:20	2012-03-24 09:12:20	user	t	2012-04-08 09:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
570	user570	user570@user.com	\N	2012-02-22 08:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
571	user571	user571@user.com	\N	2012-02-21 07:10:20	2012-03-22 07:10:20	user	t	2012-04-06 07:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
572	user572	user572@user.com	\N	2012-02-20 06:09:20	2012-03-21 06:09:20	user	t	2012-04-05 06:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
573	user573	user573@user.com	\N	2012-02-19 05:08:20	2012-03-20 05:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
574	user574	user574@user.com	\N	2012-02-18 04:07:20	2012-03-19 04:07:20	user	t	2012-04-03 04:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
575	user575	user575@user.com	\N	2012-02-17 03:06:20	\N	user	t	2012-04-02 03:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
576	user576	user576@user.com	\N	2012-02-16 02:05:20	2012-03-17 02:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
577	user577	user577@user.com	\N	2012-02-15 01:04:20	2012-03-16 01:04:20	user	t	2012-03-31 01:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
578	user578	user578@user.com	\N	2012-02-14 00:03:20	2012-03-15 00:03:20	user	t	2012-03-30 00:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
579	user579	user579@user.com	\N	2012-02-12 23:02:20	2012-03-13 23:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
580	user580	user580@user.com	\N	2012-02-11 22:01:20	\N	user	t	2012-03-27 22:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
581	user581	user581@user.com	\N	2012-02-10 21:00:20	2012-03-11 21:00:20	user	t	2012-03-26 21:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
582	user582	user582@user.com	\N	2012-02-09 19:59:20	2012-03-10 19:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
583	user583	user583@user.com	\N	2012-02-08 18:58:20	2012-03-09 18:58:20	user	t	2012-03-24 18:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
584	user584	user584@user.com	\N	2012-02-07 17:57:20	2012-03-08 17:57:20	user	t	2012-03-23 17:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
585	user585	user585@user.com	\N	2012-02-06 16:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
586	user586	user586@user.com	\N	2012-02-05 15:55:20	2012-03-06 15:55:20	user	t	2012-03-21 15:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
587	user587	user587@user.com	\N	2012-02-04 14:54:20	2012-03-05 14:54:20	user	t	2012-03-20 14:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
588	user588	user588@user.com	\N	2012-02-03 13:53:20	2012-03-04 13:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
589	user589	user589@user.com	\N	2012-02-02 12:52:20	2012-03-03 12:52:20	user	t	2012-03-18 12:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
590	user590	user590@user.com	\N	2012-02-01 11:51:20	\N	user	t	2012-03-17 11:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
591	user591	user591@user.com	\N	2012-01-31 10:50:20	2012-03-01 10:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
592	user592	user592@user.com	\N	2012-01-30 09:49:20	2012-02-29 09:49:20	user	t	2012-03-15 09:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
593	user593	user593@user.com	\N	2012-01-29 08:48:20	2012-02-28 08:48:20	user	t	2012-03-14 08:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
594	user594	user594@user.com	\N	2012-01-28 07:47:20	2012-02-27 07:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
595	user595	user595@user.com	\N	2012-01-27 06:46:20	\N	user	t	2012-03-12 06:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
596	user596	user596@user.com	\N	2012-01-26 05:45:20	2012-02-25 05:45:20	user	t	2012-03-11 05:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
597	user597	user597@user.com	\N	2012-01-25 04:44:20	2012-02-24 04:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
598	user598	user598@user.com	\N	2012-01-24 03:43:20	2012-02-23 03:43:20	user	t	2012-03-09 03:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
599	user599	user599@user.com	\N	2012-01-23 02:42:20	2012-02-22 02:42:20	user	t	2012-03-08 02:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
600	user600	user600@user.com	\N	2012-01-22 01:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
601	user601	user601@user.com	\N	2012-01-21 00:40:20	2012-02-20 00:40:20	user	t	2012-03-06 00:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
602	user602	user602@user.com	\N	2012-01-19 23:39:20	2012-02-18 23:39:20	user	t	2012-03-04 23:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
603	user603	user603@user.com	\N	2012-01-18 22:38:20	2012-02-17 22:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
604	user604	user604@user.com	\N	2012-01-17 21:37:20	2012-02-16 21:37:20	user	t	2012-03-02 21:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
605	user605	user605@user.com	\N	2012-01-16 20:36:20	\N	user	t	2012-03-01 20:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
606	user606	user606@user.com	\N	2012-01-15 19:35:20	2012-02-14 19:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
607	user607	user607@user.com	\N	2012-01-14 18:34:20	2012-02-13 18:34:20	user	t	2012-02-28 18:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
608	user608	user608@user.com	\N	2012-01-13 17:33:20	2012-02-12 17:33:20	user	t	2012-02-27 17:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
609	user609	user609@user.com	\N	2012-01-12 16:32:20	2012-02-11 16:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
610	user610	user610@user.com	\N	2012-01-11 15:31:20	\N	user	t	2012-02-25 15:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
611	user611	user611@user.com	\N	2012-01-10 14:30:20	2012-02-09 14:30:20	user	t	2012-02-24 14:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
612	user612	user612@user.com	\N	2012-01-09 13:29:20	2012-02-08 13:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
613	user613	user613@user.com	\N	2012-01-08 12:28:20	2012-02-07 12:28:20	user	t	2012-02-22 12:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
614	user614	user614@user.com	\N	2012-01-07 11:27:20	2012-02-06 11:27:20	user	t	2012-02-21 11:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
615	user615	user615@user.com	\N	2012-01-06 10:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
616	user616	user616@user.com	\N	2012-01-05 09:25:20	2012-02-04 09:25:20	user	t	2012-02-19 09:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
617	user617	user617@user.com	\N	2012-01-04 08:24:20	2012-02-03 08:24:20	user	t	2012-02-18 08:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
618	user618	user618@user.com	\N	2012-01-03 07:23:20	2012-02-02 07:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
619	user619	user619@user.com	\N	2012-01-02 06:22:20	2012-02-01 06:22:20	user	t	2012-02-16 06:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
620	user620	user620@user.com	\N	2012-01-01 05:21:20	\N	user	t	2012-02-15 05:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
621	user621	user621@user.com	\N	2011-12-31 04:20:20	2012-01-30 04:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
622	user622	user622@user.com	\N	2011-12-30 03:19:20	2012-01-29 03:19:20	user	t	2012-02-13 03:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
623	user623	user623@user.com	\N	2011-12-29 02:18:20	2012-01-28 02:18:20	user	t	2012-02-12 02:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
624	user624	user624@user.com	\N	2011-12-28 01:17:20	2012-01-27 01:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
625	user625	user625@user.com	\N	2011-12-27 00:16:20	\N	user	t	2012-02-10 00:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
626	user626	user626@user.com	\N	2011-12-25 23:15:20	2012-01-24 23:15:20	user	t	2012-02-08 23:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
627	user627	user627@user.com	\N	2011-12-24 22:14:20	2012-01-23 22:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
628	user628	user628@user.com	\N	2011-12-23 21:13:20	2012-01-22 21:13:20	user	t	2012-02-06 21:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
629	user629	user629@user.com	\N	2011-12-22 20:12:20	2012-01-21 20:12:20	user	t	2012-02-05 20:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
630	user630	user630@user.com	\N	2011-12-21 19:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
631	user631	user631@user.com	\N	2011-12-20 18:10:20	2012-01-19 18:10:20	user	t	2012-02-03 18:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
632	user632	user632@user.com	\N	2011-12-19 17:09:20	2012-01-18 17:09:20	user	t	2012-02-02 17:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
633	user633	user633@user.com	\N	2011-12-18 16:08:20	2012-01-17 16:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
634	user634	user634@user.com	\N	2011-12-17 15:07:20	2012-01-16 15:07:20	user	t	2012-01-31 15:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
635	user635	user635@user.com	\N	2011-12-16 14:06:20	\N	user	t	2012-01-30 14:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
636	user636	user636@user.com	\N	2011-12-15 13:05:20	2012-01-14 13:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
637	user637	user637@user.com	\N	2011-12-14 12:04:20	2012-01-13 12:04:20	user	t	2012-01-28 12:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
638	user638	user638@user.com	\N	2011-12-13 11:03:20	2012-01-12 11:03:20	user	t	2012-01-27 11:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
639	user639	user639@user.com	\N	2011-12-12 10:02:20	2012-01-11 10:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
640	user640	user640@user.com	\N	2011-12-11 09:01:20	\N	user	t	2012-01-25 09:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
641	user641	user641@user.com	\N	2011-12-10 08:00:20	2012-01-09 08:00:20	user	t	2012-01-24 08:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
642	user642	user642@user.com	\N	2011-12-09 06:59:20	2012-01-08 06:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
643	user643	user643@user.com	\N	2011-12-08 05:58:20	2012-01-07 05:58:20	user	t	2012-01-22 05:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
644	user644	user644@user.com	\N	2011-12-07 04:57:20	2012-01-06 04:57:20	user	t	2012-01-21 04:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
645	user645	user645@user.com	\N	2011-12-06 03:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
646	user646	user646@user.com	\N	2011-12-05 02:55:20	2012-01-04 02:55:20	user	t	2012-01-19 02:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
647	user647	user647@user.com	\N	2011-12-04 01:54:20	2012-01-03 01:54:20	user	t	2012-01-18 01:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
648	user648	user648@user.com	\N	2011-12-03 00:53:20	2012-01-02 00:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
649	user649	user649@user.com	\N	2011-12-01 23:52:20	2011-12-31 23:52:20	user	t	2012-01-15 23:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
650	user650	user650@user.com	\N	2011-11-30 22:51:20	\N	user	t	2012-01-14 22:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
651	user651	user651@user.com	\N	2011-11-29 21:50:20	2011-12-29 21:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
652	user652	user652@user.com	\N	2011-11-28 20:49:20	2011-12-28 20:49:20	user	t	2012-01-12 20:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
653	user653	user653@user.com	\N	2011-11-27 19:48:20	2011-12-27 19:48:20	user	t	2012-01-11 19:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
654	user654	user654@user.com	\N	2011-11-26 18:47:20	2011-12-26 18:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
655	user655	user655@user.com	\N	2011-11-25 17:46:20	\N	user	t	2012-01-09 17:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
656	user656	user656@user.com	\N	2011-11-24 16:45:20	2011-12-24 16:45:20	user	t	2012-01-08 16:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
657	user657	user657@user.com	\N	2011-11-23 15:44:20	2011-12-23 15:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
658	user658	user658@user.com	\N	2011-11-22 14:43:20	2011-12-22 14:43:20	user	t	2012-01-06 14:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
659	user659	user659@user.com	\N	2011-11-21 13:42:20	2011-12-21 13:42:20	user	t	2012-01-05 13:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
660	user660	user660@user.com	\N	2011-11-20 12:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
661	user661	user661@user.com	\N	2011-11-19 11:40:20	2011-12-19 11:40:20	user	t	2012-01-03 11:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
662	user662	user662@user.com	\N	2011-11-18 10:39:20	2011-12-18 10:39:20	user	t	2012-01-02 10:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
663	user663	user663@user.com	\N	2011-11-17 09:38:20	2011-12-17 09:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
664	user664	user664@user.com	\N	2011-11-16 08:37:20	2011-12-16 08:37:20	user	t	2011-12-31 08:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
665	user665	user665@user.com	\N	2011-11-15 07:36:20	\N	user	t	2011-12-30 07:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
666	user666	user666@user.com	\N	2011-11-14 06:35:20	2011-12-14 06:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
667	user667	user667@user.com	\N	2011-11-13 05:34:20	2011-12-13 05:34:20	user	t	2011-12-28 05:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
668	user668	user668@user.com	\N	2011-11-12 04:33:20	2011-12-12 04:33:20	user	t	2011-12-27 04:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
669	user669	user669@user.com	\N	2011-11-11 03:32:20	2011-12-11 03:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
670	user670	user670@user.com	\N	2011-11-10 02:31:20	\N	user	t	2011-12-25 02:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
671	user671	user671@user.com	\N	2011-11-09 01:30:20	2011-12-09 01:30:20	user	t	2011-12-24 01:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
672	user672	user672@user.com	\N	2011-11-08 00:29:20	2011-12-08 00:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
673	user673	user673@user.com	\N	2011-11-06 23:28:20	2011-12-06 23:28:20	user	t	2011-12-21 23:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
674	user674	user674@user.com	\N	2011-11-05 22:27:20	2011-12-05 22:27:20	user	t	2011-12-20 22:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
675	user675	user675@user.com	\N	2011-11-04 21:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
676	user676	user676@user.com	\N	2011-11-03 20:25:20	2011-12-03 20:25:20	user	t	2011-12-18 20:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
677	user677	user677@user.com	\N	2011-11-02 19:24:20	2011-12-02 19:24:20	user	t	2011-12-17 19:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
678	user678	user678@user.com	\N	2011-11-01 18:23:20	2011-12-01 18:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
679	user679	user679@user.com	\N	2011-10-31 17:22:20	2011-11-30 17:22:20	user	t	2011-12-15 17:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
680	user680	user680@user.com	\N	2011-10-30 16:21:20	\N	user	t	2011-12-14 16:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
681	user681	user681@user.com	\N	2011-10-29 15:20:20	2011-11-28 15:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
682	user682	user682@user.com	\N	2011-10-28 14:19:20	2011-11-27 14:19:20	user	t	2011-12-12 14:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
683	user683	user683@user.com	\N	2011-10-27 13:18:20	2011-11-26 13:18:20	user	t	2011-12-11 13:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
684	user684	user684@user.com	\N	2011-10-26 12:17:20	2011-11-25 12:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
685	user685	user685@user.com	\N	2011-10-25 11:16:20	\N	user	t	2011-12-09 11:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
686	user686	user686@user.com	\N	2011-10-24 10:15:20	2011-11-23 10:15:20	user	t	2011-12-08 10:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
687	user687	user687@user.com	\N	2011-10-23 09:14:20	2011-11-22 09:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
688	user688	user688@user.com	\N	2011-10-22 08:13:20	2011-11-21 08:13:20	user	t	2011-12-06 08:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
689	user689	user689@user.com	\N	2011-10-21 07:12:20	2011-11-20 07:12:20	user	t	2011-12-05 07:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
690	user690	user690@user.com	\N	2011-10-20 06:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
691	user691	user691@user.com	\N	2011-10-19 05:10:20	2011-11-18 05:10:20	user	t	2011-12-03 05:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
692	user692	user692@user.com	\N	2011-10-18 04:09:20	2011-11-17 04:09:20	user	t	2011-12-02 04:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
693	user693	user693@user.com	\N	2011-10-17 03:08:20	2011-11-16 03:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
694	user694	user694@user.com	\N	2011-10-16 02:07:20	2011-11-15 02:07:20	user	t	2011-11-30 02:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
695	user695	user695@user.com	\N	2011-10-15 01:06:20	\N	user	t	2011-11-29 01:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
696	user696	user696@user.com	\N	2011-10-14 00:05:20	2011-11-13 00:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
697	user697	user697@user.com	\N	2011-10-12 23:04:20	2011-11-11 23:04:20	user	t	2011-11-26 23:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
698	user698	user698@user.com	\N	2011-10-11 22:03:20	2011-11-10 22:03:20	user	t	2011-11-25 22:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
699	user699	user699@user.com	\N	2011-10-10 21:02:20	2011-11-09 21:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
700	user700	user700@user.com	\N	2011-10-09 20:01:20	\N	user	t	2011-11-23 20:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
701	user701	user701@user.com	\N	2011-10-08 19:00:20	2011-11-07 19:00:20	user	t	2011-11-22 19:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
702	user702	user702@user.com	\N	2011-10-07 17:59:20	2011-11-06 17:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
703	user703	user703@user.com	\N	2011-10-06 16:58:20	2011-11-05 16:58:20	user	t	2011-11-20 16:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
704	user704	user704@user.com	\N	2011-10-05 15:57:20	2011-11-04 15:57:20	user	t	2011-11-19 15:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
705	user705	user705@user.com	\N	2011-10-04 14:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
706	user706	user706@user.com	\N	2011-10-03 13:55:20	2011-11-02 13:55:20	user	t	2011-11-17 13:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
707	user707	user707@user.com	\N	2011-10-02 12:54:20	2011-11-01 12:54:20	user	t	2011-11-16 12:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
708	user708	user708@user.com	\N	2011-10-01 11:53:20	2011-10-31 11:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
709	user709	user709@user.com	\N	2011-09-30 10:52:20	2011-10-30 10:52:20	user	t	2011-11-14 10:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
710	user710	user710@user.com	\N	2011-09-29 09:51:20	\N	user	t	2011-11-13 09:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
711	user711	user711@user.com	\N	2011-09-28 08:50:20	2011-10-28 08:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
712	user712	user712@user.com	\N	2011-09-27 07:49:20	2011-10-27 07:49:20	user	t	2011-11-11 07:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
713	user713	user713@user.com	\N	2011-09-26 06:48:20	2011-10-26 06:48:20	user	t	2011-11-10 06:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
714	user714	user714@user.com	\N	2011-09-25 05:47:20	2011-10-25 05:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
715	user715	user715@user.com	\N	2011-09-24 04:46:20	\N	user	t	2011-11-08 04:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
716	user716	user716@user.com	\N	2011-09-23 03:45:20	2011-10-23 03:45:20	user	t	2011-11-07 03:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
717	user717	user717@user.com	\N	2011-09-22 02:44:20	2011-10-22 02:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
718	user718	user718@user.com	\N	2011-09-21 01:43:20	2011-10-21 01:43:20	user	t	2011-11-05 01:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
719	user719	user719@user.com	\N	2011-09-20 00:42:20	2011-10-20 00:42:20	user	t	2011-11-04 00:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
720	user720	user720@user.com	\N	2011-09-18 23:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
721	user721	user721@user.com	\N	2011-09-17 22:40:20	2011-10-17 22:40:20	user	t	2011-11-01 22:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
722	user722	user722@user.com	\N	2011-09-16 21:39:20	2011-10-16 21:39:20	user	t	2011-10-31 21:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
723	user723	user723@user.com	\N	2011-09-15 20:38:20	2011-10-15 20:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
724	user724	user724@user.com	\N	2011-09-14 19:37:20	2011-10-14 19:37:20	user	t	2011-10-29 19:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
725	user725	user725@user.com	\N	2011-09-13 18:36:20	\N	user	t	2011-10-28 18:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
726	user726	user726@user.com	\N	2011-09-12 17:35:20	2011-10-12 17:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
727	user727	user727@user.com	\N	2011-09-11 16:34:20	2011-10-11 16:34:20	user	t	2011-10-26 16:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
728	user728	user728@user.com	\N	2011-09-10 15:33:20	2011-10-10 15:33:20	user	t	2011-10-25 15:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
729	user729	user729@user.com	\N	2011-09-09 14:32:20	2011-10-09 14:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
730	user730	user730@user.com	\N	2011-09-08 13:31:20	\N	user	t	2011-10-23 13:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
731	user731	user731@user.com	\N	2011-09-07 12:30:20	2011-10-07 12:30:20	user	t	2011-10-22 12:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
732	user732	user732@user.com	\N	2011-09-06 11:29:20	2011-10-06 11:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
733	user733	user733@user.com	\N	2011-09-05 10:28:20	2011-10-05 10:28:20	user	t	2011-10-20 10:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
734	user734	user734@user.com	\N	2011-09-04 09:27:20	2011-10-04 09:27:20	user	t	2011-10-19 09:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
735	user735	user735@user.com	\N	2011-09-03 08:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
736	user736	user736@user.com	\N	2011-09-02 07:25:20	2011-10-02 07:25:20	user	t	2011-10-17 07:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
737	user737	user737@user.com	\N	2011-09-01 06:24:20	2011-10-01 06:24:20	user	t	2011-10-16 06:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
738	user738	user738@user.com	\N	2011-08-31 05:23:20	2011-09-30 05:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
739	user739	user739@user.com	\N	2011-08-30 04:22:20	2011-09-29 04:22:20	user	t	2011-10-14 04:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
740	user740	user740@user.com	\N	2011-08-29 03:21:20	\N	user	t	2011-10-13 03:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
741	user741	user741@user.com	\N	2011-08-28 02:20:20	2011-09-27 02:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
742	user742	user742@user.com	\N	2011-08-27 01:19:20	2011-09-26 01:19:20	user	t	2011-10-11 01:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
743	user743	user743@user.com	\N	2011-08-26 00:18:20	2011-09-25 00:18:20	user	t	2011-10-10 00:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
744	user744	user744@user.com	\N	2011-08-24 23:17:20	2011-09-23 23:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
745	user745	user745@user.com	\N	2011-08-23 22:16:20	\N	user	t	2011-10-07 22:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
746	user746	user746@user.com	\N	2011-08-22 21:15:20	2011-09-21 21:15:20	user	t	2011-10-06 21:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
747	user747	user747@user.com	\N	2011-08-21 20:14:20	2011-09-20 20:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
748	user748	user748@user.com	\N	2011-08-20 19:13:20	2011-09-19 19:13:20	user	t	2011-10-04 19:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
749	user749	user749@user.com	\N	2011-08-19 18:12:20	2011-09-18 18:12:20	user	t	2011-10-03 18:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
750	user750	user750@user.com	\N	2011-08-18 17:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
751	user751	user751@user.com	\N	2011-08-17 16:10:20	2011-09-16 16:10:20	user	t	2011-10-01 16:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
752	user752	user752@user.com	\N	2011-08-16 15:09:20	2011-09-15 15:09:20	user	t	2011-09-30 15:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
753	user753	user753@user.com	\N	2011-08-15 14:08:20	2011-09-14 14:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
754	user754	user754@user.com	\N	2011-08-14 13:07:20	2011-09-13 13:07:20	user	t	2011-09-28 13:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
755	user755	user755@user.com	\N	2011-08-13 12:06:20	\N	user	t	2011-09-27 12:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
756	user756	user756@user.com	\N	2011-08-12 11:05:20	2011-09-11 11:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
757	user757	user757@user.com	\N	2011-08-11 10:04:20	2011-09-10 10:04:20	user	t	2011-09-25 10:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
758	user758	user758@user.com	\N	2011-08-10 09:03:20	2011-09-09 09:03:20	user	t	2011-09-24 09:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
759	user759	user759@user.com	\N	2011-08-09 08:02:20	2011-09-08 08:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
760	user760	user760@user.com	\N	2011-08-08 07:01:20	\N	user	t	2011-09-22 07:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
761	user761	user761@user.com	\N	2011-08-07 06:00:20	2011-09-06 06:00:20	user	t	2011-09-21 06:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
762	user762	user762@user.com	\N	2011-08-06 04:59:20	2011-09-05 04:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
763	user763	user763@user.com	\N	2011-08-05 03:58:20	2011-09-04 03:58:20	user	t	2011-09-19 03:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
764	user764	user764@user.com	\N	2011-08-04 02:57:20	2011-09-03 02:57:20	user	t	2011-09-18 02:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
765	user765	user765@user.com	\N	2011-08-03 01:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
766	user766	user766@user.com	\N	2011-08-02 00:55:20	2011-09-01 00:55:20	user	t	2011-09-16 00:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
767	user767	user767@user.com	\N	2011-07-31 23:54:20	2011-08-30 23:54:20	user	t	2011-09-14 23:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
768	user768	user768@user.com	\N	2011-07-30 22:53:20	2011-08-29 22:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
769	user769	user769@user.com	\N	2011-07-29 21:52:20	2011-08-28 21:52:20	user	t	2011-09-12 21:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
770	user770	user770@user.com	\N	2011-07-28 20:51:20	\N	user	t	2011-09-11 20:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
771	user771	user771@user.com	\N	2011-07-27 19:50:20	2011-08-26 19:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
772	user772	user772@user.com	\N	2011-07-26 18:49:20	2011-08-25 18:49:20	user	t	2011-09-09 18:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
773	user773	user773@user.com	\N	2011-07-25 17:48:20	2011-08-24 17:48:20	user	t	2011-09-08 17:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
774	user774	user774@user.com	\N	2011-07-24 16:47:20	2011-08-23 16:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
775	user775	user775@user.com	\N	2011-07-23 15:46:20	\N	user	t	2011-09-06 15:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
776	user776	user776@user.com	\N	2011-07-22 14:45:20	2011-08-21 14:45:20	user	t	2011-09-05 14:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
777	user777	user777@user.com	\N	2011-07-21 13:44:20	2011-08-20 13:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
778	user778	user778@user.com	\N	2011-07-20 12:43:20	2011-08-19 12:43:20	user	t	2011-09-03 12:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
779	user779	user779@user.com	\N	2011-07-19 11:42:20	2011-08-18 11:42:20	user	t	2011-09-02 11:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
780	user780	user780@user.com	\N	2011-07-18 10:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
781	user781	user781@user.com	\N	2011-07-17 09:40:20	2011-08-16 09:40:20	user	t	2011-08-31 09:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
782	user782	user782@user.com	\N	2011-07-16 08:39:20	2011-08-15 08:39:20	user	t	2011-08-30 08:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
783	user783	user783@user.com	\N	2011-07-15 07:38:20	2011-08-14 07:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
784	user784	user784@user.com	\N	2011-07-14 06:37:20	2011-08-13 06:37:20	user	t	2011-08-28 06:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
785	user785	user785@user.com	\N	2011-07-13 05:36:20	\N	user	t	2011-08-27 05:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
786	user786	user786@user.com	\N	2011-07-12 04:35:20	2011-08-11 04:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
787	user787	user787@user.com	\N	2011-07-11 03:34:20	2011-08-10 03:34:20	user	t	2011-08-25 03:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
788	user788	user788@user.com	\N	2011-07-10 02:33:20	2011-08-09 02:33:20	user	t	2011-08-24 02:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
789	user789	user789@user.com	\N	2011-07-09 01:32:20	2011-08-08 01:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
790	user790	user790@user.com	\N	2011-07-08 00:31:20	\N	user	t	2011-08-22 00:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
791	user791	user791@user.com	\N	2011-07-06 23:30:20	2011-08-05 23:30:20	user	t	2011-08-20 23:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
792	user792	user792@user.com	\N	2011-07-05 22:29:20	2011-08-04 22:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
793	user793	user793@user.com	\N	2011-07-04 21:28:20	2011-08-03 21:28:20	user	t	2011-08-18 21:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
794	user794	user794@user.com	\N	2011-07-03 20:27:20	2011-08-02 20:27:20	user	t	2011-08-17 20:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
795	user795	user795@user.com	\N	2011-07-02 19:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
796	user796	user796@user.com	\N	2011-07-01 18:25:20	2011-07-31 18:25:20	user	t	2011-08-15 18:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
797	user797	user797@user.com	\N	2011-06-30 17:24:20	2011-07-30 17:24:20	user	t	2011-08-14 17:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
798	user798	user798@user.com	\N	2011-06-29 16:23:20	2011-07-29 16:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
799	user799	user799@user.com	\N	2011-06-28 15:22:20	2011-07-28 15:22:20	user	t	2011-08-12 15:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
800	user800	user800@user.com	\N	2011-06-27 14:21:20	\N	user	t	2011-08-11 14:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
801	user801	user801@user.com	\N	2011-06-26 13:20:20	2011-07-26 13:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
802	user802	user802@user.com	\N	2011-06-25 12:19:20	2011-07-25 12:19:20	user	t	2011-08-09 12:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
803	user803	user803@user.com	\N	2011-06-24 11:18:20	2011-07-24 11:18:20	user	t	2011-08-08 11:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
804	user804	user804@user.com	\N	2011-06-23 10:17:20	2011-07-23 10:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
805	user805	user805@user.com	\N	2011-06-22 09:16:20	\N	user	t	2011-08-06 09:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
806	user806	user806@user.com	\N	2011-06-21 08:15:20	2011-07-21 08:15:20	user	t	2011-08-05 08:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
807	user807	user807@user.com	\N	2011-06-20 07:14:20	2011-07-20 07:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
808	user808	user808@user.com	\N	2011-06-19 06:13:20	2011-07-19 06:13:20	user	t	2011-08-03 06:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
809	user809	user809@user.com	\N	2011-06-18 05:12:20	2011-07-18 05:12:20	user	t	2011-08-02 05:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
810	user810	user810@user.com	\N	2011-06-17 04:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
811	user811	user811@user.com	\N	2011-06-16 03:10:20	2011-07-16 03:10:20	user	t	2011-07-31 03:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
812	user812	user812@user.com	\N	2011-06-15 02:09:20	2011-07-15 02:09:20	user	t	2011-07-30 02:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
813	user813	user813@user.com	\N	2011-06-14 01:08:20	2011-07-14 01:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
814	user814	user814@user.com	\N	2011-06-13 00:07:20	2011-07-13 00:07:20	user	t	2011-07-28 00:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
815	user815	user815@user.com	\N	2011-06-11 23:06:20	\N	user	t	2011-07-26 23:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
816	user816	user816@user.com	\N	2011-06-10 22:05:20	2011-07-10 22:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
817	user817	user817@user.com	\N	2011-06-09 21:04:20	2011-07-09 21:04:20	user	t	2011-07-24 21:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
818	user818	user818@user.com	\N	2011-06-08 20:03:20	2011-07-08 20:03:20	user	t	2011-07-23 20:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
819	user819	user819@user.com	\N	2011-06-07 19:02:20	2011-07-07 19:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
820	user820	user820@user.com	\N	2011-06-06 18:01:20	\N	user	t	2011-07-21 18:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
821	user821	user821@user.com	\N	2011-06-05 17:00:20	2011-07-05 17:00:20	user	t	2011-07-20 17:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
822	user822	user822@user.com	\N	2011-06-04 15:59:20	2011-07-04 15:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
823	user823	user823@user.com	\N	2011-06-03 14:58:20	2011-07-03 14:58:20	user	t	2011-07-18 14:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
824	user824	user824@user.com	\N	2011-06-02 13:57:20	2011-07-02 13:57:20	user	t	2011-07-17 13:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
825	user825	user825@user.com	\N	2011-06-01 12:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
826	user826	user826@user.com	\N	2011-05-31 11:55:20	2011-06-30 11:55:20	user	t	2011-07-15 11:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
827	user827	user827@user.com	\N	2011-05-30 10:54:20	2011-06-29 10:54:20	user	t	2011-07-14 10:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
828	user828	user828@user.com	\N	2011-05-29 09:53:20	2011-06-28 09:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
829	user829	user829@user.com	\N	2011-05-28 08:52:20	2011-06-27 08:52:20	user	t	2011-07-12 08:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
830	user830	user830@user.com	\N	2011-05-27 07:51:20	\N	user	t	2011-07-11 07:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
831	user831	user831@user.com	\N	2011-05-26 06:50:20	2011-06-25 06:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
832	user832	user832@user.com	\N	2011-05-25 05:49:20	2011-06-24 05:49:20	user	t	2011-07-09 05:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
833	user833	user833@user.com	\N	2011-05-24 04:48:20	2011-06-23 04:48:20	user	t	2011-07-08 04:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
834	user834	user834@user.com	\N	2011-05-23 03:47:20	2011-06-22 03:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
835	user835	user835@user.com	\N	2011-05-22 02:46:20	\N	user	t	2011-07-06 02:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
836	user836	user836@user.com	\N	2011-05-21 01:45:20	2011-06-20 01:45:20	user	t	2011-07-05 01:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
837	user837	user837@user.com	\N	2011-05-20 00:44:20	2011-06-19 00:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
838	user838	user838@user.com	\N	2011-05-18 23:43:20	2011-06-17 23:43:20	user	t	2011-07-02 23:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
839	user839	user839@user.com	\N	2011-05-17 22:42:20	2011-06-16 22:42:20	user	t	2011-07-01 22:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
840	user840	user840@user.com	\N	2011-05-16 21:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
841	user841	user841@user.com	\N	2011-05-15 20:40:20	2011-06-14 20:40:20	user	t	2011-06-29 20:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
842	user842	user842@user.com	\N	2011-05-14 19:39:20	2011-06-13 19:39:20	user	t	2011-06-28 19:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
843	user843	user843@user.com	\N	2011-05-13 18:38:20	2011-06-12 18:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
844	user844	user844@user.com	\N	2011-05-12 17:37:20	2011-06-11 17:37:20	user	t	2011-06-26 17:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
845	user845	user845@user.com	\N	2011-05-11 16:36:20	\N	user	t	2011-06-25 16:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
846	user846	user846@user.com	\N	2011-05-10 15:35:20	2011-06-09 15:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
847	user847	user847@user.com	\N	2011-05-09 14:34:20	2011-06-08 14:34:20	user	t	2011-06-23 14:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
848	user848	user848@user.com	\N	2011-05-08 13:33:20	2011-06-07 13:33:20	user	t	2011-06-22 13:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
849	user849	user849@user.com	\N	2011-05-07 12:32:20	2011-06-06 12:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
850	user850	user850@user.com	\N	2011-05-06 11:31:20	\N	user	t	2011-06-20 11:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
851	user851	user851@user.com	\N	2011-05-05 10:30:20	2011-06-04 10:30:20	user	t	2011-06-19 10:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
852	user852	user852@user.com	\N	2011-05-04 09:29:20	2011-06-03 09:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
853	user853	user853@user.com	\N	2011-05-03 08:28:20	2011-06-02 08:28:20	user	t	2011-06-17 08:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
854	user854	user854@user.com	\N	2011-05-02 07:27:20	2011-06-01 07:27:20	user	t	2011-06-16 07:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
855	user855	user855@user.com	\N	2011-05-01 06:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
856	user856	user856@user.com	\N	2011-04-30 05:25:20	2011-05-30 05:25:20	user	t	2011-06-14 05:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
857	user857	user857@user.com	\N	2011-04-29 04:24:20	2011-05-29 04:24:20	user	t	2011-06-13 04:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
858	user858	user858@user.com	\N	2011-04-28 03:23:20	2011-05-28 03:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
859	user859	user859@user.com	\N	2011-04-27 02:22:20	2011-05-27 02:22:20	user	t	2011-06-11 02:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
860	user860	user860@user.com	\N	2011-04-26 01:21:20	\N	user	t	2011-06-10 01:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
861	user861	user861@user.com	\N	2011-04-25 00:20:20	2011-05-25 00:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
862	user862	user862@user.com	\N	2011-04-23 23:19:20	2011-05-23 23:19:20	user	t	2011-06-07 23:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
863	user863	user863@user.com	\N	2011-04-22 22:18:20	2011-05-22 22:18:20	user	t	2011-06-06 22:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
864	user864	user864@user.com	\N	2011-04-21 21:17:20	2011-05-21 21:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
865	user865	user865@user.com	\N	2011-04-20 20:16:20	\N	user	t	2011-06-04 20:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
866	user866	user866@user.com	\N	2011-04-19 19:15:20	2011-05-19 19:15:20	user	t	2011-06-03 19:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
867	user867	user867@user.com	\N	2011-04-18 18:14:20	2011-05-18 18:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
868	user868	user868@user.com	\N	2011-04-17 17:13:20	2011-05-17 17:13:20	user	t	2011-06-01 17:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
869	user869	user869@user.com	\N	2011-04-16 16:12:20	2011-05-16 16:12:20	user	t	2011-05-31 16:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
870	user870	user870@user.com	\N	2011-04-15 15:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
871	user871	user871@user.com	\N	2011-04-14 14:10:20	2011-05-14 14:10:20	user	t	2011-05-29 14:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
872	user872	user872@user.com	\N	2011-04-13 13:09:20	2011-05-13 13:09:20	user	t	2011-05-28 13:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
873	user873	user873@user.com	\N	2011-04-12 12:08:20	2011-05-12 12:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
874	user874	user874@user.com	\N	2011-04-11 11:07:20	2011-05-11 11:07:20	user	t	2011-05-26 11:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
875	user875	user875@user.com	\N	2011-04-10 10:06:20	\N	user	t	2011-05-25 10:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
876	user876	user876@user.com	\N	2011-04-09 09:05:20	2011-05-09 09:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
877	user877	user877@user.com	\N	2011-04-08 08:04:20	2011-05-08 08:04:20	user	t	2011-05-23 08:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
878	user878	user878@user.com	\N	2011-04-07 07:03:20	2011-05-07 07:03:20	user	t	2011-05-22 07:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
879	user879	user879@user.com	\N	2011-04-06 06:02:20	2011-05-06 06:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
880	user880	user880@user.com	\N	2011-04-05 05:01:20	\N	user	t	2011-05-20 05:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
881	user881	user881@user.com	\N	2011-04-04 04:00:20	2011-05-04 04:00:20	user	t	2011-05-19 04:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
882	user882	user882@user.com	\N	2011-04-03 02:59:20	2011-05-03 02:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
883	user883	user883@user.com	\N	2011-04-02 01:58:20	2011-05-02 01:58:20	user	t	2011-05-17 01:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
884	user884	user884@user.com	\N	2011-04-01 00:57:20	2011-05-01 00:57:20	user	t	2011-05-16 00:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
885	user885	user885@user.com	\N	2011-03-30 23:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
886	user886	user886@user.com	\N	2011-03-29 22:55:20	2011-04-28 22:55:20	user	t	2011-05-13 22:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
887	user887	user887@user.com	\N	2011-03-28 21:54:20	2011-04-27 21:54:20	user	t	2011-05-12 21:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
888	user888	user888@user.com	\N	2011-03-27 20:53:20	2011-04-26 20:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
889	user889	user889@user.com	\N	2011-03-26 19:52:20	2011-04-25 19:52:20	user	t	2011-05-10 19:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
890	user890	user890@user.com	\N	2011-03-25 18:51:20	\N	user	t	2011-05-09 18:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
891	user891	user891@user.com	\N	2011-03-24 17:50:20	2011-04-23 17:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
892	user892	user892@user.com	\N	2011-03-23 16:49:20	2011-04-22 16:49:20	user	t	2011-05-07 16:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
893	user893	user893@user.com	\N	2011-03-22 15:48:20	2011-04-21 15:48:20	user	t	2011-05-06 15:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
894	user894	user894@user.com	\N	2011-03-21 14:47:20	2011-04-20 14:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
895	user895	user895@user.com	\N	2011-03-20 13:46:20	\N	user	t	2011-05-04 13:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
896	user896	user896@user.com	\N	2011-03-19 12:45:20	2011-04-18 12:45:20	user	t	2011-05-03 12:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
897	user897	user897@user.com	\N	2011-03-18 11:44:20	2011-04-17 11:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
898	user898	user898@user.com	\N	2011-03-17 10:43:20	2011-04-16 10:43:20	user	t	2011-05-01 10:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
899	user899	user899@user.com	\N	2011-03-16 09:42:20	2011-04-15 09:42:20	user	t	2011-04-30 09:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
900	user900	user900@user.com	\N	2011-03-15 08:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
901	user901	user901@user.com	\N	2011-03-14 07:40:20	2011-04-13 07:40:20	user	t	2011-04-28 07:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
902	user902	user902@user.com	\N	2011-03-13 06:39:20	2011-04-12 06:39:20	user	t	2011-04-27 06:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
903	user903	user903@user.com	\N	2011-03-12 05:38:20	2011-04-11 05:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
904	user904	user904@user.com	\N	2011-03-11 04:37:20	2011-04-10 04:37:20	user	t	2011-04-25 04:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
905	user905	user905@user.com	\N	2011-03-10 03:36:20	\N	user	t	2011-04-24 03:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
906	user906	user906@user.com	\N	2011-03-09 02:35:20	2011-04-08 02:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
907	user907	user907@user.com	\N	2011-03-08 01:34:20	2011-04-07 01:34:20	user	t	2011-04-22 01:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
908	user908	user908@user.com	\N	2011-03-07 00:33:20	2011-04-06 00:33:20	user	t	2011-04-21 00:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
909	user909	user909@user.com	\N	2011-03-05 23:32:20	2011-04-04 23:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
910	user910	user910@user.com	\N	2011-03-04 22:31:20	\N	user	t	2011-04-18 22:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
911	user911	user911@user.com	\N	2011-03-03 21:30:20	2011-04-02 21:30:20	user	t	2011-04-17 21:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
912	user912	user912@user.com	\N	2011-03-02 20:29:20	2011-04-01 20:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
913	user913	user913@user.com	\N	2011-03-01 19:28:20	2011-03-31 19:28:20	user	t	2011-04-15 19:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
914	user914	user914@user.com	\N	2011-02-28 18:27:20	2011-03-30 18:27:20	user	t	2011-04-14 18:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
915	user915	user915@user.com	\N	2011-02-27 17:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
916	user916	user916@user.com	\N	2011-02-26 16:25:20	2011-03-28 16:25:20	user	t	2011-04-12 16:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
917	user917	user917@user.com	\N	2011-02-25 15:24:20	2011-03-27 15:24:20	user	t	2011-04-11 15:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
918	user918	user918@user.com	\N	2011-02-24 14:23:20	2011-03-26 14:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
919	user919	user919@user.com	\N	2011-02-23 13:22:20	2011-03-25 13:22:20	user	t	2011-04-09 13:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
920	user920	user920@user.com	\N	2011-02-22 12:21:20	\N	user	t	2011-04-08 12:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
921	user921	user921@user.com	\N	2011-02-21 11:20:20	2011-03-23 11:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
922	user922	user922@user.com	\N	2011-02-20 10:19:20	2011-03-22 10:19:20	user	t	2011-04-06 10:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
923	user923	user923@user.com	\N	2011-02-19 09:18:20	2011-03-21 09:18:20	user	t	2011-04-05 09:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
924	user924	user924@user.com	\N	2011-02-18 08:17:20	2011-03-20 08:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
925	user925	user925@user.com	\N	2011-02-17 07:16:20	\N	user	t	2011-04-03 07:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
926	user926	user926@user.com	\N	2011-02-16 06:15:20	2011-03-18 06:15:20	user	t	2011-04-02 06:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
927	user927	user927@user.com	\N	2011-02-15 05:14:20	2011-03-17 05:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
928	user928	user928@user.com	\N	2011-02-14 04:13:20	2011-03-16 04:13:20	user	t	2011-03-31 04:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
929	user929	user929@user.com	\N	2011-02-13 03:12:20	2011-03-15 03:12:20	user	t	2011-03-30 03:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
930	user930	user930@user.com	\N	2011-02-12 02:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
931	user931	user931@user.com	\N	2011-02-11 01:10:20	2011-03-13 01:10:20	user	t	2011-03-28 01:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
932	user932	user932@user.com	\N	2011-02-10 00:09:20	2011-03-12 00:09:20	user	t	2011-03-27 00:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
933	user933	user933@user.com	\N	2011-02-08 23:08:20	2011-03-10 23:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
934	user934	user934@user.com	\N	2011-02-07 22:07:20	2011-03-09 22:07:20	user	t	2011-03-24 22:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
935	user935	user935@user.com	\N	2011-02-06 21:06:20	\N	user	t	2011-03-23 21:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
936	user936	user936@user.com	\N	2011-02-05 20:05:20	2011-03-07 20:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
937	user937	user937@user.com	\N	2011-02-04 19:04:20	2011-03-06 19:04:20	user	t	2011-03-21 19:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
938	user938	user938@user.com	\N	2011-02-03 18:03:20	2011-03-05 18:03:20	user	t	2011-03-20 18:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
939	user939	user939@user.com	\N	2011-02-02 17:02:20	2011-03-04 17:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
940	user940	user940@user.com	\N	2011-02-01 16:01:20	\N	user	t	2011-03-18 16:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
941	user941	user941@user.com	\N	2011-01-31 15:00:20	2011-03-02 15:00:20	user	t	2011-03-17 15:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
942	user942	user942@user.com	\N	2011-01-30 13:59:20	2011-03-01 13:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
943	user943	user943@user.com	\N	2011-01-29 12:58:20	2011-02-28 12:58:20	user	t	2011-03-15 12:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
944	user944	user944@user.com	\N	2011-01-28 11:57:20	2011-02-27 11:57:20	user	t	2011-03-14 11:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
945	user945	user945@user.com	\N	2011-01-27 10:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
946	user946	user946@user.com	\N	2011-01-26 09:55:20	2011-02-25 09:55:20	user	t	2011-03-12 09:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
947	user947	user947@user.com	\N	2011-01-25 08:54:20	2011-02-24 08:54:20	user	t	2011-03-11 08:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
948	user948	user948@user.com	\N	2011-01-24 07:53:20	2011-02-23 07:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
949	user949	user949@user.com	\N	2011-01-23 06:52:20	2011-02-22 06:52:20	user	t	2011-03-09 06:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
950	user950	user950@user.com	\N	2011-01-22 05:51:20	\N	user	t	2011-03-08 05:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
951	user951	user951@user.com	\N	2011-01-21 04:50:20	2011-02-20 04:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
952	user952	user952@user.com	\N	2011-01-20 03:49:20	2011-02-19 03:49:20	user	t	2011-03-06 03:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
953	user953	user953@user.com	\N	2011-01-19 02:48:20	2011-02-18 02:48:20	user	t	2011-03-05 02:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
954	user954	user954@user.com	\N	2011-01-18 01:47:20	2011-02-17 01:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
955	user955	user955@user.com	\N	2011-01-17 00:46:20	\N	user	t	2011-03-03 00:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
956	user956	user956@user.com	\N	2011-01-15 23:45:20	2011-02-14 23:45:20	user	t	2011-03-01 23:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
957	user957	user957@user.com	\N	2011-01-14 22:44:20	2011-02-13 22:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
958	user958	user958@user.com	\N	2011-01-13 21:43:20	2011-02-12 21:43:20	user	t	2011-02-27 21:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
959	user959	user959@user.com	\N	2011-01-12 20:42:20	2011-02-11 20:42:20	user	t	2011-02-26 20:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
960	user960	user960@user.com	\N	2011-01-11 19:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
961	user961	user961@user.com	\N	2011-01-10 18:40:20	2011-02-09 18:40:20	user	t	2011-02-24 18:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
962	user962	user962@user.com	\N	2011-01-09 17:39:20	2011-02-08 17:39:20	user	t	2011-02-23 17:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
963	user963	user963@user.com	\N	2011-01-08 16:38:20	2011-02-07 16:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
964	user964	user964@user.com	\N	2011-01-07 15:37:20	2011-02-06 15:37:20	user	t	2011-02-21 15:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
965	user965	user965@user.com	\N	2011-01-06 14:36:20	\N	user	t	2011-02-20 14:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
966	user966	user966@user.com	\N	2011-01-05 13:35:20	2011-02-04 13:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
967	user967	user967@user.com	\N	2011-01-04 12:34:20	2011-02-03 12:34:20	user	t	2011-02-18 12:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
968	user968	user968@user.com	\N	2011-01-03 11:33:20	2011-02-02 11:33:20	user	t	2011-02-17 11:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
969	user969	user969@user.com	\N	2011-01-02 10:32:20	2011-02-01 10:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
970	user970	user970@user.com	\N	2011-01-01 09:31:20	\N	user	t	2011-02-15 09:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
971	user971	user971@user.com	\N	2010-12-31 08:30:20	2011-01-30 08:30:20	user	t	2011-02-14 08:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
972	user972	user972@user.com	\N	2010-12-30 07:29:20	2011-01-29 07:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
973	user973	user973@user.com	\N	2010-12-29 06:28:20	2011-01-28 06:28:20	user	t	2011-02-12 06:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
974	user974	user974@user.com	\N	2010-12-28 05:27:20	2011-01-27 05:27:20	user	t	2011-02-11 05:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
975	user975	user975@user.com	\N	2010-12-27 04:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
976	user976	user976@user.com	\N	2010-12-26 03:25:20	2011-01-25 03:25:20	user	t	2011-02-09 03:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
977	user977	user977@user.com	\N	2010-12-25 02:24:20	2011-01-24 02:24:20	user	t	2011-02-08 02:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
978	user978	user978@user.com	\N	2010-12-24 01:23:20	2011-01-23 01:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
979	user979	user979@user.com	\N	2010-12-23 00:22:20	2011-01-22 00:22:20	user	t	2011-02-06 00:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
980	user980	user980@user.com	\N	2010-12-21 23:21:20	\N	user	t	2011-02-04 23:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
981	user981	user981@user.com	\N	2010-12-20 22:20:20	2011-01-19 22:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
982	user982	user982@user.com	\N	2010-12-19 21:19:20	2011-01-18 21:19:20	user	t	2011-02-02 21:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
983	user983	user983@user.com	\N	2010-12-18 20:18:20	2011-01-17 20:18:20	user	t	2011-02-01 20:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
984	user984	user984@user.com	\N	2010-12-17 19:17:20	2011-01-16 19:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
985	user985	user985@user.com	\N	2010-12-16 18:16:20	\N	user	t	2011-01-30 18:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
986	user986	user986@user.com	\N	2010-12-15 17:15:20	2011-01-14 17:15:20	user	t	2011-01-29 17:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
987	user987	user987@user.com	\N	2010-12-14 16:14:20	2011-01-13 16:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
988	user988	user988@user.com	\N	2010-12-13 15:13:20	2011-01-12 15:13:20	user	t	2011-01-27 15:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
989	user989	user989@user.com	\N	2010-12-12 14:12:20	2011-01-11 14:12:20	user	t	2011-01-26 14:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
990	user990	user990@user.com	\N	2010-12-11 13:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
991	user991	user991@user.com	\N	2010-12-10 12:10:20	2011-01-09 12:10:20	user	t	2011-01-24 12:10:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
992	user992	user992@user.com	\N	2010-12-09 11:09:20	2011-01-08 11:09:20	user	t	2011-01-23 11:09:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
993	user993	user993@user.com	\N	2010-12-08 10:08:20	2011-01-07 10:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
994	user994	user994@user.com	\N	2010-12-07 09:07:20	2011-01-06 09:07:20	user	t	2011-01-21 09:07:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
995	user995	user995@user.com	\N	2010-12-06 08:06:20	\N	user	t	2011-01-20 08:06:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
996	user996	user996@user.com	\N	2010-12-05 07:05:20	2011-01-04 07:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
997	user997	user997@user.com	\N	2010-12-04 06:04:20	2011-01-03 06:04:20	user	t	2011-01-18 06:04:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
998	user998	user998@user.com	\N	2010-12-03 05:03:20	2011-01-02 05:03:20	user	t	2011-01-17 05:03:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
999	user999	user999@user.com	\N	2010-12-02 04:02:20	2011-01-01 04:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1000	user1000	user1000@user.com	\N	2010-12-01 03:01:20	\N	user	t	2011-01-15 03:01:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1001	user1001	user1001@user.com	\N	2010-11-30 02:00:20	2010-12-30 02:00:20	user	t	2011-01-14 02:00:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1002	user1002	user1002@user.com	\N	2010-11-29 00:59:20	2010-12-29 00:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1003	user1003	user1003@user.com	\N	2010-11-27 23:58:20	2010-12-27 23:58:20	user	t	2011-01-11 23:58:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1004	user1004	user1004@user.com	\N	2010-11-26 22:57:20	2010-12-26 22:57:20	user	t	2011-01-10 22:57:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1005	user1005	user1005@user.com	\N	2010-11-25 21:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1006	user1006	user1006@user.com	\N	2010-11-24 20:55:20	2010-12-24 20:55:20	user	t	2011-01-08 20:55:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1007	user1007	user1007@user.com	\N	2010-11-23 19:54:20	2010-12-23 19:54:20	user	t	2011-01-07 19:54:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1008	user1008	user1008@user.com	\N	2010-11-22 18:53:20	2010-12-22 18:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1009	user1009	user1009@user.com	\N	2010-11-21 17:52:20	2010-12-21 17:52:20	user	t	2011-01-05 17:52:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1010	user1010	user1010@user.com	\N	2010-11-20 16:51:20	\N	user	t	2011-01-04 16:51:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1011	user1011	user1011@user.com	\N	2010-11-19 15:50:20	2010-12-19 15:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1012	user1012	user1012@user.com	\N	2010-11-18 14:49:20	2010-12-18 14:49:20	user	t	2011-01-02 14:49:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1013	user1013	user1013@user.com	\N	2010-11-17 13:48:20	2010-12-17 13:48:20	user	t	2011-01-01 13:48:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1014	user1014	user1014@user.com	\N	2010-11-16 12:47:20	2010-12-16 12:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1015	user1015	user1015@user.com	\N	2010-11-15 11:46:20	\N	user	t	2010-12-30 11:46:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1016	user1016	user1016@user.com	\N	2010-11-14 10:45:20	2010-12-14 10:45:20	user	t	2010-12-29 10:45:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1017	user1017	user1017@user.com	\N	2010-11-13 09:44:20	2010-12-13 09:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1018	user1018	user1018@user.com	\N	2010-11-12 08:43:20	2010-12-12 08:43:20	user	t	2010-12-27 08:43:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1019	user1019	user1019@user.com	\N	2010-11-11 07:42:20	2010-12-11 07:42:20	user	t	2010-12-26 07:42:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1020	user1020	user1020@user.com	\N	2010-11-10 06:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1021	user1021	user1021@user.com	\N	2010-11-09 05:40:20	2010-12-09 05:40:20	user	t	2010-12-24 05:40:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1022	user1022	user1022@user.com	\N	2010-11-08 04:39:20	2010-12-08 04:39:20	user	t	2010-12-23 04:39:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1023	user1023	user1023@user.com	\N	2010-11-07 03:38:20	2010-12-07 03:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1024	user1024	user1024@user.com	\N	2010-11-06 02:37:20	2010-12-06 02:37:20	user	t	2010-12-21 02:37:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1025	user1025	user1025@user.com	\N	2010-11-05 01:36:20	\N	user	t	2010-12-20 01:36:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1026	user1026	user1026@user.com	\N	2010-11-04 00:35:20	2010-12-04 00:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1027	user1027	user1027@user.com	\N	2010-11-02 23:34:20	2010-12-02 23:34:20	user	t	2010-12-17 23:34:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1028	user1028	user1028@user.com	\N	2010-11-01 22:33:20	2010-12-01 22:33:20	user	t	2010-12-16 22:33:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1029	user1029	user1029@user.com	\N	2010-10-31 21:32:20	2010-11-30 21:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1030	user1030	user1030@user.com	\N	2010-10-30 20:31:20	\N	user	t	2010-12-14 20:31:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1031	user1031	user1031@user.com	\N	2010-10-29 19:30:20	2010-11-28 19:30:20	user	t	2010-12-13 19:30:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1032	user1032	user1032@user.com	\N	2010-10-28 18:29:20	2010-11-27 18:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1033	user1033	user1033@user.com	\N	2010-10-27 17:28:20	2010-11-26 17:28:20	user	t	2010-12-11 17:28:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1034	user1034	user1034@user.com	\N	2010-10-26 16:27:20	2010-11-25 16:27:20	user	t	2010-12-10 16:27:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1035	user1035	user1035@user.com	\N	2010-10-25 15:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1036	user1036	user1036@user.com	\N	2010-10-24 14:25:20	2010-11-23 14:25:20	user	t	2010-12-08 14:25:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1037	user1037	user1037@user.com	\N	2010-10-23 13:24:20	2010-11-22 13:24:20	user	t	2010-12-07 13:24:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1038	user1038	user1038@user.com	\N	2010-10-22 12:23:20	2010-11-21 12:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1039	user1039	user1039@user.com	\N	2010-10-21 11:22:20	2010-11-20 11:22:20	user	t	2010-12-05 11:22:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1040	user1040	user1040@user.com	\N	2010-10-20 10:21:20	\N	user	t	2010-12-04 10:21:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1041	user1041	user1041@user.com	\N	2010-10-19 09:20:20	2010-11-18 09:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1042	user1042	user1042@user.com	\N	2010-10-18 08:19:20	2010-11-17 08:19:20	user	t	2010-12-02 08:19:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1043	user1043	user1043@user.com	\N	2010-10-17 07:18:20	2010-11-16 07:18:20	user	t	2010-12-01 07:18:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1044	user1044	user1044@user.com	\N	2010-10-16 06:17:20	2010-11-15 06:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1045	user1045	user1045@user.com	\N	2010-10-15 05:16:20	\N	user	t	2010-11-29 05:16:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1046	user1046	user1046@user.com	\N	2010-10-14 04:15:20	2010-11-13 04:15:20	user	t	2010-11-28 04:15:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1047	user1047	user1047@user.com	\N	2010-10-13 03:14:20	2010-11-12 03:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1048	user1048	user1048@user.com	\N	2010-10-12 02:13:20	2010-11-11 02:13:20	user	t	2010-11-26 02:13:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1049	user1049	user1049@user.com	\N	2010-10-11 01:12:20	2010-11-10 01:12:20	user	t	2010-11-25 01:12:20	87dc1e131a1369fdf8f1c824a6a62dff	\N	\N	\N	\N
1	U_twitter_71662685	\N	\N	2013-10-07 14:40:22	2013-10-07 14:40:22	user	t	2013-10-07 14:40:22	\N	1.jpg	\N	\N	\N
\.


--
-- Data for Name: user_feed_external; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_feed_external (id, user_id, last_published_id, feed_external_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_place; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_place (id, user_id, name, cx, cy, cx_p_cy, cx_m_cy, created_at, updated_at, radius, permissions, is_spirit) FROM stdin;
1	2	My place 1 spirit	1	1	2	0	2013-10-07 12:43:38	\N	44	2	f
3	6	My place 3 spirit	10	30	40	-20	2013-10-07 12:44:22	\N	\N	2	f
5	12	My place 5 spirit	1000	3000	4000	-2000	2013-10-07 12:44:38	\N	\N	2	f
2	4	My place 2 spirit	1	2	3	-1	2013-10-07 12:44:02	\N	\N	2	t
8	4	Place for user 4	68	-12	56	80	2013-10-08 11:58:14	\N	48	6	f
9	5	Place for user 5	80	87	167	-7	2013-10-08 11:58:14	2013-11-02 06:53:14	29	6	f
10	7	Place for user 7	-47	78	31	-125	2013-10-08 11:58:14	2013-10-31 04:51:14	28	6	f
4	8	My place 4 spirit	100	300	400	-200	2013-10-07 12:44:31	\N	\N	2	t
11	8	Place for user 8	71	91	162	-20	2013-10-08 11:58:14	\N	26	6	f
12	10	Place for user 10	23	0	23	23	2013-10-08 11:58:14	2013-10-28 01:48:14	39	6	f
13	11	Place for user 11	5	38	43	-33	2013-10-08 11:58:15	2013-10-27 00:47:15	36	6	f
14	13	Place for user 13	7	19	26	-12	2013-10-08 11:58:15	2013-10-24 22:45:15	43	6	f
6	14	My place 6 spirit	10000	30000	40000	-20000	2013-10-07 12:44:43	\N	\N	2	t
15	14	Place for user 14	-7	95	88	-102	2013-10-08 11:58:15	2013-10-23 21:44:15	49	6	f
7	16	My place 7 spirit	100000	300000	400000	-200000	2013-10-07 12:44:48	\N	\N	2	t
16	16	Place for user 16	37	-10	27	47	2013-10-08 11:58:15	\N	28	6	f
17	17	Place for user 17	61	-7	54	68	2013-10-08 11:58:15	2013-10-20 18:41:15	31	6	f
18	19	Place for user 19	49	49	98	0	2013-10-08 11:58:15	2013-10-18 16:39:15	34	6	f
19	20	Place for user 20	59	3	62	56	2013-10-08 11:58:15	\N	34	6	f
20	22	Place for user 22	60	10	70	50	2013-10-08 11:58:15	2013-10-15 13:36:15	41	6	f
21	23	Place for user 23	-19	-43	-62	24	2013-10-08 11:58:15	2013-10-14 12:35:15	30	6	f
22	25	Place for user 25	-12	92	80	-104	2013-10-08 11:58:15	2013-10-12 10:33:15	39	6	f
23	26	Place for user 26	51	14	65	37	2013-10-08 11:58:15	2013-10-11 09:32:15	21	6	f
24	28	Place for user 28	45	75	120	-30	2013-10-08 11:58:15	\N	21	6	f
25	29	Place for user 29	-27	-21	-48	-6	2013-10-08 11:58:15	2013-10-08 06:29:15	43	6	f
26	31	Place for user 31	51	62	113	-11	2013-10-08 11:58:15	2013-10-06 04:27:15	36	6	f
27	32	Place for user 32	93	-43	50	136	2013-10-08 11:58:15	\N	23	6	f
28	34	Place for user 34	-50	54	4	-104	2013-10-08 11:58:15	2013-10-03 01:24:15	28	6	f
29	35	Place for user 35	-45	58	13	-103	2013-10-08 11:58:16	2013-10-02 00:23:15	23	6	f
30	37	Place for user 37	-44	29	-15	-73	2013-10-08 11:58:16	2013-09-29 22:21:16	34	6	f
31	38	Place for user 38	25	91	116	-66	2013-10-08 11:58:16	2013-09-28 21:20:16	36	6	f
32	40	Place for user 40	83	25	108	58	2013-10-08 11:58:16	\N	38	6	f
33	41	Place for user 41	-14	18	4	-32	2013-10-08 11:58:16	2013-09-25 18:17:16	26	6	f
34	43	Place for user 43	75	47	122	28	2013-10-08 11:58:16	2013-09-23 16:15:16	24	6	f
35	44	Place for user 44	10	61	71	-51	2013-10-08 11:58:16	\N	25	6	f
36	46	Place for user 46	65	57	122	8	2013-10-08 11:58:16	2013-09-20 13:12:16	32	6	f
37	47	Place for user 47	89	64	153	25	2013-10-08 11:58:16	2013-09-19 12:11:16	28	6	f
38	49	Place for user 49	8	41	49	-33	2013-10-08 11:58:16	2013-09-17 10:09:16	36	6	f
39	50	Place for user 50	-46	-34	-80	-12	2013-10-08 11:58:16	2013-09-16 09:08:16	43	6	f
40	52	Place for user 52	69	57	126	12	2013-10-08 11:58:16	\N	29	6	f
41	53	Place for user 53	-24	-36	-60	12	2013-10-08 11:58:16	2013-09-13 06:05:16	40	6	f
42	55	Place for user 55	52	78	130	-26	2013-10-08 11:58:16	2013-09-11 04:03:16	39	6	f
43	56	Place for user 56	71	75	146	-4	2013-10-08 11:58:16	\N	21	6	f
44	58	Place for user 58	76	66	142	10	2013-10-08 11:58:16	2013-09-08 01:00:16	49	6	f
45	59	Place for user 59	42	76	118	-34	2013-10-08 11:58:16	2013-09-06 23:59:16	34	6	f
46	61	Place for user 61	14	-2	12	16	2013-10-08 11:58:16	2013-09-04 21:57:16	29	6	f
47	62	Place for user 62	-9	29	20	-38	2013-10-08 11:58:17	2013-09-03 20:56:16	21	6	f
48	64	Place for user 64	22	28	50	-6	2013-10-08 11:58:17	\N	48	6	f
49	65	Place for user 65	98	0	98	98	2013-10-08 11:58:17	2013-08-31 17:53:17	28	6	f
50	67	Place for user 67	32	27	59	5	2013-10-08 11:58:17	2013-08-29 15:51:17	43	6	f
51	68	Place for user 68	71	13	84	58	2013-10-08 11:58:17	\N	30	6	f
52	70	Place for user 70	12	-49	-37	61	2013-10-08 11:58:17	2013-08-26 12:48:17	38	6	f
53	71	Place for user 71	17	-46	-29	63	2013-10-08 11:58:17	2013-08-25 11:47:17	21	6	f
54	73	Place for user 73	13	55	68	-42	2013-10-08 11:58:18	2013-08-23 09:45:17	45	6	f
55	74	Place for user 74	74	-6	68	80	2013-10-08 11:58:18	2013-08-22 08:44:18	46	6	f
56	76	Place for user 76	-26	53	27	-79	2013-10-08 11:58:18	\N	41	6	f
57	77	Place for user 77	85	-35	50	120	2013-10-08 11:58:18	2013-08-19 05:41:18	41	6	f
58	79	Place for user 79	22	44	66	-22	2013-10-08 11:58:18	2013-08-17 03:39:18	44	6	f
59	80	Place for user 80	70	21	91	49	2013-10-08 11:58:18	\N	35	6	f
60	82	Place for user 82	90	-23	67	113	2013-10-08 11:58:18	2013-08-14 00:36:18	46	6	f
61	83	Place for user 83	-6	-12	-18	6	2013-10-08 11:58:18	2013-08-12 23:35:18	45	6	f
62	85	Place for user 85	11	37	48	-26	2013-10-08 11:58:18	2013-08-10 21:33:18	33	6	f
63	86	Place for user 86	-17	-19	-36	2	2013-10-08 11:58:18	2013-08-09 20:32:18	20	6	f
64	88	Place for user 88	1	42	43	-41	2013-10-08 11:58:18	\N	32	6	f
65	89	Place for user 89	-6	35	29	-41	2013-10-08 11:58:18	2013-08-06 17:29:18	49	6	f
66	91	Place for user 91	-37	0	-37	-37	2013-10-08 11:58:18	2013-08-04 15:27:18	24	6	f
67	92	Place for user 92	65	67	132	-2	2013-10-08 11:58:19	\N	32	6	f
68	94	Place for user 94	-33	100	67	-133	2013-10-08 11:58:19	2013-08-01 12:24:19	40	6	f
69	95	Place for user 95	-21	-15	-36	-6	2013-10-08 11:58:19	2013-07-31 11:23:19	35	6	f
70	97	Place for user 97	25	16	41	9	2013-10-08 11:58:19	2013-07-29 09:21:19	45	6	f
71	98	Place for user 98	82	94	176	-12	2013-10-08 11:58:19	2013-07-28 08:20:19	42	6	f
72	100	Place for user 100	-4	92	88	-96	2013-10-08 11:58:19	\N	45	6	f
73	101	Place for user 101	9	55	64	-46	2013-10-08 11:58:19	2013-07-25 05:17:19	39	6	f
74	103	Place for user 103	36	-37	-1	73	2013-10-08 11:58:19	2013-07-23 03:15:19	23	6	f
75	104	Place for user 104	-33	-28	-61	-5	2013-10-08 11:58:19	\N	44	6	f
76	106	Place for user 106	42	24	66	18	2013-10-08 11:58:19	2013-07-20 00:12:19	29	6	f
77	107	Place for user 107	73	16	89	57	2013-10-08 11:58:19	2013-07-18 23:11:19	36	6	f
78	109	Place for user 109	-34	56	22	-90	2013-10-08 11:58:19	2013-07-16 21:09:19	39	6	f
79	110	Place for user 110	24	-15	9	39	2013-10-08 11:58:19	2013-07-15 20:08:19	39	6	f
80	112	Place for user 112	99	14	113	85	2013-10-08 11:58:19	\N	22	6	f
81	113	Place for user 113	35	99	134	-64	2013-10-08 11:58:19	2013-07-12 17:05:19	26	6	f
82	115	Place for user 115	49	27	76	22	2013-10-08 11:58:19	2013-07-10 15:03:19	22	6	f
83	116	Place for user 116	-39	48	9	-87	2013-10-08 11:58:19	\N	34	6	f
84	118	Place for user 118	79	85	164	-6	2013-10-08 11:58:19	2013-07-07 12:00:19	34	6	f
85	119	Place for user 119	88	-8	80	96	2013-10-08 11:58:20	2013-07-06 10:59:20	41	6	f
86	121	Place for user 121	21	45	66	-24	2013-10-08 11:58:20	2013-07-04 08:57:20	42	6	f
87	122	Place for user 122	56	-7	49	63	2013-10-08 11:58:20	2013-07-03 07:56:20	39	6	f
88	124	Place for user 124	38	-3	35	41	2013-10-08 11:58:20	\N	33	6	f
89	125	Place for user 125	7	-2	5	9	2013-10-08 11:58:20	2013-06-30 04:53:20	35	6	f
90	127	Place for user 127	52	-10	42	62	2013-10-08 11:58:20	2013-06-28 02:51:20	30	6	f
91	128	Place for user 128	44	31	75	13	2013-10-08 11:58:20	\N	24	6	f
92	130	Place for user 130	-11	73	62	-84	2013-10-08 11:58:20	2013-06-24 23:48:20	49	6	f
93	131	Place for user 131	47	-26	21	73	2013-10-08 11:58:20	2013-06-23 22:47:20	32	6	f
94	133	Place for user 133	100	31	131	69	2013-10-08 11:58:20	2013-06-21 20:45:20	45	6	f
95	134	Place for user 134	52	14	66	38	2013-10-08 11:58:20	2013-06-20 19:44:20	47	6	f
96	136	Place for user 136	32	31	63	1	2013-10-08 11:58:20	\N	47	6	f
97	137	Place for user 137	-18	-37	-55	19	2013-10-08 11:58:20	2013-06-17 16:41:20	21	6	f
98	139	Place for user 139	74	-33	41	107	2013-10-08 11:58:20	2013-06-15 14:39:20	43	6	f
99	140	Place for user 140	37	69	106	-32	2013-10-08 11:58:20	\N	26	6	f
100	142	Place for user 142	39	-4	35	43	2013-10-08 11:58:20	2013-06-12 11:36:20	27	6	f
101	143	Place for user 143	-21	-38	-59	17	2013-10-08 11:58:20	2013-06-11 10:35:20	42	6	f
102	145	Place for user 145	99	-12	87	111	2013-10-08 11:58:20	2013-06-09 08:33:20	44	6	f
103	146	Place for user 146	47	70	117	-23	2013-10-08 11:58:21	2013-06-08 07:32:20	35	6	f
104	148	Place for user 148	7	-45	-38	52	2013-10-08 11:58:21	\N	35	6	f
105	149	Place for user 149	100	-5	95	105	2013-10-08 11:58:21	2013-06-05 04:29:21	26	6	f
106	151	Place for user 151	36	46	82	-10	2013-10-08 11:58:21	2013-06-03 02:27:21	41	6	f
107	152	Place for user 152	16	63	79	-47	2013-10-08 11:58:21	\N	44	6	f
108	154	Place for user 154	96	-33	63	129	2013-10-08 11:58:21	2013-05-30 23:24:21	42	6	f
109	155	Place for user 155	70	87	157	-17	2013-10-08 11:58:21	2013-05-29 22:23:21	26	6	f
110	157	Place for user 157	6	-15	-9	21	2013-10-08 11:58:21	2013-05-27 20:21:21	45	6	f
111	158	Place for user 158	-45	-7	-52	-38	2013-10-08 11:58:21	2013-05-26 19:20:21	37	6	f
112	160	Place for user 160	99	-33	66	132	2013-10-08 11:58:21	\N	28	6	f
113	161	Place for user 161	41	60	101	-19	2013-10-08 11:58:21	2013-05-23 16:17:21	25	6	f
114	163	Place for user 163	-35	35	0	-70	2013-10-08 11:58:21	2013-05-21 14:15:21	23	6	f
115	164	Place for user 164	65	15	80	50	2013-10-08 11:58:21	\N	25	6	f
116	166	Place for user 166	44	54	98	-10	2013-10-08 11:58:21	2013-05-18 11:12:21	29	6	f
117	167	Place for user 167	38	-46	-8	84	2013-10-08 11:58:21	2013-05-17 10:11:21	46	6	f
118	169	Place for user 169	-23	92	69	-115	2013-10-08 11:58:21	2013-05-15 08:09:21	28	6	f
119	170	Place for user 170	-36	25	-11	-61	2013-10-08 11:58:21	2013-05-14 07:08:21	48	6	f
120	172	Place for user 172	3	17	20	-14	2013-10-08 11:58:22	\N	22	6	f
121	173	Place for user 173	-25	89	64	-114	2013-10-08 11:58:22	2013-05-11 04:05:22	38	6	f
122	175	Place for user 175	-40	87	47	-127	2013-10-08 11:58:22	2013-05-09 02:03:22	26	6	f
123	176	Place for user 176	69	-18	51	87	2013-10-08 11:58:22	\N	37	6	f
124	178	Place for user 178	-8	74	66	-82	2013-10-08 11:58:22	2013-05-05 23:00:22	29	6	f
125	179	Place for user 179	88	-31	57	119	2013-10-08 11:58:22	2013-05-04 21:59:22	29	6	f
126	181	Place for user 181	53	39	92	14	2013-10-08 11:58:22	2013-05-02 19:57:22	41	6	f
127	182	Place for user 182	-7	63	56	-70	2013-10-08 11:58:22	2013-05-01 18:56:22	48	6	f
128	184	Place for user 184	58	10	68	48	2013-10-08 11:58:22	\N	44	6	f
129	185	Place for user 185	76	-47	29	123	2013-10-08 11:58:22	2013-04-28 15:53:22	22	6	f
130	187	Place for user 187	-25	-16	-41	-9	2013-10-08 11:58:22	2013-04-26 13:51:22	24	6	f
131	190	Place for user 190	79	83	162	-4	2013-10-08 11:58:22	2013-04-23 10:48:22	38	6	f
132	191	Place for user 191	80	-5	75	85	2013-10-08 11:58:22	2013-04-22 09:47:22	32	6	f
133	193	Place for user 193	-21	33	12	-54	2013-10-08 11:58:22	2013-04-20 07:45:22	22	6	f
134	194	Place for user 194	-23	-16	-39	-7	2013-10-08 11:58:22	2013-04-19 06:44:22	34	6	f
135	196	Place for user 196	-35	0	-35	-35	2013-10-08 11:58:23	\N	24	6	f
136	197	Place for user 197	-30	54	24	-84	2013-10-08 11:58:23	2013-04-16 03:41:23	23	6	f
137	199	Place for user 199	-17	23	6	-40	2013-10-08 11:58:23	2013-04-14 01:39:23	28	6	f
138	200	Place for user 200	65	51	116	14	2013-10-08 11:58:23	\N	31	6	f
139	202	Place for user 202	75	13	88	62	2013-10-08 11:58:23	2013-04-10 22:36:23	26	6	f
140	203	Place for user 203	-21	96	75	-117	2013-10-08 11:58:23	2013-04-09 21:35:23	20	6	f
141	205	Place for user 205	-41	31	-10	-72	2013-10-08 11:58:23	2013-04-07 19:33:23	47	6	f
142	206	Place for user 206	-18	-32	-50	14	2013-10-08 11:58:23	2013-04-06 18:32:23	23	6	f
143	208	Place for user 208	41	93	134	-52	2013-10-08 11:58:23	\N	33	6	f
144	209	Place for user 209	13	86	99	-73	2013-10-08 11:58:23	2013-04-03 15:29:23	27	6	f
145	211	Place for user 211	-50	-38	-88	-12	2013-10-08 11:58:23	2013-04-01 13:27:23	28	6	f
146	212	Place for user 212	-5	90	85	-95	2013-10-08 11:58:23	\N	39	6	f
147	214	Place for user 214	3	-48	-45	51	2013-10-08 11:58:23	2013-03-29 10:24:23	20	6	f
148	215	Place for user 215	84	31	115	53	2013-10-08 11:58:23	2013-03-28 09:23:23	23	6	f
149	217	Place for user 217	-46	65	19	-111	2013-10-08 11:58:23	2013-03-26 07:21:23	21	6	f
150	218	Place for user 218	27	-31	-4	58	2013-10-08 11:58:23	2013-03-25 06:20:23	27	6	f
151	220	Place for user 220	60	-6	54	66	2013-10-08 11:58:23	\N	22	6	f
152	221	Place for user 221	79	26	105	53	2013-10-08 11:58:24	2013-03-22 03:17:23	45	6	f
153	223	Place for user 223	96	10	106	86	2013-10-08 11:58:24	2013-03-20 01:15:24	43	6	f
154	224	Place for user 224	17	70	87	-53	2013-10-08 11:58:24	\N	27	6	f
155	226	Place for user 226	22	-26	-4	48	2013-10-08 11:58:24	2013-03-16 22:12:24	39	6	f
156	227	Place for user 227	97	-39	58	136	2013-10-08 11:58:24	2013-03-15 21:11:24	32	6	f
157	229	Place for user 229	-9	51	42	-60	2013-10-08 11:58:24	2013-03-13 19:09:24	47	6	f
158	230	Place for user 230	88	76	164	12	2013-10-08 11:58:24	2013-03-12 18:08:24	28	6	f
159	232	Place for user 232	84	94	178	-10	2013-10-08 11:58:24	\N	41	6	f
160	233	Place for user 233	20	26	46	-6	2013-10-08 11:58:24	2013-03-09 15:05:24	21	6	f
161	235	Place for user 235	68	70	138	-2	2013-10-08 11:58:24	2013-03-07 13:03:24	23	6	f
162	236	Place for user 236	-35	68	33	-103	2013-10-08 11:58:24	\N	29	6	f
163	238	Place for user 238	38	53	91	-15	2013-10-08 11:58:24	2013-03-04 10:00:24	42	6	f
164	239	Place for user 239	87	88	175	-1	2013-10-08 11:58:24	2013-03-03 08:59:24	33	6	f
165	241	Place for user 241	98	-15	83	113	2013-10-08 11:58:24	2013-03-01 06:57:24	42	6	f
166	242	Place for user 242	95	34	129	61	2013-10-08 11:58:24	2013-02-28 05:56:24	20	6	f
167	244	Place for user 244	24	-7	17	31	2013-10-08 11:58:25	\N	42	6	f
168	245	Place for user 245	-22	55	33	-77	2013-10-08 11:58:25	2013-02-25 02:53:25	48	6	f
169	247	Place for user 247	8	-28	-20	36	2013-10-08 11:58:25	2013-02-23 00:51:25	32	6	f
170	248	Place for user 248	46	98	144	-52	2013-10-08 11:58:25	\N	39	6	f
171	250	Place for user 250	81	-34	47	115	2013-10-08 11:58:25	2013-02-19 21:48:25	45	6	f
172	251	Place for user 251	39	-49	-10	88	2013-10-08 11:58:25	2013-02-18 20:47:25	22	6	f
173	253	Place for user 253	-11	97	86	-108	2013-10-08 11:58:25	2013-02-16 18:45:25	21	6	f
174	254	Place for user 254	63	52	115	11	2013-10-08 11:58:25	2013-02-15 17:44:25	35	6	f
175	256	Place for user 256	19	-19	0	38	2013-10-08 11:58:25	\N	47	6	f
176	257	Place for user 257	74	-47	27	121	2013-10-08 11:58:25	2013-02-12 14:41:25	40	6	f
177	259	Place for user 259	30	92	122	-62	2013-10-08 11:58:25	2013-02-10 12:39:25	39	6	f
178	260	Place for user 260	-35	76	41	-111	2013-10-08 11:58:25	\N	23	6	f
179	262	Place for user 262	-47	-4	-51	-43	2013-10-08 11:58:25	2013-02-07 09:36:25	49	6	f
180	263	Place for user 263	47	64	111	-17	2013-10-08 11:58:25	2013-02-06 08:35:25	36	6	f
181	265	Place for user 265	61	53	114	8	2013-10-08 11:58:25	2013-02-04 06:33:25	30	6	f
182	266	Place for user 266	-19	56	37	-75	2013-10-08 11:58:25	2013-02-03 05:32:25	21	6	f
183	268	Place for user 268	87	93	180	-6	2013-10-08 11:58:25	\N	42	6	f
184	269	Place for user 269	33	48	81	-15	2013-10-08 11:58:25	2013-01-31 02:29:25	26	6	f
185	271	Place for user 271	33	8	41	25	2013-10-08 11:58:25	2013-01-29 00:27:25	48	6	f
186	272	Place for user 272	74	-12	62	86	2013-10-08 11:58:26	\N	34	6	f
187	274	Place for user 274	32	43	75	-11	2013-10-08 11:58:26	2013-01-25 21:24:26	43	6	f
188	275	Place for user 275	75	80	155	-5	2013-10-08 11:58:26	2013-01-24 20:23:26	46	6	f
189	277	Place for user 277	-31	59	28	-90	2013-10-08 11:58:26	2013-01-22 18:21:26	47	6	f
190	278	Place for user 278	37	52	89	-15	2013-10-08 11:58:26	2013-01-21 17:20:26	48	6	f
191	280	Place for user 280	90	-24	66	114	2013-10-08 11:58:26	\N	25	6	f
192	281	Place for user 281	-37	22	-15	-59	2013-10-08 11:58:26	2013-01-18 14:17:26	40	6	f
193	283	Place for user 283	14	-15	-1	29	2013-10-08 11:58:26	2013-01-16 12:15:26	32	6	f
194	284	Place for user 284	21	-24	-3	45	2013-10-08 11:58:26	\N	43	6	f
195	286	Place for user 286	54	-42	12	96	2013-10-08 11:58:26	2013-01-13 09:12:26	23	6	f
196	287	Place for user 287	37	5	42	32	2013-10-08 11:58:26	2013-01-12 08:11:26	44	6	f
197	289	Place for user 289	37	40	77	-3	2013-10-08 11:58:26	2013-01-10 06:09:26	35	6	f
198	290	Place for user 290	-29	96	67	-125	2013-10-08 11:58:26	2013-01-09 05:08:26	33	6	f
199	292	Place for user 292	-26	83	57	-109	2013-10-08 11:58:26	\N	30	6	f
200	293	Place for user 293	15	-18	-3	33	2013-10-08 11:58:26	2013-01-06 02:05:26	39	6	f
201	295	Place for user 295	-36	54	18	-90	2013-10-08 11:58:26	2013-01-04 00:03:26	27	6	f
202	296	Place for user 296	-23	34	11	-57	2013-10-08 11:58:26	\N	37	6	f
203	298	Place for user 298	3	60	63	-57	2013-10-08 11:58:26	2012-12-31 21:00:26	32	6	f
204	299	Place for user 299	82	23	105	59	2013-10-08 11:58:27	2012-12-30 19:59:27	25	6	f
205	301	Place for user 301	69	45	114	24	2013-10-08 11:58:27	2012-12-28 17:57:27	42	6	f
206	302	Place for user 302	-18	-13	-31	-5	2013-10-08 11:58:27	2012-12-27 16:56:27	41	6	f
207	304	Place for user 304	40	43	83	-3	2013-10-08 11:58:27	\N	47	6	f
208	305	Place for user 305	-38	52	14	-90	2013-10-08 11:58:27	2012-12-24 13:53:27	26	6	f
209	307	Place for user 307	35	-44	-9	79	2013-10-08 11:58:27	2012-12-22 11:51:27	47	6	f
210	308	Place for user 308	-16	23	7	-39	2013-10-08 11:58:27	\N	42	6	f
211	310	Place for user 310	35	-9	26	44	2013-10-08 11:58:27	2012-12-19 08:48:27	28	6	f
212	311	Place for user 311	55	31	86	24	2013-10-08 11:58:27	2012-12-18 07:47:27	31	6	f
213	313	Place for user 313	-12	-39	-51	27	2013-10-08 11:58:27	2012-12-16 05:45:27	22	6	f
214	314	Place for user 314	-11	99	88	-110	2013-10-08 11:58:27	2012-12-15 04:44:27	26	6	f
215	316	Place for user 316	8	8	16	0	2013-10-08 11:58:27	\N	37	6	f
216	317	Place for user 317	14	48	62	-34	2013-10-08 11:58:27	2012-12-12 01:41:27	33	6	f
217	319	Place for user 319	-14	1	-13	-15	2013-10-08 11:58:27	2012-12-09 23:39:27	48	6	f
218	320	Place for user 320	76	52	128	24	2013-10-08 11:58:27	\N	29	6	f
219	322	Place for user 322	85	22	107	63	2013-10-08 11:58:27	2012-12-06 20:36:27	43	6	f
220	323	Place for user 323	-39	-4	-43	-35	2013-10-08 11:58:28	2012-12-05 19:35:27	21	6	f
221	325	Place for user 325	30	73	103	-43	2013-10-08 11:58:28	2012-12-03 17:33:28	46	6	f
222	326	Place for user 326	-6	36	30	-42	2013-10-08 11:58:28	2012-12-02 16:32:28	20	6	f
223	328	Place for user 328	59	25	84	34	2013-10-08 11:58:28	\N	28	6	f
224	329	Place for user 329	69	22	91	47	2013-10-08 11:58:28	2012-11-29 13:29:28	22	6	f
225	331	Place for user 331	15	19	34	-4	2013-10-08 11:58:28	2012-11-27 11:27:28	35	6	f
226	332	Place for user 332	13	-46	-33	59	2013-10-08 11:58:28	\N	43	6	f
227	334	Place for user 334	-11	60	49	-71	2013-10-08 11:58:28	2012-11-24 08:24:28	21	6	f
228	335	Place for user 335	62	15	77	47	2013-10-08 11:58:28	2012-11-23 07:23:28	27	6	f
229	337	Place for user 337	-21	62	41	-83	2013-10-08 11:58:29	2012-11-21 05:21:28	23	6	f
230	338	Place for user 338	97	-41	56	138	2013-10-08 11:58:29	2012-11-20 04:20:29	33	6	f
231	340	Place for user 340	-4	-50	-54	46	2013-10-08 11:58:29	\N	26	6	f
232	341	Place for user 341	-28	-37	-65	9	2013-10-08 11:58:29	2012-11-17 01:17:29	32	6	f
233	343	Place for user 343	34	-27	7	61	2013-10-08 11:58:29	2012-11-14 23:15:29	41	6	f
234	344	Place for user 344	22	-17	5	39	2013-10-08 11:58:29	\N	22	6	f
235	346	Place for user 346	-25	-32	-57	7	2013-10-08 11:58:29	2012-11-11 20:12:29	20	6	f
236	347	Place for user 347	-29	32	3	-61	2013-10-08 11:58:29	2012-11-10 19:11:29	28	6	f
237	349	Place for user 349	24	55	79	-31	2013-10-08 11:58:29	2012-11-08 17:09:29	38	6	f
238	350	Place for user 350	-21	66	45	-87	2013-10-08 11:58:29	2012-11-07 16:08:29	45	6	f
239	352	Place for user 352	17	66	83	-49	2013-10-08 11:58:29	\N	37	6	f
240	353	Place for user 353	53	-46	7	99	2013-10-08 11:58:29	2012-11-04 13:05:29	22	6	f
241	355	Place for user 355	51	85	136	-34	2013-10-08 11:58:29	2012-11-02 11:03:29	42	6	f
242	356	Place for user 356	70	7	77	63	2013-10-08 11:58:29	\N	30	6	f
243	358	Place for user 358	-43	96	53	-139	2013-10-08 11:58:30	2012-10-30 08:00:29	31	6	f
244	359	Place for user 359	22	3	25	19	2013-10-08 11:58:30	2012-10-29 06:59:30	35	6	f
245	361	Place for user 361	29	-39	-10	68	2013-10-08 11:58:30	2012-10-27 04:57:30	40	6	f
246	362	Place for user 362	82	-41	41	123	2013-10-08 11:58:30	2012-10-26 03:56:30	48	6	f
247	364	Place for user 364	79	11	90	68	2013-10-08 11:58:30	\N	39	6	f
248	365	Place for user 365	20	-1	19	21	2013-10-08 11:58:30	2012-10-23 00:53:30	29	6	f
249	367	Place for user 367	-12	20	8	-32	2013-10-08 11:58:30	2012-10-20 22:51:30	30	6	f
250	368	Place for user 368	52	-28	24	80	2013-10-08 11:58:30	\N	22	6	f
251	370	Place for user 370	97	-7	90	104	2013-10-08 11:58:30	2012-10-17 19:48:30	26	6	f
252	371	Place for user 371	-24	-29	-53	5	2013-10-08 11:58:30	2012-10-16 18:47:30	44	6	f
253	373	Place for user 373	23	41	64	-18	2013-10-08 11:58:30	2012-10-14 16:45:30	34	6	f
254	374	Place for user 374	84	-46	38	130	2013-10-08 11:58:30	2012-10-13 15:44:30	42	6	f
255	376	Place for user 376	91	89	180	2	2013-10-08 11:58:30	\N	35	6	f
256	379	Place for user 379	88	31	119	57	2013-10-08 11:58:30	2012-10-08 10:39:30	29	6	f
257	380	Place for user 380	-50	-45	-95	-5	2013-10-08 11:58:30	\N	35	6	f
258	382	Place for user 382	75	95	170	-20	2013-10-08 11:58:31	2012-10-05 07:36:30	25	6	f
259	383	Place for user 383	9	92	101	-83	2013-10-08 11:58:31	2012-10-04 06:35:31	35	6	f
260	385	Place for user 385	14	-12	2	26	2013-10-08 11:58:31	2012-10-02 04:33:31	20	6	f
261	386	Place for user 386	-28	-48	-76	20	2013-10-08 11:58:31	2012-10-01 03:32:31	49	6	f
262	388	Place for user 388	31	-16	15	47	2013-10-08 11:58:31	\N	49	6	f
263	389	Place for user 389	23	92	115	-69	2013-10-08 11:58:31	2012-09-28 00:29:31	46	6	f
264	391	Place for user 391	2	-42	-40	44	2013-10-08 11:58:31	2012-09-25 22:27:31	21	6	f
265	392	Place for user 392	30	90	120	-60	2013-10-08 11:58:31	\N	39	6	f
266	394	Place for user 394	-29	45	16	-74	2013-10-08 11:58:31	2012-09-22 19:24:31	46	6	f
267	395	Place for user 395	-40	-2	-42	-38	2013-10-08 11:58:31	2012-09-21 18:23:31	20	6	f
268	397	Place for user 397	84	-44	40	128	2013-10-08 11:58:31	2012-09-19 16:21:31	21	6	f
269	398	Place for user 398	67	28	95	39	2013-10-08 11:58:31	2012-09-18 15:20:31	38	6	f
270	400	Place for user 400	25	32	57	-7	2013-10-08 11:58:31	\N	32	6	f
271	401	Place for user 401	-15	98	83	-113	2013-10-08 11:58:31	2012-09-15 12:17:31	37	6	f
272	403	Place for user 403	-25	10	-15	-35	2013-10-08 11:58:31	2012-09-13 10:15:31	49	6	f
273	404	Place for user 404	20	-47	-27	67	2013-10-08 11:58:31	\N	39	6	f
274	406	Place for user 406	43	12	55	31	2013-10-08 11:58:31	2012-09-10 07:12:31	48	6	f
275	407	Place for user 407	38	24	62	14	2013-10-08 11:58:31	2012-09-09 06:11:31	30	6	f
276	409	Place for user 409	85	20	105	65	2013-10-08 11:58:31	2012-09-07 04:09:31	42	6	f
277	410	Place for user 410	21	62	83	-41	2013-10-08 11:58:32	2012-09-06 03:08:32	28	6	f
278	412	Place for user 412	-29	-45	-74	16	2013-10-08 11:58:32	\N	33	6	f
279	413	Place for user 413	-22	21	-1	-43	2013-10-08 11:58:32	2012-09-03 00:05:32	25	6	f
280	415	Place for user 415	-45	71	26	-116	2013-10-08 11:58:32	2012-08-31 22:03:32	28	6	f
281	416	Place for user 416	89	-20	69	109	2013-10-08 11:58:32	\N	26	6	f
282	418	Place for user 418	22	-19	3	41	2013-10-08 11:58:32	2012-08-28 19:00:32	38	6	f
283	419	Place for user 419	73	94	167	-21	2013-10-08 11:58:32	2012-08-27 17:59:32	32	6	f
284	421	Place for user 421	-8	68	60	-76	2013-10-08 11:58:32	2012-08-25 15:57:32	44	6	f
285	422	Place for user 422	-49	-48	-97	-1	2013-10-08 11:58:32	2012-08-24 14:56:32	32	6	f
286	424	Place for user 424	51	77	128	-26	2013-10-08 11:58:32	\N	25	6	f
287	425	Place for user 425	50	37	87	13	2013-10-08 11:58:32	2012-08-21 11:53:32	20	6	f
288	427	Place for user 427	47	-17	30	64	2013-10-08 11:58:32	2012-08-19 09:51:32	34	6	f
289	428	Place for user 428	8	-20	-12	28	2013-10-08 11:58:32	\N	29	6	f
290	430	Place for user 430	48	-28	20	76	2013-10-08 11:58:32	2012-08-16 06:48:32	26	6	f
291	431	Place for user 431	51	25	76	26	2013-10-08 11:58:32	2012-08-15 05:47:32	23	6	f
292	433	Place for user 433	-15	17	2	-32	2013-10-08 11:58:32	2012-08-13 03:45:32	40	6	f
293	434	Place for user 434	26	98	124	-72	2013-10-08 11:58:32	2012-08-12 02:44:32	30	6	f
294	436	Place for user 436	-43	3	-40	-46	2013-10-08 11:58:32	\N	45	6	f
295	437	Place for user 437	35	35	70	0	2013-10-08 11:58:33	2012-08-08 23:41:32	25	6	f
296	439	Place for user 439	-7	-19	-26	12	2013-10-08 11:58:33	2012-08-06 21:39:33	22	6	f
297	440	Place for user 440	-7	30	23	-37	2013-10-08 11:58:33	\N	27	6	f
298	442	Place for user 442	67	-50	17	117	2013-10-08 11:58:33	2012-08-03 18:36:33	26	6	f
299	443	Place for user 443	-42	14	-28	-56	2013-10-08 11:58:33	2012-08-02 17:35:33	45	6	f
300	445	Place for user 445	1	-50	-49	51	2013-10-08 11:58:33	2012-07-31 15:33:33	30	6	f
301	446	Place for user 446	30	-48	-18	78	2013-10-08 11:58:33	2012-07-30 14:32:33	23	6	f
302	448	Place for user 448	11	18	29	-7	2013-10-08 11:58:33	\N	38	6	f
303	449	Place for user 449	36	-33	3	69	2013-10-08 11:58:33	2012-07-27 11:29:33	32	6	f
304	451	Place for user 451	7	84	91	-77	2013-10-08 11:58:33	2012-07-25 09:27:33	44	6	f
305	452	Place for user 452	16	-28	-12	44	2013-10-08 11:58:33	\N	23	6	f
306	454	Place for user 454	62	-33	29	95	2013-10-08 11:58:33	2012-07-22 06:24:33	23	6	f
307	455	Place for user 455	-32	-15	-47	-17	2013-10-08 11:58:33	2012-07-21 05:23:33	20	6	f
308	457	Place for user 457	19	-43	-24	62	2013-10-08 11:58:33	2012-07-19 03:21:33	36	6	f
309	458	Place for user 458	80	-46	34	126	2013-10-08 11:58:33	2012-07-18 02:20:33	31	6	f
310	460	Place for user 460	-38	53	15	-91	2013-10-08 11:58:33	\N	27	6	f
311	461	Place for user 461	16	76	92	-60	2013-10-08 11:58:33	2012-07-14 23:17:33	33	6	f
312	463	Place for user 463	-8	31	23	-39	2013-10-08 11:58:33	2012-07-12 21:15:33	21	6	f
313	464	Place for user 464	32	80	112	-48	2013-10-08 11:58:33	\N	47	6	f
314	466	Place for user 466	75	53	128	22	2013-10-08 11:58:33	2012-07-09 18:12:33	49	6	f
315	467	Place for user 467	67	54	121	13	2013-10-08 11:58:34	2012-07-08 17:11:34	32	6	f
316	469	Place for user 469	-11	-9	-20	-2	2013-10-08 11:58:34	2012-07-06 15:09:34	47	6	f
317	470	Place for user 470	8	33	41	-25	2013-10-08 11:58:34	2012-07-05 14:08:34	28	6	f
318	472	Place for user 472	-43	58	15	-101	2013-10-08 11:58:34	\N	23	6	f
319	473	Place for user 473	28	27	55	1	2013-10-08 11:58:34	2012-07-02 11:05:34	35	6	f
320	475	Place for user 475	-4	-35	-39	31	2013-10-08 11:58:34	2012-06-30 09:03:34	26	6	f
321	476	Place for user 476	-15	90	75	-105	2013-10-08 11:58:34	\N	28	6	f
322	478	Place for user 478	-21	26	5	-47	2013-10-08 11:58:34	2012-06-27 06:00:34	43	6	f
323	479	Place for user 479	53	18	71	35	2013-10-08 11:58:34	2012-06-26 04:59:34	36	6	f
324	481	Place for user 481	11	50	61	-39	2013-10-08 11:58:34	2012-06-24 02:57:34	20	6	f
325	482	Place for user 482	-36	-23	-59	-13	2013-10-08 11:58:34	2012-06-23 01:56:34	28	6	f
326	484	Place for user 484	20	86	106	-66	2013-10-08 11:58:34	\N	26	6	f
327	485	Place for user 485	-20	66	46	-86	2013-10-08 11:58:34	2012-06-19 22:53:34	38	6	f
328	487	Place for user 487	39	-7	32	46	2013-10-08 11:58:34	2012-06-17 20:51:34	23	6	f
329	488	Place for user 488	12	0	12	12	2013-10-08 11:58:34	\N	37	6	f
330	490	Place for user 490	-1	69	68	-70	2013-10-08 11:58:34	2012-06-14 17:48:34	25	6	f
331	491	Place for user 491	-38	22	-16	-60	2013-10-08 11:58:34	2012-06-13 16:47:34	39	6	f
332	493	Place for user 493	-23	-28	-51	5	2013-10-08 11:58:34	2012-06-11 14:45:34	38	6	f
333	494	Place for user 494	-42	66	24	-108	2013-10-08 11:58:34	2012-06-10 13:44:34	27	6	f
334	496	Place for user 496	-3	20	17	-23	2013-10-08 11:58:35	\N	42	6	f
335	497	Place for user 497	78	86	164	-8	2013-10-08 11:58:35	2012-06-07 10:41:35	43	6	f
336	500	Place for user 500	8	83	91	-75	2013-10-08 11:58:35	\N	38	6	f
337	502	Place for user 502	62	89	151	-27	2013-10-08 11:58:35	2012-06-02 05:36:35	27	6	f
338	503	Place for user 503	34	22	56	12	2013-10-08 11:58:35	2012-06-01 04:35:35	35	6	f
339	505	Place for user 505	-20	83	63	-103	2013-10-08 11:58:35	2012-05-30 02:33:35	28	6	f
340	506	Place for user 506	42	4	46	38	2013-10-08 11:58:35	2012-05-29 01:32:35	34	6	f
341	508	Place for user 508	22	4	26	18	2013-10-08 11:58:35	\N	46	6	f
342	509	Place for user 509	64	-15	49	79	2013-10-08 11:58:35	2012-05-25 22:29:35	29	6	f
343	511	Place for user 511	55	-13	42	68	2013-10-08 11:58:35	2012-05-23 20:27:35	49	6	f
344	512	Place for user 512	-18	42	24	-60	2013-10-08 11:58:35	\N	46	6	f
345	514	Place for user 514	-35	38	3	-73	2013-10-08 11:58:35	2012-05-20 17:24:35	21	6	f
346	515	Place for user 515	12	25	37	-13	2013-10-08 11:58:35	2012-05-19 16:23:35	45	6	f
347	517	Place for user 517	30	-7	23	37	2013-10-08 11:58:35	2012-05-17 14:21:35	32	6	f
348	518	Place for user 518	3	3	6	0	2013-10-08 11:58:35	2012-05-16 13:20:35	36	6	f
349	520	Place for user 520	-35	-43	-78	8	2013-10-08 11:58:35	\N	32	6	f
350	521	Place for user 521	66	19	85	47	2013-10-08 11:58:35	2012-05-13 10:17:35	43	6	f
351	524	Place for user 524	-48	26	-22	-74	2013-10-08 11:58:35	\N	23	6	f
352	526	Place for user 526	85	56	141	29	2013-10-08 11:58:36	2012-05-08 05:12:35	32	6	f
353	527	Place for user 527	53	48	101	5	2013-10-08 11:58:36	2012-05-07 04:11:36	38	6	f
354	529	Place for user 529	-26	-24	-50	-2	2013-10-08 11:58:36	2012-05-05 02:09:36	36	6	f
355	530	Place for user 530	-13	4	-9	-17	2013-10-08 11:58:36	2012-05-04 01:08:36	44	6	f
356	532	Place for user 532	-8	-17	-25	9	2013-10-08 11:58:36	\N	43	6	f
357	533	Place for user 533	-28	87	59	-115	2013-10-08 11:58:36	2012-04-30 22:05:36	29	6	f
358	535	Place for user 535	1	-12	-11	13	2013-10-08 11:58:36	2012-04-28 20:03:36	29	6	f
359	536	Place for user 536	88	-28	60	116	2013-10-08 11:58:36	\N	44	6	f
360	538	Place for user 538	52	0	52	52	2013-10-08 11:58:36	2012-04-25 17:00:36	29	6	f
361	539	Place for user 539	6	9	15	-3	2013-10-08 11:58:36	2012-04-24 15:59:36	24	6	f
362	541	Place for user 541	27	54	81	-27	2013-10-08 11:58:37	2012-04-22 13:57:36	37	6	f
363	542	Place for user 542	-3	81	78	-84	2013-10-08 11:58:37	2012-04-21 12:56:37	47	6	f
364	544	Place for user 544	-3	-24	-27	21	2013-10-08 11:58:37	\N	41	6	f
365	545	Place for user 545	-22	0	-22	-22	2013-10-08 11:58:37	2012-04-18 09:53:37	24	6	f
366	547	Place for user 547	96	5	101	91	2013-10-08 11:58:37	2012-04-16 07:51:37	27	6	f
367	548	Place for user 548	3	-14	-11	17	2013-10-08 11:58:37	\N	36	6	f
368	550	Place for user 550	31	-41	-10	72	2013-10-08 11:58:37	2012-04-13 04:48:37	24	6	f
369	551	Place for user 551	23	100	123	-77	2013-10-08 11:58:37	2012-04-12 03:47:37	21	6	f
370	553	Place for user 553	-3	13	10	-16	2013-10-08 11:58:37	2012-04-10 01:45:37	31	6	f
371	554	Place for user 554	65	42	107	23	2013-10-08 11:58:37	2012-04-09 00:44:37	32	6	f
372	556	Place for user 556	100	33	133	67	2013-10-08 11:58:37	\N	22	6	f
373	557	Place for user 557	64	-16	48	80	2013-10-08 11:58:38	2012-04-05 21:41:37	41	6	f
374	559	Place for user 559	-38	33	-5	-71	2013-10-08 11:58:38	2012-04-03 19:39:38	44	6	f
375	560	Place for user 560	-30	-22	-52	-8	2013-10-08 11:58:38	\N	25	6	f
376	562	Place for user 562	15	9	24	6	2013-10-08 11:58:38	2012-03-31 16:36:38	36	6	f
377	563	Place for user 563	-17	100	83	-117	2013-10-08 11:58:38	2012-03-30 15:35:38	44	6	f
378	565	Place for user 565	31	98	129	-67	2013-10-08 11:58:38	2012-03-28 13:33:38	27	6	f
379	566	Place for user 566	47	95	142	-48	2013-10-08 11:58:38	2012-03-27 12:32:38	41	6	f
380	568	Place for user 568	40	-19	21	59	2013-10-08 11:58:38	\N	22	6	f
381	569	Place for user 569	1	-47	-46	48	2013-10-08 11:58:38	2012-03-24 09:29:38	22	6	f
382	571	Place for user 571	55	42	97	13	2013-10-08 11:58:38	2012-03-22 07:27:38	43	6	f
383	572	Place for user 572	60	50	110	10	2013-10-08 11:58:38	\N	37	6	f
384	574	Place for user 574	80	-28	52	108	2013-10-08 11:58:38	2012-03-19 04:24:38	32	6	f
385	575	Place for user 575	27	-28	-1	55	2013-10-08 11:58:38	2012-03-18 03:23:38	48	6	f
386	577	Place for user 577	34	36	70	-2	2013-10-08 11:58:38	2012-03-16 01:21:38	31	6	f
387	578	Place for user 578	56	47	103	9	2013-10-08 11:58:38	2012-03-15 00:20:38	45	6	f
388	580	Place for user 580	-41	63	22	-104	2013-10-08 11:58:38	\N	39	6	f
389	581	Place for user 581	89	-14	75	103	2013-10-08 11:58:38	2012-03-11 21:17:38	32	6	f
390	583	Place for user 583	-50	30	-20	-80	2013-10-08 11:58:38	2012-03-09 19:15:38	38	6	f
391	584	Place for user 584	1	79	80	-78	2013-10-08 11:58:38	\N	26	6	f
392	586	Place for user 586	84	90	174	-6	2013-10-08 11:58:39	2012-03-06 16:12:38	31	6	f
393	587	Place for user 587	-8	35	27	-43	2013-10-08 11:58:39	2012-03-05 15:11:39	39	6	f
394	589	Place for user 589	43	82	125	-39	2013-10-08 11:58:39	2012-03-03 13:09:39	37	6	f
395	590	Place for user 590	-5	-19	-24	14	2013-10-08 11:58:39	2012-03-02 12:08:39	43	6	f
396	592	Place for user 592	-40	58	18	-98	2013-10-08 11:58:39	\N	27	6	f
397	593	Place for user 593	85	72	157	13	2013-10-08 11:58:39	2012-02-28 09:05:39	23	6	f
398	595	Place for user 595	28	93	121	-65	2013-10-08 11:58:39	2012-02-26 07:03:39	29	6	f
399	596	Place for user 596	83	37	120	46	2013-10-08 11:58:39	\N	21	6	f
400	598	Place for user 598	85	-21	64	106	2013-10-08 11:58:39	2012-02-23 04:00:39	28	6	f
401	599	Place for user 599	-41	51	10	-92	2013-10-08 11:58:39	2012-02-22 02:59:39	27	6	f
402	601	Place for user 601	55	45	100	10	2013-10-08 11:58:40	2012-02-20 00:57:39	24	6	f
403	602	Place for user 602	-36	-35	-71	-1	2013-10-08 11:58:40	2012-02-18 23:56:40	32	6	f
404	604	Place for user 604	-40	23	-17	-63	2013-10-08 11:58:40	\N	20	6	f
405	605	Place for user 605	57	81	138	-24	2013-10-08 11:58:40	2012-02-15 20:53:40	24	6	f
406	607	Place for user 607	23	85	108	-62	2013-10-08 11:58:40	2012-02-13 18:51:40	21	6	f
407	608	Place for user 608	5	72	77	-67	2013-10-08 11:58:40	\N	38	6	f
408	610	Place for user 610	46	71	117	-25	2013-10-08 11:58:40	2012-02-10 15:48:40	40	6	f
409	611	Place for user 611	76	82	158	-6	2013-10-08 11:58:40	2012-02-09 14:47:40	33	6	f
410	613	Place for user 613	93	15	108	78	2013-10-08 11:58:40	2012-02-07 12:45:40	27	6	f
411	614	Place for user 614	97	27	124	70	2013-10-08 11:58:40	2012-02-06 11:44:40	27	6	f
412	616	Place for user 616	-34	80	46	-114	2013-10-08 11:58:40	\N	40	6	f
413	617	Place for user 617	-29	-47	-76	18	2013-10-08 11:58:40	2012-02-03 08:41:40	46	6	f
414	619	Place for user 619	-14	25	11	-39	2013-10-08 11:58:40	2012-02-01 06:39:40	21	6	f
415	620	Place for user 620	10	0	10	10	2013-10-08 11:58:40	\N	36	6	f
416	622	Place for user 622	-25	-17	-42	-8	2013-10-08 11:58:45	2012-01-29 03:36:45	28	6	f
417	623	Place for user 623	50	27	77	23	2013-10-08 11:58:46	2012-01-28 02:35:46	26	6	f
418	625	Place for user 625	-10	3	-7	-13	2013-10-08 11:58:47	2012-01-26 00:33:46	25	6	f
419	626	Place for user 626	-13	73	60	-86	2013-10-08 11:58:47	2012-01-24 23:32:47	39	6	f
420	628	Place for user 628	57	82	139	-25	2013-10-08 11:58:47	\N	21	6	f
421	629	Place for user 629	9	36	45	-27	2013-10-08 11:58:47	2012-01-21 20:29:47	32	6	f
422	631	Place for user 631	-39	23	-16	-62	2013-10-08 11:58:47	2012-01-19 18:27:47	31	6	f
423	632	Place for user 632	43	27	70	16	2013-10-08 11:58:47	\N	36	6	f
424	634	Place for user 634	-9	-44	-53	35	2013-10-08 11:58:47	2012-01-16 15:24:47	40	6	f
425	635	Place for user 635	-46	78	32	-124	2013-10-08 11:58:47	2012-01-15 14:23:47	23	6	f
426	637	Place for user 637	86	35	121	51	2013-10-08 11:58:47	2012-01-13 12:21:47	34	6	f
427	638	Place for user 638	-14	-6	-20	-8	2013-10-08 11:58:47	2012-01-12 11:20:47	23	6	f
428	640	Place for user 640	-22	93	71	-115	2013-10-08 11:58:47	\N	41	6	f
429	641	Place for user 641	-26	75	49	-101	2013-10-08 11:58:48	2012-01-09 08:17:47	33	6	f
430	643	Place for user 643	-28	49	21	-77	2013-10-08 11:58:48	2012-01-07 06:15:48	43	6	f
431	644	Place for user 644	-24	78	54	-102	2013-10-08 11:58:48	\N	44	6	f
432	646	Place for user 646	-5	-11	-16	6	2013-10-08 11:58:48	2012-01-04 03:12:48	32	6	f
433	647	Place for user 647	30	23	53	7	2013-10-08 11:58:48	2012-01-03 02:11:48	21	6	f
434	649	Place for user 649	-32	9	-23	-41	2013-10-08 11:58:48	2012-01-01 00:09:48	23	6	f
435	650	Place for user 650	54	20	74	34	2013-10-08 11:58:48	2011-12-30 23:08:48	35	6	f
436	652	Place for user 652	-27	4	-23	-31	2013-10-08 11:58:48	\N	28	6	f
437	653	Place for user 653	82	-43	39	125	2013-10-08 11:58:48	2011-12-27 20:05:48	28	6	f
438	655	Place for user 655	11	-49	-38	60	2013-10-08 11:58:48	2011-12-25 18:03:48	33	6	f
439	656	Place for user 656	74	-48	26	122	2013-10-08 11:58:48	\N	21	6	f
440	658	Place for user 658	-44	-48	-92	4	2013-10-08 11:58:48	2011-12-22 15:00:48	32	6	f
441	659	Place for user 659	9	1	10	8	2013-10-08 11:58:48	2011-12-21 13:59:48	42	6	f
442	661	Place for user 661	74	94	168	-20	2013-10-08 11:58:48	2011-12-19 11:57:48	34	6	f
443	662	Place for user 662	78	15	93	63	2013-10-08 11:58:48	2011-12-18 10:56:48	37	6	f
444	664	Place for user 664	21	63	84	-42	2013-10-08 11:58:49	\N	38	6	f
445	665	Place for user 665	38	2	40	36	2013-10-08 11:58:49	2011-12-15 07:53:49	24	6	f
446	667	Place for user 667	1	-32	-31	33	2013-10-08 11:58:49	2011-12-13 05:51:49	49	6	f
447	668	Place for user 668	-47	60	13	-107	2013-10-08 11:58:49	\N	49	6	f
448	670	Place for user 670	59	-32	27	91	2013-10-08 11:58:49	2011-12-10 02:48:49	32	6	f
449	671	Place for user 671	95	-9	86	104	2013-10-08 11:58:49	2011-12-09 01:47:49	31	6	f
450	673	Place for user 673	97	35	132	62	2013-10-08 11:58:49	2011-12-06 23:45:49	34	6	f
451	674	Place for user 674	-31	-8	-39	-23	2013-10-08 11:58:49	2011-12-05 22:44:49	22	6	f
452	676	Place for user 676	83	-13	70	96	2013-10-08 11:58:49	\N	43	6	f
453	677	Place for user 677	67	33	100	34	2013-10-08 11:58:49	2011-12-02 19:41:49	31	6	f
454	679	Place for user 679	-4	-26	-30	22	2013-10-08 11:58:49	2011-11-30 17:39:49	47	6	f
455	682	Place for user 682	-38	26	-12	-64	2013-10-08 11:58:49	2011-11-27 14:36:49	32	6	f
456	683	Place for user 683	0	73	73	-73	2013-10-08 11:58:49	2011-11-26 13:35:49	45	6	f
457	685	Place for user 685	1	62	63	-61	2013-10-08 11:58:49	2011-11-24 11:33:49	48	6	f
458	686	Place for user 686	-13	-16	-29	3	2013-10-08 11:58:50	2011-11-23 10:32:50	47	6	f
459	688	Place for user 688	-2	30	28	-32	2013-10-08 11:58:50	\N	32	6	f
460	689	Place for user 689	26	24	50	2	2013-10-08 11:58:50	2011-11-20 07:29:50	46	6	f
461	691	Place for user 691	-17	14	-3	-31	2013-10-08 11:58:51	2011-11-18 05:27:51	40	6	f
462	692	Place for user 692	1	43	44	-42	2013-10-08 11:58:51	\N	32	6	f
463	694	Place for user 694	97	-27	70	124	2013-10-08 11:58:51	2011-11-15 02:24:51	20	6	f
464	695	Place for user 695	-6	100	94	-106	2013-10-08 11:58:51	2011-11-14 01:23:51	46	6	f
465	698	Place for user 698	-12	1	-11	-13	2013-10-08 11:58:51	2011-11-10 22:20:51	27	6	f
466	700	Place for user 700	-26	95	69	-121	2013-10-08 11:58:51	\N	29	6	f
467	701	Place for user 701	-28	-5	-33	-23	2013-10-08 11:58:51	2011-11-07 19:17:51	36	6	f
468	703	Place for user 703	-18	56	38	-74	2013-10-08 11:58:51	2011-11-05 17:15:51	42	6	f
469	704	Place for user 704	-4	-43	-47	39	2013-10-08 11:58:51	\N	37	6	f
470	706	Place for user 706	-41	-50	-91	9	2013-10-08 11:58:51	2011-11-02 14:12:51	20	6	f
471	707	Place for user 707	40	-25	15	65	2013-10-08 11:58:51	2011-11-01 13:11:51	30	6	f
472	709	Place for user 709	12	-45	-33	57	2013-10-08 11:58:52	2011-10-30 11:09:52	37	6	f
473	710	Place for user 710	76	58	134	18	2013-10-08 11:58:52	2011-10-29 10:08:52	44	6	f
474	712	Place for user 712	79	74	153	5	2013-10-08 11:58:52	\N	45	6	f
475	713	Place for user 713	-50	19	-31	-69	2013-10-08 11:58:52	2011-10-26 07:05:52	41	6	f
476	715	Place for user 715	56	-24	32	80	2013-10-08 11:58:52	2011-10-24 05:03:52	26	6	f
477	716	Place for user 716	-4	-27	-31	23	2013-10-08 11:58:52	\N	36	6	f
478	718	Place for user 718	46	10	56	36	2013-10-08 11:58:52	2011-10-21 02:00:52	34	6	f
479	719	Place for user 719	-28	42	14	-70	2013-10-08 11:58:52	2011-10-20 00:59:52	35	6	f
480	721	Place for user 721	37	74	111	-37	2013-10-08 11:58:52	2011-10-17 22:57:52	36	6	f
481	722	Place for user 722	-1	-2	-3	1	2013-10-08 11:58:52	2011-10-16 21:56:52	36	6	f
482	724	Place for user 724	62	34	96	28	2013-10-08 11:58:52	\N	33	6	f
483	725	Place for user 725	-14	64	50	-78	2013-10-08 11:58:52	2011-10-13 18:53:52	22	6	f
484	727	Place for user 727	-46	61	15	-107	2013-10-08 11:58:52	2011-10-11 16:51:52	24	6	f
485	728	Place for user 728	85	68	153	17	2013-10-08 11:58:52	\N	30	6	f
486	730	Place for user 730	55	23	78	32	2013-10-08 11:58:52	2011-10-08 13:48:52	46	6	f
487	731	Place for user 731	-7	4	-3	-11	2013-10-08 11:58:52	2011-10-07 12:47:52	28	6	f
488	733	Place for user 733	40	-6	34	46	2013-10-08 11:58:52	2011-10-05 10:45:52	39	6	f
489	734	Place for user 734	45	81	126	-36	2013-10-08 11:58:53	2011-10-04 09:44:53	24	6	f
490	736	Place for user 736	24	75	99	-51	2013-10-08 11:58:53	\N	20	6	f
491	737	Place for user 737	-9	99	90	-108	2013-10-08 11:58:53	2011-10-01 06:41:53	23	6	f
492	739	Place for user 739	-5	38	33	-43	2013-10-08 11:58:53	2011-09-29 04:39:53	35	6	f
493	740	Place for user 740	55	67	122	-12	2013-10-08 11:58:53	\N	20	6	f
494	742	Place for user 742	39	99	138	-60	2013-10-08 11:58:53	2011-09-26 01:36:53	43	6	f
495	743	Place for user 743	-15	-8	-23	-7	2013-10-08 11:58:53	2011-09-25 00:35:53	23	6	f
496	745	Place for user 745	5	-33	-28	38	2013-10-08 11:58:53	2011-09-22 22:33:53	44	6	f
497	746	Place for user 746	16	-49	-33	65	2013-10-08 11:58:53	2011-09-21 21:32:53	25	6	f
498	748	Place for user 748	-20	39	19	-59	2013-10-08 11:58:53	\N	37	6	f
499	749	Place for user 749	66	47	113	19	2013-10-08 11:58:53	2011-09-18 18:29:53	40	6	f
500	751	Place for user 751	69	48	117	21	2013-10-08 11:58:53	2011-09-16 16:27:53	23	6	f
501	752	Place for user 752	-45	-19	-64	-26	2013-10-08 11:58:53	\N	29	6	f
502	754	Place for user 754	-9	38	29	-47	2013-10-08 11:58:53	2011-09-13 13:24:53	34	6	f
503	755	Place for user 755	56	60	116	-4	2013-10-08 11:58:53	2011-09-12 12:23:53	38	6	f
504	757	Place for user 757	63	20	83	43	2013-10-08 11:58:53	2011-09-10 10:21:53	22	6	f
505	758	Place for user 758	29	-31	-2	60	2013-10-08 11:58:54	2011-09-09 09:20:53	37	6	f
506	760	Place for user 760	31	40	71	-9	2013-10-08 11:58:54	\N	39	6	f
507	761	Place for user 761	-46	-9	-55	-37	2013-10-08 11:58:54	2011-09-06 06:17:54	46	6	f
508	763	Place for user 763	33	16	49	17	2013-10-08 11:58:54	2011-09-04 04:15:54	37	6	f
509	764	Place for user 764	86	-18	68	104	2013-10-08 11:58:54	\N	42	6	f
510	766	Place for user 766	91	-37	54	128	2013-10-08 11:58:54	2011-09-01 01:12:54	49	6	f
511	767	Place for user 767	-28	70	42	-98	2013-10-08 11:58:54	2011-08-31 00:11:54	34	6	f
512	770	Place for user 770	-5	-50	-55	45	2013-10-08 11:58:54	2011-08-27 21:08:54	43	6	f
513	772	Place for user 772	60	86	146	-26	2013-10-08 11:58:54	\N	47	6	f
514	773	Place for user 773	7	-49	-42	56	2013-10-08 11:58:54	2011-08-24 18:05:54	35	6	f
515	775	Place for user 775	93	17	110	76	2013-10-08 11:58:54	2011-08-22 16:03:54	47	6	f
516	776	Place for user 776	69	54	123	15	2013-10-08 11:58:54	\N	36	6	f
517	778	Place for user 778	37	21	58	16	2013-10-08 11:58:54	2011-08-19 13:00:54	28	6	f
518	779	Place for user 779	-23	87	64	-110	2013-10-08 11:58:54	2011-08-18 11:59:54	40	6	f
519	782	Place for user 782	6	68	74	-62	2013-10-08 11:58:55	2011-08-15 08:56:55	46	6	f
520	784	Place for user 784	-30	30	0	-60	2013-10-08 11:58:55	\N	44	6	f
521	785	Place for user 785	99	10	109	89	2013-10-08 11:58:55	2011-08-12 05:53:55	42	6	f
522	787	Place for user 787	-18	72	54	-90	2013-10-08 11:58:55	2011-08-10 03:51:55	24	6	f
523	788	Place for user 788	64	58	122	6	2013-10-08 11:58:55	\N	41	6	f
524	790	Place for user 790	31	-40	-9	71	2013-10-08 11:58:55	2011-08-07 00:48:55	29	6	f
525	791	Place for user 791	58	51	109	7	2013-10-08 11:58:55	2011-08-05 23:47:55	40	6	f
526	793	Place for user 793	-30	61	31	-91	2013-10-08 11:58:55	2011-08-03 21:45:55	21	6	f
527	794	Place for user 794	39	77	116	-38	2013-10-08 11:58:55	2011-08-02 20:44:55	40	6	f
528	796	Place for user 796	29	47	76	-18	2013-10-08 11:58:55	\N	41	6	f
529	797	Place for user 797	81	83	164	-2	2013-10-08 11:58:55	2011-07-30 17:41:55	49	6	f
530	799	Place for user 799	-15	-43	-58	28	2013-10-08 11:58:55	2011-07-28 15:39:55	41	6	f
531	800	Place for user 800	14	6	20	8	2013-10-08 11:58:55	\N	28	6	f
532	802	Place for user 802	75	78	153	-3	2013-10-08 11:58:55	2011-07-25 12:36:55	42	6	f
533	803	Place for user 803	96	54	150	42	2013-10-08 11:58:55	2011-07-24 11:35:55	22	6	f
534	805	Place for user 805	39	44	83	-5	2013-10-08 11:58:55	2011-07-22 09:33:55	26	6	f
535	806	Place for user 806	-17	22	5	-39	2013-10-08 11:58:56	2011-07-21 08:32:55	39	6	f
536	808	Place for user 808	59	35	94	24	2013-10-08 11:58:56	\N	42	6	f
537	809	Place for user 809	-43	70	27	-113	2013-10-08 11:58:56	2011-07-18 05:29:56	43	6	f
538	811	Place for user 811	-45	54	9	-99	2013-10-08 11:58:56	2011-07-16 03:27:56	42	6	f
539	812	Place for user 812	16	-30	-14	46	2013-10-08 11:58:56	\N	43	6	f
540	814	Place for user 814	70	61	131	9	2013-10-08 11:58:56	2011-07-13 00:24:56	44	6	f
541	815	Place for user 815	-48	15	-33	-63	2013-10-08 11:58:56	2011-07-11 23:23:56	32	6	f
542	817	Place for user 817	43	94	137	-51	2013-10-08 11:58:56	2011-07-09 21:21:56	29	6	f
543	818	Place for user 818	24	1	25	23	2013-10-08 11:58:56	2011-07-08 20:20:56	47	6	f
544	820	Place for user 820	65	78	143	-13	2013-10-08 11:58:56	\N	48	6	f
545	821	Place for user 821	23	-50	-27	73	2013-10-08 11:58:56	2011-07-05 17:17:56	35	6	f
546	823	Place for user 823	-25	93	68	-118	2013-10-08 11:58:56	2011-07-03 15:15:56	40	6	f
547	824	Place for user 824	-31	32	1	-63	2013-10-08 11:58:56	\N	46	6	f
548	826	Place for user 826	60	52	112	8	2013-10-08 11:58:56	2011-06-30 12:12:56	30	6	f
549	827	Place for user 827	81	64	145	17	2013-10-08 11:58:56	2011-06-29 11:11:56	44	6	f
550	830	Place for user 830	53	-45	8	98	2013-10-08 11:58:57	2011-06-26 08:08:56	26	6	f
551	832	Place for user 832	50	21	71	29	2013-10-08 11:58:57	\N	32	6	f
552	833	Place for user 833	-41	58	17	-99	2013-10-08 11:58:57	2011-06-23 05:05:57	47	6	f
553	835	Place for user 835	4	-26	-22	30	2013-10-08 11:58:57	2011-06-21 03:03:57	41	6	f
554	836	Place for user 836	29	17	46	12	2013-10-08 11:58:57	\N	49	6	f
555	838	Place for user 838	-13	72	59	-85	2013-10-08 11:58:57	2011-06-18 00:00:57	44	6	f
556	839	Place for user 839	35	53	88	-18	2013-10-08 11:58:57	2011-06-16 22:59:57	47	6	f
557	841	Place for user 841	-37	-17	-54	-20	2013-10-08 11:58:57	2011-06-14 20:57:57	41	6	f
558	842	Place for user 842	92	-42	50	134	2013-10-08 11:58:57	2011-06-13 19:56:57	34	6	f
559	844	Place for user 844	54	-7	47	61	2013-10-08 11:58:57	\N	48	6	f
560	845	Place for user 845	48	37	85	11	2013-10-08 11:58:57	2011-06-10 16:53:57	47	6	f
561	847	Place for user 847	-8	53	45	-61	2013-10-08 11:58:57	2011-06-08 14:51:57	47	6	f
562	848	Place for user 848	12	72	84	-60	2013-10-08 11:58:57	\N	23	6	f
563	850	Place for user 850	26	20	46	6	2013-10-08 11:58:57	2011-06-05 11:48:57	41	6	f
564	851	Place for user 851	-15	19	4	-34	2013-10-08 11:58:57	2011-06-04 10:47:57	45	6	f
565	853	Place for user 853	-43	-34	-77	-9	2013-10-08 11:58:57	2011-06-02 08:45:57	28	6	f
566	854	Place for user 854	73	-29	44	102	2013-10-08 11:58:57	2011-06-01 07:44:57	21	6	f
567	856	Place for user 856	16	6	22	10	2013-10-08 11:58:58	\N	30	6	f
568	857	Place for user 857	56	98	154	-42	2013-10-08 11:58:58	2011-05-29 04:41:58	37	6	f
569	859	Place for user 859	22	65	87	-43	2013-10-08 11:58:58	2011-05-27 02:39:58	37	6	f
570	860	Place for user 860	-15	-7	-22	-8	2013-10-08 11:58:58	\N	32	6	f
571	862	Place for user 862	-47	55	8	-102	2013-10-08 11:58:58	2011-05-23 23:36:58	43	6	f
572	863	Place for user 863	49	1	50	48	2013-10-08 11:58:58	2011-05-22 22:35:58	31	6	f
573	865	Place for user 865	87	13	100	74	2013-10-08 11:58:58	2011-05-20 20:33:58	24	6	f
574	866	Place for user 866	88	60	148	28	2013-10-08 11:58:58	2011-05-19 19:32:58	33	6	f
575	868	Place for user 868	28	78	106	-50	2013-10-08 11:58:58	\N	29	6	f
576	869	Place for user 869	-49	-4	-53	-45	2013-10-08 11:58:58	2011-05-16 16:29:58	36	6	f
577	871	Place for user 871	-12	-28	-40	16	2013-10-08 11:58:58	2011-05-14 14:27:58	38	6	f
578	872	Place for user 872	22	-38	-16	60	2013-10-08 11:58:58	\N	29	6	f
579	874	Place for user 874	-2	86	84	-88	2013-10-08 11:58:58	2011-05-11 11:24:58	26	6	f
580	875	Place for user 875	-11	66	55	-77	2013-10-08 11:58:58	2011-05-10 10:23:58	43	6	f
581	877	Place for user 877	46	93	139	-47	2013-10-08 11:58:58	2011-05-08 08:21:58	37	6	f
582	878	Place for user 878	83	78	161	5	2013-10-08 11:58:58	2011-05-07 07:20:58	29	6	f
583	880	Place for user 880	37	16	53	21	2013-10-08 11:58:59	\N	36	6	f
584	881	Place for user 881	38	-23	15	61	2013-10-08 11:58:59	2011-05-04 04:17:59	39	6	f
585	883	Place for user 883	51	-4	47	55	2013-10-08 11:58:59	2011-05-02 02:15:59	22	6	f
586	884	Place for user 884	-9	42	33	-51	2013-10-08 11:58:59	\N	25	6	f
587	886	Place for user 886	-12	91	79	-103	2013-10-08 11:58:59	2011-04-28 23:12:59	40	6	f
588	887	Place for user 887	36	13	49	23	2013-10-08 11:58:59	2011-04-27 22:11:59	28	6	f
589	889	Place for user 889	1	-38	-37	39	2013-10-08 11:58:59	2011-04-25 20:09:59	45	6	f
590	890	Place for user 890	32	-37	-5	69	2013-10-08 11:58:59	2011-04-24 19:08:59	38	6	f
591	892	Place for user 892	-35	29	-6	-64	2013-10-08 11:58:59	\N	38	6	f
592	893	Place for user 893	80	4	84	76	2013-10-08 11:58:59	2011-04-21 16:05:59	43	6	f
593	895	Place for user 895	33	75	108	-42	2013-10-08 11:58:59	2011-04-19 14:03:59	34	6	f
594	896	Place for user 896	31	-7	24	38	2013-10-08 11:58:59	\N	35	6	f
595	898	Place for user 898	6	82	88	-76	2013-10-08 11:58:59	2011-04-16 11:00:59	22	6	f
596	899	Place for user 899	64	82	146	-18	2013-10-08 11:58:59	2011-04-15 09:59:59	40	6	f
597	901	Place for user 901	61	72	133	-11	2013-10-08 11:58:59	2011-04-13 07:57:59	47	6	f
598	902	Place for user 902	43	74	117	-31	2013-10-08 11:59:00	2011-04-12 06:56:59	49	6	f
599	904	Place for user 904	4	-36	-32	40	2013-10-08 11:59:00	\N	24	6	f
600	905	Place for user 905	-46	-16	-62	-30	2013-10-08 11:59:00	2011-04-09 03:54:00	42	6	f
601	907	Place for user 907	-3	-34	-37	31	2013-10-08 11:59:00	2011-04-07 01:52:00	44	6	f
602	908	Place for user 908	18	-12	6	30	2013-10-08 11:59:00	\N	49	6	f
603	910	Place for user 910	58	26	84	32	2013-10-08 11:59:00	2011-04-03 22:49:00	21	6	f
604	911	Place for user 911	97	87	184	10	2013-10-08 11:59:00	2011-04-02 21:48:00	45	6	f
605	913	Place for user 913	-49	37	-12	-86	2013-10-08 11:59:00	2011-03-31 19:46:00	30	6	f
606	914	Place for user 914	75	-18	57	93	2013-10-08 11:59:00	2011-03-30 18:45:00	26	6	f
607	916	Place for user 916	26	-34	-8	60	2013-10-08 11:59:00	\N	41	6	f
608	917	Place for user 917	-20	-22	-42	2	2013-10-08 11:59:00	2011-03-27 15:42:00	40	6	f
609	919	Place for user 919	54	85	139	-31	2013-10-08 11:59:00	2011-03-25 13:40:00	28	6	f
610	920	Place for user 920	-36	70	34	-106	2013-10-08 11:59:00	\N	40	6	f
611	922	Place for user 922	97	-14	83	111	2013-10-08 11:59:00	2011-03-22 10:37:00	43	6	f
612	923	Place for user 923	93	21	114	72	2013-10-08 11:59:00	2011-03-21 09:36:00	40	6	f
613	925	Place for user 925	75	9	84	66	2013-10-08 11:59:01	2011-03-19 07:34:01	47	6	f
614	926	Place for user 926	32	46	78	-14	2013-10-08 11:59:01	2011-03-18 06:33:01	33	6	f
615	928	Place for user 928	59	93	152	-34	2013-10-08 11:59:01	\N	39	6	f
616	929	Place for user 929	54	33	87	21	2013-10-08 11:59:01	2011-03-15 03:30:01	39	6	f
617	931	Place for user 931	34	63	97	-29	2013-10-08 11:59:01	2011-03-13 01:28:01	34	6	f
618	932	Place for user 932	-27	32	5	-59	2013-10-08 11:59:01	\N	29	6	f
619	934	Place for user 934	-21	47	26	-68	2013-10-08 11:59:01	2011-03-09 22:25:01	26	6	f
620	935	Place for user 935	12	90	102	-78	2013-10-08 11:59:01	2011-03-08 21:24:01	24	6	f
621	937	Place for user 937	-43	28	-15	-71	2013-10-08 11:59:01	2011-03-06 19:22:01	27	6	f
622	940	Place for user 940	-26	-3	-29	-23	2013-10-08 11:59:01	\N	46	6	f
623	941	Place for user 941	-43	-44	-87	1	2013-10-08 11:59:01	2011-03-02 15:18:01	34	6	f
624	943	Place for user 943	41	59	100	-18	2013-10-08 11:59:01	2011-02-28 13:16:01	35	6	f
625	944	Place for user 944	-17	3	-14	-20	2013-10-08 11:59:02	\N	42	6	f
626	946	Place for user 946	-37	92	55	-129	2013-10-08 11:59:02	2011-02-25 10:13:02	27	6	f
627	947	Place for user 947	-22	-25	-47	3	2013-10-08 11:59:02	2011-02-24 09:12:02	49	6	f
628	949	Place for user 949	66	3	69	63	2013-10-08 11:59:02	2011-02-22 07:10:02	47	6	f
629	950	Place for user 950	78	96	174	-18	2013-10-08 11:59:02	2011-02-21 06:09:02	39	6	f
630	952	Place for user 952	93	62	155	31	2013-10-08 11:59:02	\N	34	6	f
631	953	Place for user 953	68	-21	47	89	2013-10-08 11:59:02	2011-02-18 03:06:02	21	6	f
632	955	Place for user 955	-27	45	18	-72	2013-10-08 11:59:02	2011-02-16 01:04:02	29	6	f
633	956	Place for user 956	81	86	167	-5	2013-10-08 11:59:02	\N	43	6	f
634	958	Place for user 958	-19	-27	-46	8	2013-10-08 11:59:02	2011-02-12 22:01:02	41	6	f
635	959	Place for user 959	13	22	35	-9	2013-10-08 11:59:02	2011-02-11 21:00:02	30	6	f
636	961	Place for user 961	79	31	110	48	2013-10-08 11:59:02	2011-02-09 18:58:02	38	6	f
637	962	Place for user 962	44	22	66	22	2013-10-08 11:59:02	2011-02-08 17:57:02	24	6	f
638	964	Place for user 964	86	34	120	52	2013-10-08 11:59:02	\N	32	6	f
639	965	Place for user 965	-15	-6	-21	-9	2013-10-08 11:59:02	2011-02-05 14:54:02	37	6	f
640	968	Place for user 968	39	2	41	37	2013-10-08 11:59:02	\N	21	6	f
641	970	Place for user 970	96	92	188	4	2013-10-08 11:59:03	2011-01-31 09:49:02	48	6	f
642	971	Place for user 971	-19	82	63	-101	2013-10-08 11:59:03	2011-01-30 08:48:03	26	6	f
643	973	Place for user 973	8	-26	-18	34	2013-10-08 11:59:03	2011-01-28 06:46:03	37	6	f
644	974	Place for user 974	14	33	47	-19	2013-10-08 11:59:03	2011-01-27 05:45:03	35	6	f
645	976	Place for user 976	19	85	104	-66	2013-10-08 11:59:03	\N	27	6	f
646	977	Place for user 977	3	-2	1	5	2013-10-08 11:59:03	2011-01-24 02:42:03	41	6	f
647	979	Place for user 979	43	-47	-4	90	2013-10-08 11:59:03	2011-01-22 00:40:03	38	6	f
648	980	Place for user 980	-9	75	66	-84	2013-10-08 11:59:03	\N	45	6	f
649	982	Place for user 982	41	92	133	-51	2013-10-08 11:59:03	2011-01-18 21:37:03	37	6	f
650	983	Place for user 983	-34	10	-24	-44	2013-10-08 11:59:03	2011-01-17 20:36:03	40	6	f
651	985	Place for user 985	-38	-23	-61	-15	2013-10-08 11:59:03	2011-01-15 18:34:03	49	6	f
652	986	Place for user 986	-24	10	-14	-34	2013-10-08 11:59:03	2011-01-14 17:33:03	27	6	f
653	988	Place for user 988	-14	60	46	-74	2013-10-08 11:59:03	\N	32	6	f
654	989	Place for user 989	-50	21	-29	-71	2013-10-08 11:59:03	2011-01-11 14:30:03	22	6	f
655	991	Place for user 991	89	-42	47	131	2013-10-08 11:59:03	2011-01-09 12:28:03	29	6	f
656	992	Place for user 992	-21	-28	-49	7	2013-10-08 11:59:03	\N	43	6	f
657	994	Place for user 994	88	9	97	79	2013-10-08 11:59:03	2011-01-06 09:25:03	27	6	f
658	995	Place for user 995	74	22	96	52	2013-10-08 11:59:03	2011-01-05 08:24:03	42	6	f
659	997	Place for user 997	56	-4	52	60	2013-10-08 11:59:04	2011-01-03 06:22:03	20	6	f
660	998	Place for user 998	28	-6	22	34	2013-10-08 11:59:04	2011-01-02 05:21:04	38	6	f
661	1000	Place for user 1000	-44	95	51	-139	2013-10-08 11:59:04	\N	29	6	f
662	1001	Place for user 1001	42	40	82	2	2013-10-08 11:59:04	2010-12-30 02:18:04	25	6	f
663	1004	Place for user 1004	55	7	62	48	2013-10-08 11:59:04	\N	38	6	f
664	1006	Place for user 1006	55	89	144	-34	2013-10-08 11:59:04	2010-12-24 21:13:04	28	6	f
665	1007	Place for user 1007	13	80	93	-67	2013-10-08 11:59:04	2010-12-23 20:12:04	34	6	f
666	1009	Place for user 1009	51	-35	16	86	2013-10-08 11:59:04	2010-12-21 18:10:04	31	6	f
667	1010	Place for user 1010	39	76	115	-37	2013-10-08 11:59:04	2010-12-20 17:09:04	22	6	f
668	1012	Place for user 1012	87	34	121	53	2013-10-08 11:59:04	\N	39	6	f
669	1013	Place for user 1013	15	59	74	-44	2013-10-08 11:59:04	2010-12-17 14:06:04	22	6	f
670	1015	Place for user 1015	-33	60	27	-93	2013-10-08 11:59:04	2010-12-15 12:04:04	22	6	f
671	1016	Place for user 1016	4	-23	-19	27	2013-10-08 11:59:04	\N	23	6	f
672	1018	Place for user 1018	-6	77	71	-83	2013-10-08 11:59:04	2010-12-12 09:01:04	44	6	f
673	1019	Place for user 1019	95	59	154	36	2013-10-08 11:59:04	2010-12-11 08:00:04	24	6	f
674	1021	Place for user 1021	52	-19	33	71	2013-10-08 11:59:05	2010-12-09 05:58:04	36	6	f
675	1022	Place for user 1022	49	10	59	39	2013-10-08 11:59:05	2010-12-08 04:57:05	42	6	f
676	1024	Place for user 1024	0	85	85	-85	2013-10-08 11:59:05	\N	42	6	f
677	1025	Place for user 1025	90	68	158	22	2013-10-08 11:59:05	2010-12-05 01:54:05	34	6	f
678	1027	Place for user 1027	-21	-44	-65	23	2013-10-08 11:59:05	2010-12-02 23:52:05	46	6	f
679	1028	Place for user 1028	-42	8	-34	-50	2013-10-08 11:59:05	\N	49	6	f
680	1030	Place for user 1030	10	72	82	-62	2013-10-08 11:59:05	2010-11-29 20:49:05	34	6	f
681	1031	Place for user 1031	-11	51	40	-62	2013-10-08 11:59:05	2010-11-28 19:48:05	34	6	f
682	1033	Place for user 1033	33	79	112	-46	2013-10-08 11:59:05	2010-11-26 17:46:05	43	6	f
683	1034	Place for user 1034	33	88	121	-55	2013-10-08 11:59:05	2010-11-25 16:45:05	31	6	f
684	1036	Place for user 1036	57	-8	49	65	2013-10-08 11:59:05	\N	39	6	f
685	1037	Place for user 1037	98	94	192	4	2013-10-08 11:59:05	2010-11-22 13:42:05	42	6	f
686	1039	Place for user 1039	52	70	122	-18	2013-10-08 11:59:05	2010-11-20 11:40:05	41	6	f
687	1040	Place for user 1040	38	52	90	-14	2013-10-08 11:59:05	\N	46	6	f
688	1042	Place for user 1042	77	-8	69	85	2013-10-08 11:59:05	2010-11-17 08:37:05	34	6	f
689	1043	Place for user 1043	88	91	179	-3	2013-10-08 11:59:05	2010-11-16 07:36:05	27	6	f
690	1045	Place for user 1045	78	11	89	67	2013-10-08 11:59:05	2010-11-14 05:34:05	38	6	f
691	1046	Place for user 1046	46	-28	18	74	2013-10-08 11:59:05	2010-11-13 04:33:05	36	6	f
692	1048	Place for user 1048	67	68	135	-1	2013-10-08 11:59:05	\N	29	6	f
693	1049	Place for user 1049	-40	-25	-65	-15	2013-10-08 11:59:06	2010-11-10 01:30:05	34	6	f
694	3	Spirit Place for user 3	48	18	66	30	2013-10-08 14:06:52	2013-11-04 11:03:52	27	2	t
695	5	Spirit Place for user 5	77	-43	34	120	2013-10-08 14:06:52	\N	44	2	t
696	7	Spirit Place for user 7	65	26	91	39	2013-10-08 14:06:52	2013-10-31 06:59:52	48	2	t
697	9	Spirit Place for user 9	25	68	93	-43	2013-10-08 14:06:52	2013-10-29 04:57:52	41	2	t
698	11	Spirit Place for user 11	2	57	59	-55	2013-10-08 14:06:52	2013-10-27 02:55:52	44	2	t
699	13	Spirit Place for user 13	-30	87	57	-117	2013-10-08 14:06:52	2013-10-25 00:53:52	41	2	t
700	15	Spirit Place for user 15	72	-50	22	122	2013-10-08 14:06:52	\N	22	2	t
701	17	Spirit Place for user 17	91	11	102	80	2013-10-08 14:06:52	2013-10-20 20:49:52	24	2	t
702	19	Spirit Place for user 19	-50	42	-8	-92	2013-10-08 14:06:52	2013-10-18 18:47:52	28	2	t
703	21	Spirit Place for user 21	63	10	73	53	2013-10-08 14:06:52	2013-10-16 16:45:52	39	2	t
704	23	Spirit Place for user 23	42	21	63	21	2013-10-08 14:06:52	2013-10-14 14:43:52	32	2	t
705	25	Spirit Place for user 25	-21	54	33	-75	2013-10-08 14:06:53	\N	43	2	t
706	27	Spirit Place for user 27	92	88	180	4	2013-10-08 14:06:53	2013-10-10 10:39:53	46	2	t
707	29	Spirit Place for user 29	60	8	68	52	2013-10-08 14:06:53	2013-10-08 08:37:53	31	2	t
708	31	Spirit Place for user 31	15	-39	-24	54	2013-10-08 14:06:53	2013-10-06 06:35:53	21	2	t
709	33	Spirit Place for user 33	58	35	93	23	2013-10-08 14:06:53	2013-10-04 04:33:53	39	2	t
710	35	Spirit Place for user 35	98	-41	57	139	2013-10-08 14:06:53	\N	27	2	t
711	37	Spirit Place for user 37	27	-24	3	51	2013-10-08 14:06:53	2013-09-30 00:29:53	36	2	t
712	39	Spirit Place for user 39	53	40	93	13	2013-10-08 14:06:53	2013-09-27 22:27:53	22	2	t
713	41	Spirit Place for user 41	44	-13	31	57	2013-10-08 14:06:53	2013-09-25 20:25:53	32	2	t
714	43	Spirit Place for user 43	99	-25	74	124	2013-10-08 14:06:53	2013-09-23 18:23:53	42	2	t
715	45	Spirit Place for user 45	-23	-39	-62	16	2013-10-08 14:06:53	\N	44	2	t
716	47	Spirit Place for user 47	94	98	192	-4	2013-10-08 14:06:53	2013-09-19 14:19:53	26	2	t
717	49	Spirit Place for user 49	-43	69	26	-112	2013-10-08 14:06:54	2013-09-17 12:17:53	27	2	t
718	51	Spirit Place for user 51	12	75	87	-63	2013-10-08 14:06:54	2013-09-15 10:15:54	48	2	t
719	53	Spirit Place for user 53	-2	66	64	-68	2013-10-08 14:06:54	2013-09-13 08:13:54	30	2	t
720	55	Spirit Place for user 55	100	34	134	66	2013-10-08 14:06:54	\N	30	2	t
721	57	Spirit Place for user 57	73	-35	38	108	2013-10-08 14:06:54	2013-09-09 04:09:54	35	2	t
722	59	Spirit Place for user 59	83	52	135	31	2013-10-08 14:06:54	2013-09-07 02:07:54	37	2	t
723	61	Spirit Place for user 61	62	76	138	-14	2013-10-08 14:06:54	2013-09-05 00:05:54	24	2	t
724	63	Spirit Place for user 63	98	92	190	6	2013-10-08 14:06:54	2013-09-02 22:03:54	44	2	t
725	65	Spirit Place for user 65	95	86	181	9	2013-10-08 14:06:54	\N	39	2	t
726	67	Spirit Place for user 67	-29	33	4	-62	2013-10-08 14:06:54	2013-08-29 17:59:54	38	2	t
727	69	Spirit Place for user 69	50	24	74	26	2013-10-08 14:06:55	2013-08-27 15:57:55	32	2	t
728	71	Spirit Place for user 71	95	40	135	55	2013-10-08 14:06:55	2013-08-25 13:55:55	38	2	t
729	73	Spirit Place for user 73	95	42	137	53	2013-10-08 14:06:55	2013-08-23 11:53:55	45	2	t
730	75	Spirit Place for user 75	2	-28	-26	30	2013-10-08 14:06:55	\N	43	2	t
731	77	Spirit Place for user 77	24	57	81	-33	2013-10-08 14:06:55	2013-08-19 07:49:55	39	2	t
732	79	Spirit Place for user 79	74	59	133	15	2013-10-08 14:06:55	2013-08-17 05:47:55	24	2	t
733	81	Spirit Place for user 81	22	60	82	-38	2013-10-08 14:06:55	2013-08-15 03:45:55	21	2	t
734	83	Spirit Place for user 83	19	-34	-15	53	2013-10-08 14:06:55	2013-08-13 01:43:55	34	2	t
735	85	Spirit Place for user 85	21	46	67	-25	2013-10-08 14:06:55	\N	35	2	t
736	87	Spirit Place for user 87	68	-14	54	82	2013-10-08 14:06:56	2013-08-08 21:39:56	49	2	t
737	89	Spirit Place for user 89	60	40	100	20	2013-10-08 14:06:56	2013-08-06 19:37:56	42	2	t
738	91	Spirit Place for user 91	8	14	22	-6	2013-10-08 14:06:56	2013-08-04 17:35:56	28	2	t
739	93	Spirit Place for user 93	0	-39	-39	39	2013-10-08 14:06:56	2013-08-02 15:33:56	29	2	t
740	95	Spirit Place for user 95	60	-38	22	98	2013-10-08 14:06:56	\N	47	2	t
741	97	Spirit Place for user 97	34	-19	15	53	2013-10-08 14:06:56	2013-07-29 11:29:56	43	2	t
742	99	Spirit Place for user 99	-4	9	5	-13	2013-10-08 14:06:56	2013-07-27 09:27:56	30	2	t
743	101	Spirit Place for user 101	11	-10	1	21	2013-10-08 14:06:56	2013-07-25 07:25:56	37	2	t
744	103	Spirit Place for user 103	6	70	76	-64	2013-10-08 14:06:56	2013-07-23 05:23:56	34	2	t
745	105	Spirit Place for user 105	-18	-21	-39	3	2013-10-08 14:06:56	\N	25	2	t
746	107	Spirit Place for user 107	-48	93	45	-141	2013-10-08 14:06:56	2013-07-19 01:19:56	36	2	t
747	109	Spirit Place for user 109	28	13	41	15	2013-10-08 14:06:56	2013-07-16 23:17:56	37	2	t
748	111	Spirit Place for user 111	15	-7	8	22	2013-10-08 14:06:56	2013-07-14 21:15:56	26	2	t
749	113	Spirit Place for user 113	69	19	88	50	2013-10-08 14:06:57	2013-07-12 19:13:57	32	2	t
750	115	Spirit Place for user 115	-21	5	-16	-26	2013-10-08 14:06:57	\N	33	2	t
751	117	Spirit Place for user 117	-32	66	34	-98	2013-10-08 14:06:57	2013-07-08 15:09:57	32	2	t
752	119	Spirit Place for user 119	-41	-38	-79	-3	2013-10-08 14:06:57	2013-07-06 13:07:57	43	2	t
753	121	Spirit Place for user 121	-14	37	23	-51	2013-10-08 14:06:57	2013-07-04 11:05:57	44	2	t
754	123	Spirit Place for user 123	70	-48	22	118	2013-10-08 14:06:57	2013-07-02 09:03:57	24	2	t
755	125	Spirit Place for user 125	73	87	160	-14	2013-10-08 14:06:57	\N	33	2	t
756	127	Spirit Place for user 127	100	24	124	76	2013-10-08 14:06:57	2013-06-28 04:59:57	47	2	t
757	129	Spirit Place for user 129	-24	75	51	-99	2013-10-08 14:06:57	2013-06-26 02:57:57	21	2	t
758	131	Spirit Place for user 131	-3	30	27	-33	2013-10-08 14:06:57	2013-06-24 00:55:57	29	2	t
759	133	Spirit Place for user 133	-47	-3	-50	-44	2013-10-08 14:06:57	2013-06-21 22:53:57	41	2	t
760	135	Spirit Place for user 135	94	-32	62	126	2013-10-08 14:06:57	\N	23	2	t
761	137	Spirit Place for user 137	-5	-49	-54	44	2013-10-08 14:06:57	2013-06-17 18:49:57	40	2	t
762	139	Spirit Place for user 139	-23	-50	-73	27	2013-10-08 14:06:58	2013-06-15 16:47:57	41	2	t
763	141	Spirit Place for user 141	-34	-12	-46	-22	2013-10-08 14:06:58	2013-06-13 14:45:58	41	2	t
764	143	Spirit Place for user 143	-24	-29	-53	5	2013-10-08 14:06:58	2013-06-11 12:43:58	26	2	t
765	145	Spirit Place for user 145	-17	41	24	-58	2013-10-08 14:06:58	\N	40	2	t
766	147	Spirit Place for user 147	-34	28	-6	-62	2013-10-08 14:06:58	2013-06-07 08:39:58	38	2	t
767	149	Spirit Place for user 149	94	83	177	11	2013-10-08 14:06:58	2013-06-05 06:37:58	23	2	t
768	151	Spirit Place for user 151	90	-24	66	114	2013-10-08 14:06:58	2013-06-03 04:35:58	36	2	t
769	153	Spirit Place for user 153	24	71	95	-47	2013-10-08 14:06:58	2013-06-01 02:33:58	30	2	t
770	155	Spirit Place for user 155	77	0	77	77	2013-10-08 14:06:58	\N	22	2	t
771	157	Spirit Place for user 157	35	-13	22	48	2013-10-08 14:06:58	2013-05-27 22:29:58	43	2	t
772	159	Spirit Place for user 159	-12	34	22	-46	2013-10-08 14:06:58	2013-05-25 20:27:58	37	2	t
773	161	Spirit Place for user 161	-6	0	-6	-6	2013-10-08 14:06:58	2013-05-23 18:25:58	38	2	t
774	163	Spirit Place for user 163	1	-50	-49	51	2013-10-08 14:06:58	2013-05-21 16:23:58	33	2	t
775	165	Spirit Place for user 165	1	-40	-39	41	2013-10-08 14:06:58	\N	46	2	t
776	167	Spirit Place for user 167	-14	-32	-46	18	2013-10-08 14:06:59	2013-05-17 12:19:59	41	2	t
777	169	Spirit Place for user 169	73	31	104	42	2013-10-08 14:06:59	2013-05-15 10:17:59	45	2	t
778	171	Spirit Place for user 171	2	4	6	-2	2013-10-08 14:06:59	2013-05-13 08:15:59	35	2	t
779	173	Spirit Place for user 173	52	-23	29	75	2013-10-08 14:06:59	2013-05-11 06:13:59	37	2	t
780	175	Spirit Place for user 175	61	0	61	61	2013-10-08 14:06:59	\N	22	2	t
781	177	Spirit Place for user 177	77	81	158	-4	2013-10-08 14:06:59	2013-05-07 02:09:59	46	2	t
782	179	Spirit Place for user 179	8	20	28	-12	2013-10-08 14:06:59	2013-05-05 00:07:59	23	2	t
783	181	Spirit Place for user 181	-50	48	-2	-98	2013-10-08 14:06:59	2013-05-02 22:05:59	34	2	t
784	183	Spirit Place for user 183	-41	40	-1	-81	2013-10-08 14:06:59	2013-04-30 20:03:59	45	2	t
785	185	Spirit Place for user 185	77	95	172	-18	2013-10-08 14:06:59	\N	48	2	t
786	187	Spirit Place for user 187	84	-33	51	117	2013-10-08 14:06:59	2013-04-26 15:59:59	49	2	t
787	189	Spirit Place for user 189	-5	45	40	-50	2013-10-08 14:06:59	2013-04-24 13:57:59	43	2	t
788	191	Spirit Place for user 191	14	24	38	-10	2013-10-08 14:06:59	2013-04-22 11:55:59	35	2	t
789	193	Spirit Place for user 193	32	86	118	-54	2013-10-08 14:07:00	2013-04-20 09:53:59	27	2	t
790	195	Spirit Place for user 195	76	21	97	55	2013-10-08 14:07:00	\N	32	2	t
791	197	Spirit Place for user 197	97	2	99	95	2013-10-08 14:07:00	2013-04-16 05:50:00	34	2	t
792	199	Spirit Place for user 199	36	82	118	-46	2013-10-08 14:07:00	2013-04-14 03:48:00	48	2	t
793	201	Spirit Place for user 201	35	-15	20	50	2013-10-08 14:07:00	2013-04-12 01:46:00	42	2	t
794	203	Spirit Place for user 203	46	37	83	9	2013-10-08 14:07:00	2013-04-09 23:44:00	34	2	t
795	205	Spirit Place for user 205	50	-30	20	80	2013-10-08 14:07:00	\N	42	2	t
796	207	Spirit Place for user 207	31	32	63	-1	2013-10-08 14:07:00	2013-04-05 19:40:00	40	2	t
797	209	Spirit Place for user 209	99	76	175	23	2013-10-08 14:07:00	2013-04-03 17:38:00	26	2	t
798	211	Spirit Place for user 211	-11	20	9	-31	2013-10-08 14:07:00	2013-04-01 15:36:00	33	2	t
799	213	Spirit Place for user 213	-31	-8	-39	-23	2013-10-08 14:07:00	2013-03-30 13:34:00	40	2	t
800	215	Spirit Place for user 215	-15	-35	-50	20	2013-10-08 14:07:00	\N	33	2	t
801	217	Spirit Place for user 217	64	84	148	-20	2013-10-08 14:07:00	2013-03-26 09:30:00	25	2	t
802	219	Spirit Place for user 219	95	54	149	41	2013-10-08 14:07:01	2013-03-24 07:28:00	34	2	t
803	221	Spirit Place for user 221	-45	67	22	-112	2013-10-08 14:07:01	2013-03-22 05:26:01	28	2	t
804	223	Spirit Place for user 223	-12	4	-8	-16	2013-10-08 14:07:01	2013-03-20 03:24:01	41	2	t
805	225	Spirit Place for user 225	22	-43	-21	65	2013-10-08 14:07:01	\N	23	2	t
806	227	Spirit Place for user 227	-30	48	18	-78	2013-10-08 14:07:01	2013-03-15 23:20:01	49	2	t
807	229	Spirit Place for user 229	-41	98	57	-139	2013-10-08 14:07:01	2013-03-13 21:18:01	49	2	t
808	231	Spirit Place for user 231	-35	14	-21	-49	2013-10-08 14:07:01	2013-03-11 19:16:01	46	2	t
809	233	Spirit Place for user 233	-36	80	44	-116	2013-10-08 14:07:01	2013-03-09 17:14:01	23	2	t
810	235	Spirit Place for user 235	97	46	143	51	2013-10-08 14:07:01	\N	33	2	t
811	237	Spirit Place for user 237	77	98	175	-21	2013-10-08 14:07:01	2013-03-05 13:10:01	30	2	t
812	239	Spirit Place for user 239	41	36	77	5	2013-10-08 14:07:01	2013-03-03 11:08:01	46	2	t
813	241	Spirit Place for user 241	-48	69	21	-117	2013-10-08 14:07:01	2013-03-01 09:06:01	22	2	t
814	243	Spirit Place for user 243	33	44	77	-11	2013-10-08 14:07:01	2013-02-27 07:04:01	20	2	t
815	245	Spirit Place for user 245	-22	-16	-38	-6	2013-10-08 14:07:02	\N	39	2	t
816	247	Spirit Place for user 247	40	62	102	-22	2013-10-08 14:07:02	2013-02-23 03:00:02	38	2	t
817	249	Spirit Place for user 249	52	13	65	39	2013-10-08 14:07:02	2013-02-21 00:58:02	34	2	t
818	251	Spirit Place for user 251	-15	37	22	-52	2013-10-08 14:07:02	2013-02-18 22:56:02	24	2	t
819	253	Spirit Place for user 253	4	13	17	-9	2013-10-08 14:07:02	2013-02-16 20:54:02	48	2	t
820	255	Spirit Place for user 255	6	-1	5	7	2013-10-08 14:07:02	\N	46	2	t
821	257	Spirit Place for user 257	57	28	85	29	2013-10-08 14:07:02	2013-02-12 16:50:02	42	2	t
822	259	Spirit Place for user 259	85	15	100	70	2013-10-08 14:07:02	2013-02-10 14:48:02	27	2	t
823	261	Spirit Place for user 261	67	93	160	-26	2013-10-08 14:07:02	2013-02-08 12:46:02	22	2	t
824	263	Spirit Place for user 263	-49	98	49	-147	2013-10-08 14:07:02	2013-02-06 10:44:02	24	2	t
825	265	Spirit Place for user 265	3	60	63	-57	2013-10-08 14:07:02	\N	42	2	t
826	267	Spirit Place for user 267	-26	47	21	-73	2013-10-08 14:07:02	2013-02-02 06:40:02	42	2	t
827	269	Spirit Place for user 269	44	38	82	6	2013-10-08 14:07:02	2013-01-31 04:38:02	31	2	t
828	271	Spirit Place for user 271	6	92	98	-86	2013-10-08 14:07:03	2013-01-29 02:36:02	40	2	t
829	273	Spirit Place for user 273	76	2	78	74	2013-10-08 14:07:03	2013-01-27 00:34:03	27	2	t
830	275	Spirit Place for user 275	95	57	152	38	2013-10-08 14:07:03	\N	23	2	t
831	277	Spirit Place for user 277	-21	-2	-23	-19	2013-10-08 14:07:03	2013-01-22 20:30:03	27	2	t
832	279	Spirit Place for user 279	100	66	166	34	2013-10-08 14:07:03	2013-01-20 18:28:03	26	2	t
833	281	Spirit Place for user 281	-3	54	51	-57	2013-10-08 14:07:03	2013-01-18 16:26:03	40	2	t
834	283	Spirit Place for user 283	81	-7	74	88	2013-10-08 14:07:03	2013-01-16 14:24:03	26	2	t
835	285	Spirit Place for user 285	16	-33	-17	49	2013-10-08 14:07:03	\N	42	2	t
836	287	Spirit Place for user 287	73	99	172	-26	2013-10-08 14:07:03	2013-01-12 10:20:03	32	2	t
837	289	Spirit Place for user 289	75	1	76	74	2013-10-08 14:07:03	2013-01-10 08:18:03	41	2	t
838	291	Spirit Place for user 291	-14	12	-2	-26	2013-10-08 14:07:03	2013-01-08 06:16:03	40	2	t
839	293	Spirit Place for user 293	93	7	100	86	2013-10-08 14:07:04	2013-01-06 04:14:03	44	2	t
840	295	Spirit Place for user 295	73	40	113	33	2013-10-08 14:07:04	\N	25	2	t
841	297	Spirit Place for user 297	-8	-35	-43	27	2013-10-08 14:07:04	2013-01-02 00:10:04	20	2	t
842	299	Spirit Place for user 299	83	-30	53	113	2013-10-08 14:07:04	2012-12-30 22:08:04	46	2	t
843	301	Spirit Place for user 301	-2	30	28	-32	2013-10-08 14:07:04	2012-12-28 20:06:04	27	2	t
844	303	Spirit Place for user 303	-8	-4	-12	-4	2013-10-08 14:07:04	2012-12-26 18:04:04	44	2	t
845	305	Spirit Place for user 305	16	36	52	-20	2013-10-08 14:07:04	\N	23	2	t
846	307	Spirit Place for user 307	-31	-24	-55	-7	2013-10-08 14:07:05	2012-12-22 14:00:04	39	2	t
847	309	Spirit Place for user 309	20	-44	-24	64	2013-10-08 14:07:05	2012-12-20 11:58:05	21	2	t
848	311	Spirit Place for user 311	83	30	113	53	2013-10-08 14:07:05	2012-12-18 09:56:05	39	2	t
849	313	Spirit Place for user 313	80	80	160	0	2013-10-08 14:07:05	2012-12-16 07:54:05	31	2	t
850	315	Spirit Place for user 315	-47	94	47	-141	2013-10-08 14:07:05	\N	48	2	t
851	317	Spirit Place for user 317	-10	42	32	-52	2013-10-08 14:07:05	2012-12-12 03:50:05	38	2	t
852	319	Spirit Place for user 319	75	28	103	47	2013-10-08 14:07:05	2012-12-10 01:48:05	37	2	t
853	321	Spirit Place for user 321	7	91	98	-84	2013-10-08 14:07:05	2012-12-07 23:46:05	23	2	t
854	323	Spirit Place for user 323	58	89	147	-31	2013-10-08 14:07:05	2012-12-05 21:44:05	28	2	t
855	325	Spirit Place for user 325	-45	-1	-46	-44	2013-10-08 14:07:05	\N	47	2	t
856	327	Spirit Place for user 327	49	68	117	-19	2013-10-08 14:07:06	2012-12-01 17:40:06	42	2	t
857	329	Spirit Place for user 329	9	-40	-31	49	2013-10-08 14:07:06	2012-11-29 15:38:06	33	2	t
858	331	Spirit Place for user 331	40	80	120	-40	2013-10-08 14:07:06	2012-11-27 13:36:06	36	2	t
859	333	Spirit Place for user 333	2	-2	0	4	2013-10-08 14:07:06	2012-11-25 11:34:06	32	2	t
860	335	Spirit Place for user 335	99	4	103	95	2013-10-08 14:07:06	\N	34	2	t
861	337	Spirit Place for user 337	33	6	39	27	2013-10-08 14:07:06	2012-11-21 07:30:06	21	2	t
862	339	Spirit Place for user 339	76	69	145	7	2013-10-08 14:07:06	2012-11-19 05:28:06	20	2	t
863	341	Spirit Place for user 341	87	-16	71	103	2013-10-08 14:07:06	2012-11-17 03:26:06	42	2	t
864	343	Spirit Place for user 343	66	-34	32	100	2013-10-08 14:07:07	2012-11-15 01:24:06	45	2	t
865	345	Spirit Place for user 345	59	-28	31	87	2013-10-08 14:07:07	\N	39	2	t
866	347	Spirit Place for user 347	-49	84	35	-133	2013-10-08 14:07:07	2012-11-10 21:20:07	47	2	t
867	349	Spirit Place for user 349	-7	11	4	-18	2013-10-08 14:07:07	2012-11-08 19:18:07	35	2	t
868	351	Spirit Place for user 351	-26	3	-23	-29	2013-10-08 14:07:07	2012-11-06 17:16:07	46	2	t
869	353	Spirit Place for user 353	57	28	85	29	2013-10-08 14:07:07	2012-11-04 15:14:07	33	2	t
870	355	Spirit Place for user 355	-39	72	33	-111	2013-10-08 14:07:07	\N	26	2	t
871	357	Spirit Place for user 357	-43	62	19	-105	2013-10-08 14:07:07	2012-10-31 11:10:07	47	2	t
872	359	Spirit Place for user 359	76	58	134	18	2013-10-08 14:07:07	2012-10-29 09:08:07	30	2	t
873	361	Spirit Place for user 361	-19	-29	-48	10	2013-10-08 14:07:07	2012-10-27 07:06:07	45	2	t
874	363	Spirit Place for user 363	44	99	143	-55	2013-10-08 14:07:07	2012-10-25 05:04:07	45	2	t
875	365	Spirit Place for user 365	32	-40	-8	72	2013-10-08 14:07:07	\N	22	2	t
876	367	Spirit Place for user 367	78	-42	36	120	2013-10-08 14:07:07	2012-10-21 01:00:07	45	2	t
877	369	Spirit Place for user 369	38	33	71	5	2013-10-08 14:07:08	2012-10-18 22:58:08	28	2	t
878	371	Spirit Place for user 371	88	-26	62	114	2013-10-08 14:07:08	2012-10-16 20:56:08	42	2	t
879	373	Spirit Place for user 373	64	21	85	43	2013-10-08 14:07:08	2012-10-14 18:54:08	35	2	t
880	375	Spirit Place for user 375	-21	33	12	-54	2013-10-08 14:07:08	\N	39	2	t
881	377	Spirit Place for user 377	71	73	144	-2	2013-10-08 14:07:08	2012-10-10 14:50:08	25	2	t
882	379	Spirit Place for user 379	-16	0	-16	-16	2013-10-08 14:07:08	2012-10-08 12:48:08	42	2	t
883	381	Spirit Place for user 381	42	83	125	-41	2013-10-08 14:07:08	2012-10-06 10:46:08	44	2	t
884	383	Spirit Place for user 383	-37	-47	-84	10	2013-10-08 14:07:08	2012-10-04 08:44:08	44	2	t
885	385	Spirit Place for user 385	-36	77	41	-113	2013-10-08 14:07:08	\N	21	2	t
886	387	Spirit Place for user 387	-50	-28	-78	-22	2013-10-08 14:07:08	2012-09-30 04:40:08	35	2	t
887	389	Spirit Place for user 389	99	37	136	62	2013-10-08 14:07:08	2012-09-28 02:38:08	47	2	t
888	391	Spirit Place for user 391	46	3	49	43	2013-10-08 14:07:08	2012-09-26 00:36:08	26	2	t
889	393	Spirit Place for user 393	28	17	45	11	2013-10-08 14:07:08	2012-09-23 22:34:08	31	2	t
890	395	Spirit Place for user 395	28	-21	7	49	2013-10-08 14:07:09	\N	29	2	t
891	397	Spirit Place for user 397	19	58	77	-39	2013-10-08 14:07:09	2012-09-19 18:30:09	35	2	t
892	399	Spirit Place for user 399	3	85	88	-82	2013-10-08 14:07:09	2012-09-17 16:28:09	23	2	t
893	401	Spirit Place for user 401	68	93	161	-25	2013-10-08 14:07:09	2012-09-15 14:26:09	20	2	t
894	403	Spirit Place for user 403	13	-20	-7	33	2013-10-08 14:07:09	2012-09-13 12:24:09	34	2	t
895	405	Spirit Place for user 405	62	14	76	48	2013-10-08 14:07:09	\N	27	2	t
896	407	Spirit Place for user 407	-34	-1	-35	-33	2013-10-08 14:07:09	2012-09-09 08:20:09	43	2	t
897	409	Spirit Place for user 409	-32	47	15	-79	2013-10-08 14:07:09	2012-09-07 06:18:09	43	2	t
898	411	Spirit Place for user 411	-45	73	28	-118	2013-10-08 14:07:09	2012-09-05 04:16:09	28	2	t
899	413	Spirit Place for user 413	47	27	74	20	2013-10-08 14:07:09	2012-09-03 02:14:09	22	2	t
900	415	Spirit Place for user 415	-33	25	-8	-58	2013-10-08 14:07:09	\N	43	2	t
901	417	Spirit Place for user 417	19	21	40	-2	2013-10-08 14:07:09	2012-08-29 22:10:09	22	2	t
902	419	Spirit Place for user 419	-43	32	-11	-75	2013-10-08 14:07:09	2012-08-27 20:08:09	41	2	t
903	421	Spirit Place for user 421	37	-47	-10	84	2013-10-08 14:07:10	2012-08-25 18:06:09	40	2	t
904	423	Spirit Place for user 423	-14	-45	-59	31	2013-10-08 14:07:10	2012-08-23 16:04:10	45	2	t
905	425	Spirit Place for user 425	-34	90	56	-124	2013-10-08 14:07:10	\N	27	2	t
906	427	Spirit Place for user 427	20	5	25	15	2013-10-08 14:07:10	2012-08-19 12:00:10	34	2	t
907	429	Spirit Place for user 429	-35	-9	-44	-26	2013-10-08 14:07:10	2012-08-17 09:58:10	43	2	t
908	431	Spirit Place for user 431	-31	-48	-79	17	2013-10-08 14:07:10	2012-08-15 07:56:10	41	2	t
909	433	Spirit Place for user 433	-10	47	37	-57	2013-10-08 14:07:10	2012-08-13 05:54:10	36	2	t
910	435	Spirit Place for user 435	5	98	103	-93	2013-10-08 14:07:10	\N	49	2	t
911	437	Spirit Place for user 437	-44	-33	-77	-11	2013-10-08 14:07:10	2012-08-09 01:50:10	46	2	t
912	439	Spirit Place for user 439	2	28	30	-26	2013-10-08 14:07:10	2012-08-06 23:48:10	26	2	t
913	441	Spirit Place for user 441	-11	-6	-17	-5	2013-10-08 14:07:10	2012-08-04 21:46:10	22	2	t
914	443	Spirit Place for user 443	-14	-43	-57	29	2013-10-08 14:07:10	2012-08-02 19:44:10	31	2	t
915	445	Spirit Place for user 445	18	58	76	-40	2013-10-08 14:07:10	\N	23	2	t
916	447	Spirit Place for user 447	58	98	156	-40	2013-10-08 14:07:11	2012-07-29 15:40:10	33	2	t
917	449	Spirit Place for user 449	37	8	45	29	2013-10-08 14:07:11	2012-07-27 13:38:11	20	2	t
918	451	Spirit Place for user 451	64	24	88	40	2013-10-08 14:07:11	2012-07-25 11:36:11	43	2	t
919	453	Spirit Place for user 453	20	18	38	2	2013-10-08 14:07:11	2012-07-23 09:34:11	21	2	t
920	455	Spirit Place for user 455	13	68	81	-55	2013-10-08 14:07:11	\N	29	2	t
921	457	Spirit Place for user 457	-34	44	10	-78	2013-10-08 14:07:11	2012-07-19 05:30:11	41	2	t
922	459	Spirit Place for user 459	-4	11	7	-15	2013-10-08 14:07:11	2012-07-17 03:28:11	29	2	t
923	461	Spirit Place for user 461	58	55	113	3	2013-10-08 14:07:11	2012-07-15 01:26:11	26	2	t
924	463	Spirit Place for user 463	-30	23	-7	-53	2013-10-08 14:07:11	2012-07-12 23:24:11	36	2	t
925	465	Spirit Place for user 465	7	87	94	-80	2013-10-08 14:07:11	\N	41	2	t
926	467	Spirit Place for user 467	32	78	110	-46	2013-10-08 14:07:11	2012-07-08 19:20:11	27	2	t
927	469	Spirit Place for user 469	-10	41	31	-51	2013-10-08 14:07:11	2012-07-06 17:18:11	29	2	t
928	471	Spirit Place for user 471	7	-42	-35	49	2013-10-08 14:07:11	2012-07-04 15:16:11	28	2	t
929	473	Spirit Place for user 473	38	-29	9	67	2013-10-08 14:07:12	2012-07-02 13:14:11	21	2	t
930	475	Spirit Place for user 475	14	70	84	-56	2013-10-08 14:07:12	\N	30	2	t
931	477	Spirit Place for user 477	96	-34	62	130	2013-10-08 14:07:12	2012-06-28 09:10:12	22	2	t
932	479	Spirit Place for user 479	77	-12	65	89	2013-10-08 14:07:12	2012-06-26 07:08:12	23	2	t
933	481	Spirit Place for user 481	45	44	89	1	2013-10-08 14:07:12	2012-06-24 05:06:12	42	2	t
934	483	Spirit Place for user 483	11	42	53	-31	2013-10-08 14:07:12	2012-06-22 03:04:12	41	2	t
935	485	Spirit Place for user 485	39	82	121	-43	2013-10-08 14:07:12	\N	43	2	t
936	487	Spirit Place for user 487	-12	-39	-51	27	2013-10-08 14:07:12	2012-06-17 23:00:12	34	2	t
937	489	Spirit Place for user 489	-22	10	-12	-32	2013-10-08 14:07:12	2012-06-15 20:58:12	44	2	t
938	491	Spirit Place for user 491	-30	83	53	-113	2013-10-08 14:07:12	2012-06-13 18:56:12	49	2	t
939	493	Spirit Place for user 493	59	34	93	25	2013-10-08 14:07:12	2012-06-11 16:54:12	35	2	t
940	495	Spirit Place for user 495	38	-16	22	54	2013-10-08 14:07:12	\N	30	2	t
941	497	Spirit Place for user 497	-26	-22	-48	-4	2013-10-08 14:07:12	2012-06-07 12:50:12	22	2	t
942	499	Spirit Place for user 499	8	82	90	-74	2013-10-08 14:07:13	2012-06-05 10:48:13	21	2	t
943	501	Spirit Place for user 501	-44	39	-5	-83	2013-10-08 14:07:13	2012-06-03 08:46:13	48	2	t
944	503	Spirit Place for user 503	64	19	83	45	2013-10-08 14:07:13	2012-06-01 06:44:13	44	2	t
945	505	Spirit Place for user 505	44	60	104	-16	2013-10-08 14:07:13	\N	40	2	t
946	507	Spirit Place for user 507	6	67	73	-61	2013-10-08 14:07:13	2012-05-28 02:40:13	32	2	t
947	509	Spirit Place for user 509	37	36	73	1	2013-10-08 14:07:13	2012-05-26 00:38:13	27	2	t
948	511	Spirit Place for user 511	61	89	150	-28	2013-10-08 14:07:13	2012-05-23 22:36:13	32	2	t
949	513	Spirit Place for user 513	-27	-32	-59	5	2013-10-08 14:07:13	2012-05-21 20:34:13	29	2	t
950	515	Spirit Place for user 515	-35	97	62	-132	2013-10-08 14:07:13	\N	37	2	t
951	517	Spirit Place for user 517	-3	30	27	-33	2013-10-08 14:07:13	2012-05-17 16:30:13	39	2	t
952	519	Spirit Place for user 519	75	0	75	75	2013-10-08 14:07:13	2012-05-15 14:28:13	42	2	t
953	521	Spirit Place for user 521	5	-12	-7	17	2013-10-08 14:07:13	2012-05-13 12:26:13	26	2	t
954	523	Spirit Place for user 523	-46	-3	-49	-43	2013-10-08 14:07:14	2012-05-11 10:24:13	37	2	t
955	525	Spirit Place for user 525	11	-25	-14	36	2013-10-08 14:07:14	\N	23	2	t
956	527	Spirit Place for user 527	35	-36	-1	71	2013-10-08 14:07:14	2012-05-07 06:20:14	36	2	t
957	529	Spirit Place for user 529	4	24	28	-20	2013-10-08 14:07:14	2012-05-05 04:18:14	43	2	t
958	531	Spirit Place for user 531	-50	18	-32	-68	2013-10-08 14:07:14	2012-05-03 02:16:14	46	2	t
959	533	Spirit Place for user 533	47	29	76	18	2013-10-08 14:07:14	2012-05-01 00:14:14	33	2	t
960	535	Spirit Place for user 535	73	-32	41	105	2013-10-08 14:07:14	\N	42	2	t
961	537	Spirit Place for user 537	17	-19	-2	36	2013-10-08 14:07:14	2012-04-26 20:10:14	21	2	t
962	539	Spirit Place for user 539	6	72	78	-66	2013-10-08 14:07:14	2012-04-24 18:08:14	47	2	t
963	541	Spirit Place for user 541	45	2	47	43	2013-10-08 14:07:14	2012-04-22 16:06:14	44	2	t
964	543	Spirit Place for user 543	44	93	137	-49	2013-10-08 14:07:14	2012-04-20 14:04:14	26	2	t
965	545	Spirit Place for user 545	30	37	67	-7	2013-10-08 14:07:15	\N	20	2	t
966	547	Spirit Place for user 547	97	50	147	47	2013-10-08 14:07:15	2012-04-16 10:00:15	26	2	t
967	549	Spirit Place for user 549	-5	16	11	-21	2013-10-08 14:07:15	2012-04-14 07:58:15	23	2	t
968	551	Spirit Place for user 551	69	16	85	53	2013-10-08 14:07:15	2012-04-12 05:56:15	47	2	t
969	553	Spirit Place for user 553	-47	-16	-63	-31	2013-10-08 14:07:15	2012-04-10 03:54:15	20	2	t
970	555	Spirit Place for user 555	95	-45	50	140	2013-10-08 14:07:15	\N	24	2	t
971	557	Spirit Place for user 557	-11	0	-11	-11	2013-10-08 14:07:15	2012-04-05 23:50:15	22	2	t
972	559	Spirit Place for user 559	46	60	106	-14	2013-10-08 14:07:15	2012-04-03 21:48:15	28	2	t
973	561	Spirit Place for user 561	97	-44	53	141	2013-10-08 14:07:15	2012-04-01 19:46:15	32	2	t
974	563	Spirit Place for user 563	-11	43	32	-54	2013-10-08 14:07:15	2012-03-30 17:44:15	48	2	t
975	565	Spirit Place for user 565	40	85	125	-45	2013-10-08 14:07:15	\N	48	2	t
976	567	Spirit Place for user 567	82	-35	47	117	2013-10-08 14:07:16	2012-03-26 13:40:15	38	2	t
977	569	Spirit Place for user 569	57	89	146	-32	2013-10-08 14:07:16	2012-03-24 11:38:16	26	2	t
978	571	Spirit Place for user 571	84	10	94	74	2013-10-08 14:07:16	2012-03-22 09:36:16	28	2	t
979	573	Spirit Place for user 573	-39	69	30	-108	2013-10-08 14:07:16	2012-03-20 07:34:16	40	2	t
980	575	Spirit Place for user 575	-32	25	-7	-57	2013-10-08 14:07:16	\N	28	2	t
981	577	Spirit Place for user 577	38	-41	-3	79	2013-10-08 14:07:16	2012-03-16 03:30:16	32	2	t
982	579	Spirit Place for user 579	-43	-2	-45	-41	2013-10-08 14:07:16	2012-03-14 01:28:16	20	2	t
983	581	Spirit Place for user 581	40	57	97	-17	2013-10-08 14:07:16	2012-03-11 23:26:16	45	2	t
984	583	Spirit Place for user 583	26	57	83	-31	2013-10-08 14:07:17	2012-03-09 21:24:17	47	2	t
985	585	Spirit Place for user 585	9	40	49	-31	2013-10-08 14:07:17	\N	20	2	t
986	587	Spirit Place for user 587	85	15	100	70	2013-10-08 14:07:17	2012-03-05 17:20:17	43	2	t
987	589	Spirit Place for user 589	-33	-26	-59	-7	2013-10-08 14:07:17	2012-03-03 15:18:17	46	2	t
988	591	Spirit Place for user 591	-42	-50	-92	8	2013-10-08 14:07:17	2012-03-01 13:16:17	30	2	t
989	593	Spirit Place for user 593	2	81	83	-79	2013-10-08 14:07:17	2012-02-28 11:14:17	49	2	t
990	595	Spirit Place for user 595	-19	83	64	-102	2013-10-08 14:07:17	\N	32	2	t
991	597	Spirit Place for user 597	77	80	157	-3	2013-10-08 14:07:17	2012-02-24 07:10:17	24	2	t
992	599	Spirit Place for user 599	-45	8	-37	-53	2013-10-08 14:07:17	2012-02-22 05:08:17	34	2	t
993	601	Spirit Place for user 601	95	27	122	68	2013-10-08 14:07:17	2012-02-20 03:06:17	32	2	t
994	603	Spirit Place for user 603	-16	-33	-49	17	2013-10-08 14:07:18	2012-02-18 01:04:17	23	2	t
995	605	Spirit Place for user 605	-18	75	57	-93	2013-10-08 14:07:18	\N	32	2	t
996	607	Spirit Place for user 607	76	17	93	59	2013-10-08 14:07:18	2012-02-13 21:00:18	41	2	t
997	609	Spirit Place for user 609	8	40	48	-32	2013-10-08 14:07:18	2012-02-11 18:58:18	21	2	t
998	611	Spirit Place for user 611	9	77	86	-68	2013-10-08 14:07:18	2012-02-09 16:56:18	32	2	t
999	613	Spirit Place for user 613	0	93	93	-93	2013-10-08 14:07:18	2012-02-07 14:54:18	42	2	t
1000	615	Spirit Place for user 615	-37	86	49	-123	2013-10-08 14:07:18	\N	38	2	t
1001	617	Spirit Place for user 617	10	-40	-30	50	2013-10-08 14:07:18	2012-02-03 10:50:18	38	2	t
1002	619	Spirit Place for user 619	-29	62	33	-91	2013-10-08 14:07:18	2012-02-01 08:48:18	48	2	t
1003	621	Spirit Place for user 621	30	-37	-7	67	2013-10-08 14:07:18	2012-01-30 06:46:18	33	2	t
1004	623	Spirit Place for user 623	-42	-14	-56	-28	2013-10-08 14:07:18	2012-01-28 04:44:18	30	2	t
1005	625	Spirit Place for user 625	14	38	52	-24	2013-10-08 14:07:18	\N	28	2	t
1006	627	Spirit Place for user 627	17	-26	-9	43	2013-10-08 14:07:18	2012-01-24 00:40:18	27	2	t
1007	629	Spirit Place for user 629	68	56	124	12	2013-10-08 14:07:19	2012-01-21 22:38:18	44	2	t
1008	631	Spirit Place for user 631	66	5	71	61	2013-10-08 14:07:19	2012-01-19 20:36:19	37	2	t
1009	633	Spirit Place for user 633	4	49	53	-45	2013-10-08 14:07:19	2012-01-17 18:34:19	35	2	t
1010	635	Spirit Place for user 635	18	81	99	-63	2013-10-08 14:07:19	\N	24	2	t
1011	637	Spirit Place for user 637	34	-10	24	44	2013-10-08 14:07:19	2012-01-13 14:30:19	28	2	t
1012	639	Spirit Place for user 639	-18	-14	-32	-4	2013-10-08 14:07:19	2012-01-11 12:28:19	22	2	t
1013	641	Spirit Place for user 641	67	57	124	10	2013-10-08 14:07:19	2012-01-09 10:26:19	35	2	t
1014	643	Spirit Place for user 643	53	-36	17	89	2013-10-08 14:07:19	2012-01-07 08:24:19	36	2	t
1015	645	Spirit Place for user 645	3	46	49	-43	2013-10-08 14:07:19	\N	20	2	t
1016	647	Spirit Place for user 647	74	84	158	-10	2013-10-08 14:07:19	2012-01-03 04:20:19	31	2	t
1017	649	Spirit Place for user 649	13	5	18	8	2013-10-08 14:07:19	2012-01-01 02:18:19	29	2	t
1018	651	Spirit Place for user 651	-28	4	-24	-32	2013-10-08 14:07:19	2011-12-30 00:16:19	29	2	t
1019	653	Spirit Place for user 653	93	-40	53	133	2013-10-08 14:07:20	2011-12-27 22:14:19	25	2	t
1020	655	Spirit Place for user 655	2	84	86	-82	2013-10-08 14:07:20	\N	40	2	t
1021	657	Spirit Place for user 657	56	-23	33	79	2013-10-08 14:07:20	2011-12-23 18:10:20	26	2	t
1022	659	Spirit Place for user 659	41	60	101	-19	2013-10-08 14:07:20	2011-12-21 16:08:20	38	2	t
1023	661	Spirit Place for user 661	79	83	162	-4	2013-10-08 14:07:20	2011-12-19 14:06:20	44	2	t
1024	663	Spirit Place for user 663	-21	-40	-61	19	2013-10-08 14:07:20	2011-12-17 12:04:20	49	2	t
1025	665	Spirit Place for user 665	-9	49	40	-58	2013-10-08 14:07:20	\N	20	2	t
1026	667	Spirit Place for user 667	72	80	152	-8	2013-10-08 14:07:20	2011-12-13 08:00:20	28	2	t
1027	669	Spirit Place for user 669	-49	-38	-87	-11	2013-10-08 14:07:20	2011-12-11 05:58:20	45	2	t
1028	671	Spirit Place for user 671	21	72	93	-51	2013-10-08 14:07:20	2011-12-09 03:56:20	38	2	t
1029	673	Spirit Place for user 673	43	-37	6	80	2013-10-08 14:07:20	2011-12-07 01:54:20	34	2	t
1030	675	Spirit Place for user 675	-19	8	-11	-27	2013-10-08 14:07:21	\N	49	2	t
1031	677	Spirit Place for user 677	86	-6	80	92	2013-10-08 14:07:21	2011-12-02 21:50:21	49	2	t
1032	679	Spirit Place for user 679	70	-20	50	90	2013-10-08 14:07:21	2011-11-30 19:48:21	42	2	t
1033	681	Spirit Place for user 681	-44	11	-33	-55	2013-10-08 14:07:21	2011-11-28 17:46:21	38	2	t
1034	683	Spirit Place for user 683	80	29	109	51	2013-10-08 14:07:21	2011-11-26 15:44:21	25	2	t
1035	685	Spirit Place for user 685	94	48	142	46	2013-10-08 14:07:21	\N	37	2	t
1036	687	Spirit Place for user 687	-18	16	-2	-34	2013-10-08 14:07:21	2011-11-22 11:40:21	26	2	t
1037	689	Spirit Place for user 689	-46	61	15	-107	2013-10-08 14:07:21	2011-11-20 09:38:21	39	2	t
1038	691	Spirit Place for user 691	-47	28	-19	-75	2013-10-08 14:07:22	2011-11-18 07:36:21	41	2	t
1039	693	Spirit Place for user 693	67	54	121	13	2013-10-08 14:07:22	2011-11-16 05:34:22	35	2	t
1040	695	Spirit Place for user 695	45	65	110	-20	2013-10-08 14:07:22	\N	46	2	t
1041	697	Spirit Place for user 697	-45	-40	-85	-5	2013-10-08 14:07:22	2011-11-12 01:30:22	36	2	t
1042	699	Spirit Place for user 699	18	72	90	-54	2013-10-08 14:07:22	2011-11-09 23:28:22	25	2	t
1043	701	Spirit Place for user 701	92	-44	48	136	2013-10-08 14:07:22	2011-11-07 21:26:22	43	2	t
1044	703	Spirit Place for user 703	-11	7	-4	-18	2013-10-08 14:07:22	2011-11-05 19:24:22	22	2	t
1045	705	Spirit Place for user 705	91	-8	83	99	2013-10-08 14:07:22	\N	27	2	t
1046	707	Spirit Place for user 707	39	17	56	22	2013-10-08 14:07:22	2011-11-01 15:20:22	46	2	t
1047	709	Spirit Place for user 709	-10	-33	-43	23	2013-10-08 14:07:22	2011-10-30 13:18:22	36	2	t
1048	711	Spirit Place for user 711	-18	44	26	-62	2013-10-08 14:07:22	2011-10-28 11:16:22	34	2	t
1049	713	Spirit Place for user 713	27	49	76	-22	2013-10-08 14:07:22	2011-10-26 09:14:22	32	2	t
1050	715	Spirit Place for user 715	-45	19	-26	-64	2013-10-08 14:07:23	\N	32	2	t
1051	717	Spirit Place for user 717	73	-46	27	119	2013-10-08 14:07:23	2011-10-22 05:10:23	34	2	t
1052	719	Spirit Place for user 719	64	-3	61	67	2013-10-08 14:07:23	2011-10-20 03:08:23	27	2	t
1053	721	Spirit Place for user 721	-35	-23	-58	-12	2013-10-08 14:07:23	2011-10-18 01:06:23	36	2	t
1054	723	Spirit Place for user 723	38	44	82	-6	2013-10-08 14:07:23	2011-10-15 23:04:23	31	2	t
1055	725	Spirit Place for user 725	39	16	55	23	2013-10-08 14:07:23	\N	29	2	t
1056	727	Spirit Place for user 727	-31	3	-28	-34	2013-10-08 14:07:23	2011-10-11 19:00:23	23	2	t
1057	729	Spirit Place for user 729	91	35	126	56	2013-10-08 14:07:23	2011-10-09 16:58:23	41	2	t
1058	731	Spirit Place for user 731	-27	23	-4	-50	2013-10-08 14:07:23	2011-10-07 14:56:23	43	2	t
1059	733	Spirit Place for user 733	-2	55	53	-57	2013-10-08 14:07:23	2011-10-05 12:54:23	34	2	t
1060	735	Spirit Place for user 735	41	-45	-4	86	2013-10-08 14:07:23	\N	24	2	t
1061	737	Spirit Place for user 737	73	47	120	26	2013-10-08 14:07:23	2011-10-01 08:50:23	48	2	t
1062	739	Spirit Place for user 739	65	0	65	65	2013-10-08 14:07:23	2011-09-29 06:48:23	47	2	t
1063	741	Spirit Place for user 741	-5	66	61	-71	2013-10-08 14:07:24	2011-09-27 04:46:23	44	2	t
1064	743	Spirit Place for user 743	31	-7	24	38	2013-10-08 14:07:24	2011-09-25 02:44:24	25	2	t
1065	745	Spirit Place for user 745	-47	43	-4	-90	2013-10-08 14:07:24	\N	33	2	t
1066	747	Spirit Place for user 747	25	88	113	-63	2013-10-08 14:07:24	2011-09-20 22:40:24	45	2	t
1067	749	Spirit Place for user 749	40	93	133	-53	2013-10-08 14:07:24	2011-09-18 20:38:24	40	2	t
1068	751	Spirit Place for user 751	29	23	52	6	2013-10-08 14:07:24	2011-09-16 18:36:24	28	2	t
1069	753	Spirit Place for user 753	40	-4	36	44	2013-10-08 14:07:24	2011-09-14 16:34:24	43	2	t
1070	755	Spirit Place for user 755	-47	-28	-75	-19	2013-10-08 14:07:24	\N	36	2	t
1071	757	Spirit Place for user 757	4	100	104	-96	2013-10-08 14:07:24	2011-09-10 12:30:24	29	2	t
1072	759	Spirit Place for user 759	49	21	70	28	2013-10-08 14:07:24	2011-09-08 10:28:24	30	2	t
1073	761	Spirit Place for user 761	90	24	114	66	2013-10-08 14:07:24	2011-09-06 08:26:24	40	2	t
1074	763	Spirit Place for user 763	77	47	124	30	2013-10-08 14:07:24	2011-09-04 06:24:24	42	2	t
1075	765	Spirit Place for user 765	52	65	117	-13	2013-10-08 14:07:24	\N	20	2	t
1076	767	Spirit Place for user 767	-27	54	27	-81	2013-10-08 14:07:25	2011-08-31 02:20:25	21	2	t
1077	769	Spirit Place for user 769	5	72	77	-67	2013-10-08 14:07:25	2011-08-29 00:18:25	25	2	t
1078	771	Spirit Place for user 771	19	3	22	16	2013-10-08 14:07:25	2011-08-26 22:16:25	32	2	t
1079	773	Spirit Place for user 773	-35	41	6	-76	2013-10-08 14:07:25	2011-08-24 20:14:25	22	2	t
1080	775	Spirit Place for user 775	-1	21	20	-22	2013-10-08 14:07:25	\N	39	2	t
1081	777	Spirit Place for user 777	-49	-18	-67	-31	2013-10-08 14:07:25	2011-08-20 16:10:25	26	2	t
1082	779	Spirit Place for user 779	9	-20	-11	29	2013-10-08 14:07:25	2011-08-18 14:08:25	43	2	t
1083	781	Spirit Place for user 781	56	1	57	55	2013-10-08 14:07:25	2011-08-16 12:06:25	40	2	t
1084	783	Spirit Place for user 783	74	-4	70	78	2013-10-08 14:07:25	2011-08-14 10:04:25	29	2	t
1085	785	Spirit Place for user 785	-23	85	62	-108	2013-10-08 14:07:25	\N	20	2	t
1086	787	Spirit Place for user 787	47	100	147	-53	2013-10-08 14:07:25	2011-08-10 06:00:25	42	2	t
1087	789	Spirit Place for user 789	10	92	102	-82	2013-10-08 14:07:25	2011-08-08 03:58:25	27	2	t
1088	791	Spirit Place for user 791	-32	-42	-74	10	2013-10-08 14:07:25	2011-08-06 01:56:25	21	2	t
1089	793	Spirit Place for user 793	52	76	128	-24	2013-10-08 14:07:26	2011-08-03 23:54:25	21	2	t
1090	795	Spirit Place for user 795	94	-6	88	100	2013-10-08 14:07:26	\N	39	2	t
1091	797	Spirit Place for user 797	34	6	40	28	2013-10-08 14:07:29	2011-07-30 19:50:29	28	2	t
1092	799	Spirit Place for user 799	-31	63	32	-94	2013-10-08 14:07:30	2011-07-28 17:48:30	22	2	t
1093	801	Spirit Place for user 801	-17	98	81	-115	2013-10-08 14:07:30	2011-07-26 15:46:30	33	2	t
1094	803	Spirit Place for user 803	45	39	84	6	2013-10-08 14:07:31	2011-07-24 13:44:31	25	2	t
1095	805	Spirit Place for user 805	-44	62	18	-106	2013-10-08 14:07:31	\N	43	2	t
1096	807	Spirit Place for user 807	52	9	61	43	2013-10-08 14:07:31	2011-07-20 09:40:31	29	2	t
1097	809	Spirit Place for user 809	71	-21	50	92	2013-10-08 14:07:31	2011-07-18 07:38:31	24	2	t
1098	811	Spirit Place for user 811	21	69	90	-48	2013-10-08 14:07:31	2011-07-16 05:36:31	47	2	t
1099	813	Spirit Place for user 813	87	58	145	29	2013-10-08 14:07:31	2011-07-14 03:34:31	26	2	t
1100	815	Spirit Place for user 815	11	100	111	-89	2013-10-08 14:07:31	\N	42	2	t
1101	817	Spirit Place for user 817	-32	50	18	-82	2013-10-08 14:07:31	2011-07-09 23:30:31	47	2	t
1102	819	Spirit Place for user 819	25	59	84	-34	2013-10-08 14:07:31	2011-07-07 21:28:31	25	2	t
1103	821	Spirit Place for user 821	3	30	33	-27	2013-10-08 14:07:31	2011-07-05 19:26:31	27	2	t
1104	823	Spirit Place for user 823	37	52	89	-15	2013-10-08 14:07:31	2011-07-03 17:24:31	23	2	t
1105	825	Spirit Place for user 825	-44	-7	-51	-37	2013-10-08 14:07:31	\N	28	2	t
1106	827	Spirit Place for user 827	27	39	66	-12	2013-10-08 14:07:31	2011-06-29 13:20:31	28	2	t
1107	829	Spirit Place for user 829	-2	-40	-42	38	2013-10-08 14:07:32	2011-06-27 11:18:32	45	2	t
1108	831	Spirit Place for user 831	-47	-43	-90	-4	2013-10-08 14:07:32	2011-06-25 09:16:32	28	2	t
1109	833	Spirit Place for user 833	74	10	84	64	2013-10-08 14:07:32	2011-06-23 07:14:32	39	2	t
1110	835	Spirit Place for user 835	97	-37	60	134	2013-10-08 14:07:32	\N	27	2	t
1111	837	Spirit Place for user 837	75	-37	38	112	2013-10-08 14:07:32	2011-06-19 03:10:32	49	2	t
1112	839	Spirit Place for user 839	-8	-7	-15	-1	2013-10-08 14:07:32	2011-06-17 01:08:32	47	2	t
1113	841	Spirit Place for user 841	15	-45	-30	60	2013-10-08 14:07:32	2011-06-14 23:06:32	40	2	t
1114	843	Spirit Place for user 843	-13	-7	-20	-6	2013-10-08 14:07:32	2011-06-12 21:04:32	33	2	t
1115	845	Spirit Place for user 845	79	-50	29	129	2013-10-08 14:07:32	\N	37	2	t
1116	847	Spirit Place for user 847	99	1	100	98	2013-10-08 14:07:32	2011-06-08 17:00:32	41	2	t
1117	849	Spirit Place for user 849	-9	76	67	-85	2013-10-08 14:07:32	2011-06-06 14:58:32	40	2	t
1118	851	Spirit Place for user 851	94	3	97	91	2013-10-08 14:07:32	2011-06-04 12:56:32	28	2	t
1119	853	Spirit Place for user 853	-30	26	-4	-56	2013-10-08 14:07:32	2011-06-02 10:54:32	38	2	t
1120	855	Spirit Place for user 855	73	-49	24	122	2013-10-08 14:07:33	\N	43	2	t
1121	857	Spirit Place for user 857	95	22	117	73	2013-10-08 14:07:33	2011-05-29 06:50:33	46	2	t
1122	859	Spirit Place for user 859	-50	90	40	-140	2013-10-08 14:07:33	2011-05-27 04:48:33	36	2	t
1123	861	Spirit Place for user 861	-44	26	-18	-70	2013-10-08 14:07:33	2011-05-25 02:46:33	36	2	t
1124	863	Spirit Place for user 863	4	-24	-20	28	2013-10-08 14:07:33	2011-05-23 00:44:33	43	2	t
1125	865	Spirit Place for user 865	-23	62	39	-85	2013-10-08 14:07:33	\N	28	2	t
1126	867	Spirit Place for user 867	-43	64	21	-107	2013-10-08 14:07:33	2011-05-18 20:40:33	49	2	t
1127	869	Spirit Place for user 869	52	9	61	43	2013-10-08 14:07:33	2011-05-16 18:38:33	30	2	t
1128	871	Spirit Place for user 871	95	64	159	31	2013-10-08 14:07:33	2011-05-14 16:36:33	41	2	t
1129	873	Spirit Place for user 873	68	34	102	34	2013-10-08 14:07:33	2011-05-12 14:34:33	23	2	t
1130	875	Spirit Place for user 875	-39	97	58	-136	2013-10-08 14:07:33	\N	22	2	t
1131	877	Spirit Place for user 877	36	3	39	33	2013-10-08 14:07:33	2011-05-08 10:30:33	35	2	t
1132	879	Spirit Place for user 879	84	82	166	2	2013-10-08 14:07:33	2011-05-06 08:28:33	42	2	t
1133	881	Spirit Place for user 881	-48	50	2	-98	2013-10-08 14:07:34	2011-05-04 06:26:33	44	2	t
1134	883	Spirit Place for user 883	-30	-43	-73	13	2013-10-08 14:07:34	2011-05-02 04:24:34	21	2	t
1135	885	Spirit Place for user 885	2	85	87	-83	2013-10-08 14:07:34	\N	44	2	t
1136	887	Spirit Place for user 887	13	7	20	6	2013-10-08 14:07:34	2011-04-28 00:20:34	47	2	t
1137	889	Spirit Place for user 889	-31	32	1	-63	2013-10-08 14:07:34	2011-04-25 22:18:34	35	2	t
1138	891	Spirit Place for user 891	37	39	76	-2	2013-10-08 14:07:34	2011-04-23 20:16:34	40	2	t
1139	893	Spirit Place for user 893	48	37	85	11	2013-10-08 14:07:34	2011-04-21 18:14:34	47	2	t
1140	895	Spirit Place for user 895	35	-16	19	51	2013-10-08 14:07:34	\N	46	2	t
1141	897	Spirit Place for user 897	3	44	47	-41	2013-10-08 14:07:34	2011-04-17 14:10:34	36	2	t
1142	899	Spirit Place for user 899	5	-17	-12	22	2013-10-08 14:07:34	2011-04-15 12:08:34	31	2	t
1143	901	Spirit Place for user 901	18	9	27	9	2013-10-08 14:07:34	2011-04-13 10:06:34	35	2	t
1144	903	Spirit Place for user 903	27	-29	-2	56	2013-10-08 14:07:34	2011-04-11 08:04:34	36	2	t
1145	905	Spirit Place for user 905	-7	-15	-22	8	2013-10-08 14:07:35	\N	27	2	t
1146	907	Spirit Place for user 907	28	-44	-16	72	2013-10-08 14:07:35	2011-04-07 04:00:35	40	2	t
1147	909	Spirit Place for user 909	-32	50	18	-82	2013-10-08 14:07:35	2011-04-05 01:58:35	22	2	t
1148	911	Spirit Place for user 911	-29	71	42	-100	2013-10-08 14:07:35	2011-04-02 23:56:35	33	2	t
1149	913	Spirit Place for user 913	-37	26	-11	-63	2013-10-08 14:07:35	2011-03-31 21:54:35	24	2	t
1150	915	Spirit Place for user 915	20	40	60	-20	2013-10-08 14:07:35	\N	22	2	t
1151	917	Spirit Place for user 917	55	9	64	46	2013-10-08 14:07:35	2011-03-27 17:50:35	26	2	t
1152	919	Spirit Place for user 919	69	-47	22	116	2013-10-08 14:07:35	2011-03-25 15:48:35	37	2	t
1153	921	Spirit Place for user 921	-43	42	-1	-85	2013-10-08 14:07:35	2011-03-23 13:46:35	31	2	t
1154	923	Spirit Place for user 923	31	87	118	-56	2013-10-08 14:07:35	2011-03-21 11:44:35	49	2	t
1155	925	Spirit Place for user 925	6	-7	-1	13	2013-10-08 14:07:35	\N	45	2	t
1156	927	Spirit Place for user 927	33	13	46	20	2013-10-08 14:07:35	2011-03-17 07:40:35	39	2	t
1157	929	Spirit Place for user 929	-44	45	1	-89	2013-10-08 14:07:35	2011-03-15 05:38:35	33	2	t
1158	931	Spirit Place for user 931	-12	37	25	-49	2013-10-08 14:07:36	2011-03-13 03:36:35	45	2	t
1159	933	Spirit Place for user 933	-32	-3	-35	-29	2013-10-08 14:07:36	2011-03-11 01:34:36	31	2	t
1160	935	Spirit Place for user 935	33	-41	-8	74	2013-10-08 14:07:36	\N	31	2	t
1161	937	Spirit Place for user 937	53	-34	19	87	2013-10-08 14:07:36	2011-03-06 21:30:36	44	2	t
1162	939	Spirit Place for user 939	-24	81	57	-105	2013-10-08 14:07:36	2011-03-04 19:28:36	31	2	t
1163	941	Spirit Place for user 941	0	86	86	-86	2013-10-08 14:07:36	2011-03-02 17:26:36	35	2	t
1164	943	Spirit Place for user 943	-45	43	-2	-88	2013-10-08 14:07:36	2011-02-28 15:24:36	21	2	t
1165	945	Spirit Place for user 945	-31	5	-26	-36	2013-10-08 14:07:36	\N	41	2	t
1166	947	Spirit Place for user 947	9	61	70	-52	2013-10-08 14:07:36	2011-02-24 11:20:36	44	2	t
1167	949	Spirit Place for user 949	8	-43	-35	51	2013-10-08 14:07:36	2011-02-22 09:18:36	47	2	t
1168	951	Spirit Place for user 951	-42	-18	-60	-24	2013-10-08 14:07:36	2011-02-20 07:16:36	47	2	t
1169	953	Spirit Place for user 953	26	-1	25	27	2013-10-08 14:07:36	2011-02-18 05:14:36	38	2	t
1170	955	Spirit Place for user 955	51	-4	47	55	2013-10-08 14:07:36	\N	23	2	t
1171	957	Spirit Place for user 957	51	89	140	-38	2013-10-08 14:07:37	2011-02-14 01:10:36	31	2	t
1172	959	Spirit Place for user 959	18	12	30	6	2013-10-08 14:07:37	2011-02-11 23:08:37	43	2	t
1173	961	Spirit Place for user 961	19	94	113	-75	2013-10-08 14:07:37	2011-02-09 21:06:37	36	2	t
1174	963	Spirit Place for user 963	36	-7	29	43	2013-10-08 14:07:37	2011-02-07 19:04:37	42	2	t
1175	965	Spirit Place for user 965	33	-34	-1	67	2013-10-08 14:07:37	\N	44	2	t
1176	967	Spirit Place for user 967	29	-6	23	35	2013-10-08 14:07:37	2011-02-03 15:00:37	33	2	t
1177	969	Spirit Place for user 969	73	40	113	33	2013-10-08 14:07:37	2011-02-01 12:58:37	36	2	t
1178	971	Spirit Place for user 971	55	49	104	6	2013-10-08 14:07:37	2011-01-30 10:56:37	22	2	t
1179	973	Spirit Place for user 973	62	-23	39	85	2013-10-08 14:07:37	2011-01-28 08:54:37	27	2	t
1180	975	Spirit Place for user 975	13	23	36	-10	2013-10-08 14:07:37	\N	38	2	t
1181	977	Spirit Place for user 977	32	62	94	-30	2013-10-08 14:07:37	2011-01-24 04:50:37	20	2	t
1182	979	Spirit Place for user 979	75	49	124	26	2013-10-08 14:07:37	2011-01-22 02:48:37	49	2	t
1183	981	Spirit Place for user 981	49	0	49	49	2013-10-08 14:07:37	2011-01-20 00:46:37	39	2	t
1184	983	Spirit Place for user 983	-27	100	73	-127	2013-10-08 14:07:38	2011-01-17 22:44:37	38	2	t
1185	985	Spirit Place for user 985	61	33	94	28	2013-10-08 14:07:38	\N	28	2	t
1186	987	Spirit Place for user 987	16	-23	-7	39	2013-10-08 14:07:38	2011-01-13 18:40:38	32	2	t
1187	989	Spirit Place for user 989	24	62	86	-38	2013-10-08 14:07:38	2011-01-11 16:38:38	27	2	t
1188	991	Spirit Place for user 991	74	86	160	-12	2013-10-08 14:07:38	2011-01-09 14:36:38	30	2	t
1189	993	Spirit Place for user 993	95	-7	88	102	2013-10-08 14:07:38	2011-01-07 12:34:38	21	2	t
1190	995	Spirit Place for user 995	89	-37	52	126	2013-10-08 14:07:38	\N	47	2	t
1191	997	Spirit Place for user 997	11	27	38	-16	2013-10-08 14:07:39	2011-01-03 08:30:38	29	2	t
1192	999	Spirit Place for user 999	93	3	96	90	2013-10-08 14:07:39	2011-01-01 06:28:39	45	2	t
1193	1001	Spirit Place for user 1001	-19	12	-7	-31	2013-10-08 14:07:41	2010-12-30 04:26:41	20	2	t
1194	1003	Spirit Place for user 1003	-30	63	33	-93	2013-10-08 14:07:41	2010-12-28 02:24:41	49	2	t
1195	1005	Spirit Place for user 1005	-47	-38	-85	-9	2013-10-08 14:07:41	\N	46	2	t
1196	1007	Spirit Place for user 1007	25	-32	-7	57	2013-10-08 14:07:41	2010-12-23 22:20:41	43	2	t
1197	1009	Spirit Place for user 1009	-48	7	-41	-55	2013-10-08 14:07:41	2010-12-21 20:18:41	36	2	t
1198	1011	Spirit Place for user 1011	13	-43	-30	56	2013-10-08 14:07:41	2010-12-19 18:16:41	22	2	t
1199	1013	Spirit Place for user 1013	-31	95	64	-126	2013-10-08 14:07:41	2010-12-17 16:14:41	45	2	t
1200	1015	Spirit Place for user 1015	20	-15	5	35	2013-10-08 14:07:41	\N	32	2	t
1201	1017	Spirit Place for user 1017	16	70	86	-54	2013-10-08 14:07:41	2010-12-13 12:10:41	39	2	t
1202	1019	Spirit Place for user 1019	46	14	60	32	2013-10-08 14:07:41	2010-12-11 10:08:41	20	2	t
1203	1021	Spirit Place for user 1021	18	59	77	-41	2013-10-08 14:07:41	2010-12-09 08:06:41	22	2	t
1204	1023	Spirit Place for user 1023	-48	-3	-51	-45	2013-10-08 14:07:41	2010-12-07 06:04:41	38	2	t
1205	1025	Spirit Place for user 1025	37	48	85	-11	2013-10-08 14:07:42	\N	30	2	t
1206	1027	Spirit Place for user 1027	-4	-8	-12	4	2013-10-08 14:07:42	2010-12-03 02:00:42	45	2	t
1207	1029	Spirit Place for user 1029	-20	-23	-43	3	2013-10-08 14:07:42	2010-11-30 23:58:42	43	2	t
1208	1031	Spirit Place for user 1031	-39	22	-17	-61	2013-10-08 14:07:42	2010-11-28 21:56:42	25	2	t
1209	1033	Spirit Place for user 1033	-1	45	44	-46	2013-10-08 14:07:42	2010-11-26 19:54:42	40	2	t
1210	1035	Spirit Place for user 1035	37	26	63	11	2013-10-08 14:07:42	\N	26	2	t
1211	1037	Spirit Place for user 1037	29	-42	-13	71	2013-10-08 14:07:42	2010-11-22 15:50:42	26	2	t
1212	1039	Spirit Place for user 1039	13	-12	1	25	2013-10-08 14:07:42	2010-11-20 13:48:42	48	2	t
1213	1041	Spirit Place for user 1041	99	13	112	86	2013-10-08 14:07:42	2010-11-18 11:46:42	28	2	t
1214	1043	Spirit Place for user 1043	-15	-20	-35	5	2013-10-08 14:07:42	2010-11-16 09:44:42	28	2	t
1215	1045	Spirit Place for user 1045	7	91	98	-84	2013-10-08 14:07:42	\N	45	2	t
1216	1047	Spirit Place for user 1047	76	68	144	8	2013-10-08 14:07:42	2010-11-12 05:40:42	44	2	t
1217	1049	Spirit Place for user 1049	-19	11	-8	-30	2013-10-08 14:07:42	2010-11-10 03:38:42	45	2	t
1218	4	Spirit Place for user 4	91	46	137	45	2013-10-08 14:07:43	2013-11-03 10:03:42	34	2	t
1219	5	Spirit Place for user 5	12	-32	-20	44	2013-10-08 14:07:43	\N	33	2	t
1220	7	Spirit Place for user 7	15	8	23	7	2013-10-08 14:07:43	2013-10-31 07:00:43	43	2	t
1221	8	Spirit Place for user 8	-3	-40	-43	37	2013-10-08 14:07:43	2013-10-30 05:59:43	32	2	t
1222	10	Spirit Place for user 10	-22	4	-18	-26	2013-10-08 14:07:43	\N	20	2	t
1223	11	Spirit Place for user 11	-3	20	17	-23	2013-10-08 14:07:43	2013-10-27 02:56:43	49	2	t
1224	13	Spirit Place for user 13	55	73	128	-18	2013-10-08 14:07:43	2013-10-25 00:54:43	26	2	t
1225	14	Spirit Place for user 14	-3	68	65	-71	2013-10-08 14:07:43	2013-10-23 23:53:43	48	2	t
1226	16	Spirit Place for user 16	3	68	71	-65	2013-10-08 14:07:43	2013-10-21 21:51:43	29	2	t
1227	17	Spirit Place for user 17	-22	-3	-25	-19	2013-10-08 14:07:43	2013-10-20 20:50:43	43	2	t
1228	19	Spirit Place for user 19	44	69	113	-25	2013-10-08 14:07:43	2013-10-18 18:48:43	45	2	t
1229	20	Spirit Place for user 20	45	50	95	-5	2013-10-08 14:07:44	\N	48	2	t
1230	22	Spirit Place for user 22	88	-13	75	101	2013-10-08 14:07:44	2013-10-15 15:45:44	27	2	t
1231	23	Spirit Place for user 23	84	12	96	72	2013-10-08 14:07:44	2013-10-14 14:44:44	40	2	t
1232	25	Spirit Place for user 25	52	96	148	-44	2013-10-08 14:07:44	\N	38	2	t
1233	26	Spirit Place for user 26	-3	-34	-37	31	2013-10-08 14:07:44	2013-10-11 11:41:44	49	2	t
1234	28	Spirit Place for user 28	-24	50	26	-74	2013-10-08 14:07:44	2013-10-09 09:39:44	20	2	t
1235	29	Spirit Place for user 29	-41	-21	-62	-20	2013-10-08 14:07:44	2013-10-08 08:38:44	23	2	t
1236	31	Spirit Place for user 31	40	30	70	10	2013-10-08 14:07:44	2013-10-06 06:36:44	37	2	t
1237	32	Spirit Place for user 32	62	-40	22	102	2013-10-08 14:07:44	2013-10-05 05:35:44	31	2	t
1238	34	Spirit Place for user 34	3	76	79	-73	2013-10-08 14:07:44	2013-10-03 03:33:44	46	2	t
1239	35	Spirit Place for user 35	-6	46	40	-52	2013-10-08 14:07:44	\N	48	2	t
1240	37	Spirit Place for user 37	-41	57	16	-98	2013-10-08 14:07:44	2013-09-30 00:30:44	21	2	t
1241	38	Spirit Place for user 38	67	75	142	-8	2013-10-08 14:07:45	2013-09-28 23:29:44	38	2	t
1242	40	Spirit Place for user 40	98	82	180	16	2013-10-08 14:07:45	\N	37	2	t
1243	41	Spirit Place for user 41	96	2	98	94	2013-10-08 14:07:45	2013-09-25 20:26:45	41	2	t
1244	43	Spirit Place for user 43	10	52	62	-42	2013-10-08 14:07:45	2013-09-23 18:24:45	24	2	t
1245	44	Spirit Place for user 44	80	-35	45	115	2013-10-08 14:07:45	2013-09-22 17:23:45	41	2	t
1246	46	Spirit Place for user 46	57	33	90	24	2013-10-08 14:07:45	2013-09-20 15:21:45	37	2	t
1247	47	Spirit Place for user 47	-19	36	17	-55	2013-10-08 14:07:45	2013-09-19 14:20:45	39	2	t
1248	49	Spirit Place for user 49	6	-17	-11	23	2013-10-08 14:07:45	2013-09-17 12:18:45	36	2	t
1249	50	Spirit Place for user 50	-30	-10	-40	-20	2013-10-08 14:07:45	\N	34	2	t
1250	52	Spirit Place for user 52	73	-4	69	77	2013-10-08 14:07:45	2013-09-14 09:15:45	29	2	t
1251	53	Spirit Place for user 53	91	-37	54	128	2013-10-08 14:07:45	2013-09-13 08:14:45	32	2	t
1252	55	Spirit Place for user 55	57	-38	19	95	2013-10-08 14:07:45	\N	32	2	t
1253	56	Spirit Place for user 56	-26	73	47	-99	2013-10-08 14:07:46	2013-09-10 05:11:45	30	2	t
1254	58	Spirit Place for user 58	74	25	99	49	2013-10-08 14:07:46	2013-09-08 03:09:46	29	2	t
1255	59	Spirit Place for user 59	-49	-37	-86	-12	2013-10-08 14:07:46	2013-09-07 02:08:46	36	2	t
1256	61	Spirit Place for user 61	57	-1	56	58	2013-10-08 14:07:46	2013-09-05 00:06:46	25	2	t
1257	62	Spirit Place for user 62	34	-47	-13	81	2013-10-08 14:07:46	2013-09-03 23:05:46	24	2	t
1258	64	Spirit Place for user 64	-34	-12	-46	-22	2013-10-08 14:07:46	2013-09-01 21:03:46	24	2	t
1259	65	Spirit Place for user 65	3	-50	-47	53	2013-10-08 14:07:46	\N	23	2	t
1260	67	Spirit Place for user 67	9	39	48	-30	2013-10-08 14:07:46	2013-08-29 18:00:46	26	2	t
1261	68	Spirit Place for user 68	6	-16	-10	22	2013-10-08 14:07:46	2013-08-28 16:59:46	28	2	t
1262	70	Spirit Place for user 70	8	91	99	-83	2013-10-08 14:07:46	\N	44	2	t
1263	71	Spirit Place for user 71	-20	-38	-58	18	2013-10-08 14:07:46	2013-08-25 13:56:46	49	2	t
1264	73	Spirit Place for user 73	8	5	13	3	2013-10-08 14:07:47	2013-08-23 11:54:47	48	2	t
1265	74	Spirit Place for user 74	44	-46	-2	90	2013-10-08 14:07:47	2013-08-22 10:53:47	31	2	t
1266	76	Spirit Place for user 76	0	-28	-28	28	2013-10-08 14:07:47	2013-08-20 08:51:47	20	2	t
1267	77	Spirit Place for user 77	38	54	92	-16	2013-10-08 14:07:47	2013-08-19 07:50:47	30	2	t
1268	79	Spirit Place for user 79	17	38	55	-21	2013-10-08 14:07:47	2013-08-17 05:48:47	33	2	t
1269	80	Spirit Place for user 80	100	-18	82	118	2013-10-08 14:07:47	\N	43	2	t
1270	82	Spirit Place for user 82	74	23	97	51	2013-10-08 14:07:47	2013-08-14 02:45:47	20	2	t
1271	83	Spirit Place for user 83	55	73	128	-18	2013-10-08 14:07:47	2013-08-13 01:44:47	36	2	t
1272	85	Spirit Place for user 85	55	14	69	41	2013-10-08 14:07:47	\N	31	2	t
1273	86	Spirit Place for user 86	40	-8	32	48	2013-10-08 14:07:47	2013-08-09 22:41:47	46	2	t
1274	88	Spirit Place for user 88	70	80	150	-10	2013-10-08 14:07:47	2013-08-07 20:39:47	47	2	t
1275	89	Spirit Place for user 89	-16	26	10	-42	2013-10-08 14:07:47	2013-08-06 19:38:47	24	2	t
1276	91	Spirit Place for user 91	-36	51	15	-87	2013-10-08 14:07:48	2013-08-04 17:36:47	31	2	t
1277	92	Spirit Place for user 92	48	-8	40	56	2013-10-08 14:07:48	2013-08-03 16:35:48	49	2	t
1278	94	Spirit Place for user 94	13	-23	-10	36	2013-10-08 14:07:48	2013-08-01 14:33:48	43	2	t
1279	95	Spirit Place for user 95	39	-10	29	49	2013-10-08 14:07:48	\N	32	2	t
1280	97	Spirit Place for user 97	39	3	42	36	2013-10-08 14:07:48	2013-07-29 11:30:48	41	2	t
1281	98	Spirit Place for user 98	20	35	55	-15	2013-10-08 14:07:48	2013-07-28 10:29:48	22	2	t
1282	100	Spirit Place for user 100	0	-33	-33	33	2013-10-08 14:07:48	\N	28	2	t
1283	101	Spirit Place for user 101	99	-1	98	100	2013-10-08 14:07:48	2013-07-25 07:26:48	24	2	t
1284	103	Spirit Place for user 103	-21	-6	-27	-15	2013-10-08 14:07:48	2013-07-23 05:24:48	41	2	t
1285	104	Spirit Place for user 104	-38	75	37	-113	2013-10-08 14:07:48	2013-07-22 04:23:48	20	2	t
1286	106	Spirit Place for user 106	-17	48	31	-65	2013-10-08 14:07:48	2013-07-20 02:21:48	24	2	t
1287	107	Spirit Place for user 107	-16	27	11	-43	2013-10-08 14:07:49	2013-07-19 01:20:49	35	2	t
1288	109	Spirit Place for user 109	79	63	142	16	2013-10-08 14:07:49	2013-07-16 23:18:49	25	2	t
1289	110	Spirit Place for user 110	98	4	102	94	2013-10-08 14:07:49	\N	24	2	t
1290	112	Spirit Place for user 112	54	21	75	33	2013-10-08 14:07:49	2013-07-13 20:15:49	30	2	t
1291	113	Spirit Place for user 113	27	67	94	-40	2013-10-08 14:07:49	2013-07-12 19:14:49	42	2	t
1292	115	Spirit Place for user 115	11	4	15	7	2013-10-08 14:07:49	\N	31	2	t
1293	116	Spirit Place for user 116	-16	-37	-53	21	2013-10-08 14:07:49	2013-07-09 16:11:49	34	2	t
1294	118	Spirit Place for user 118	21	95	116	-74	2013-10-08 14:07:50	2013-07-07 14:09:50	25	2	t
1295	119	Spirit Place for user 119	-42	93	51	-135	2013-10-08 14:07:50	2013-07-06 13:08:50	41	2	t
1296	121	Spirit Place for user 121	-21	-19	-40	-2	2013-10-08 14:07:50	2013-07-04 11:06:50	26	2	t
1297	122	Spirit Place for user 122	-2	-21	-23	19	2013-10-08 14:07:50	2013-07-03 10:05:50	33	2	t
1298	124	Spirit Place for user 124	12	60	72	-48	2013-10-08 14:07:50	2013-07-01 08:03:50	37	2	t
1299	125	Spirit Place for user 125	-31	68	37	-99	2013-10-08 14:07:50	\N	22	2	t
1300	127	Spirit Place for user 127	79	47	126	32	2013-10-08 14:07:50	2013-06-28 05:00:50	49	2	t
1301	128	Spirit Place for user 128	-21	67	46	-88	2013-10-08 14:07:50	2013-06-27 03:59:50	33	2	t
1302	130	Spirit Place for user 130	-27	-48	-75	21	2013-10-08 14:07:50	\N	28	2	t
1303	131	Spirit Place for user 131	0	100	100	-100	2013-10-08 14:07:50	2013-06-24 00:56:50	43	2	t
1304	133	Spirit Place for user 133	36	0	36	36	2013-10-08 14:07:51	2013-06-21 22:54:51	49	2	t
1305	134	Spirit Place for user 134	100	60	160	40	2013-10-08 14:07:51	2013-06-20 21:53:51	37	2	t
1306	136	Spirit Place for user 136	61	34	95	27	2013-10-08 14:07:51	2013-06-18 19:51:51	40	2	t
1307	137	Spirit Place for user 137	68	-47	21	115	2013-10-08 14:07:51	2013-06-17 18:50:51	20	2	t
1308	139	Spirit Place for user 139	62	64	126	-2	2013-10-08 14:07:51	2013-06-15 16:48:51	36	2	t
1309	140	Spirit Place for user 140	74	-17	57	91	2013-10-08 14:07:51	\N	22	2	t
1310	142	Spirit Place for user 142	76	-17	59	93	2013-10-08 14:07:51	2013-06-12 13:45:51	22	2	t
1311	143	Spirit Place for user 143	-44	-32	-76	-12	2013-10-08 14:07:51	2013-06-11 12:44:51	25	2	t
1312	145	Spirit Place for user 145	71	75	146	-4	2013-10-08 14:07:51	\N	20	2	t
1313	146	Spirit Place for user 146	-8	-42	-50	34	2013-10-08 14:07:51	2013-06-08 09:41:51	36	2	t
1314	148	Spirit Place for user 148	67	10	77	57	2013-10-08 14:07:51	2013-06-06 07:39:51	41	2	t
1315	149	Spirit Place for user 149	83	80	163	3	2013-10-08 14:07:51	2013-06-05 06:38:51	35	2	t
1316	151	Spirit Place for user 151	71	-18	53	89	2013-10-08 14:07:52	2013-06-03 04:36:51	31	2	t
1317	152	Spirit Place for user 152	-38	60	22	-98	2013-10-08 14:07:52	2013-06-02 03:35:52	41	2	t
1318	154	Spirit Place for user 154	79	23	102	56	2013-10-08 14:07:52	2013-05-31 01:33:52	33	2	t
1319	155	Spirit Place for user 155	28	-44	-16	72	2013-10-08 14:07:52	\N	41	2	t
1320	157	Spirit Place for user 157	-2	69	67	-71	2013-10-08 14:07:52	2013-05-27 22:30:52	36	2	t
1321	158	Spirit Place for user 158	20	76	96	-56	2013-10-08 14:07:52	2013-05-26 21:29:52	48	2	t
1322	160	Spirit Place for user 160	45	87	132	-42	2013-10-08 14:07:52	\N	42	2	t
1323	161	Spirit Place for user 161	77	-6	71	83	2013-10-08 14:07:52	2013-05-23 18:26:52	42	2	t
1324	163	Spirit Place for user 163	-15	36	21	-51	2013-10-08 14:07:52	2013-05-21 16:24:52	25	2	t
1325	164	Spirit Place for user 164	-30	74	44	-104	2013-10-08 14:07:52	2013-05-20 15:23:52	28	2	t
1326	166	Spirit Place for user 166	2	-11	-9	13	2013-10-08 14:07:52	2013-05-18 13:21:52	23	2	t
1327	167	Spirit Place for user 167	12	-37	-25	49	2013-10-08 14:07:52	2013-05-17 12:20:52	45	2	t
1328	169	Spirit Place for user 169	74	58	132	16	2013-10-08 14:07:52	2013-05-15 10:18:52	20	2	t
1329	170	Spirit Place for user 170	14	-15	-1	29	2013-10-08 14:07:53	\N	35	2	t
1330	172	Spirit Place for user 172	29	25	54	4	2013-10-08 14:07:53	2013-05-12 07:15:53	30	2	t
1331	173	Spirit Place for user 173	-36	85	49	-121	2013-10-08 14:07:53	2013-05-11 06:14:53	27	2	t
1332	175	Spirit Place for user 175	67	-4	63	71	2013-10-08 14:07:53	\N	39	2	t
1333	176	Spirit Place for user 176	70	74	144	-4	2013-10-08 14:07:53	2013-05-08 03:11:53	20	2	t
1334	178	Spirit Place for user 178	-9	57	48	-66	2013-10-08 14:07:53	2013-05-06 01:09:53	38	2	t
1335	179	Spirit Place for user 179	-33	60	27	-93	2013-10-08 14:07:53	2013-05-05 00:08:53	39	2	t
1336	181	Spirit Place for user 181	24	100	124	-76	2013-10-08 14:07:53	2013-05-02 22:06:53	31	2	t
1337	182	Spirit Place for user 182	75	-46	29	121	2013-10-08 14:07:53	2013-05-01 21:05:53	31	2	t
1338	184	Spirit Place for user 184	27	-40	-13	67	2013-10-08 14:07:53	2013-04-29 19:03:53	47	2	t
1339	185	Spirit Place for user 185	91	78	169	13	2013-10-08 14:07:53	\N	22	2	t
1340	187	Spirit Place for user 187	5	-18	-13	23	2013-10-08 14:07:53	2013-04-26 16:00:53	36	2	t
1341	188	Spirit Place for user 188	62	46	108	16	2013-10-08 14:07:54	2013-04-25 14:59:54	35	2	t
1342	190	Spirit Place for user 190	78	46	124	32	2013-10-08 14:07:54	\N	24	2	t
1343	191	Spirit Place for user 191	53	31	84	22	2013-10-08 14:07:54	2013-04-22 11:56:54	24	2	t
1344	193	Spirit Place for user 193	70	13	83	57	2013-10-08 14:07:54	2013-04-20 09:54:54	29	2	t
1345	194	Spirit Place for user 194	-10	-34	-44	24	2013-10-08 14:07:54	2013-04-19 08:53:54	22	2	t
1346	196	Spirit Place for user 196	53	59	112	-6	2013-10-08 14:07:54	2013-04-17 06:51:54	31	2	t
1347	197	Spirit Place for user 197	-14	59	45	-73	2013-10-08 14:07:54	2013-04-16 05:50:54	35	2	t
1348	199	Spirit Place for user 199	87	29	116	58	2013-10-08 14:07:54	2013-04-14 03:48:54	30	2	t
1349	200	Spirit Place for user 200	-44	-3	-47	-41	2013-10-08 14:07:54	\N	34	2	t
1350	202	Spirit Place for user 202	80	30	110	50	2013-10-08 14:07:54	2013-04-11 00:45:54	34	2	t
1351	203	Spirit Place for user 203	48	93	141	-45	2013-10-08 14:07:54	2013-04-09 23:44:54	33	2	t
1352	205	Spirit Place for user 205	53	43	96	10	2013-10-08 14:07:55	\N	40	2	t
1353	206	Spirit Place for user 206	-26	-7	-33	-19	2013-10-08 14:07:55	2013-04-06 20:41:55	29	2	t
1354	208	Spirit Place for user 208	42	11	53	31	2013-10-08 14:07:55	2013-04-04 18:39:55	49	2	t
1355	209	Spirit Place for user 209	12	-49	-37	61	2013-10-08 14:07:55	2013-04-03 17:38:55	20	2	t
1356	211	Spirit Place for user 211	11	22	33	-11	2013-10-08 14:07:55	2013-04-01 15:36:55	24	2	t
1357	212	Spirit Place for user 212	53	-9	44	62	2013-10-08 14:07:55	2013-03-31 14:35:55	40	2	t
1358	214	Spirit Place for user 214	42	-45	-3	87	2013-10-08 14:07:55	2013-03-29 12:33:55	40	2	t
1359	215	Spirit Place for user 215	15	-43	-28	58	2013-10-08 14:07:55	\N	38	2	t
1360	217	Spirit Place for user 217	16	5	21	11	2013-10-08 14:07:55	2013-03-26 09:30:55	29	2	t
1361	218	Spirit Place for user 218	74	22	96	52	2013-10-08 14:07:55	2013-03-25 08:29:55	41	2	t
1362	220	Spirit Place for user 220	-49	-18	-67	-31	2013-10-08 14:07:55	\N	23	2	t
1363	221	Spirit Place for user 221	58	45	103	13	2013-10-08 14:07:55	2013-03-22 05:26:55	39	2	t
1364	223	Spirit Place for user 223	17	-1	16	18	2013-10-08 14:07:55	2013-03-20 03:24:55	41	2	t
1365	224	Spirit Place for user 224	29	99	128	-70	2013-10-08 14:07:56	2013-03-19 02:23:56	36	2	t
1366	226	Spirit Place for user 226	85	27	112	58	2013-10-08 14:07:56	2013-03-17 00:21:56	26	2	t
1367	227	Spirit Place for user 227	63	0	63	63	2013-10-08 14:07:56	2013-03-15 23:20:56	28	2	t
1368	229	Spirit Place for user 229	-39	-6	-45	-33	2013-10-08 14:07:56	2013-03-13 21:18:56	46	2	t
1369	230	Spirit Place for user 230	-43	51	8	-94	2013-10-08 14:07:56	\N	20	2	t
1370	232	Spirit Place for user 232	49	30	79	19	2013-10-08 14:07:56	2013-03-10 18:15:56	48	2	t
1371	233	Spirit Place for user 233	14	55	69	-41	2013-10-08 14:07:56	2013-03-09 17:14:56	44	2	t
1372	235	Spirit Place for user 235	30	-50	-20	80	2013-10-08 14:07:56	\N	25	2	t
1373	236	Spirit Place for user 236	-37	14	-23	-51	2013-10-08 14:07:56	2013-03-06 14:11:56	48	2	t
1374	238	Spirit Place for user 238	-8	50	42	-58	2013-10-08 14:08:00	2013-03-04 12:09:56	43	2	t
1375	239	Spirit Place for user 239	2	-11	-9	13	2013-10-08 14:08:01	2013-03-03 11:09:01	27	2	t
1376	241	Spirit Place for user 241	-30	5	-25	-35	2013-10-08 14:08:02	2013-03-01 09:07:01	37	2	t
1377	242	Spirit Place for user 242	-35	-18	-53	-17	2013-10-08 14:08:02	2013-02-28 08:06:02	38	2	t
1378	244	Spirit Place for user 244	-31	59	28	-90	2013-10-08 14:08:02	2013-02-26 06:04:02	39	2	t
1379	245	Spirit Place for user 245	-35	59	24	-94	2013-10-08 14:08:02	\N	42	2	t
1380	247	Spirit Place for user 247	36	6	42	30	2013-10-08 14:08:02	2013-02-23 03:01:02	29	2	t
1381	248	Spirit Place for user 248	65	10	75	55	2013-10-08 14:08:02	2013-02-22 02:00:02	22	2	t
1382	250	Spirit Place for user 250	18	18	36	0	2013-10-08 14:08:02	\N	45	2	t
1383	251	Spirit Place for user 251	66	28	94	38	2013-10-08 14:08:02	2013-02-18 22:57:02	41	2	t
1384	253	Spirit Place for user 253	82	13	95	69	2013-10-08 14:08:02	2013-02-16 20:55:02	49	2	t
1385	254	Spirit Place for user 254	79	21	100	58	2013-10-08 14:08:02	2013-02-15 19:54:02	45	2	t
1386	256	Spirit Place for user 256	-22	68	46	-90	2013-10-08 14:08:02	2013-02-13 17:52:02	27	2	t
1387	257	Spirit Place for user 257	60	15	75	45	2013-10-08 14:08:02	2013-02-12 16:51:02	30	2	t
1388	259	Spirit Place for user 259	-21	-9	-30	-12	2013-10-08 14:08:03	2013-02-10 14:49:02	30	2	t
1389	260	Spirit Place for user 260	93	-48	45	141	2013-10-08 14:08:03	\N	41	2	t
1390	262	Spirit Place for user 262	42	58	100	-16	2013-10-08 14:08:03	2013-02-07 11:46:03	36	2	t
1391	263	Spirit Place for user 263	-24	48	24	-72	2013-10-08 14:08:03	2013-02-06 10:45:03	38	2	t
1392	265	Spirit Place for user 265	11	-44	-33	55	2013-10-08 14:08:03	\N	39	2	t
1393	266	Spirit Place for user 266	80	30	110	50	2013-10-08 14:08:03	2013-02-03 07:42:03	26	2	t
1394	268	Spirit Place for user 268	50	-45	5	95	2013-10-08 14:08:03	2013-02-01 05:40:03	26	2	t
1395	269	Spirit Place for user 269	57	59	116	-2	2013-10-08 14:08:03	2013-01-31 04:39:03	32	2	t
1396	271	Spirit Place for user 271	-21	12	-9	-33	2013-10-08 14:08:03	2013-01-29 02:37:03	39	2	t
1397	272	Spirit Place for user 272	91	98	189	-7	2013-10-08 14:08:03	2013-01-28 01:36:03	46	2	t
1398	274	Spirit Place for user 274	-44	77	33	-121	2013-10-08 14:08:03	2013-01-25 23:34:03	33	2	t
1399	275	Spirit Place for user 275	1	-8	-7	9	2013-10-08 14:08:04	\N	42	2	t
1400	277	Spirit Place for user 277	-2	-31	-33	29	2013-10-08 14:08:04	2013-01-22 20:31:04	26	2	t
1401	278	Spirit Place for user 278	95	17	112	78	2013-10-08 14:08:04	2013-01-21 19:30:04	49	2	t
1402	280	Spirit Place for user 280	16	-8	8	24	2013-10-08 14:08:04	\N	37	2	t
1403	281	Spirit Place for user 281	32	6	38	26	2013-10-08 14:08:04	2013-01-18 16:27:04	33	2	t
1404	283	Spirit Place for user 283	53	74	127	-21	2013-10-08 14:08:04	2013-01-16 14:25:04	23	2	t
1405	284	Spirit Place for user 284	-17	26	9	-43	2013-10-08 14:08:04	2013-01-15 13:24:04	41	2	t
1406	286	Spirit Place for user 286	-21	34	13	-55	2013-10-08 14:08:04	2013-01-13 11:22:04	49	2	t
1407	287	Spirit Place for user 287	56	22	78	34	2013-10-08 14:08:04	2013-01-12 10:21:04	20	2	t
1408	289	Spirit Place for user 289	-7	-33	-40	26	2013-10-08 14:08:05	2013-01-10 08:19:04	49	2	t
1409	290	Spirit Place for user 290	93	66	159	27	2013-10-08 14:08:05	\N	47	2	t
1410	292	Spirit Place for user 292	16	94	110	-78	2013-10-08 14:08:05	2013-01-07 05:16:05	43	2	t
1411	293	Spirit Place for user 293	41	-13	28	54	2013-10-08 14:08:05	2013-01-06 04:15:05	20	2	t
1412	295	Spirit Place for user 295	23	-44	-21	67	2013-10-08 14:08:06	\N	34	2	t
1413	296	Spirit Place for user 296	67	93	160	-26	2013-10-08 14:08:06	2013-01-03 01:12:06	26	2	t
1414	298	Spirit Place for user 298	64	85	149	-21	2013-10-08 14:08:06	2012-12-31 23:10:06	41	2	t
1415	299	Spirit Place for user 299	98	88	186	10	2013-10-08 14:08:06	2012-12-30 22:09:06	23	2	t
1416	301	Spirit Place for user 301	37	89	126	-52	2013-10-08 14:08:06	2012-12-28 20:07:06	46	2	t
1417	302	Spirit Place for user 302	57	93	150	-36	2013-10-08 14:08:06	2012-12-27 19:06:06	26	2	t
1418	304	Spirit Place for user 304	43	-20	23	63	2013-10-08 14:08:07	2012-12-25 17:04:06	39	2	t
1419	305	Spirit Place for user 305	47	69	116	-22	2013-10-08 14:08:07	\N	29	2	t
1420	307	Spirit Place for user 307	-19	94	75	-113	2013-10-08 14:08:07	2012-12-22 14:01:07	24	2	t
1421	308	Spirit Place for user 308	-33	75	42	-108	2013-10-08 14:08:07	2012-12-21 13:00:07	48	2	t
1422	310	Spirit Place for user 310	25	53	78	-28	2013-10-08 14:08:07	\N	22	2	t
1423	311	Spirit Place for user 311	50	20	70	30	2013-10-08 14:08:07	2012-12-18 09:57:07	45	2	t
1424	313	Spirit Place for user 313	16	77	93	-61	2013-10-08 14:08:07	2012-12-16 07:55:07	49	2	t
1425	314	Spirit Place for user 314	2	35	37	-33	2013-10-08 14:08:07	2012-12-15 06:54:07	49	2	t
1426	316	Spirit Place for user 316	27	69	96	-42	2013-10-08 14:08:07	2012-12-13 04:52:07	41	2	t
1427	317	Spirit Place for user 317	7	32	39	-25	2013-10-08 14:08:07	2012-12-12 03:51:07	30	2	t
1428	319	Spirit Place for user 319	84	-25	59	109	2013-10-08 14:08:08	2012-12-10 01:49:07	20	2	t
1429	320	Spirit Place for user 320	75	13	88	62	2013-10-08 14:08:08	\N	32	2	t
1430	322	Spirit Place for user 322	15	21	36	-6	2013-10-08 14:08:08	2012-12-06 22:46:08	40	2	t
1431	323	Spirit Place for user 323	-2	51	49	-53	2013-10-08 14:08:08	2012-12-05 21:45:08	34	2	t
1432	325	Spirit Place for user 325	-8	49	41	-57	2013-10-08 14:08:08	\N	34	2	t
1433	326	Spirit Place for user 326	68	-26	42	94	2013-10-08 14:08:08	2012-12-02 18:42:08	20	2	t
1434	328	Spirit Place for user 328	-31	91	60	-122	2013-10-08 14:08:08	2012-11-30 16:40:08	47	2	t
1435	329	Spirit Place for user 329	-45	-43	-88	-2	2013-10-08 14:08:08	2012-11-29 15:39:08	30	2	t
1436	331	Spirit Place for user 331	-3	-6	-9	3	2013-10-08 14:08:08	2012-11-27 13:37:08	42	2	t
1437	332	Spirit Place for user 332	-34	9	-25	-43	2013-10-08 14:08:08	2012-11-26 12:36:08	29	2	t
1438	334	Spirit Place for user 334	1	54	55	-53	2013-10-08 14:08:09	2012-11-24 10:34:08	24	2	t
1439	335	Spirit Place for user 335	59	61	120	-2	2013-10-08 14:08:09	\N	47	2	t
1440	337	Spirit Place for user 337	-47	93	46	-140	2013-10-08 14:08:09	2012-11-21 07:31:09	29	2	t
1441	338	Spirit Place for user 338	96	-1	95	97	2013-10-08 14:08:09	2012-11-20 06:30:09	24	2	t
1442	340	Spirit Place for user 340	-35	0	-35	-35	2013-10-08 14:08:09	\N	41	2	t
1443	341	Spirit Place for user 341	14	-45	-31	59	2013-10-08 14:08:09	2012-11-17 03:27:09	39	2	t
1444	343	Spirit Place for user 343	51	-41	10	92	2013-10-08 14:08:09	2012-11-15 01:25:09	26	2	t
1445	344	Spirit Place for user 344	-46	-11	-57	-35	2013-10-08 14:08:09	2012-11-14 00:24:09	33	2	t
1446	346	Spirit Place for user 346	71	19	90	52	2013-10-08 14:08:09	2012-11-11 22:22:09	28	2	t
1447	347	Spirit Place for user 347	-49	65	16	-114	2013-10-08 14:08:10	2012-11-10 21:21:09	35	2	t
1448	349	Spirit Place for user 349	-15	-45	-60	30	2013-10-08 14:08:10	2012-11-08 19:19:10	49	2	t
1449	350	Spirit Place for user 350	67	6	73	61	2013-10-08 14:08:10	\N	49	2	t
1450	352	Spirit Place for user 352	84	-50	34	134	2013-10-08 14:08:10	2012-11-05 16:16:10	42	2	t
1451	353	Spirit Place for user 353	91	1	92	90	2013-10-08 14:08:10	2012-11-04 15:15:10	36	2	t
1452	355	Spirit Place for user 355	44	-9	35	53	2013-10-08 14:08:10	\N	41	2	t
1453	356	Spirit Place for user 356	62	82	144	-20	2013-10-08 14:08:10	2012-11-01 12:12:10	40	2	t
1454	358	Spirit Place for user 358	-24	90	66	-114	2013-10-08 14:08:10	2012-10-30 10:10:10	42	2	t
1455	359	Spirit Place for user 359	25	-24	1	49	2013-10-08 14:08:10	2012-10-29 09:09:10	41	2	t
1456	361	Spirit Place for user 361	93	44	137	49	2013-10-08 14:08:11	2012-10-27 07:07:11	33	2	t
1457	362	Spirit Place for user 362	97	-39	58	136	2013-10-08 14:08:11	2012-10-26 06:06:11	45	2	t
1458	364	Spirit Place for user 364	-50	36	-14	-86	2013-10-08 14:08:11	2012-10-24 04:04:11	31	2	t
1459	365	Spirit Place for user 365	2	73	75	-71	2013-10-08 14:08:11	\N	23	2	t
1460	367	Spirit Place for user 367	41	8	49	33	2013-10-08 14:08:11	2012-10-21 01:01:11	27	2	t
1461	368	Spirit Place for user 368	-31	-21	-52	-10	2013-10-08 14:08:11	2012-10-20 00:00:11	47	2	t
1462	370	Spirit Place for user 370	18	2	20	16	2013-10-08 14:08:11	\N	35	2	t
1463	371	Spirit Place for user 371	53	-31	22	84	2013-10-08 14:08:12	2012-10-16 20:57:11	33	2	t
1464	373	Spirit Place for user 373	8	93	101	-85	2013-10-08 14:08:12	2012-10-14 18:55:12	37	2	t
1465	374	Spirit Place for user 374	88	86	174	2	2013-10-08 14:08:12	2012-10-13 17:54:12	48	2	t
1466	376	Spirit Place for user 376	46	57	103	-11	2013-10-08 14:08:12	2012-10-11 15:52:12	49	2	t
1467	377	Spirit Place for user 377	11	38	49	-27	2013-10-08 14:08:12	2012-10-10 14:51:12	34	2	t
1468	379	Spirit Place for user 379	-37	-37	-74	0	2013-10-08 14:08:12	2012-10-08 12:49:12	47	2	t
1469	380	Spirit Place for user 380	-26	-28	-54	2	2013-10-08 14:08:12	\N	34	2	t
1470	382	Spirit Place for user 382	79	71	150	8	2013-10-08 14:08:12	2012-10-05 09:46:12	36	2	t
1471	383	Spirit Place for user 383	14	51	65	-37	2013-10-08 14:08:12	2012-10-04 08:45:12	48	2	t
1472	385	Spirit Place for user 385	-38	50	12	-88	2013-10-08 14:08:12	\N	27	2	t
1473	386	Spirit Place for user 386	8	75	83	-67	2013-10-08 14:08:12	2012-10-01 05:42:12	44	2	t
1474	388	Spirit Place for user 388	-34	20	-14	-54	2013-10-08 14:08:13	2012-09-29 03:40:12	45	2	t
1475	389	Spirit Place for user 389	-15	-43	-58	28	2013-10-08 14:08:13	2012-09-28 02:39:13	44	2	t
1476	391	Spirit Place for user 391	-5	69	64	-74	2013-10-08 14:08:13	2012-09-26 00:37:13	35	2	t
1477	392	Spirit Place for user 392	0	18	18	-18	2013-10-08 14:08:13	2012-09-24 23:36:13	44	2	t
1478	394	Spirit Place for user 394	33	68	101	-35	2013-10-08 14:08:13	2012-09-22 21:34:13	32	2	t
1479	395	Spirit Place for user 395	79	-2	77	81	2013-10-08 14:08:13	\N	28	2	t
1480	397	Spirit Place for user 397	71	-49	22	120	2013-10-08 14:08:13	2012-09-19 18:31:13	43	2	t
1481	398	Spirit Place for user 398	-14	23	9	-37	2013-10-08 14:08:13	2012-09-18 17:30:13	38	2	t
1482	400	Spirit Place for user 400	-47	11	-36	-58	2013-10-08 14:08:13	\N	46	2	t
1483	401	Spirit Place for user 401	89	82	171	7	2013-10-08 14:08:13	2012-09-15 14:27:13	49	2	t
1484	403	Spirit Place for user 403	75	4	79	71	2013-10-08 14:08:13	2012-09-13 12:25:13	35	2	t
1485	404	Spirit Place for user 404	0	33	33	-33	2013-10-08 14:08:14	2012-09-12 11:24:13	20	2	t
1486	406	Spirit Place for user 406	-26	71	45	-97	2013-10-08 14:08:14	2012-09-10 09:22:14	22	2	t
1487	407	Spirit Place for user 407	71	37	108	34	2013-10-08 14:08:14	2012-09-09 08:21:14	38	2	t
1488	409	Spirit Place for user 409	24	4	28	20	2013-10-08 14:08:14	2012-09-07 06:19:14	48	2	t
1489	410	Spirit Place for user 410	64	-13	51	77	2013-10-08 14:08:14	\N	20	2	t
1490	412	Spirit Place for user 412	60	12	72	48	2013-10-08 14:08:14	2012-09-04 03:16:14	20	2	t
1491	413	Spirit Place for user 413	31	-3	28	34	2013-10-08 14:08:14	2012-09-03 02:15:14	44	2	t
1492	415	Spirit Place for user 415	24	26	50	-2	2013-10-08 14:08:14	\N	48	2	t
1493	416	Spirit Place for user 416	70	-2	68	72	2013-10-08 14:08:14	2012-08-30 23:12:14	42	2	t
1494	418	Spirit Place for user 418	-3	-30	-33	27	2013-10-08 14:08:14	2012-08-28 21:10:14	37	2	t
1495	419	Spirit Place for user 419	94	-17	77	111	2013-10-08 14:08:14	2012-08-27 20:09:14	34	2	t
1496	421	Spirit Place for user 421	18	10	28	8	2013-10-08 14:08:14	2012-08-25 18:07:14	45	2	t
1497	422	Spirit Place for user 422	84	43	127	41	2013-10-08 14:08:15	2012-08-24 17:06:14	26	2	t
1498	424	Spirit Place for user 424	-3	-23	-26	20	2013-10-08 14:08:15	2012-08-22 15:04:15	29	2	t
1499	425	Spirit Place for user 425	-3	-1	-4	-2	2013-10-08 14:08:15	\N	40	2	t
1500	427	Spirit Place for user 427	42	72	114	-30	2013-10-08 14:08:15	2012-08-19 12:01:15	45	2	t
1501	428	Spirit Place for user 428	92	-10	82	102	2013-10-08 14:08:15	2012-08-18 11:00:15	25	2	t
1502	430	Spirit Place for user 430	-47	88	41	-135	2013-10-08 14:08:15	\N	33	2	t
1503	431	Spirit Place for user 431	-22	27	5	-49	2013-10-08 14:08:15	2012-08-15 07:57:15	47	2	t
1504	433	Spirit Place for user 433	99	-8	91	107	2013-10-08 14:08:15	2012-08-13 05:55:15	21	2	t
1505	434	Spirit Place for user 434	-48	7	-41	-55	2013-10-08 14:08:15	2012-08-12 04:54:15	34	2	t
1506	436	Spirit Place for user 436	-18	10	-8	-28	2013-10-08 14:08:15	2012-08-10 02:52:15	43	2	t
1507	437	Spirit Place for user 437	25	99	124	-74	2013-10-08 14:08:15	2012-08-09 01:51:15	33	2	t
1508	439	Spirit Place for user 439	-32	68	36	-100	2013-10-08 14:08:15	2012-08-06 23:49:15	22	2	t
1509	440	Spirit Place for user 440	0	10	10	-10	2013-10-08 14:08:16	\N	28	2	t
1510	442	Spirit Place for user 442	38	-44	-6	82	2013-10-08 14:08:16	2012-08-03 20:46:16	25	2	t
1511	443	Spirit Place for user 443	-5	16	11	-21	2013-10-08 14:08:16	2012-08-02 19:45:16	27	2	t
1512	445	Spirit Place for user 445	52	65	117	-13	2013-10-08 14:08:16	\N	27	2	t
1513	446	Spirit Place for user 446	-18	-2	-20	-16	2013-10-08 14:08:16	2012-07-30 16:42:16	21	2	t
1514	448	Spirit Place for user 448	82	0	82	82	2013-10-08 14:08:16	2012-07-28 14:40:16	48	2	t
1515	449	Spirit Place for user 449	23	-6	17	29	2013-10-08 14:08:16	2012-07-27 13:39:16	28	2	t
1516	451	Spirit Place for user 451	-40	6	-34	-46	2013-10-08 14:08:16	2012-07-25 11:37:16	41	2	t
1517	452	Spirit Place for user 452	-30	-12	-42	-18	2013-10-08 14:08:16	2012-07-24 10:36:16	44	2	t
1518	454	Spirit Place for user 454	50	43	93	7	2013-10-08 14:08:16	2012-07-22 08:34:16	27	2	t
1519	455	Spirit Place for user 455	9	79	88	-70	2013-10-08 14:08:16	\N	33	2	t
1520	457	Spirit Place for user 457	29	89	118	-60	2013-10-08 14:08:16	2012-07-19 05:31:16	40	2	t
1521	458	Spirit Place for user 458	63	28	91	35	2013-10-08 14:08:17	2012-07-18 04:30:17	49	2	t
1522	460	Spirit Place for user 460	50	-21	29	71	2013-10-08 14:08:17	\N	46	2	t
1523	461	Spirit Place for user 461	-32	21	-11	-53	2013-10-08 14:08:17	2012-07-15 01:27:17	23	2	t
1524	463	Spirit Place for user 463	53	6	59	47	2013-10-08 14:08:17	2012-07-12 23:25:17	38	2	t
1525	464	Spirit Place for user 464	-24	56	32	-80	2013-10-08 14:08:17	2012-07-11 22:24:17	25	2	t
1526	466	Spirit Place for user 466	14	97	111	-83	2013-10-08 14:08:17	2012-07-09 20:22:17	25	2	t
1527	467	Spirit Place for user 467	89	-24	65	113	2013-10-08 14:08:17	2012-07-08 19:21:17	24	2	t
1528	469	Spirit Place for user 469	-28	-4	-32	-24	2013-10-08 14:08:17	2012-07-06 17:19:17	41	2	t
1529	470	Spirit Place for user 470	-49	97	48	-146	2013-10-08 14:08:17	\N	34	2	t
1530	472	Spirit Place for user 472	-49	-1	-50	-48	2013-10-08 14:08:17	2012-07-03 14:16:17	29	2	t
1531	473	Spirit Place for user 473	37	-24	13	61	2013-10-08 14:08:17	2012-07-02 13:15:17	26	2	t
1532	475	Spirit Place for user 475	-28	52	24	-80	2013-10-08 14:08:17	\N	25	2	t
1533	476	Spirit Place for user 476	79	66	145	13	2013-10-08 14:08:18	2012-06-29 10:12:18	36	2	t
1534	478	Spirit Place for user 478	-22	39	17	-61	2013-10-08 14:08:18	2012-06-27 08:10:18	22	2	t
1535	479	Spirit Place for user 479	42	-49	-7	91	2013-10-08 14:08:18	2012-06-26 07:09:18	21	2	t
1536	481	Spirit Place for user 481	26	22	48	4	2013-10-08 14:08:18	2012-06-24 05:07:18	33	2	t
1537	482	Spirit Place for user 482	-49	94	45	-143	2013-10-08 14:08:18	2012-06-23 04:06:18	47	2	t
1538	484	Spirit Place for user 484	-50	23	-27	-73	2013-10-08 14:08:18	2012-06-21 02:04:18	24	2	t
1539	485	Spirit Place for user 485	-10	13	3	-23	2013-10-08 14:08:18	\N	24	2	t
1540	487	Spirit Place for user 487	47	-9	38	56	2013-10-08 14:08:18	2012-06-17 23:01:18	33	2	t
1541	488	Spirit Place for user 488	11	36	47	-25	2013-10-08 14:08:18	2012-06-16 22:00:18	25	2	t
1542	490	Spirit Place for user 490	-4	-26	-30	22	2013-10-08 14:08:18	\N	44	2	t
1543	491	Spirit Place for user 491	84	21	105	63	2013-10-08 14:08:18	2012-06-13 18:57:18	36	2	t
1544	493	Spirit Place for user 493	13	43	56	-30	2013-10-08 14:08:19	2012-06-11 16:55:18	48	2	t
1545	494	Spirit Place for user 494	70	30	100	40	2013-10-08 14:08:19	2012-06-10 15:54:19	25	2	t
1546	496	Spirit Place for user 496	-6	64	58	-70	2013-10-08 14:08:19	2012-06-08 13:52:19	22	2	t
1547	497	Spirit Place for user 497	41	69	110	-28	2013-10-08 14:08:19	2012-06-07 12:51:19	31	2	t
1548	499	Spirit Place for user 499	-43	47	4	-90	2013-10-08 14:08:19	2012-06-05 10:49:19	31	2	t
1549	500	Spirit Place for user 500	97	68	165	29	2013-10-08 14:08:19	\N	28	2	t
1550	502	Spirit Place for user 502	10	71	81	-61	2013-10-08 14:08:19	2012-06-02 07:46:19	40	2	t
1551	503	Spirit Place for user 503	33	-46	-13	79	2013-10-08 14:08:19	2012-06-01 06:45:19	41	2	t
1552	505	Spirit Place for user 505	-3	2	-1	-5	2013-10-08 14:08:19	\N	41	2	t
1553	506	Spirit Place for user 506	96	29	125	67	2013-10-08 14:08:19	2012-05-29 03:42:19	36	2	t
1554	508	Spirit Place for user 508	-43	21	-22	-64	2013-10-08 14:08:19	2012-05-27 01:40:19	39	2	t
1555	509	Spirit Place for user 509	89	6	95	83	2013-10-08 14:08:20	2012-05-26 00:39:19	40	2	t
1556	511	Spirit Place for user 511	-5	-16	-21	11	2013-10-08 14:08:20	2012-05-23 22:37:20	39	2	t
1557	512	Spirit Place for user 512	25	15	40	10	2013-10-08 14:08:20	2012-05-22 21:36:20	41	2	t
1558	514	Spirit Place for user 514	-9	44	35	-53	2013-10-08 14:08:20	2012-05-20 19:34:20	32	2	t
1559	515	Spirit Place for user 515	31	64	95	-33	2013-10-08 14:08:20	\N	41	2	t
1560	517	Spirit Place for user 517	49	39	88	10	2013-10-08 14:08:20	2012-05-17 16:31:20	26	2	t
1561	518	Spirit Place for user 518	40	-4	36	44	2013-10-08 14:08:20	2012-05-16 15:30:20	47	2	t
1562	520	Spirit Place for user 520	-1	-18	-19	17	2013-10-08 14:08:20	\N	38	2	t
1563	521	Spirit Place for user 521	75	-36	39	111	2013-10-08 14:08:20	2012-05-13 12:27:20	41	2	t
1564	523	Spirit Place for user 523	5	88	93	-83	2013-10-08 14:08:20	2012-05-11 10:25:20	40	2	t
1565	524	Spirit Place for user 524	44	56	100	-12	2013-10-08 14:08:20	2012-05-10 09:24:20	43	2	t
1566	526	Spirit Place for user 526	-14	85	71	-99	2013-10-08 14:08:20	2012-05-08 07:22:20	23	2	t
1567	527	Spirit Place for user 527	-11	99	88	-110	2013-10-08 14:08:20	2012-05-07 06:21:20	48	2	t
1568	529	Spirit Place for user 529	-10	18	8	-28	2013-10-08 14:08:21	2012-05-05 04:19:20	48	2	t
1569	530	Spirit Place for user 530	-23	25	2	-48	2013-10-08 14:08:21	\N	35	2	t
1570	532	Spirit Place for user 532	37	-22	15	59	2013-10-08 14:08:21	2012-05-02 01:16:21	27	2	t
1571	533	Spirit Place for user 533	9	43	52	-34	2013-10-08 14:08:21	2012-05-01 00:15:21	42	2	t
1572	535	Spirit Place for user 535	68	69	137	-1	2013-10-08 14:08:21	\N	48	2	t
1573	536	Spirit Place for user 536	82	-20	62	102	2013-10-08 14:08:21	2012-04-27 21:12:21	48	2	t
1574	538	Spirit Place for user 538	77	91	168	-14	2013-10-08 14:08:21	2012-04-25 19:10:21	23	2	t
1575	539	Spirit Place for user 539	12	-5	7	17	2013-10-08 14:08:21	2012-04-24 18:09:21	46	2	t
1576	541	Spirit Place for user 541	45	92	137	-47	2013-10-08 14:08:21	2012-04-22 16:07:21	26	2	t
1577	542	Spirit Place for user 542	77	-4	73	81	2013-10-08 14:08:22	2012-04-21 15:06:21	42	2	t
1578	544	Spirit Place for user 544	94	33	127	61	2013-10-08 14:08:22	2012-04-19 13:04:22	33	2	t
1579	545	Spirit Place for user 545	-12	-17	-29	5	2013-10-08 14:08:22	\N	38	2	t
1580	547	Spirit Place for user 547	60	33	93	27	2013-10-08 14:08:22	2012-04-16 10:01:22	35	2	t
1581	548	Spirit Place for user 548	73	-31	42	104	2013-10-08 14:08:22	2012-04-15 09:00:22	45	2	t
1582	550	Spirit Place for user 550	60	57	117	3	2013-10-08 14:08:22	\N	32	2	t
1583	551	Spirit Place for user 551	-12	45	33	-57	2013-10-08 14:08:22	2012-04-12 05:57:22	27	2	t
1584	553	Spirit Place for user 553	69	-8	61	77	2013-10-08 14:08:22	2012-04-10 03:55:22	47	2	t
1585	554	Spirit Place for user 554	10	66	76	-56	2013-10-08 14:08:22	2012-04-09 02:54:22	35	2	t
1586	556	Spirit Place for user 556	-13	49	36	-62	2013-10-08 14:08:23	2012-04-07 00:52:22	20	2	t
1587	557	Spirit Place for user 557	33	35	68	-2	2013-10-08 14:08:23	2012-04-05 23:51:23	32	2	t
1588	559	Spirit Place for user 559	62	37	99	25	2013-10-08 14:08:23	2012-04-03 21:49:23	24	2	t
1589	560	Spirit Place for user 560	3	34	37	-31	2013-10-08 14:08:23	\N	30	2	t
1590	562	Spirit Place for user 562	-28	67	39	-95	2013-10-08 14:08:23	2012-03-31 18:46:23	42	2	t
1591	563	Spirit Place for user 563	100	85	185	15	2013-10-08 14:08:23	2012-03-30 17:45:23	49	2	t
1592	565	Spirit Place for user 565	-5	18	13	-23	2013-10-08 14:08:23	\N	25	2	t
1593	566	Spirit Place for user 566	90	-43	47	133	2013-10-08 14:08:23	2012-03-27 14:42:23	47	2	t
1594	568	Spirit Place for user 568	91	43	134	48	2013-10-08 14:08:23	2012-03-25 12:40:23	39	2	t
1595	569	Spirit Place for user 569	9	22	31	-13	2013-10-08 14:08:23	2012-03-24 11:39:23	35	2	t
1596	571	Spirit Place for user 571	71	1	72	70	2013-10-08 14:08:23	2012-03-22 09:37:23	37	2	t
1597	572	Spirit Place for user 572	-36	-20	-56	-16	2013-10-08 14:08:23	2012-03-21 08:36:23	21	2	t
1598	574	Spirit Place for user 574	100	-24	76	124	2013-10-08 14:08:24	2012-03-19 06:34:23	40	2	t
1599	575	Spirit Place for user 575	41	73	114	-32	2013-10-08 14:08:24	\N	39	2	t
1600	577	Spirit Place for user 577	71	26	97	45	2013-10-08 14:08:24	2012-03-16 03:31:24	23	2	t
1601	578	Spirit Place for user 578	78	80	158	-2	2013-10-08 14:08:24	2012-03-15 02:30:24	42	2	t
1602	580	Spirit Place for user 580	89	-12	77	101	2013-10-08 14:08:24	\N	43	2	t
1603	581	Spirit Place for user 581	54	100	154	-46	2013-10-08 14:08:24	2012-03-11 23:27:24	26	2	t
1604	583	Spirit Place for user 583	98	40	138	58	2013-10-08 14:08:24	2012-03-09 21:25:24	43	2	t
1605	584	Spirit Place for user 584	41	73	114	-32	2013-10-08 14:08:24	2012-03-08 20:24:24	26	2	t
1606	586	Spirit Place for user 586	-17	5	-12	-22	2013-10-08 14:08:24	2012-03-06 18:22:24	28	2	t
1607	587	Spirit Place for user 587	99	-39	60	138	2013-10-08 14:08:24	2012-03-05 17:21:24	47	2	t
1608	589	Spirit Place for user 589	-34	-47	-81	13	2013-10-08 14:08:24	2012-03-03 15:19:24	32	2	t
1609	590	Spirit Place for user 590	57	58	115	-1	2013-10-08 14:08:25	\N	38	2	t
1610	592	Spirit Place for user 592	-20	77	57	-97	2013-10-08 14:08:25	2012-02-29 12:16:25	46	2	t
1611	593	Spirit Place for user 593	75	90	165	-15	2013-10-08 14:08:25	2012-02-28 11:15:25	38	2	t
1612	595	Spirit Place for user 595	-48	27	-21	-75	2013-10-08 14:08:25	\N	42	2	t
1613	596	Spirit Place for user 596	45	62	107	-17	2013-10-08 14:08:25	2012-02-25 08:12:25	25	2	t
1614	598	Spirit Place for user 598	25	70	95	-45	2013-10-08 14:08:25	2012-02-23 06:10:25	20	2	t
1615	599	Spirit Place for user 599	72	-31	41	103	2013-10-08 14:08:25	2012-02-22 05:09:25	21	2	t
1616	601	Spirit Place for user 601	42	47	89	-5	2013-10-08 14:08:25	2012-02-20 03:07:25	42	2	t
1617	602	Spirit Place for user 602	59	71	130	-12	2013-10-08 14:08:25	2012-02-19 02:06:25	39	2	t
1618	604	Spirit Place for user 604	91	77	168	14	2013-10-08 14:08:26	2012-02-17 00:04:25	30	2	t
1619	605	Spirit Place for user 605	50	70	120	-20	2013-10-08 14:08:26	\N	45	2	t
1620	607	Spirit Place for user 607	1	76	77	-75	2013-10-08 14:08:26	2012-02-13 21:01:26	35	2	t
1621	608	Spirit Place for user 608	64	-46	18	110	2013-10-08 14:08:26	2012-02-12 20:00:26	31	2	t
1622	610	Spirit Place for user 610	91	-22	69	113	2013-10-08 14:08:26	\N	34	2	t
1623	611	Spirit Place for user 611	52	15	67	37	2013-10-08 14:08:26	2012-02-09 16:57:26	38	2	t
1624	613	Spirit Place for user 613	-4	-22	-26	18	2013-10-08 14:08:26	2012-02-07 14:55:26	32	2	t
1625	614	Spirit Place for user 614	70	75	145	-5	2013-10-08 14:08:26	2012-02-06 13:54:26	37	2	t
1626	616	Spirit Place for user 616	26	96	122	-70	2013-10-08 14:08:26	2012-02-04 11:52:26	48	2	t
1627	617	Spirit Place for user 617	40	38	78	2	2013-10-08 14:08:30	2012-02-03 10:51:26	42	2	t
1628	619	Spirit Place for user 619	-15	38	23	-53	2013-10-08 14:08:30	2012-02-01 08:49:30	25	2	t
1629	620	Spirit Place for user 620	-4	5	1	-9	2013-10-08 14:08:30	\N	21	2	t
1630	622	Spirit Place for user 622	-31	-33	-64	2	2013-10-08 14:08:30	2012-01-29 05:46:30	39	2	t
1631	623	Spirit Place for user 623	50	26	76	24	2013-10-08 14:08:30	2012-01-28 04:45:30	25	2	t
1632	625	Spirit Place for user 625	38	15	53	23	2013-10-08 14:08:31	\N	35	2	t
1633	626	Spirit Place for user 626	-40	64	24	-104	2013-10-08 14:08:31	2012-01-25 01:42:31	34	2	t
1634	628	Spirit Place for user 628	6	-13	-7	19	2013-10-08 14:08:31	2012-01-22 23:40:31	43	2	t
1635	629	Spirit Place for user 629	15	36	51	-21	2013-10-08 14:08:31	2012-01-21 22:39:31	28	2	t
1636	631	Spirit Place for user 631	62	60	122	2	2013-10-08 14:08:31	2012-01-19 20:37:31	25	2	t
1637	632	Spirit Place for user 632	83	52	135	31	2013-10-08 14:08:31	2012-01-18 19:36:31	48	2	t
1638	634	Spirit Place for user 634	88	97	185	-9	2013-10-08 14:08:31	2012-01-16 17:34:31	46	2	t
1639	635	Spirit Place for user 635	-47	1	-46	-48	2013-10-08 14:08:31	\N	45	2	t
1640	637	Spirit Place for user 637	34	94	128	-60	2013-10-08 14:08:31	2012-01-13 14:31:31	41	2	t
1641	638	Spirit Place for user 638	-3	-45	-48	42	2013-10-08 14:08:31	2012-01-12 13:30:31	35	2	t
1642	640	Spirit Place for user 640	9	57	66	-48	2013-10-08 14:08:31	\N	35	2	t
1643	641	Spirit Place for user 641	-49	64	15	-113	2013-10-08 14:08:32	2012-01-09 10:27:32	41	2	t
1644	643	Spirit Place for user 643	95	82	177	13	2013-10-08 14:08:32	2012-01-07 08:25:32	41	2	t
1645	644	Spirit Place for user 644	-50	63	13	-113	2013-10-08 14:08:32	2012-01-06 07:24:32	22	2	t
1646	646	Spirit Place for user 646	36	60	96	-24	2013-10-08 14:08:32	2012-01-04 05:22:32	40	2	t
1647	647	Spirit Place for user 647	47	-21	26	68	2013-10-08 14:08:32	2012-01-03 04:21:32	46	2	t
1648	649	Spirit Place for user 649	5	42	47	-37	2013-10-08 14:08:33	2012-01-01 02:19:33	30	2	t
1649	650	Spirit Place for user 650	-26	58	32	-84	2013-10-08 14:08:33	\N	48	2	t
1650	652	Spirit Place for user 652	97	-23	74	120	2013-10-08 14:08:33	2011-12-28 23:16:33	32	2	t
1651	653	Spirit Place for user 653	44	33	77	11	2013-10-08 14:08:33	2011-12-27 22:15:33	31	2	t
1652	655	Spirit Place for user 655	64	-21	43	85	2013-10-08 14:08:33	\N	34	2	t
1653	656	Spirit Place for user 656	-46	62	16	-108	2013-10-08 14:08:33	2011-12-24 19:12:33	20	2	t
1654	658	Spirit Place for user 658	-30	-46	-76	16	2013-10-08 14:08:33	2011-12-22 17:10:33	28	2	t
1655	659	Spirit Place for user 659	-32	62	30	-94	2013-10-08 14:08:33	2011-12-21 16:09:33	22	2	t
1656	661	Spirit Place for user 661	-19	26	7	-45	2013-10-08 14:08:34	2011-12-19 14:07:33	49	2	t
1657	662	Spirit Place for user 662	4	-29	-25	33	2013-10-08 14:08:34	2011-12-18 13:06:34	33	2	t
1658	664	Spirit Place for user 664	-22	-11	-33	-11	2013-10-08 14:08:34	2011-12-16 11:04:34	40	2	t
1659	665	Spirit Place for user 665	23	97	120	-74	2013-10-08 14:08:34	\N	34	2	t
1660	667	Spirit Place for user 667	33	46	79	-13	2013-10-08 14:08:34	2011-12-13 08:01:34	28	2	t
1661	668	Spirit Place for user 668	-29	52	23	-81	2013-10-08 14:08:34	2011-12-12 07:00:34	45	2	t
1662	670	Spirit Place for user 670	-27	-33	-60	6	2013-10-08 14:08:34	\N	41	2	t
1663	671	Spirit Place for user 671	-23	-22	-45	-1	2013-10-08 14:08:35	2011-12-09 03:57:34	31	2	t
1664	673	Spirit Place for user 673	70	91	161	-21	2013-10-08 14:08:35	2011-12-07 01:55:35	28	2	t
1665	674	Spirit Place for user 674	30	-48	-18	78	2013-10-08 14:08:35	2011-12-06 00:54:35	22	2	t
1666	676	Spirit Place for user 676	6	14	20	-8	2013-10-08 14:08:35	2011-12-03 22:52:35	35	2	t
1667	677	Spirit Place for user 677	79	-15	64	94	2013-10-08 14:08:35	2011-12-02 21:51:35	20	2	t
1668	679	Spirit Place for user 679	-24	81	57	-105	2013-10-08 14:08:35	2011-11-30 19:49:35	37	2	t
1669	680	Spirit Place for user 680	-42	27	-15	-69	2013-10-08 14:08:35	\N	34	2	t
1670	682	Spirit Place for user 682	-40	6	-34	-46	2013-10-08 14:08:35	2011-11-27 16:46:35	49	2	t
1671	683	Spirit Place for user 683	-17	-23	-40	6	2013-10-08 14:08:35	2011-11-26 15:45:35	20	2	t
1672	685	Spirit Place for user 685	73	45	118	28	2013-10-08 14:08:35	\N	20	2	t
1673	686	Spirit Place for user 686	-28	71	43	-99	2013-10-08 14:08:35	2011-11-23 12:42:35	21	2	t
1674	688	Spirit Place for user 688	55	49	104	6	2013-10-08 14:08:36	2011-11-21 10:40:35	40	2	t
1675	689	Spirit Place for user 689	-25	-38	-63	13	2013-10-08 14:08:36	2011-11-20 09:39:36	48	2	t
1676	691	Spirit Place for user 691	64	65	129	-1	2013-10-08 14:08:36	2011-11-18 07:37:36	27	2	t
1677	692	Spirit Place for user 692	5	-35	-30	40	2013-10-08 14:08:36	2011-11-17 06:36:36	42	2	t
1678	694	Spirit Place for user 694	-32	-22	-54	-10	2013-10-08 14:08:36	2011-11-15 04:34:36	33	2	t
1679	695	Spirit Place for user 695	46	98	144	-52	2013-10-08 14:08:36	\N	45	2	t
1680	697	Spirit Place for user 697	55	90	145	-35	2013-10-08 14:08:36	2011-11-12 01:31:36	29	2	t
1681	698	Spirit Place for user 698	69	76	145	-7	2013-10-08 14:08:36	2011-11-11 00:30:36	30	2	t
1682	700	Spirit Place for user 700	-27	-14	-41	-13	2013-10-08 14:08:36	\N	27	2	t
1683	701	Spirit Place for user 701	-21	27	6	-48	2013-10-08 14:08:36	2011-11-07 21:27:36	25	2	t
1684	703	Spirit Place for user 703	89	89	178	0	2013-10-08 14:08:36	2011-11-05 19:25:36	43	2	t
1685	704	Spirit Place for user 704	-38	48	10	-86	2013-10-08 14:08:36	2011-11-04 18:24:36	23	2	t
1686	706	Spirit Place for user 706	90	38	128	52	2013-10-08 14:08:36	2011-11-02 16:22:36	46	2	t
1687	707	Spirit Place for user 707	10	67	77	-57	2013-10-08 14:08:37	2011-11-01 15:21:37	24	2	t
1688	709	Spirit Place for user 709	-37	-13	-50	-24	2013-10-08 14:08:37	2011-10-30 13:19:37	33	2	t
1689	710	Spirit Place for user 710	-22	22	0	-44	2013-10-08 14:08:37	\N	36	2	t
1690	712	Spirit Place for user 712	45	-13	32	58	2013-10-08 14:08:37	2011-10-27 10:16:37	41	2	t
1691	713	Spirit Place for user 713	26	-41	-15	67	2013-10-08 14:08:37	2011-10-26 09:15:37	30	2	t
1692	715	Spirit Place for user 715	86	58	144	28	2013-10-08 14:08:37	\N	20	2	t
1693	716	Spirit Place for user 716	-28	-32	-60	4	2013-10-08 14:08:39	2011-10-23 06:12:39	25	2	t
1694	718	Spirit Place for user 718	82	-4	78	86	2013-10-08 14:08:39	2011-10-21 04:10:39	33	2	t
1695	719	Spirit Place for user 719	79	18	97	61	2013-10-08 14:08:39	2011-10-20 03:09:39	26	2	t
1696	721	Spirit Place for user 721	74	19	93	55	2013-10-08 14:08:39	2011-10-18 01:07:39	36	2	t
1697	722	Spirit Place for user 722	22	-49	-27	71	2013-10-08 14:08:39	2011-10-17 00:06:39	35	2	t
1698	724	Spirit Place for user 724	0	8	8	-8	2013-10-08 14:08:40	2011-10-14 22:04:39	41	2	t
1699	725	Spirit Place for user 725	36	44	80	-8	2013-10-08 14:08:40	\N	23	2	t
1700	727	Spirit Place for user 727	-34	49	15	-83	2013-10-08 14:08:40	2011-10-11 19:01:40	37	2	t
1701	728	Spirit Place for user 728	91	1	92	90	2013-10-08 14:08:40	2011-10-10 18:00:40	39	2	t
1702	730	Spirit Place for user 730	45	-40	5	85	2013-10-08 14:08:40	\N	21	2	t
1703	731	Spirit Place for user 731	-6	75	69	-81	2013-10-08 14:08:40	2011-10-07 14:57:40	49	2	t
1704	733	Spirit Place for user 733	-34	-30	-64	-4	2013-10-08 14:08:40	2011-10-05 12:55:40	46	2	t
1705	734	Spirit Place for user 734	-41	18	-23	-59	2013-10-08 14:08:40	2011-10-04 11:54:40	45	2	t
1706	736	Spirit Place for user 736	-45	57	12	-102	2013-10-08 14:08:40	2011-10-02 09:52:40	34	2	t
1707	737	Spirit Place for user 737	28	13	41	15	2013-10-08 14:08:40	2011-10-01 08:51:40	46	2	t
1708	739	Spirit Place for user 739	19	-31	-12	50	2013-10-08 14:08:40	2011-09-29 06:49:40	40	2	t
1709	740	Spirit Place for user 740	21	51	72	-30	2013-10-08 14:08:40	\N	38	2	t
1710	742	Spirit Place for user 742	-18	-13	-31	-5	2013-10-08 14:08:41	2011-09-26 03:46:40	25	2	t
1711	743	Spirit Place for user 743	8	46	54	-38	2013-10-08 14:08:41	2011-09-25 02:45:41	44	2	t
1712	745	Spirit Place for user 745	56	-35	21	91	2013-10-08 14:08:41	\N	34	2	t
1713	746	Spirit Place for user 746	-20	-25	-45	5	2013-10-08 14:08:41	2011-09-21 23:42:41	32	2	t
1714	748	Spirit Place for user 748	41	30	71	11	2013-10-08 14:08:41	2011-09-19 21:40:41	23	2	t
1715	749	Spirit Place for user 749	17	-8	9	25	2013-10-08 14:08:41	2011-09-18 20:39:41	45	2	t
1716	751	Spirit Place for user 751	16	29	45	-13	2013-10-08 14:08:41	2011-09-16 18:37:41	46	2	t
1717	752	Spirit Place for user 752	-3	39	36	-42	2013-10-08 14:08:41	2011-09-15 17:36:41	21	2	t
1718	754	Spirit Place for user 754	42	78	120	-36	2013-10-08 14:08:41	2011-09-13 15:34:41	20	2	t
1719	755	Spirit Place for user 755	76	-45	31	121	2013-10-08 14:08:41	\N	21	2	t
1720	757	Spirit Place for user 757	58	-47	11	105	2013-10-08 14:08:41	2011-09-10 12:31:41	27	2	t
1721	758	Spirit Place for user 758	54	-35	19	89	2013-10-08 14:08:41	2011-09-09 11:30:41	26	2	t
1722	760	Spirit Place for user 760	15	48	63	-33	2013-10-08 14:08:42	\N	32	2	t
1723	761	Spirit Place for user 761	81	10	91	71	2013-10-08 14:08:42	2011-09-06 08:27:42	39	2	t
1724	763	Spirit Place for user 763	66	82	148	-16	2013-10-08 14:08:42	2011-09-04 06:25:42	47	2	t
1725	764	Spirit Place for user 764	21	86	107	-65	2013-10-08 14:08:42	2011-09-03 05:24:42	29	2	t
1726	766	Spirit Place for user 766	-27	64	37	-91	2013-10-08 14:08:42	2011-09-01 03:22:42	43	2	t
1727	767	Spirit Place for user 767	68	-7	61	75	2013-10-08 14:08:42	2011-08-31 02:21:42	22	2	t
1728	769	Spirit Place for user 769	-20	86	66	-106	2013-10-08 14:08:42	2011-08-29 00:19:42	27	2	t
1729	770	Spirit Place for user 770	-28	-5	-33	-23	2013-10-08 14:08:42	\N	37	2	t
1730	772	Spirit Place for user 772	40	-12	28	52	2013-10-08 14:08:42	2011-08-25 21:16:42	45	2	t
1731	773	Spirit Place for user 773	-34	86	52	-120	2013-10-08 14:08:42	2011-08-24 20:15:42	38	2	t
1732	775	Spirit Place for user 775	13	94	107	-81	2013-10-08 14:08:42	\N	39	2	t
1733	776	Spirit Place for user 776	29	54	83	-25	2013-10-08 14:08:42	2011-08-21 17:12:42	23	2	t
1734	778	Spirit Place for user 778	-31	23	-8	-54	2013-10-08 14:08:42	2011-08-19 15:10:42	34	2	t
1735	779	Spirit Place for user 779	64	89	153	-25	2013-10-08 14:08:43	2011-08-18 14:09:42	49	2	t
1736	781	Spirit Place for user 781	-1	68	67	-69	2013-10-08 14:08:43	2011-08-16 12:07:43	24	2	t
1737	782	Spirit Place for user 782	64	-42	22	106	2013-10-08 14:08:43	2011-08-15 11:06:43	37	2	t
1738	784	Spirit Place for user 784	63	35	98	28	2013-10-08 14:08:43	2011-08-13 09:04:43	31	2	t
1739	785	Spirit Place for user 785	58	63	121	-5	2013-10-08 14:08:43	\N	21	2	t
1740	787	Spirit Place for user 787	27	100	127	-73	2013-10-08 14:08:43	2011-08-10 06:01:43	23	2	t
1741	788	Spirit Place for user 788	45	-46	-1	91	2013-10-08 14:08:43	2011-08-09 05:00:43	35	2	t
1742	790	Spirit Place for user 790	35	-23	12	58	2013-10-08 14:08:43	\N	23	2	t
1743	791	Spirit Place for user 791	78	-21	57	99	2013-10-08 14:08:44	2011-08-06 01:57:44	25	2	t
1744	793	Spirit Place for user 793	-32	34	2	-66	2013-10-08 14:08:44	2011-08-03 23:55:44	22	2	t
1745	794	Spirit Place for user 794	14	14	28	0	2013-10-08 14:08:44	2011-08-02 22:54:44	23	2	t
1746	796	Spirit Place for user 796	71	22	93	49	2013-10-08 14:08:44	2011-07-31 20:52:44	29	2	t
1747	797	Spirit Place for user 797	-7	-42	-49	35	2013-10-08 14:08:44	2011-07-30 19:51:44	34	2	t
1748	799	Spirit Place for user 799	89	-5	84	94	2013-10-08 14:08:44	2011-07-28 17:49:44	32	2	t
1749	800	Spirit Place for user 800	12	-41	-29	53	2013-10-08 14:08:44	\N	29	2	t
1750	802	Spirit Place for user 802	92	36	128	56	2013-10-08 14:08:44	2011-07-25 14:46:44	41	2	t
1751	803	Spirit Place for user 803	91	92	183	-1	2013-10-08 14:08:44	2011-07-24 13:45:44	49	2	t
1752	805	Spirit Place for user 805	97	30	127	67	2013-10-08 14:08:44	\N	42	2	t
1753	806	Spirit Place for user 806	39	93	132	-54	2013-10-08 14:08:45	2011-07-21 10:42:45	42	2	t
1754	808	Spirit Place for user 808	-20	54	34	-74	2013-10-08 14:08:45	2011-07-19 08:40:45	49	2	t
1755	809	Spirit Place for user 809	-48	33	-15	-81	2013-10-08 14:08:45	2011-07-18 07:39:45	44	2	t
1756	811	Spirit Place for user 811	93	82	175	11	2013-10-08 14:08:45	2011-07-16 05:37:45	22	2	t
1757	812	Spirit Place for user 812	71	74	145	-3	2013-10-08 14:08:45	2011-07-15 04:36:45	32	2	t
1758	814	Spirit Place for user 814	11	82	93	-71	2013-10-08 14:08:45	2011-07-13 02:34:45	46	2	t
1759	815	Spirit Place for user 815	44	-13	31	57	2013-10-08 14:08:45	\N	28	2	t
1760	817	Spirit Place for user 817	-3	13	10	-16	2013-10-08 14:08:45	2011-07-09 23:31:45	42	2	t
1761	818	Spirit Place for user 818	-45	-10	-55	-35	2013-10-08 14:08:45	2011-07-08 22:30:45	49	2	t
1762	820	Spirit Place for user 820	32	21	53	11	2013-10-08 14:08:45	\N	29	2	t
1763	821	Spirit Place for user 821	-31	80	49	-111	2013-10-08 14:08:45	2011-07-05 19:27:45	36	2	t
1764	823	Spirit Place for user 823	-29	-28	-57	-1	2013-10-08 14:08:45	2011-07-03 17:25:45	20	2	t
1765	824	Spirit Place for user 824	25	37	62	-12	2013-10-08 14:08:46	2011-07-02 16:24:45	26	2	t
1766	826	Spirit Place for user 826	34	-11	23	45	2013-10-08 14:08:46	2011-06-30 14:22:46	24	2	t
1767	827	Spirit Place for user 827	9	-35	-26	44	2013-10-08 14:08:46	2011-06-29 13:21:46	32	2	t
1768	829	Spirit Place for user 829	-49	7	-42	-56	2013-10-08 14:08:46	2011-06-27 11:19:46	32	2	t
1769	830	Spirit Place for user 830	90	73	163	17	2013-10-08 14:08:46	\N	37	2	t
1770	832	Spirit Place for user 832	50	26	76	24	2013-10-08 14:08:46	2011-06-24 08:16:46	43	2	t
1771	833	Spirit Place for user 833	31	59	90	-28	2013-10-08 14:08:46	2011-06-23 07:15:46	26	2	t
1772	835	Spirit Place for user 835	82	9	91	73	2013-10-08 14:08:46	\N	27	2	t
1773	836	Spirit Place for user 836	60	73	133	-13	2013-10-08 14:08:46	2011-06-20 04:12:46	45	2	t
1774	838	Spirit Place for user 838	10	-41	-31	51	2013-10-08 14:08:46	2011-06-18 02:10:46	47	2	t
1775	839	Spirit Place for user 839	13	-14	-1	27	2013-10-08 14:08:46	2011-06-17 01:09:46	21	2	t
1776	841	Spirit Place for user 841	-7	91	84	-98	2013-10-08 14:08:46	2011-06-14 23:07:46	28	2	t
1777	842	Spirit Place for user 842	74	63	137	11	2013-10-08 14:08:47	2011-06-13 22:06:47	35	2	t
1778	844	Spirit Place for user 844	68	50	118	18	2013-10-08 14:08:47	2011-06-11 20:04:47	35	2	t
1779	845	Spirit Place for user 845	-33	-26	-59	-7	2013-10-08 14:08:47	\N	34	2	t
1780	847	Spirit Place for user 847	-6	43	37	-49	2013-10-08 14:08:47	2011-06-08 17:01:47	21	2	t
1781	848	Spirit Place for user 848	20	-39	-19	59	2013-10-08 14:08:47	2011-06-07 16:00:47	41	2	t
1782	850	Spirit Place for user 850	88	-50	38	138	2013-10-08 14:08:47	\N	32	2	t
1783	851	Spirit Place for user 851	-4	57	53	-61	2013-10-08 14:08:47	2011-06-04 12:57:47	24	2	t
1784	853	Spirit Place for user 853	-5	81	76	-86	2013-10-08 14:08:47	2011-06-02 10:55:47	26	2	t
1785	854	Spirit Place for user 854	26	-25	1	51	2013-10-08 14:08:47	2011-06-01 09:54:47	45	2	t
1786	856	Spirit Place for user 856	72	25	97	47	2013-10-08 14:08:47	2011-05-30 07:52:47	48	2	t
1787	857	Spirit Place for user 857	94	79	173	15	2013-10-08 14:08:47	2011-05-29 06:51:47	45	2	t
1788	859	Spirit Place for user 859	98	61	159	37	2013-10-08 14:08:47	2011-05-27 04:49:47	36	2	t
1789	860	Spirit Place for user 860	30	-48	-18	78	2013-10-08 14:08:48	\N	29	2	t
1790	862	Spirit Place for user 862	31	37	68	-6	2013-10-08 14:08:48	2011-05-24 01:46:48	37	2	t
1791	863	Spirit Place for user 863	21	-28	-7	49	2013-10-08 14:08:48	2011-05-23 00:45:48	49	2	t
1792	865	Spirit Place for user 865	100	28	128	72	2013-10-08 14:08:48	\N	37	2	t
1793	866	Spirit Place for user 866	-12	41	29	-53	2013-10-08 14:08:48	2011-05-19 21:42:48	33	2	t
1794	868	Spirit Place for user 868	73	79	152	-6	2013-10-08 14:08:48	2011-05-17 19:40:48	37	2	t
1795	869	Spirit Place for user 869	21	66	87	-45	2013-10-08 14:08:48	2011-05-16 18:39:48	37	2	t
1796	871	Spirit Place for user 871	98	6	104	92	2013-10-08 14:08:48	2011-05-14 16:37:48	30	2	t
1797	872	Spirit Place for user 872	-21	18	-3	-39	2013-10-08 14:08:48	2011-05-13 15:36:48	38	2	t
1798	874	Spirit Place for user 874	54	27	81	27	2013-10-08 14:08:48	2011-05-11 13:34:48	46	2	t
1799	875	Spirit Place for user 875	-18	80	62	-98	2013-10-08 14:08:48	\N	49	2	t
1800	877	Spirit Place for user 877	22	-8	14	30	2013-10-08 14:08:48	2011-05-08 10:31:48	28	2	t
1801	878	Spirit Place for user 878	18	72	90	-54	2013-10-08 14:08:49	2011-05-07 09:30:48	38	2	t
1802	880	Spirit Place for user 880	99	-44	55	143	2013-10-08 14:08:49	\N	48	2	t
1803	881	Spirit Place for user 881	-40	-34	-74	-6	2013-10-08 14:08:49	2011-05-04 06:27:49	46	2	t
1804	883	Spirit Place for user 883	-8	12	4	-20	2013-10-08 14:08:49	2011-05-02 04:25:49	34	2	t
1805	884	Spirit Place for user 884	26	44	70	-18	2013-10-08 14:08:49	2011-05-01 03:24:49	34	2	t
1806	886	Spirit Place for user 886	-12	47	35	-59	2013-10-08 14:08:49	2011-04-29 01:22:49	39	2	t
1807	887	Spirit Place for user 887	17	-9	8	26	2013-10-08 14:08:49	2011-04-28 00:21:49	29	2	t
1808	889	Spirit Place for user 889	1	14	15	-13	2013-10-08 14:08:49	2011-04-25 22:19:49	48	2	t
1809	890	Spirit Place for user 890	35	-41	-6	76	2013-10-08 14:08:49	\N	38	2	t
1810	892	Spirit Place for user 892	61	-12	49	73	2013-10-08 14:08:49	2011-04-22 19:16:49	43	2	t
1811	893	Spirit Place for user 893	39	41	80	-2	2013-10-08 14:08:49	2011-04-21 18:15:49	24	2	t
1812	895	Spirit Place for user 895	90	1	91	89	2013-10-08 14:08:50	\N	36	2	t
1813	896	Spirit Place for user 896	-20	-35	-55	15	2013-10-08 14:08:50	2011-04-18 15:12:50	22	2	t
1814	898	Spirit Place for user 898	-11	42	31	-53	2013-10-08 14:08:50	2011-04-16 13:10:50	49	2	t
1815	899	Spirit Place for user 899	35	-3	32	38	2013-10-08 14:08:50	2011-04-15 12:09:50	46	2	t
1816	901	Spirit Place for user 901	25	70	95	-45	2013-10-08 14:08:50	2011-04-13 10:07:50	36	2	t
1817	902	Spirit Place for user 902	26	82	108	-56	2013-10-08 14:08:50	2011-04-12 09:06:50	30	2	t
1818	904	Spirit Place for user 904	14	96	110	-82	2013-10-08 14:08:50	2011-04-10 07:04:50	45	2	t
1819	905	Spirit Place for user 905	98	72	170	26	2013-10-08 14:08:50	\N	26	2	t
1820	907	Spirit Place for user 907	68	-41	27	109	2013-10-08 14:08:51	2011-04-07 04:01:50	31	2	t
1821	908	Spirit Place for user 908	47	55	102	-8	2013-10-08 14:08:51	2011-04-06 03:00:51	23	2	t
1822	910	Spirit Place for user 910	92	17	109	75	2013-10-08 14:08:51	\N	46	2	t
1823	911	Spirit Place for user 911	75	87	162	-12	2013-10-08 14:08:51	2011-04-02 23:57:51	37	2	t
1824	913	Spirit Place for user 913	-20	-50	-70	30	2013-10-08 14:08:51	2011-03-31 21:55:51	38	2	t
1825	914	Spirit Place for user 914	4	55	59	-51	2013-10-08 14:08:51	2011-03-30 20:54:51	22	2	t
1826	916	Spirit Place for user 916	-13	-36	-49	23	2013-10-08 14:08:51	2011-03-28 18:52:51	32	2	t
1827	917	Spirit Place for user 917	-37	-38	-75	1	2013-10-08 14:08:51	2011-03-27 17:51:51	47	2	t
1828	919	Spirit Place for user 919	-5	51	46	-56	2013-10-08 14:08:51	2011-03-25 15:49:51	26	2	t
1829	920	Spirit Place for user 920	-7	-5	-12	-2	2013-10-08 14:08:51	\N	22	2	t
1830	922	Spirit Place for user 922	50	56	106	-6	2013-10-08 14:08:51	2011-03-22 12:46:51	33	2	t
1831	923	Spirit Place for user 923	19	-29	-10	48	2013-10-08 14:08:52	2011-03-21 11:45:52	48	2	t
1832	925	Spirit Place for user 925	-46	-14	-60	-32	2013-10-08 14:08:52	\N	29	2	t
1833	926	Spirit Place for user 926	41	78	119	-37	2013-10-08 14:08:52	2011-03-18 08:42:52	42	2	t
1834	928	Spirit Place for user 928	25	0	25	25	2013-10-08 14:08:52	2011-03-16 06:40:52	25	2	t
1835	929	Spirit Place for user 929	63	69	132	-6	2013-10-08 14:08:52	2011-03-15 05:39:52	29	2	t
1836	931	Spirit Place for user 931	45	-6	39	51	2013-10-08 14:08:52	2011-03-13 03:37:52	36	2	t
1837	932	Spirit Place for user 932	7	3	10	4	2013-10-08 14:08:52	2011-03-12 02:36:52	24	2	t
1838	934	Spirit Place for user 934	-26	15	-11	-41	2013-10-08 14:08:52	2011-03-10 00:34:52	41	2	t
1839	935	Spirit Place for user 935	43	2	45	41	2013-10-08 14:08:52	\N	38	2	t
1840	937	Spirit Place for user 937	-43	79	36	-122	2013-10-08 14:08:52	2011-03-06 21:31:52	40	2	t
1841	938	Spirit Place for user 938	30	96	126	-66	2013-10-08 14:08:52	2011-03-05 20:30:52	41	2	t
1842	940	Spirit Place for user 940	8	32	40	-24	2013-10-08 14:08:53	\N	29	2	t
1843	941	Spirit Place for user 941	63	-13	50	76	2013-10-08 14:08:53	2011-03-02 17:27:53	43	2	t
1844	943	Spirit Place for user 943	-16	55	39	-71	2013-10-08 14:08:53	2011-02-28 15:25:53	20	2	t
1845	944	Spirit Place for user 944	92	-32	60	124	2013-10-08 14:08:53	2011-02-27 14:24:53	22	2	t
1846	946	Spirit Place for user 946	-21	-38	-59	17	2013-10-08 14:08:53	2011-02-25 12:22:53	21	2	t
1847	947	Spirit Place for user 947	68	51	119	17	2013-10-08 14:08:53	2011-02-24 11:21:53	42	2	t
1848	949	Spirit Place for user 949	-42	38	-4	-80	2013-10-08 14:08:54	2011-02-22 09:19:53	36	2	t
1849	950	Spirit Place for user 950	55	44	99	11	2013-10-08 14:08:54	\N	24	2	t
1850	952	Spirit Place for user 952	56	-12	44	68	2013-10-08 14:08:54	2011-02-19 06:16:54	41	2	t
1851	953	Spirit Place for user 953	99	27	126	72	2013-10-08 14:08:54	2011-02-18 05:15:54	32	2	t
1852	955	Spirit Place for user 955	4	18	22	-14	2013-10-08 14:08:54	\N	43	2	t
1853	956	Spirit Place for user 956	44	4	48	40	2013-10-08 14:08:54	2011-02-15 02:12:54	24	2	t
1854	958	Spirit Place for user 958	-35	31	-4	-66	2013-10-08 14:08:55	2011-02-13 00:10:55	31	2	t
1855	959	Spirit Place for user 959	-40	81	41	-121	2013-10-08 14:08:55	2011-02-11 23:09:55	27	2	t
1856	961	Spirit Place for user 961	-47	-3	-50	-44	2013-10-08 14:08:55	2011-02-09 21:07:55	27	2	t
1857	962	Spirit Place for user 962	86	-39	47	125	2013-10-08 14:08:55	2011-02-08 20:06:55	47	2	t
1858	964	Spirit Place for user 964	25	-8	17	33	2013-10-08 14:08:55	2011-02-06 18:04:55	32	2	t
1859	965	Spirit Place for user 965	-22	49	27	-71	2013-10-08 14:08:55	\N	29	2	t
1860	967	Spirit Place for user 967	22	70	92	-48	2013-10-08 14:08:55	2011-02-03 15:01:55	21	2	t
1861	968	Spirit Place for user 968	-44	-25	-69	-19	2013-10-08 14:08:56	2011-02-02 14:00:55	29	2	t
1862	970	Spirit Place for user 970	87	83	170	4	2013-10-08 14:08:56	\N	21	2	t
1863	971	Spirit Place for user 971	78	77	155	1	2013-10-08 14:08:56	2011-01-30 10:57:56	37	2	t
1864	973	Spirit Place for user 973	-36	99	63	-135	2013-10-08 14:08:56	2011-01-28 08:55:56	41	2	t
1865	974	Spirit Place for user 974	-16	83	67	-99	2013-10-08 14:08:56	2011-01-27 07:54:56	26	2	t
1866	976	Spirit Place for user 976	-34	58	24	-92	2013-10-08 14:08:56	2011-01-25 05:52:56	34	2	t
1867	977	Spirit Place for user 977	-49	-18	-67	-31	2013-10-08 14:08:56	2011-01-24 04:51:56	34	2	t
1868	979	Spirit Place for user 979	-41	-4	-45	-37	2013-10-08 14:08:56	2011-01-22 02:49:56	22	2	t
1869	980	Spirit Place for user 980	28	92	120	-64	2013-10-08 14:08:56	\N	37	2	t
1870	982	Spirit Place for user 982	72	85	157	-13	2013-10-08 14:09:00	2011-01-18 23:46:56	29	2	t
1871	983	Spirit Place for user 983	67	-9	58	76	2013-10-08 14:09:01	2011-01-17 22:46:00	35	2	t
1872	985	Spirit Place for user 985	52	69	121	-17	2013-10-08 14:09:01	\N	34	2	t
1873	986	Spirit Place for user 986	53	50	103	3	2013-10-08 14:09:01	2011-01-14 19:43:01	33	2	t
1874	988	Spirit Place for user 988	35	48	83	-13	2013-10-08 14:09:01	2011-01-12 17:41:01	49	2	t
1875	989	Spirit Place for user 989	90	15	105	75	2013-10-08 14:09:01	2011-01-11 16:40:01	41	2	t
1876	991	Spirit Place for user 991	-11	73	62	-84	2013-10-08 14:09:01	2011-01-09 14:38:01	35	2	t
1877	992	Spirit Place for user 992	20	69	89	-49	2013-10-08 14:09:01	2011-01-08 13:37:01	21	2	t
1878	994	Spirit Place for user 994	1	-41	-40	42	2013-10-08 14:09:01	2011-01-06 11:35:01	44	2	t
1879	995	Spirit Place for user 995	-7	66	59	-73	2013-10-08 14:09:02	\N	34	2	t
1880	997	Spirit Place for user 997	33	-4	29	37	2013-10-08 14:09:02	2011-01-03 08:32:02	20	2	t
1881	998	Spirit Place for user 998	92	-20	72	112	2013-10-08 14:09:02	2011-01-02 07:31:02	26	2	t
1882	1000	Spirit Place for user 1000	7	-43	-36	50	2013-10-08 14:09:02	\N	48	2	t
1883	1001	Spirit Place for user 1001	18	84	102	-66	2013-10-08 14:09:02	2010-12-30 04:28:02	49	2	t
1884	1003	Spirit Place for user 1003	85	-42	43	127	2013-10-08 14:09:02	2010-12-28 02:26:02	38	2	t
1885	1004	Spirit Place for user 1004	69	0	69	69	2013-10-08 14:09:03	2010-12-27 01:25:02	46	2	t
1886	1006	Spirit Place for user 1006	33	-33	0	66	2013-10-08 14:09:03	2010-12-24 23:23:03	31	2	t
1887	1007	Spirit Place for user 1007	33	3	36	30	2013-10-08 14:09:03	2010-12-23 22:22:03	34	2	t
1888	1009	Spirit Place for user 1009	-2	-10	-12	8	2013-10-08 14:09:03	2010-12-21 20:20:03	44	2	t
1889	1010	Spirit Place for user 1010	-27	-21	-48	-6	2013-10-08 14:09:03	\N	37	2	t
1890	1012	Spirit Place for user 1012	13	81	94	-68	2013-10-08 14:09:03	2010-12-18 17:17:03	46	2	t
1891	1013	Spirit Place for user 1013	100	-17	83	117	2013-10-08 14:09:03	2010-12-17 16:16:03	34	2	t
1892	1015	Spirit Place for user 1015	39	25	64	14	2013-10-08 14:09:03	\N	47	2	t
1893	1016	Spirit Place for user 1016	35	34	69	1	2013-10-08 14:09:03	2010-12-14 13:13:03	37	2	t
1894	1018	Spirit Place for user 1018	-21	59	38	-80	2013-10-08 14:09:03	2010-12-12 11:11:03	28	2	t
1895	1019	Spirit Place for user 1019	41	39	80	2	2013-10-08 14:09:03	2010-12-11 10:10:03	44	2	t
1896	1021	Spirit Place for user 1021	-2	-27	-29	25	2013-10-08 14:09:04	2010-12-09 08:08:03	43	2	t
1897	1022	Spirit Place for user 1022	-19	-1	-20	-18	2013-10-08 14:09:04	2010-12-08 07:07:04	20	2	t
1898	1024	Spirit Place for user 1024	82	62	144	20	2013-10-08 14:09:04	2010-12-06 05:05:04	41	2	t
1899	1025	Spirit Place for user 1025	77	25	102	52	2013-10-08 14:09:04	\N	47	2	t
1900	1027	Spirit Place for user 1027	72	81	153	-9	2013-10-08 14:09:04	2010-12-03 02:02:04	36	2	t
1901	1028	Spirit Place for user 1028	43	5	48	38	2013-10-08 14:09:04	2010-12-02 01:01:04	37	2	t
1902	1030	Spirit Place for user 1030	47	-47	0	94	2013-10-08 14:09:04	\N	38	2	t
1903	1031	Spirit Place for user 1031	62	59	121	3	2013-10-08 14:09:04	2010-11-28 21:58:04	27	2	t
1904	1033	Spirit Place for user 1033	93	65	158	28	2013-10-08 14:09:04	2010-11-26 19:56:04	45	2	t
1905	1034	Spirit Place for user 1034	11	90	101	-79	2013-10-08 14:09:04	2010-11-25 18:55:04	22	2	t
1906	1036	Spirit Place for user 1036	69	91	160	-22	2013-10-08 14:09:04	2010-11-23 16:53:04	22	2	t
1907	1037	Spirit Place for user 1037	-4	-12	-16	8	2013-10-08 14:09:04	2010-11-22 15:52:04	33	2	t
1908	1039	Spirit Place for user 1039	62	40	102	22	2013-10-08 14:09:05	2010-11-20 13:50:04	41	2	t
1909	1040	Spirit Place for user 1040	-29	57	28	-86	2013-10-08 14:09:05	\N	28	2	t
1910	1042	Spirit Place for user 1042	-45	37	-8	-82	2013-10-08 14:09:05	2010-11-17 10:47:05	45	2	t
1911	1043	Spirit Place for user 1043	5	35	40	-30	2013-10-08 14:09:05	2010-11-16 09:46:05	37	2	t
1912	1045	Spirit Place for user 1045	3	-6	-3	9	2013-10-08 14:09:05	\N	22	2	t
1913	1046	Spirit Place for user 1046	-5	-9	-14	4	2013-10-08 14:09:05	2010-11-13 06:43:05	43	2	t
1914	1048	Spirit Place for user 1048	12	55	67	-43	2013-10-08 14:09:06	2010-11-11 04:41:06	39	2	t
1915	1049	Spirit Place for user 1049	41	-7	34	48	2013-10-08 14:09:06	2010-11-10 03:40:06	27	2	t
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_settings (id, user_id, radius) FROM stdin;
1	2	2
2	3	3
3	4	4
4	8	8
5	9	9
6	20	20
\.


--
-- Data for Name: user_social; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_social (id, user_id, social_service, user_social_id, additional_data) FROM stdin;
1	101	twitter	71662685	\N
\.


--
-- Name: AuthAssignment_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "AuthAssignment"
    ADD CONSTRAINT "AuthAssignment_pkey" PRIMARY KEY (itemname, userid);


--
-- Name: AuthItemChild_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "AuthItemChild"
    ADD CONSTRAINT "AuthItemChild_pkey" PRIMARY KEY (parent, child);


--
-- Name: AuthItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "AuthItem"
    ADD CONSTRAINT "AuthItem_pkey" PRIMARY KEY (name);


--
-- Name: application_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: content_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: content_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY content
    ADD CONSTRAINT content_slug_unique UNIQUE (slug);


--
-- Name: cron_mail_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cron_mail
    ADD CONSTRAINT cron_mail_pkey PRIMARY KEY (id);


--
-- Name: favorite_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favorite
    ADD CONSTRAINT favorite_pkey PRIMARY KEY (id);


--
-- Name: feed_external_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feed_external_item
    ADD CONSTRAINT feed_external_item_pkey PRIMARY KEY (id);


--
-- Name: feed_external_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY feed_external
    ADD CONSTRAINT feed_external_pkey PRIMARY KEY (id);


--
-- Name: media_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: post_name_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post_name_user
    ADD CONSTRAINT post_name_user_pkey PRIMARY KEY (post_id, user_id);


--
-- Name: post_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: smtp_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY smtp
    ADD CONSTRAINT smtp_pkey PRIMARY KEY (id);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tag_place_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tag_place
    ADD CONSTRAINT tag_place_pkey PRIMARY KEY (id);


--
-- Name: tag_post_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tag_post
    ADD CONSTRAINT tag_post_pkey PRIMARY KEY (post_id, tag_id);


--
-- Name: token_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: user_email_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- Name: user_feed_external_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_feed_external
    ADD CONSTRAINT user_feed_external_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_place_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_place
    ADD CONSTRAINT user_place_pkey PRIMARY KEY (id);


--
-- Name: user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (id);


--
-- Name: user_settings_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_settings
    ADD CONSTRAINT user_settings_user_id_unique UNIQUE (user_id);


--
-- Name: user_social_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_social
    ADD CONSTRAINT user_social_pkey PRIMARY KEY (id);


--
-- Name: user_social_social_service_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_social
    ADD CONSTRAINT user_social_social_service_user_id_unique UNIQUE (social_service, user_social_id);


--
-- Name: user_username_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_unique UNIQUE (username);


--
-- Name: vavorite_user_id_favorit_id_type_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY favorite
    ADD CONSTRAINT vavorite_user_id_favorit_id_type_unique UNIQUE (user_id, type, favorite_id);


--
-- Name: _idx_user_place_cx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx ON user_place USING btree (cx);


--
-- Name: _idx_user_place_cx_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx_cy ON user_place USING btree (cx, cy);


--
-- Name: _idx_user_place_cx_m_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx_m_cy ON user_place USING btree (cx_m_cy);


--
-- Name: _idx_user_place_cx_p_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx_p_cy ON user_place USING btree (cx_p_cy);


--
-- Name: _idx_user_place_cx_p_cy_cx_m_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx_p_cy_cx_m_cy ON user_place USING btree (cx_p_cy, cx_m_cy);


--
-- Name: _idx_user_place_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cy ON user_place USING btree (cy);


--
-- Name: _idx_user_place_is_spirit; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_is_spirit ON user_place USING btree (is_spirit);


--
-- Name: message_from_user_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX message_from_user_id_idx ON message USING btree (from_user_id);


--
-- Name: message_to_user_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX message_to_user_id_idx ON message USING btree (to_user_id);


--
-- Name: post_cx_cy_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX post_cx_cy_idx ON post USING btree (cx, cy);


--
-- Name: post_cx_m_cy_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX post_cx_m_cy_idx ON post USING btree (cx_m_cy);


--
-- Name: post_cx_p_cy_cx_m_cy_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX post_cx_p_cy_cx_m_cy_idx ON post USING btree (cx_p_cy, cx_m_cy);


--
-- Name: post_cy_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX post_cy_idx ON post USING btree (cy);


--
-- Name: tag_name_unique; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX tag_name_unique ON tag USING btree (name);


--
-- Name: AuthAssignment_itemname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "AuthAssignment"
    ADD CONSTRAINT "AuthAssignment_itemname_fkey" FOREIGN KEY (itemname) REFERENCES "AuthItem"(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuthItemChild_child_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "AuthItemChild"
    ADD CONSTRAINT "AuthItemChild_child_fkey" FOREIGN KEY (child) REFERENCES "AuthItem"(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: AuthItemChild_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "AuthItemChild"
    ADD CONSTRAINT "AuthItemChild_parent_fkey" FOREIGN KEY (parent) REFERENCES "AuthItem"(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Ref_favorite_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY favorite
    ADD CONSTRAINT "Ref_favorite_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_feed_external_item_to_feed_external; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY feed_external_item
    ADD CONSTRAINT "Ref_feed_external_item_to_feed_external" FOREIGN KEY (feed_external_id) REFERENCES feed_external(id);


--
-- Name: Ref_message_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY message
    ADD CONSTRAINT "Ref_message_to_user" FOREIGN KEY (to_user_id) REFERENCES "user"(id);


--
-- Name: Ref_message_to_user0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY message
    ADD CONSTRAINT "Ref_message_to_user0" FOREIGN KEY (from_user_id) REFERENCES "user"(id);


--
-- Name: Ref_post_name_user_to_post; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_name_user
    ADD CONSTRAINT "Ref_post_name_user_to_post" FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: Ref_post_name_user_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY post_name_user
    ADD CONSTRAINT "Ref_post_name_user_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_post_to_post; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY post
    ADD CONSTRAINT "Ref_post_to_post" FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: Ref_post_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY post
    ADD CONSTRAINT "Ref_post_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_tag_place_to_tag; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag_place
    ADD CONSTRAINT "Ref_tag_place_to_tag" FOREIGN KEY (tag_id) REFERENCES tag(id);


--
-- Name: Ref_tag_place_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag_place
    ADD CONSTRAINT "Ref_tag_place_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_tag_post_to_post; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag_post
    ADD CONSTRAINT "Ref_tag_post_to_post" FOREIGN KEY (post_id) REFERENCES post(id);


--
-- Name: Ref_tag_post_to_tag; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag_post
    ADD CONSTRAINT "Ref_tag_post_to_tag" FOREIGN KEY (tag_id) REFERENCES tag(id);


--
-- Name: Ref_token_to_application; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY token
    ADD CONSTRAINT "Ref_token_to_application" FOREIGN KEY (application_id) REFERENCES application(id);


--
-- Name: Ref_token_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY token
    ADD CONSTRAINT "Ref_token_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_user_feed_external_to_feed_external; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_feed_external
    ADD CONSTRAINT "Ref_user_feed_external_to_feed_external" FOREIGN KEY (feed_external_id) REFERENCES feed_external(id);


--
-- Name: Ref_user_feed_external_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_feed_external
    ADD CONSTRAINT "Ref_user_feed_external_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_user_place_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_place
    ADD CONSTRAINT "Ref_user_place_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_user_settings_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_settings
    ADD CONSTRAINT "Ref_user_settings_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: Ref_user_social_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_social
    ADD CONSTRAINT "Ref_user_social_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- PostgreSQL database dump complete
--

