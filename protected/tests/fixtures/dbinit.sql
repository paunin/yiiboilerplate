--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE content_id_seq OWNED BY content.id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cron_mail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cron_mail_id_seq OWNED BY cron_mail.id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: smtp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE smtp_id_seq OWNED BY smtp.id;


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
    password character varying(255)
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_place_id_seq OWNED BY user_place.id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_settings_id_seq OWNED BY user_settings.id;


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
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_social_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_social_id_seq OWNED BY user_social.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY content ALTER COLUMN id SET DEFAULT nextval('content_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cron_mail ALTER COLUMN id SET DEFAULT nextval('cron_mail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY smtp ALTER COLUMN id SET DEFAULT nextval('smtp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_place ALTER COLUMN id SET DEFAULT nextval('user_place_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_settings ALTER COLUMN id SET DEFAULT nextval('user_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_social ALTER COLUMN id SET DEFAULT nextval('user_social_id_seq'::regclass);


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
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY content (id, title, slug, text, created_at, updated_at) FROM stdin;
2	Тестовый контент 1	content_slug_1	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
3	Тестовый контент 2	content_slug_2	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
4	Тестовый контент 3	content_slug_3	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
5	Тестовый контент 4	content_slug_4	Привет друзья! Часто ли вы покупаете еду или воду в специализированных для этого автоматах? Лично я никогда. Но Google хочет перевернуть во мне представление о подобных автоматах!\r\n \r\n\r\nЯпонское подразделение Google запустило в Токио экспериментальный проект - продажу игр с помощью автоматов, в которых обычно покупают еду и напитки. Для установки игр нужен Android 4.0+ и NFC модуль.\r\n\r\nЗа автоматом наблюдают специальные гуглолюди, которые подозрительно на вас смотрят и вынуждают вас потратить больше-больше-больше денег! Но отвлечемся от теории всемирного заговора и вернемся к нашему автомату. На экране показано 18 игр, как платных, так и бесплатных. За каждое скачивание пользователь получает сувенир - сначала он появляется на экране, а затем по-настоящему выскакивает из лотка внизу аппарата, как газировка. Что приятно, так это то, что Google, если вы не знаете что такое андроид, предложит вам им попользоваться, на примере гуглофона Nexus 4!\r\n \r\n\r\nНе знаю как вы, а я к этой идее отнесся с оптимизмом. Например если поставить такие автоматы туда где нет интернета, то быстро закачать полезное приложение будет очень кстати!\r\n\r\nПричем моду на автоматы некоторые компании взяли давно. В больших торговых центрах я часто наблюдаю картину, когда в подобных автоматах продаются чехлы для iPhone. И очень хорошо продаются! А значит у идеи определенно есть потенциал, правда пока проект в статусе бета, но я думаю, что скоро такие автоматы будут во все прогрессивных странах!	2013-10-01 11:30:38.088602	\N
\.


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('content_id_seq', 100, false);


--
-- Data for Name: cron_mail; Type: TABLE DATA; Schema: public; Owner: -
--

COPY cron_mail (id, subject, body, body_alt, to_mail, to_name, from_mail, from_name, is_sent, attachment_file, attachment_name) FROM stdin;
\.


--
-- Name: cron_mail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cron_mail_id_seq', 1, false);


--
-- Data for Name: smtp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY smtp (id, host, username, password, port, encryption, timeout, "extensionHandlers", using_count, banned) FROM stdin;
\.


--
-- Name: smtp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('smtp_id_seq', 1, false);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "user" (id, username, email, key, created_at, updated_at, role, is_active, last_login, password) FROM stdin;
1	U_twitter_71662685	\N	\N	2013-10-07 14:40:22	2013-10-07 14:40:22	user	t	2013-10-07 14:40:22	\N
2	admin	admin@admin.com	\N	2013-09-16 11:47:38	2013-10-07 12:42:38	admin	t	2013-10-07 12:42:38	1341215dbe9acab4361fd6417b2b11bc
3	user3	user3@user.com	\N	2013-10-05 08:38:20	2013-11-04 08:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
4	user4	user4@user.com	\N	2013-10-04 07:37:20	2013-11-03 07:37:20	user	t	2013-11-18 07:37:20	87dc1e131a1369fdf8f1c824a6a62dff
5	user5	user5@user.com	\N	2013-10-03 06:36:20	\N	user	t	2013-11-17 06:36:20	87dc1e131a1369fdf8f1c824a6a62dff
6	user6	user6@user.com	\N	2013-10-02 05:35:20	2013-11-01 05:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
7	user7	user7@user.com	\N	2013-10-01 04:34:20	2013-10-31 04:34:20	user	t	2013-11-15 04:34:20	87dc1e131a1369fdf8f1c824a6a62dff
8	user8	user8@user.com	\N	2013-09-30 03:33:20	2013-10-30 03:33:20	user	t	2013-11-14 03:33:20	87dc1e131a1369fdf8f1c824a6a62dff
9	user9	user9@user.com	\N	2013-09-29 02:32:20	2013-10-29 02:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
10	user10	user10@user.com	\N	2013-09-28 01:31:20	\N	user	t	2013-11-12 01:31:20	87dc1e131a1369fdf8f1c824a6a62dff
11	user11	user11@user.com	\N	2013-09-27 00:30:20	2013-10-27 00:30:20	user	t	2013-11-11 00:30:20	87dc1e131a1369fdf8f1c824a6a62dff
12	user12	user12@user.com	\N	2013-09-25 23:29:20	2013-10-25 23:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
13	user13	user13@user.com	\N	2013-09-24 22:28:20	2013-10-24 22:28:20	user	t	2013-11-08 22:28:20	87dc1e131a1369fdf8f1c824a6a62dff
14	user14	user14@user.com	\N	2013-09-23 21:27:20	2013-10-23 21:27:20	user	t	2013-11-07 21:27:20	87dc1e131a1369fdf8f1c824a6a62dff
15	user15	user15@user.com	\N	2013-09-22 20:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
16	user16	user16@user.com	\N	2013-09-21 19:25:20	2013-10-21 19:25:20	user	t	2013-11-05 19:25:20	87dc1e131a1369fdf8f1c824a6a62dff
17	user17	user17@user.com	\N	2013-09-20 18:24:20	2013-10-20 18:24:20	user	t	2013-11-04 18:24:20	87dc1e131a1369fdf8f1c824a6a62dff
18	user18	user18@user.com	\N	2013-09-19 17:23:20	2013-10-19 17:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
19	user19	user19@user.com	\N	2013-09-18 16:22:20	2013-10-18 16:22:20	user	t	2013-11-02 16:22:20	87dc1e131a1369fdf8f1c824a6a62dff
20	user20	user20@user.com	\N	2013-09-17 15:21:20	\N	user	t	2013-11-01 15:21:20	87dc1e131a1369fdf8f1c824a6a62dff
21	user21	user21@user.com	\N	2013-09-16 14:20:20	2013-10-16 14:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
22	user22	user22@user.com	\N	2013-09-15 13:19:20	2013-10-15 13:19:20	user	t	2013-10-30 13:19:20	87dc1e131a1369fdf8f1c824a6a62dff
23	user23	user23@user.com	\N	2013-09-14 12:18:20	2013-10-14 12:18:20	user	t	2013-10-29 12:18:20	87dc1e131a1369fdf8f1c824a6a62dff
24	user24	user24@user.com	\N	2013-09-13 11:17:20	2013-10-13 11:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
25	user25	user25@user.com	\N	2013-09-12 10:16:20	\N	user	t	2013-10-27 10:16:20	87dc1e131a1369fdf8f1c824a6a62dff
26	user26	user26@user.com	\N	2013-09-11 09:15:20	2013-10-11 09:15:20	user	t	2013-10-26 09:15:20	87dc1e131a1369fdf8f1c824a6a62dff
27	user27	user27@user.com	\N	2013-09-10 08:14:20	2013-10-10 08:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
28	user28	user28@user.com	\N	2013-09-09 07:13:20	2013-10-09 07:13:20	user	t	2013-10-24 07:13:20	87dc1e131a1369fdf8f1c824a6a62dff
29	user29	user29@user.com	\N	2013-09-08 06:12:20	2013-10-08 06:12:20	user	t	2013-10-23 06:12:20	87dc1e131a1369fdf8f1c824a6a62dff
30	user30	user30@user.com	\N	2013-09-07 05:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
31	user31	user31@user.com	\N	2013-09-06 04:10:20	2013-10-06 04:10:20	user	t	2013-10-21 04:10:20	87dc1e131a1369fdf8f1c824a6a62dff
32	user32	user32@user.com	\N	2013-09-05 03:09:20	2013-10-05 03:09:20	user	t	2013-10-20 03:09:20	87dc1e131a1369fdf8f1c824a6a62dff
33	user33	user33@user.com	\N	2013-09-04 02:08:20	2013-10-04 02:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
34	user34	user34@user.com	\N	2013-09-03 01:07:20	2013-10-03 01:07:20	user	t	2013-10-18 01:07:20	87dc1e131a1369fdf8f1c824a6a62dff
35	user35	user35@user.com	\N	2013-09-02 00:06:20	\N	user	t	2013-10-17 00:06:20	87dc1e131a1369fdf8f1c824a6a62dff
36	user36	user36@user.com	\N	2013-08-31 23:05:20	2013-09-30 23:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
37	user37	user37@user.com	\N	2013-08-30 22:04:20	2013-09-29 22:04:20	user	t	2013-10-14 22:04:20	87dc1e131a1369fdf8f1c824a6a62dff
38	user38	user38@user.com	\N	2013-08-29 21:03:20	2013-09-28 21:03:20	user	t	2013-10-13 21:03:20	87dc1e131a1369fdf8f1c824a6a62dff
39	user39	user39@user.com	\N	2013-08-28 20:02:20	2013-09-27 20:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
40	user40	user40@user.com	\N	2013-08-27 19:01:20	\N	user	t	2013-10-11 19:01:20	87dc1e131a1369fdf8f1c824a6a62dff
41	user41	user41@user.com	\N	2013-08-26 18:00:20	2013-09-25 18:00:20	user	t	2013-10-10 18:00:20	87dc1e131a1369fdf8f1c824a6a62dff
42	user42	user42@user.com	\N	2013-08-25 16:59:20	2013-09-24 16:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
43	user43	user43@user.com	\N	2013-08-24 15:58:20	2013-09-23 15:58:20	user	t	2013-10-08 15:58:20	87dc1e131a1369fdf8f1c824a6a62dff
44	user44	user44@user.com	\N	2013-08-23 14:57:20	2013-09-22 14:57:20	user	t	2013-10-07 14:57:20	87dc1e131a1369fdf8f1c824a6a62dff
45	user45	user45@user.com	\N	2013-08-22 13:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
46	user46	user46@user.com	\N	2013-08-21 12:55:20	2013-09-20 12:55:20	user	t	2013-10-05 12:55:20	87dc1e131a1369fdf8f1c824a6a62dff
47	user47	user47@user.com	\N	2013-08-20 11:54:20	2013-09-19 11:54:20	user	t	2013-10-04 11:54:20	87dc1e131a1369fdf8f1c824a6a62dff
48	user48	user48@user.com	\N	2013-08-19 10:53:20	2013-09-18 10:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
49	user49	user49@user.com	\N	2013-08-18 09:52:20	2013-09-17 09:52:20	user	t	2013-10-02 09:52:20	87dc1e131a1369fdf8f1c824a6a62dff
50	user50	user50@user.com	\N	2013-08-17 08:51:20	\N	user	t	2013-10-01 08:51:20	87dc1e131a1369fdf8f1c824a6a62dff
51	user51	user51@user.com	\N	2013-08-16 07:50:20	2013-09-15 07:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
52	user52	user52@user.com	\N	2013-08-15 06:49:20	2013-09-14 06:49:20	user	t	2013-09-29 06:49:20	87dc1e131a1369fdf8f1c824a6a62dff
53	user53	user53@user.com	\N	2013-08-14 05:48:20	2013-09-13 05:48:20	user	t	2013-09-28 05:48:20	87dc1e131a1369fdf8f1c824a6a62dff
54	user54	user54@user.com	\N	2013-08-13 04:47:20	2013-09-12 04:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
55	user55	user55@user.com	\N	2013-08-12 03:46:20	\N	user	t	2013-09-26 03:46:20	87dc1e131a1369fdf8f1c824a6a62dff
56	user56	user56@user.com	\N	2013-08-11 02:45:20	2013-09-10 02:45:20	user	t	2013-09-25 02:45:20	87dc1e131a1369fdf8f1c824a6a62dff
57	user57	user57@user.com	\N	2013-08-10 01:44:20	2013-09-09 01:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
58	user58	user58@user.com	\N	2013-08-09 00:43:20	2013-09-08 00:43:20	user	t	2013-09-23 00:43:20	87dc1e131a1369fdf8f1c824a6a62dff
59	user59	user59@user.com	\N	2013-08-07 23:42:20	2013-09-06 23:42:20	user	t	2013-09-21 23:42:20	87dc1e131a1369fdf8f1c824a6a62dff
60	user60	user60@user.com	\N	2013-08-06 22:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
61	user61	user61@user.com	\N	2013-08-05 21:40:20	2013-09-04 21:40:20	user	t	2013-09-19 21:40:20	87dc1e131a1369fdf8f1c824a6a62dff
62	user62	user62@user.com	\N	2013-08-04 20:39:20	2013-09-03 20:39:20	user	t	2013-09-18 20:39:20	87dc1e131a1369fdf8f1c824a6a62dff
63	user63	user63@user.com	\N	2013-08-03 19:38:20	2013-09-02 19:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
64	user64	user64@user.com	\N	2013-08-02 18:37:20	2013-09-01 18:37:20	user	t	2013-09-16 18:37:20	87dc1e131a1369fdf8f1c824a6a62dff
65	user65	user65@user.com	\N	2013-08-01 17:36:20	\N	user	t	2013-09-15 17:36:20	87dc1e131a1369fdf8f1c824a6a62dff
66	user66	user66@user.com	\N	2013-07-31 16:35:20	2013-08-30 16:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
67	user67	user67@user.com	\N	2013-07-30 15:34:20	2013-08-29 15:34:20	user	t	2013-09-13 15:34:20	87dc1e131a1369fdf8f1c824a6a62dff
68	user68	user68@user.com	\N	2013-07-29 14:33:20	2013-08-28 14:33:20	user	t	2013-09-12 14:33:20	87dc1e131a1369fdf8f1c824a6a62dff
69	user69	user69@user.com	\N	2013-07-28 13:32:20	2013-08-27 13:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
70	user70	user70@user.com	\N	2013-07-27 12:31:20	\N	user	t	2013-09-10 12:31:20	87dc1e131a1369fdf8f1c824a6a62dff
71	user71	user71@user.com	\N	2013-07-26 11:30:20	2013-08-25 11:30:20	user	t	2013-09-09 11:30:20	87dc1e131a1369fdf8f1c824a6a62dff
72	user72	user72@user.com	\N	2013-07-25 10:29:20	2013-08-24 10:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
73	user73	user73@user.com	\N	2013-07-24 09:28:20	2013-08-23 09:28:20	user	t	2013-09-07 09:28:20	87dc1e131a1369fdf8f1c824a6a62dff
74	user74	user74@user.com	\N	2013-07-23 08:27:20	2013-08-22 08:27:20	user	t	2013-09-06 08:27:20	87dc1e131a1369fdf8f1c824a6a62dff
75	user75	user75@user.com	\N	2013-07-22 07:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
76	user76	user76@user.com	\N	2013-07-21 06:25:20	2013-08-20 06:25:20	user	t	2013-09-04 06:25:20	87dc1e131a1369fdf8f1c824a6a62dff
77	user77	user77@user.com	\N	2013-07-20 05:24:20	2013-08-19 05:24:20	user	t	2013-09-03 05:24:20	87dc1e131a1369fdf8f1c824a6a62dff
78	user78	user78@user.com	\N	2013-07-19 04:23:20	2013-08-18 04:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
79	user79	user79@user.com	\N	2013-07-18 03:22:20	2013-08-17 03:22:20	user	t	2013-09-01 03:22:20	87dc1e131a1369fdf8f1c824a6a62dff
80	user80	user80@user.com	\N	2013-07-17 02:21:20	\N	user	t	2013-08-31 02:21:20	87dc1e131a1369fdf8f1c824a6a62dff
81	user81	user81@user.com	\N	2013-07-16 01:20:20	2013-08-15 01:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
82	user82	user82@user.com	\N	2013-07-15 00:19:20	2013-08-14 00:19:20	user	t	2013-08-29 00:19:20	87dc1e131a1369fdf8f1c824a6a62dff
83	user83	user83@user.com	\N	2013-07-13 23:18:20	2013-08-12 23:18:20	user	t	2013-08-27 23:18:20	87dc1e131a1369fdf8f1c824a6a62dff
84	user84	user84@user.com	\N	2013-07-12 22:17:20	2013-08-11 22:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
85	user85	user85@user.com	\N	2013-07-11 21:16:20	\N	user	t	2013-08-25 21:16:20	87dc1e131a1369fdf8f1c824a6a62dff
86	user86	user86@user.com	\N	2013-07-10 20:15:20	2013-08-09 20:15:20	user	t	2013-08-24 20:15:20	87dc1e131a1369fdf8f1c824a6a62dff
87	user87	user87@user.com	\N	2013-07-09 19:14:20	2013-08-08 19:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
88	user88	user88@user.com	\N	2013-07-08 18:13:20	2013-08-07 18:13:20	user	t	2013-08-22 18:13:20	87dc1e131a1369fdf8f1c824a6a62dff
89	user89	user89@user.com	\N	2013-07-07 17:12:20	2013-08-06 17:12:20	user	t	2013-08-21 17:12:20	87dc1e131a1369fdf8f1c824a6a62dff
90	user90	user90@user.com	\N	2013-07-06 16:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
91	user91	user91@user.com	\N	2013-07-05 15:10:20	2013-08-04 15:10:20	user	t	2013-08-19 15:10:20	87dc1e131a1369fdf8f1c824a6a62dff
92	user92	user92@user.com	\N	2013-07-04 14:09:20	2013-08-03 14:09:20	user	t	2013-08-18 14:09:20	87dc1e131a1369fdf8f1c824a6a62dff
93	user93	user93@user.com	\N	2013-07-03 13:08:20	2013-08-02 13:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
94	user94	user94@user.com	\N	2013-07-02 12:07:20	2013-08-01 12:07:20	user	t	2013-08-16 12:07:20	87dc1e131a1369fdf8f1c824a6a62dff
95	user95	user95@user.com	\N	2013-07-01 11:06:20	\N	user	t	2013-08-15 11:06:20	87dc1e131a1369fdf8f1c824a6a62dff
96	user96	user96@user.com	\N	2013-06-30 10:05:20	2013-07-30 10:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
97	user97	user97@user.com	\N	2013-06-29 09:04:20	2013-07-29 09:04:20	user	t	2013-08-13 09:04:20	87dc1e131a1369fdf8f1c824a6a62dff
98	user98	user98@user.com	\N	2013-06-28 08:03:20	2013-07-28 08:03:20	user	t	2013-08-12 08:03:20	87dc1e131a1369fdf8f1c824a6a62dff
99	user99	user99@user.com	\N	2013-06-27 07:02:20	2013-07-27 07:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
100	user100	user100@user.com	\N	2013-06-26 06:01:20	\N	user	t	2013-08-10 06:01:20	87dc1e131a1369fdf8f1c824a6a62dff
101	user101	user101@user.com	\N	2013-06-25 05:00:20	2013-07-25 05:00:20	user	t	2013-08-09 05:00:20	87dc1e131a1369fdf8f1c824a6a62dff
102	user102	user102@user.com	\N	2013-06-24 03:59:20	2013-07-24 03:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
103	user103	user103@user.com	\N	2013-06-23 02:58:20	2013-07-23 02:58:20	user	t	2013-08-07 02:58:20	87dc1e131a1369fdf8f1c824a6a62dff
104	user104	user104@user.com	\N	2013-06-22 01:57:20	2013-07-22 01:57:20	user	t	2013-08-06 01:57:20	87dc1e131a1369fdf8f1c824a6a62dff
105	user105	user105@user.com	\N	2013-06-21 00:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
106	user106	user106@user.com	\N	2013-06-19 23:55:20	2013-07-19 23:55:20	user	t	2013-08-03 23:55:20	87dc1e131a1369fdf8f1c824a6a62dff
107	user107	user107@user.com	\N	2013-06-18 22:54:20	2013-07-18 22:54:20	user	t	2013-08-02 22:54:20	87dc1e131a1369fdf8f1c824a6a62dff
108	user108	user108@user.com	\N	2013-06-17 21:53:20	2013-07-17 21:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
109	user109	user109@user.com	\N	2013-06-16 20:52:20	2013-07-16 20:52:20	user	t	2013-07-31 20:52:20	87dc1e131a1369fdf8f1c824a6a62dff
110	user110	user110@user.com	\N	2013-06-15 19:51:20	\N	user	t	2013-07-30 19:51:20	87dc1e131a1369fdf8f1c824a6a62dff
111	user111	user111@user.com	\N	2013-06-14 18:50:20	2013-07-14 18:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
112	user112	user112@user.com	\N	2013-06-13 17:49:20	2013-07-13 17:49:20	user	t	2013-07-28 17:49:20	87dc1e131a1369fdf8f1c824a6a62dff
113	user113	user113@user.com	\N	2013-06-12 16:48:20	2013-07-12 16:48:20	user	t	2013-07-27 16:48:20	87dc1e131a1369fdf8f1c824a6a62dff
114	user114	user114@user.com	\N	2013-06-11 15:47:20	2013-07-11 15:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
115	user115	user115@user.com	\N	2013-06-10 14:46:20	\N	user	t	2013-07-25 14:46:20	87dc1e131a1369fdf8f1c824a6a62dff
116	user116	user116@user.com	\N	2013-06-09 13:45:20	2013-07-09 13:45:20	user	t	2013-07-24 13:45:20	87dc1e131a1369fdf8f1c824a6a62dff
117	user117	user117@user.com	\N	2013-06-08 12:44:20	2013-07-08 12:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
118	user118	user118@user.com	\N	2013-06-07 11:43:20	2013-07-07 11:43:20	user	t	2013-07-22 11:43:20	87dc1e131a1369fdf8f1c824a6a62dff
119	user119	user119@user.com	\N	2013-06-06 10:42:20	2013-07-06 10:42:20	user	t	2013-07-21 10:42:20	87dc1e131a1369fdf8f1c824a6a62dff
120	user120	user120@user.com	\N	2013-06-05 09:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
121	user121	user121@user.com	\N	2013-06-04 08:40:20	2013-07-04 08:40:20	user	t	2013-07-19 08:40:20	87dc1e131a1369fdf8f1c824a6a62dff
122	user122	user122@user.com	\N	2013-06-03 07:39:20	2013-07-03 07:39:20	user	t	2013-07-18 07:39:20	87dc1e131a1369fdf8f1c824a6a62dff
123	user123	user123@user.com	\N	2013-06-02 06:38:20	2013-07-02 06:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
124	user124	user124@user.com	\N	2013-06-01 05:37:20	2013-07-01 05:37:20	user	t	2013-07-16 05:37:20	87dc1e131a1369fdf8f1c824a6a62dff
125	user125	user125@user.com	\N	2013-05-31 04:36:20	\N	user	t	2013-07-15 04:36:20	87dc1e131a1369fdf8f1c824a6a62dff
126	user126	user126@user.com	\N	2013-05-30 03:35:20	2013-06-29 03:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
127	user127	user127@user.com	\N	2013-05-29 02:34:20	2013-06-28 02:34:20	user	t	2013-07-13 02:34:20	87dc1e131a1369fdf8f1c824a6a62dff
128	user128	user128@user.com	\N	2013-05-28 01:33:20	2013-06-27 01:33:20	user	t	2013-07-12 01:33:20	87dc1e131a1369fdf8f1c824a6a62dff
129	user129	user129@user.com	\N	2013-05-27 00:32:20	2013-06-26 00:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
130	user130	user130@user.com	\N	2013-05-25 23:31:20	\N	user	t	2013-07-09 23:31:20	87dc1e131a1369fdf8f1c824a6a62dff
131	user131	user131@user.com	\N	2013-05-24 22:30:20	2013-06-23 22:30:20	user	t	2013-07-08 22:30:20	87dc1e131a1369fdf8f1c824a6a62dff
132	user132	user132@user.com	\N	2013-05-23 21:29:20	2013-06-22 21:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
133	user133	user133@user.com	\N	2013-05-22 20:28:20	2013-06-21 20:28:20	user	t	2013-07-06 20:28:20	87dc1e131a1369fdf8f1c824a6a62dff
134	user134	user134@user.com	\N	2013-05-21 19:27:20	2013-06-20 19:27:20	user	t	2013-07-05 19:27:20	87dc1e131a1369fdf8f1c824a6a62dff
135	user135	user135@user.com	\N	2013-05-20 18:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
136	user136	user136@user.com	\N	2013-05-19 17:25:20	2013-06-18 17:25:20	user	t	2013-07-03 17:25:20	87dc1e131a1369fdf8f1c824a6a62dff
137	user137	user137@user.com	\N	2013-05-18 16:24:20	2013-06-17 16:24:20	user	t	2013-07-02 16:24:20	87dc1e131a1369fdf8f1c824a6a62dff
138	user138	user138@user.com	\N	2013-05-17 15:23:20	2013-06-16 15:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
139	user139	user139@user.com	\N	2013-05-16 14:22:20	2013-06-15 14:22:20	user	t	2013-06-30 14:22:20	87dc1e131a1369fdf8f1c824a6a62dff
140	user140	user140@user.com	\N	2013-05-15 13:21:20	\N	user	t	2013-06-29 13:21:20	87dc1e131a1369fdf8f1c824a6a62dff
141	user141	user141@user.com	\N	2013-05-14 12:20:20	2013-06-13 12:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
142	user142	user142@user.com	\N	2013-05-13 11:19:20	2013-06-12 11:19:20	user	t	2013-06-27 11:19:20	87dc1e131a1369fdf8f1c824a6a62dff
143	user143	user143@user.com	\N	2013-05-12 10:18:20	2013-06-11 10:18:20	user	t	2013-06-26 10:18:20	87dc1e131a1369fdf8f1c824a6a62dff
144	user144	user144@user.com	\N	2013-05-11 09:17:20	2013-06-10 09:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
145	user145	user145@user.com	\N	2013-05-10 08:16:20	\N	user	t	2013-06-24 08:16:20	87dc1e131a1369fdf8f1c824a6a62dff
146	user146	user146@user.com	\N	2013-05-09 07:15:20	2013-06-08 07:15:20	user	t	2013-06-23 07:15:20	87dc1e131a1369fdf8f1c824a6a62dff
147	user147	user147@user.com	\N	2013-05-08 06:14:20	2013-06-07 06:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
148	user148	user148@user.com	\N	2013-05-07 05:13:20	2013-06-06 05:13:20	user	t	2013-06-21 05:13:20	87dc1e131a1369fdf8f1c824a6a62dff
149	user149	user149@user.com	\N	2013-05-06 04:12:20	2013-06-05 04:12:20	user	t	2013-06-20 04:12:20	87dc1e131a1369fdf8f1c824a6a62dff
150	user150	user150@user.com	\N	2013-05-05 03:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
151	user151	user151@user.com	\N	2013-05-04 02:10:20	2013-06-03 02:10:20	user	t	2013-06-18 02:10:20	87dc1e131a1369fdf8f1c824a6a62dff
152	user152	user152@user.com	\N	2013-05-03 01:09:20	2013-06-02 01:09:20	user	t	2013-06-17 01:09:20	87dc1e131a1369fdf8f1c824a6a62dff
153	user153	user153@user.com	\N	2013-05-02 00:08:20	2013-06-01 00:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
154	user154	user154@user.com	\N	2013-04-30 23:07:20	2013-05-30 23:07:20	user	t	2013-06-14 23:07:20	87dc1e131a1369fdf8f1c824a6a62dff
155	user155	user155@user.com	\N	2013-04-29 22:06:20	\N	user	t	2013-06-13 22:06:20	87dc1e131a1369fdf8f1c824a6a62dff
156	user156	user156@user.com	\N	2013-04-28 21:05:20	2013-05-28 21:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
157	user157	user157@user.com	\N	2013-04-27 20:04:20	2013-05-27 20:04:20	user	t	2013-06-11 20:04:20	87dc1e131a1369fdf8f1c824a6a62dff
158	user158	user158@user.com	\N	2013-04-26 19:03:20	2013-05-26 19:03:20	user	t	2013-06-10 19:03:20	87dc1e131a1369fdf8f1c824a6a62dff
159	user159	user159@user.com	\N	2013-04-25 18:02:20	2013-05-25 18:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
160	user160	user160@user.com	\N	2013-04-24 17:01:20	\N	user	t	2013-06-08 17:01:20	87dc1e131a1369fdf8f1c824a6a62dff
161	user161	user161@user.com	\N	2013-04-23 16:00:20	2013-05-23 16:00:20	user	t	2013-06-07 16:00:20	87dc1e131a1369fdf8f1c824a6a62dff
162	user162	user162@user.com	\N	2013-04-22 14:59:20	2013-05-22 14:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
163	user163	user163@user.com	\N	2013-04-21 13:58:20	2013-05-21 13:58:20	user	t	2013-06-05 13:58:20	87dc1e131a1369fdf8f1c824a6a62dff
164	user164	user164@user.com	\N	2013-04-20 12:57:20	2013-05-20 12:57:20	user	t	2013-06-04 12:57:20	87dc1e131a1369fdf8f1c824a6a62dff
165	user165	user165@user.com	\N	2013-04-19 11:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
166	user166	user166@user.com	\N	2013-04-18 10:55:20	2013-05-18 10:55:20	user	t	2013-06-02 10:55:20	87dc1e131a1369fdf8f1c824a6a62dff
167	user167	user167@user.com	\N	2013-04-17 09:54:20	2013-05-17 09:54:20	user	t	2013-06-01 09:54:20	87dc1e131a1369fdf8f1c824a6a62dff
168	user168	user168@user.com	\N	2013-04-16 08:53:20	2013-05-16 08:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
169	user169	user169@user.com	\N	2013-04-15 07:52:20	2013-05-15 07:52:20	user	t	2013-05-30 07:52:20	87dc1e131a1369fdf8f1c824a6a62dff
170	user170	user170@user.com	\N	2013-04-14 06:51:20	\N	user	t	2013-05-29 06:51:20	87dc1e131a1369fdf8f1c824a6a62dff
171	user171	user171@user.com	\N	2013-04-13 05:50:20	2013-05-13 05:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
172	user172	user172@user.com	\N	2013-04-12 04:49:20	2013-05-12 04:49:20	user	t	2013-05-27 04:49:20	87dc1e131a1369fdf8f1c824a6a62dff
173	user173	user173@user.com	\N	2013-04-11 03:48:20	2013-05-11 03:48:20	user	t	2013-05-26 03:48:20	87dc1e131a1369fdf8f1c824a6a62dff
174	user174	user174@user.com	\N	2013-04-10 02:47:20	2013-05-10 02:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
175	user175	user175@user.com	\N	2013-04-09 01:46:20	\N	user	t	2013-05-24 01:46:20	87dc1e131a1369fdf8f1c824a6a62dff
176	user176	user176@user.com	\N	2013-04-08 00:45:20	2013-05-08 00:45:20	user	t	2013-05-23 00:45:20	87dc1e131a1369fdf8f1c824a6a62dff
177	user177	user177@user.com	\N	2013-04-06 23:44:20	2013-05-06 23:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
178	user178	user178@user.com	\N	2013-04-05 22:43:20	2013-05-05 22:43:20	user	t	2013-05-20 22:43:20	87dc1e131a1369fdf8f1c824a6a62dff
179	user179	user179@user.com	\N	2013-04-04 21:42:20	2013-05-04 21:42:20	user	t	2013-05-19 21:42:20	87dc1e131a1369fdf8f1c824a6a62dff
180	user180	user180@user.com	\N	2013-04-03 20:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
181	user181	user181@user.com	\N	2013-04-02 19:40:20	2013-05-02 19:40:20	user	t	2013-05-17 19:40:20	87dc1e131a1369fdf8f1c824a6a62dff
182	user182	user182@user.com	\N	2013-04-01 18:39:20	2013-05-01 18:39:20	user	t	2013-05-16 18:39:20	87dc1e131a1369fdf8f1c824a6a62dff
183	user183	user183@user.com	\N	2013-03-31 17:38:20	2013-04-30 17:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
184	user184	user184@user.com	\N	2013-03-30 16:37:20	2013-04-29 16:37:20	user	t	2013-05-14 16:37:20	87dc1e131a1369fdf8f1c824a6a62dff
185	user185	user185@user.com	\N	2013-03-29 15:36:20	\N	user	t	2013-05-13 15:36:20	87dc1e131a1369fdf8f1c824a6a62dff
186	user186	user186@user.com	\N	2013-03-28 14:35:20	2013-04-27 14:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
187	user187	user187@user.com	\N	2013-03-27 13:34:20	2013-04-26 13:34:20	user	t	2013-05-11 13:34:20	87dc1e131a1369fdf8f1c824a6a62dff
188	user188	user188@user.com	\N	2013-03-26 12:33:20	2013-04-25 12:33:20	user	t	2013-05-10 12:33:20	87dc1e131a1369fdf8f1c824a6a62dff
189	user189	user189@user.com	\N	2013-03-25 11:32:20	2013-04-24 11:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
190	user190	user190@user.com	\N	2013-03-24 10:31:20	\N	user	t	2013-05-08 10:31:20	87dc1e131a1369fdf8f1c824a6a62dff
191	user191	user191@user.com	\N	2013-03-23 09:30:20	2013-04-22 09:30:20	user	t	2013-05-07 09:30:20	87dc1e131a1369fdf8f1c824a6a62dff
192	user192	user192@user.com	\N	2013-03-22 08:29:20	2013-04-21 08:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
193	user193	user193@user.com	\N	2013-03-21 07:28:20	2013-04-20 07:28:20	user	t	2013-05-05 07:28:20	87dc1e131a1369fdf8f1c824a6a62dff
194	user194	user194@user.com	\N	2013-03-20 06:27:20	2013-04-19 06:27:20	user	t	2013-05-04 06:27:20	87dc1e131a1369fdf8f1c824a6a62dff
195	user195	user195@user.com	\N	2013-03-19 05:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
196	user196	user196@user.com	\N	2013-03-18 04:25:20	2013-04-17 04:25:20	user	t	2013-05-02 04:25:20	87dc1e131a1369fdf8f1c824a6a62dff
197	user197	user197@user.com	\N	2013-03-17 03:24:20	2013-04-16 03:24:20	user	t	2013-05-01 03:24:20	87dc1e131a1369fdf8f1c824a6a62dff
198	user198	user198@user.com	\N	2013-03-16 02:23:20	2013-04-15 02:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
199	user199	user199@user.com	\N	2013-03-15 01:22:20	2013-04-14 01:22:20	user	t	2013-04-29 01:22:20	87dc1e131a1369fdf8f1c824a6a62dff
200	user200	user200@user.com	\N	2013-03-14 00:21:20	\N	user	t	2013-04-28 00:21:20	87dc1e131a1369fdf8f1c824a6a62dff
201	user201	user201@user.com	\N	2013-03-12 23:20:20	2013-04-11 23:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
202	user202	user202@user.com	\N	2013-03-11 22:19:20	2013-04-10 22:19:20	user	t	2013-04-25 22:19:20	87dc1e131a1369fdf8f1c824a6a62dff
203	user203	user203@user.com	\N	2013-03-10 21:18:20	2013-04-09 21:18:20	user	t	2013-04-24 21:18:20	87dc1e131a1369fdf8f1c824a6a62dff
204	user204	user204@user.com	\N	2013-03-09 20:17:20	2013-04-08 20:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
205	user205	user205@user.com	\N	2013-03-08 19:16:20	\N	user	t	2013-04-22 19:16:20	87dc1e131a1369fdf8f1c824a6a62dff
206	user206	user206@user.com	\N	2013-03-07 18:15:20	2013-04-06 18:15:20	user	t	2013-04-21 18:15:20	87dc1e131a1369fdf8f1c824a6a62dff
207	user207	user207@user.com	\N	2013-03-06 17:14:20	2013-04-05 17:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
208	user208	user208@user.com	\N	2013-03-05 16:13:20	2013-04-04 16:13:20	user	t	2013-04-19 16:13:20	87dc1e131a1369fdf8f1c824a6a62dff
209	user209	user209@user.com	\N	2013-03-04 15:12:20	2013-04-03 15:12:20	user	t	2013-04-18 15:12:20	87dc1e131a1369fdf8f1c824a6a62dff
210	user210	user210@user.com	\N	2013-03-03 14:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
211	user211	user211@user.com	\N	2013-03-02 13:10:20	2013-04-01 13:10:20	user	t	2013-04-16 13:10:20	87dc1e131a1369fdf8f1c824a6a62dff
212	user212	user212@user.com	\N	2013-03-01 12:09:20	2013-03-31 12:09:20	user	t	2013-04-15 12:09:20	87dc1e131a1369fdf8f1c824a6a62dff
213	user213	user213@user.com	\N	2013-02-28 11:08:20	2013-03-30 11:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
214	user214	user214@user.com	\N	2013-02-27 10:07:20	2013-03-29 10:07:20	user	t	2013-04-13 10:07:20	87dc1e131a1369fdf8f1c824a6a62dff
215	user215	user215@user.com	\N	2013-02-26 09:06:20	\N	user	t	2013-04-12 09:06:20	87dc1e131a1369fdf8f1c824a6a62dff
216	user216	user216@user.com	\N	2013-02-25 08:05:20	2013-03-27 08:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
217	user217	user217@user.com	\N	2013-02-24 07:04:20	2013-03-26 07:04:20	user	t	2013-04-10 07:04:20	87dc1e131a1369fdf8f1c824a6a62dff
218	user218	user218@user.com	\N	2013-02-23 06:03:20	2013-03-25 06:03:20	user	t	2013-04-09 06:03:20	87dc1e131a1369fdf8f1c824a6a62dff
219	user219	user219@user.com	\N	2013-02-22 05:02:20	2013-03-24 05:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
220	user220	user220@user.com	\N	2013-02-21 04:01:20	\N	user	t	2013-04-07 04:01:20	87dc1e131a1369fdf8f1c824a6a62dff
221	user221	user221@user.com	\N	2013-02-20 03:00:20	2013-03-22 03:00:20	user	t	2013-04-06 03:00:20	87dc1e131a1369fdf8f1c824a6a62dff
222	user222	user222@user.com	\N	2013-02-19 01:59:20	2013-03-21 01:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
223	user223	user223@user.com	\N	2013-02-18 00:58:20	2013-03-20 00:58:20	user	t	2013-04-04 00:58:20	87dc1e131a1369fdf8f1c824a6a62dff
224	user224	user224@user.com	\N	2013-02-16 23:57:20	2013-03-18 23:57:20	user	t	2013-04-02 23:57:20	87dc1e131a1369fdf8f1c824a6a62dff
225	user225	user225@user.com	\N	2013-02-15 22:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
226	user226	user226@user.com	\N	2013-02-14 21:55:20	2013-03-16 21:55:20	user	t	2013-03-31 21:55:20	87dc1e131a1369fdf8f1c824a6a62dff
227	user227	user227@user.com	\N	2013-02-13 20:54:20	2013-03-15 20:54:20	user	t	2013-03-30 20:54:20	87dc1e131a1369fdf8f1c824a6a62dff
228	user228	user228@user.com	\N	2013-02-12 19:53:20	2013-03-14 19:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
229	user229	user229@user.com	\N	2013-02-11 18:52:20	2013-03-13 18:52:20	user	t	2013-03-28 18:52:20	87dc1e131a1369fdf8f1c824a6a62dff
230	user230	user230@user.com	\N	2013-02-10 17:51:20	\N	user	t	2013-03-27 17:51:20	87dc1e131a1369fdf8f1c824a6a62dff
231	user231	user231@user.com	\N	2013-02-09 16:50:20	2013-03-11 16:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
232	user232	user232@user.com	\N	2013-02-08 15:49:20	2013-03-10 15:49:20	user	t	2013-03-25 15:49:20	87dc1e131a1369fdf8f1c824a6a62dff
233	user233	user233@user.com	\N	2013-02-07 14:48:20	2013-03-09 14:48:20	user	t	2013-03-24 14:48:20	87dc1e131a1369fdf8f1c824a6a62dff
234	user234	user234@user.com	\N	2013-02-06 13:47:20	2013-03-08 13:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
235	user235	user235@user.com	\N	2013-02-05 12:46:20	\N	user	t	2013-03-22 12:46:20	87dc1e131a1369fdf8f1c824a6a62dff
236	user236	user236@user.com	\N	2013-02-04 11:45:20	2013-03-06 11:45:20	user	t	2013-03-21 11:45:20	87dc1e131a1369fdf8f1c824a6a62dff
237	user237	user237@user.com	\N	2013-02-03 10:44:20	2013-03-05 10:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
238	user238	user238@user.com	\N	2013-02-02 09:43:20	2013-03-04 09:43:20	user	t	2013-03-19 09:43:20	87dc1e131a1369fdf8f1c824a6a62dff
239	user239	user239@user.com	\N	2013-02-01 08:42:20	2013-03-03 08:42:20	user	t	2013-03-18 08:42:20	87dc1e131a1369fdf8f1c824a6a62dff
240	user240	user240@user.com	\N	2013-01-31 07:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
241	user241	user241@user.com	\N	2013-01-30 06:40:20	2013-03-01 06:40:20	user	t	2013-03-16 06:40:20	87dc1e131a1369fdf8f1c824a6a62dff
242	user242	user242@user.com	\N	2013-01-29 05:39:20	2013-02-28 05:39:20	user	t	2013-03-15 05:39:20	87dc1e131a1369fdf8f1c824a6a62dff
243	user243	user243@user.com	\N	2013-01-28 04:38:20	2013-02-27 04:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
244	user244	user244@user.com	\N	2013-01-27 03:37:20	2013-02-26 03:37:20	user	t	2013-03-13 03:37:20	87dc1e131a1369fdf8f1c824a6a62dff
245	user245	user245@user.com	\N	2013-01-26 02:36:20	\N	user	t	2013-03-12 02:36:20	87dc1e131a1369fdf8f1c824a6a62dff
246	user246	user246@user.com	\N	2013-01-25 01:35:20	2013-02-24 01:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
247	user247	user247@user.com	\N	2013-01-24 00:34:20	2013-02-23 00:34:20	user	t	2013-03-10 00:34:20	87dc1e131a1369fdf8f1c824a6a62dff
248	user248	user248@user.com	\N	2013-01-22 23:33:20	2013-02-21 23:33:20	user	t	2013-03-08 23:33:20	87dc1e131a1369fdf8f1c824a6a62dff
249	user249	user249@user.com	\N	2013-01-21 22:32:20	2013-02-20 22:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
250	user250	user250@user.com	\N	2013-01-20 21:31:20	\N	user	t	2013-03-06 21:31:20	87dc1e131a1369fdf8f1c824a6a62dff
251	user251	user251@user.com	\N	2013-01-19 20:30:20	2013-02-18 20:30:20	user	t	2013-03-05 20:30:20	87dc1e131a1369fdf8f1c824a6a62dff
252	user252	user252@user.com	\N	2013-01-18 19:29:20	2013-02-17 19:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
253	user253	user253@user.com	\N	2013-01-17 18:28:20	2013-02-16 18:28:20	user	t	2013-03-03 18:28:20	87dc1e131a1369fdf8f1c824a6a62dff
254	user254	user254@user.com	\N	2013-01-16 17:27:20	2013-02-15 17:27:20	user	t	2013-03-02 17:27:20	87dc1e131a1369fdf8f1c824a6a62dff
255	user255	user255@user.com	\N	2013-01-15 16:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
256	user256	user256@user.com	\N	2013-01-14 15:25:20	2013-02-13 15:25:20	user	t	2013-02-28 15:25:20	87dc1e131a1369fdf8f1c824a6a62dff
257	user257	user257@user.com	\N	2013-01-13 14:24:20	2013-02-12 14:24:20	user	t	2013-02-27 14:24:20	87dc1e131a1369fdf8f1c824a6a62dff
258	user258	user258@user.com	\N	2013-01-12 13:23:20	2013-02-11 13:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
259	user259	user259@user.com	\N	2013-01-11 12:22:20	2013-02-10 12:22:20	user	t	2013-02-25 12:22:20	87dc1e131a1369fdf8f1c824a6a62dff
260	user260	user260@user.com	\N	2013-01-10 11:21:20	\N	user	t	2013-02-24 11:21:20	87dc1e131a1369fdf8f1c824a6a62dff
261	user261	user261@user.com	\N	2013-01-09 10:20:20	2013-02-08 10:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
262	user262	user262@user.com	\N	2013-01-08 09:19:20	2013-02-07 09:19:20	user	t	2013-02-22 09:19:20	87dc1e131a1369fdf8f1c824a6a62dff
263	user263	user263@user.com	\N	2013-01-07 08:18:20	2013-02-06 08:18:20	user	t	2013-02-21 08:18:20	87dc1e131a1369fdf8f1c824a6a62dff
264	user264	user264@user.com	\N	2013-01-06 07:17:20	2013-02-05 07:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
265	user265	user265@user.com	\N	2013-01-05 06:16:20	\N	user	t	2013-02-19 06:16:20	87dc1e131a1369fdf8f1c824a6a62dff
266	user266	user266@user.com	\N	2013-01-04 05:15:20	2013-02-03 05:15:20	user	t	2013-02-18 05:15:20	87dc1e131a1369fdf8f1c824a6a62dff
267	user267	user267@user.com	\N	2013-01-03 04:14:20	2013-02-02 04:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
268	user268	user268@user.com	\N	2013-01-02 03:13:20	2013-02-01 03:13:20	user	t	2013-02-16 03:13:20	87dc1e131a1369fdf8f1c824a6a62dff
269	user269	user269@user.com	\N	2013-01-01 02:12:20	2013-01-31 02:12:20	user	t	2013-02-15 02:12:20	87dc1e131a1369fdf8f1c824a6a62dff
270	user270	user270@user.com	\N	2012-12-31 01:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
271	user271	user271@user.com	\N	2012-12-30 00:10:20	2013-01-29 00:10:20	user	t	2013-02-13 00:10:20	87dc1e131a1369fdf8f1c824a6a62dff
272	user272	user272@user.com	\N	2012-12-28 23:09:20	2013-01-27 23:09:20	user	t	2013-02-11 23:09:20	87dc1e131a1369fdf8f1c824a6a62dff
273	user273	user273@user.com	\N	2012-12-27 22:08:20	2013-01-26 22:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
274	user274	user274@user.com	\N	2012-12-26 21:07:20	2013-01-25 21:07:20	user	t	2013-02-09 21:07:20	87dc1e131a1369fdf8f1c824a6a62dff
275	user275	user275@user.com	\N	2012-12-25 20:06:20	\N	user	t	2013-02-08 20:06:20	87dc1e131a1369fdf8f1c824a6a62dff
276	user276	user276@user.com	\N	2012-12-24 19:05:20	2013-01-23 19:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
277	user277	user277@user.com	\N	2012-12-23 18:04:20	2013-01-22 18:04:20	user	t	2013-02-06 18:04:20	87dc1e131a1369fdf8f1c824a6a62dff
278	user278	user278@user.com	\N	2012-12-22 17:03:20	2013-01-21 17:03:20	user	t	2013-02-05 17:03:20	87dc1e131a1369fdf8f1c824a6a62dff
279	user279	user279@user.com	\N	2012-12-21 16:02:20	2013-01-20 16:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
280	user280	user280@user.com	\N	2012-12-20 15:01:20	\N	user	t	2013-02-03 15:01:20	87dc1e131a1369fdf8f1c824a6a62dff
281	user281	user281@user.com	\N	2012-12-19 14:00:20	2013-01-18 14:00:20	user	t	2013-02-02 14:00:20	87dc1e131a1369fdf8f1c824a6a62dff
282	user282	user282@user.com	\N	2012-12-18 12:59:20	2013-01-17 12:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
283	user283	user283@user.com	\N	2012-12-17 11:58:20	2013-01-16 11:58:20	user	t	2013-01-31 11:58:20	87dc1e131a1369fdf8f1c824a6a62dff
284	user284	user284@user.com	\N	2012-12-16 10:57:20	2013-01-15 10:57:20	user	t	2013-01-30 10:57:20	87dc1e131a1369fdf8f1c824a6a62dff
285	user285	user285@user.com	\N	2012-12-15 09:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
286	user286	user286@user.com	\N	2012-12-14 08:55:20	2013-01-13 08:55:20	user	t	2013-01-28 08:55:20	87dc1e131a1369fdf8f1c824a6a62dff
287	user287	user287@user.com	\N	2012-12-13 07:54:20	2013-01-12 07:54:20	user	t	2013-01-27 07:54:20	87dc1e131a1369fdf8f1c824a6a62dff
288	user288	user288@user.com	\N	2012-12-12 06:53:20	2013-01-11 06:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
289	user289	user289@user.com	\N	2012-12-11 05:52:20	2013-01-10 05:52:20	user	t	2013-01-25 05:52:20	87dc1e131a1369fdf8f1c824a6a62dff
290	user290	user290@user.com	\N	2012-12-10 04:51:20	\N	user	t	2013-01-24 04:51:20	87dc1e131a1369fdf8f1c824a6a62dff
291	user291	user291@user.com	\N	2012-12-09 03:50:20	2013-01-08 03:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
292	user292	user292@user.com	\N	2012-12-08 02:49:20	2013-01-07 02:49:20	user	t	2013-01-22 02:49:20	87dc1e131a1369fdf8f1c824a6a62dff
293	user293	user293@user.com	\N	2012-12-07 01:48:20	2013-01-06 01:48:20	user	t	2013-01-21 01:48:20	87dc1e131a1369fdf8f1c824a6a62dff
294	user294	user294@user.com	\N	2012-12-06 00:47:20	2013-01-05 00:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
295	user295	user295@user.com	\N	2012-12-04 23:46:20	\N	user	t	2013-01-18 23:46:20	87dc1e131a1369fdf8f1c824a6a62dff
296	user296	user296@user.com	\N	2012-12-03 22:45:20	2013-01-02 22:45:20	user	t	2013-01-17 22:45:20	87dc1e131a1369fdf8f1c824a6a62dff
297	user297	user297@user.com	\N	2012-12-02 21:44:20	2013-01-01 21:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
298	user298	user298@user.com	\N	2012-12-01 20:43:20	2012-12-31 20:43:20	user	t	2013-01-15 20:43:20	87dc1e131a1369fdf8f1c824a6a62dff
299	user299	user299@user.com	\N	2012-11-30 19:42:20	2012-12-30 19:42:20	user	t	2013-01-14 19:42:20	87dc1e131a1369fdf8f1c824a6a62dff
300	user300	user300@user.com	\N	2012-11-29 18:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
301	user301	user301@user.com	\N	2012-11-28 17:40:20	2012-12-28 17:40:20	user	t	2013-01-12 17:40:20	87dc1e131a1369fdf8f1c824a6a62dff
302	user302	user302@user.com	\N	2012-11-27 16:39:20	2012-12-27 16:39:20	user	t	2013-01-11 16:39:20	87dc1e131a1369fdf8f1c824a6a62dff
303	user303	user303@user.com	\N	2012-11-26 15:38:20	2012-12-26 15:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
304	user304	user304@user.com	\N	2012-11-25 14:37:20	2012-12-25 14:37:20	user	t	2013-01-09 14:37:20	87dc1e131a1369fdf8f1c824a6a62dff
305	user305	user305@user.com	\N	2012-11-24 13:36:20	\N	user	t	2013-01-08 13:36:20	87dc1e131a1369fdf8f1c824a6a62dff
306	user306	user306@user.com	\N	2012-11-23 12:35:20	2012-12-23 12:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
307	user307	user307@user.com	\N	2012-11-22 11:34:20	2012-12-22 11:34:20	user	t	2013-01-06 11:34:20	87dc1e131a1369fdf8f1c824a6a62dff
308	user308	user308@user.com	\N	2012-11-21 10:33:20	2012-12-21 10:33:20	user	t	2013-01-05 10:33:20	87dc1e131a1369fdf8f1c824a6a62dff
309	user309	user309@user.com	\N	2012-11-20 09:32:20	2012-12-20 09:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
310	user310	user310@user.com	\N	2012-11-19 08:31:20	\N	user	t	2013-01-03 08:31:20	87dc1e131a1369fdf8f1c824a6a62dff
311	user311	user311@user.com	\N	2012-11-18 07:30:20	2012-12-18 07:30:20	user	t	2013-01-02 07:30:20	87dc1e131a1369fdf8f1c824a6a62dff
312	user312	user312@user.com	\N	2012-11-17 06:29:20	2012-12-17 06:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
313	user313	user313@user.com	\N	2012-11-16 05:28:20	2012-12-16 05:28:20	user	t	2012-12-31 05:28:20	87dc1e131a1369fdf8f1c824a6a62dff
314	user314	user314@user.com	\N	2012-11-15 04:27:20	2012-12-15 04:27:20	user	t	2012-12-30 04:27:20	87dc1e131a1369fdf8f1c824a6a62dff
315	user315	user315@user.com	\N	2012-11-14 03:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
316	user316	user316@user.com	\N	2012-11-13 02:25:20	2012-12-13 02:25:20	user	t	2012-12-28 02:25:20	87dc1e131a1369fdf8f1c824a6a62dff
317	user317	user317@user.com	\N	2012-11-12 01:24:20	2012-12-12 01:24:20	user	t	2012-12-27 01:24:20	87dc1e131a1369fdf8f1c824a6a62dff
318	user318	user318@user.com	\N	2012-11-11 00:23:20	2012-12-11 00:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
319	user319	user319@user.com	\N	2012-11-09 23:22:20	2012-12-09 23:22:20	user	t	2012-12-24 23:22:20	87dc1e131a1369fdf8f1c824a6a62dff
320	user320	user320@user.com	\N	2012-11-08 22:21:20	\N	user	t	2012-12-23 22:21:20	87dc1e131a1369fdf8f1c824a6a62dff
321	user321	user321@user.com	\N	2012-11-07 21:20:20	2012-12-07 21:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
322	user322	user322@user.com	\N	2012-11-06 20:19:20	2012-12-06 20:19:20	user	t	2012-12-21 20:19:20	87dc1e131a1369fdf8f1c824a6a62dff
323	user323	user323@user.com	\N	2012-11-05 19:18:20	2012-12-05 19:18:20	user	t	2012-12-20 19:18:20	87dc1e131a1369fdf8f1c824a6a62dff
324	user324	user324@user.com	\N	2012-11-04 18:17:20	2012-12-04 18:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
325	user325	user325@user.com	\N	2012-11-03 17:16:20	\N	user	t	2012-12-18 17:16:20	87dc1e131a1369fdf8f1c824a6a62dff
326	user326	user326@user.com	\N	2012-11-02 16:15:20	2012-12-02 16:15:20	user	t	2012-12-17 16:15:20	87dc1e131a1369fdf8f1c824a6a62dff
327	user327	user327@user.com	\N	2012-11-01 15:14:20	2012-12-01 15:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
328	user328	user328@user.com	\N	2012-10-31 14:13:20	2012-11-30 14:13:20	user	t	2012-12-15 14:13:20	87dc1e131a1369fdf8f1c824a6a62dff
329	user329	user329@user.com	\N	2012-10-30 13:12:20	2012-11-29 13:12:20	user	t	2012-12-14 13:12:20	87dc1e131a1369fdf8f1c824a6a62dff
330	user330	user330@user.com	\N	2012-10-29 12:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
331	user331	user331@user.com	\N	2012-10-28 11:10:20	2012-11-27 11:10:20	user	t	2012-12-12 11:10:20	87dc1e131a1369fdf8f1c824a6a62dff
332	user332	user332@user.com	\N	2012-10-27 10:09:20	2012-11-26 10:09:20	user	t	2012-12-11 10:09:20	87dc1e131a1369fdf8f1c824a6a62dff
333	user333	user333@user.com	\N	2012-10-26 09:08:20	2012-11-25 09:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
334	user334	user334@user.com	\N	2012-10-25 08:07:20	2012-11-24 08:07:20	user	t	2012-12-09 08:07:20	87dc1e131a1369fdf8f1c824a6a62dff
335	user335	user335@user.com	\N	2012-10-24 07:06:20	\N	user	t	2012-12-08 07:06:20	87dc1e131a1369fdf8f1c824a6a62dff
336	user336	user336@user.com	\N	2012-10-23 06:05:20	2012-11-22 06:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
337	user337	user337@user.com	\N	2012-10-22 05:04:20	2012-11-21 05:04:20	user	t	2012-12-06 05:04:20	87dc1e131a1369fdf8f1c824a6a62dff
338	user338	user338@user.com	\N	2012-10-21 04:03:20	2012-11-20 04:03:20	user	t	2012-12-05 04:03:20	87dc1e131a1369fdf8f1c824a6a62dff
339	user339	user339@user.com	\N	2012-10-20 03:02:20	2012-11-19 03:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
340	user340	user340@user.com	\N	2012-10-19 02:01:20	\N	user	t	2012-12-03 02:01:20	87dc1e131a1369fdf8f1c824a6a62dff
341	user341	user341@user.com	\N	2012-10-18 01:00:20	2012-11-17 01:00:20	user	t	2012-12-02 01:00:20	87dc1e131a1369fdf8f1c824a6a62dff
342	user342	user342@user.com	\N	2012-10-16 23:59:20	2012-11-15 23:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
343	user343	user343@user.com	\N	2012-10-15 22:58:20	2012-11-14 22:58:20	user	t	2012-11-29 22:58:20	87dc1e131a1369fdf8f1c824a6a62dff
344	user344	user344@user.com	\N	2012-10-14 21:57:20	2012-11-13 21:57:20	user	t	2012-11-28 21:57:20	87dc1e131a1369fdf8f1c824a6a62dff
345	user345	user345@user.com	\N	2012-10-13 20:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
346	user346	user346@user.com	\N	2012-10-12 19:55:20	2012-11-11 19:55:20	user	t	2012-11-26 19:55:20	87dc1e131a1369fdf8f1c824a6a62dff
347	user347	user347@user.com	\N	2012-10-11 18:54:20	2012-11-10 18:54:20	user	t	2012-11-25 18:54:20	87dc1e131a1369fdf8f1c824a6a62dff
348	user348	user348@user.com	\N	2012-10-10 17:53:20	2012-11-09 17:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
349	user349	user349@user.com	\N	2012-10-09 16:52:20	2012-11-08 16:52:20	user	t	2012-11-23 16:52:20	87dc1e131a1369fdf8f1c824a6a62dff
350	user350	user350@user.com	\N	2012-10-08 15:51:20	\N	user	t	2012-11-22 15:51:20	87dc1e131a1369fdf8f1c824a6a62dff
351	user351	user351@user.com	\N	2012-10-07 14:50:20	2012-11-06 14:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
352	user352	user352@user.com	\N	2012-10-06 13:49:20	2012-11-05 13:49:20	user	t	2012-11-20 13:49:20	87dc1e131a1369fdf8f1c824a6a62dff
353	user353	user353@user.com	\N	2012-10-05 12:48:20	2012-11-04 12:48:20	user	t	2012-11-19 12:48:20	87dc1e131a1369fdf8f1c824a6a62dff
354	user354	user354@user.com	\N	2012-10-04 11:47:20	2012-11-03 11:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
355	user355	user355@user.com	\N	2012-10-03 10:46:20	\N	user	t	2012-11-17 10:46:20	87dc1e131a1369fdf8f1c824a6a62dff
356	user356	user356@user.com	\N	2012-10-02 09:45:20	2012-11-01 09:45:20	user	t	2012-11-16 09:45:20	87dc1e131a1369fdf8f1c824a6a62dff
357	user357	user357@user.com	\N	2012-10-01 08:44:20	2012-10-31 08:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
358	user358	user358@user.com	\N	2012-09-30 07:43:20	2012-10-30 07:43:20	user	t	2012-11-14 07:43:20	87dc1e131a1369fdf8f1c824a6a62dff
359	user359	user359@user.com	\N	2012-09-29 06:42:20	2012-10-29 06:42:20	user	t	2012-11-13 06:42:20	87dc1e131a1369fdf8f1c824a6a62dff
360	user360	user360@user.com	\N	2012-09-28 05:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
361	user361	user361@user.com	\N	2012-09-27 04:40:20	2012-10-27 04:40:20	user	t	2012-11-11 04:40:20	87dc1e131a1369fdf8f1c824a6a62dff
362	user362	user362@user.com	\N	2012-09-26 03:39:20	2012-10-26 03:39:20	user	t	2012-11-10 03:39:20	87dc1e131a1369fdf8f1c824a6a62dff
363	user363	user363@user.com	\N	2012-09-25 02:38:20	2012-10-25 02:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
364	user364	user364@user.com	\N	2012-09-24 01:37:20	2012-10-24 01:37:20	user	t	2012-11-08 01:37:20	87dc1e131a1369fdf8f1c824a6a62dff
365	user365	user365@user.com	\N	2012-09-23 00:36:20	\N	user	t	2012-11-07 00:36:20	87dc1e131a1369fdf8f1c824a6a62dff
366	user366	user366@user.com	\N	2012-09-21 23:35:20	2012-10-21 23:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
367	user367	user367@user.com	\N	2012-09-20 22:34:20	2012-10-20 22:34:20	user	t	2012-11-04 22:34:20	87dc1e131a1369fdf8f1c824a6a62dff
368	user368	user368@user.com	\N	2012-09-19 21:33:20	2012-10-19 21:33:20	user	t	2012-11-03 21:33:20	87dc1e131a1369fdf8f1c824a6a62dff
369	user369	user369@user.com	\N	2012-09-18 20:32:20	2012-10-18 20:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
370	user370	user370@user.com	\N	2012-09-17 19:31:20	\N	user	t	2012-11-01 19:31:20	87dc1e131a1369fdf8f1c824a6a62dff
371	user371	user371@user.com	\N	2012-09-16 18:30:20	2012-10-16 18:30:20	user	t	2012-10-31 18:30:20	87dc1e131a1369fdf8f1c824a6a62dff
372	user372	user372@user.com	\N	2012-09-15 17:29:20	2012-10-15 17:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
373	user373	user373@user.com	\N	2012-09-14 16:28:20	2012-10-14 16:28:20	user	t	2012-10-29 16:28:20	87dc1e131a1369fdf8f1c824a6a62dff
374	user374	user374@user.com	\N	2012-09-13 15:27:20	2012-10-13 15:27:20	user	t	2012-10-28 15:27:20	87dc1e131a1369fdf8f1c824a6a62dff
375	user375	user375@user.com	\N	2012-09-12 14:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
376	user376	user376@user.com	\N	2012-09-11 13:25:20	2012-10-11 13:25:20	user	t	2012-10-26 13:25:20	87dc1e131a1369fdf8f1c824a6a62dff
377	user377	user377@user.com	\N	2012-09-10 12:24:20	2012-10-10 12:24:20	user	t	2012-10-25 12:24:20	87dc1e131a1369fdf8f1c824a6a62dff
378	user378	user378@user.com	\N	2012-09-09 11:23:20	2012-10-09 11:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
379	user379	user379@user.com	\N	2012-09-08 10:22:20	2012-10-08 10:22:20	user	t	2012-10-23 10:22:20	87dc1e131a1369fdf8f1c824a6a62dff
380	user380	user380@user.com	\N	2012-09-07 09:21:20	\N	user	t	2012-10-22 09:21:20	87dc1e131a1369fdf8f1c824a6a62dff
381	user381	user381@user.com	\N	2012-09-06 08:20:20	2012-10-06 08:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
382	user382	user382@user.com	\N	2012-09-05 07:19:20	2012-10-05 07:19:20	user	t	2012-10-20 07:19:20	87dc1e131a1369fdf8f1c824a6a62dff
383	user383	user383@user.com	\N	2012-09-04 06:18:20	2012-10-04 06:18:20	user	t	2012-10-19 06:18:20	87dc1e131a1369fdf8f1c824a6a62dff
384	user384	user384@user.com	\N	2012-09-03 05:17:20	2012-10-03 05:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
385	user385	user385@user.com	\N	2012-09-02 04:16:20	\N	user	t	2012-10-17 04:16:20	87dc1e131a1369fdf8f1c824a6a62dff
386	user386	user386@user.com	\N	2012-09-01 03:15:20	2012-10-01 03:15:20	user	t	2012-10-16 03:15:20	87dc1e131a1369fdf8f1c824a6a62dff
387	user387	user387@user.com	\N	2012-08-31 02:14:20	2012-09-30 02:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
388	user388	user388@user.com	\N	2012-08-30 01:13:20	2012-09-29 01:13:20	user	t	2012-10-14 01:13:20	87dc1e131a1369fdf8f1c824a6a62dff
389	user389	user389@user.com	\N	2012-08-29 00:12:20	2012-09-28 00:12:20	user	t	2012-10-13 00:12:20	87dc1e131a1369fdf8f1c824a6a62dff
390	user390	user390@user.com	\N	2012-08-27 23:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
391	user391	user391@user.com	\N	2012-08-26 22:10:20	2012-09-25 22:10:20	user	t	2012-10-10 22:10:20	87dc1e131a1369fdf8f1c824a6a62dff
392	user392	user392@user.com	\N	2012-08-25 21:09:20	2012-09-24 21:09:20	user	t	2012-10-09 21:09:20	87dc1e131a1369fdf8f1c824a6a62dff
393	user393	user393@user.com	\N	2012-08-24 20:08:20	2012-09-23 20:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
394	user394	user394@user.com	\N	2012-08-23 19:07:20	2012-09-22 19:07:20	user	t	2012-10-07 19:07:20	87dc1e131a1369fdf8f1c824a6a62dff
395	user395	user395@user.com	\N	2012-08-22 18:06:20	\N	user	t	2012-10-06 18:06:20	87dc1e131a1369fdf8f1c824a6a62dff
396	user396	user396@user.com	\N	2012-08-21 17:05:20	2012-09-20 17:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
397	user397	user397@user.com	\N	2012-08-20 16:04:20	2012-09-19 16:04:20	user	t	2012-10-04 16:04:20	87dc1e131a1369fdf8f1c824a6a62dff
398	user398	user398@user.com	\N	2012-08-19 15:03:20	2012-09-18 15:03:20	user	t	2012-10-03 15:03:20	87dc1e131a1369fdf8f1c824a6a62dff
399	user399	user399@user.com	\N	2012-08-18 14:02:20	2012-09-17 14:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
400	user400	user400@user.com	\N	2012-08-17 13:01:20	\N	user	t	2012-10-01 13:01:20	87dc1e131a1369fdf8f1c824a6a62dff
401	user401	user401@user.com	\N	2012-08-16 12:00:20	2012-09-15 12:00:20	user	t	2012-09-30 12:00:20	87dc1e131a1369fdf8f1c824a6a62dff
402	user402	user402@user.com	\N	2012-08-15 10:59:20	2012-09-14 10:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
403	user403	user403@user.com	\N	2012-08-14 09:58:20	2012-09-13 09:58:20	user	t	2012-09-28 09:58:20	87dc1e131a1369fdf8f1c824a6a62dff
404	user404	user404@user.com	\N	2012-08-13 08:57:20	2012-09-12 08:57:20	user	t	2012-09-27 08:57:20	87dc1e131a1369fdf8f1c824a6a62dff
405	user405	user405@user.com	\N	2012-08-12 07:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
406	user406	user406@user.com	\N	2012-08-11 06:55:20	2012-09-10 06:55:20	user	t	2012-09-25 06:55:20	87dc1e131a1369fdf8f1c824a6a62dff
407	user407	user407@user.com	\N	2012-08-10 05:54:20	2012-09-09 05:54:20	user	t	2012-09-24 05:54:20	87dc1e131a1369fdf8f1c824a6a62dff
408	user408	user408@user.com	\N	2012-08-09 04:53:20	2012-09-08 04:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
409	user409	user409@user.com	\N	2012-08-08 03:52:20	2012-09-07 03:52:20	user	t	2012-09-22 03:52:20	87dc1e131a1369fdf8f1c824a6a62dff
410	user410	user410@user.com	\N	2012-08-07 02:51:20	\N	user	t	2012-09-21 02:51:20	87dc1e131a1369fdf8f1c824a6a62dff
411	user411	user411@user.com	\N	2012-08-06 01:50:20	2012-09-05 01:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
412	user412	user412@user.com	\N	2012-08-05 00:49:20	2012-09-04 00:49:20	user	t	2012-09-19 00:49:20	87dc1e131a1369fdf8f1c824a6a62dff
413	user413	user413@user.com	\N	2012-08-03 23:48:20	2012-09-02 23:48:20	user	t	2012-09-17 23:48:20	87dc1e131a1369fdf8f1c824a6a62dff
414	user414	user414@user.com	\N	2012-08-02 22:47:20	2012-09-01 22:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
415	user415	user415@user.com	\N	2012-08-01 21:46:20	\N	user	t	2012-09-15 21:46:20	87dc1e131a1369fdf8f1c824a6a62dff
416	user416	user416@user.com	\N	2012-07-31 20:45:20	2012-08-30 20:45:20	user	t	2012-09-14 20:45:20	87dc1e131a1369fdf8f1c824a6a62dff
417	user417	user417@user.com	\N	2012-07-30 19:44:20	2012-08-29 19:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
418	user418	user418@user.com	\N	2012-07-29 18:43:20	2012-08-28 18:43:20	user	t	2012-09-12 18:43:20	87dc1e131a1369fdf8f1c824a6a62dff
419	user419	user419@user.com	\N	2012-07-28 17:42:20	2012-08-27 17:42:20	user	t	2012-09-11 17:42:20	87dc1e131a1369fdf8f1c824a6a62dff
420	user420	user420@user.com	\N	2012-07-27 16:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
421	user421	user421@user.com	\N	2012-07-26 15:40:20	2012-08-25 15:40:20	user	t	2012-09-09 15:40:20	87dc1e131a1369fdf8f1c824a6a62dff
422	user422	user422@user.com	\N	2012-07-25 14:39:20	2012-08-24 14:39:20	user	t	2012-09-08 14:39:20	87dc1e131a1369fdf8f1c824a6a62dff
423	user423	user423@user.com	\N	2012-07-24 13:38:20	2012-08-23 13:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
424	user424	user424@user.com	\N	2012-07-23 12:37:20	2012-08-22 12:37:20	user	t	2012-09-06 12:37:20	87dc1e131a1369fdf8f1c824a6a62dff
425	user425	user425@user.com	\N	2012-07-22 11:36:20	\N	user	t	2012-09-05 11:36:20	87dc1e131a1369fdf8f1c824a6a62dff
426	user426	user426@user.com	\N	2012-07-21 10:35:20	2012-08-20 10:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
427	user427	user427@user.com	\N	2012-07-20 09:34:20	2012-08-19 09:34:20	user	t	2012-09-03 09:34:20	87dc1e131a1369fdf8f1c824a6a62dff
428	user428	user428@user.com	\N	2012-07-19 08:33:20	2012-08-18 08:33:20	user	t	2012-09-02 08:33:20	87dc1e131a1369fdf8f1c824a6a62dff
429	user429	user429@user.com	\N	2012-07-18 07:32:20	2012-08-17 07:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
430	user430	user430@user.com	\N	2012-07-17 06:31:20	\N	user	t	2012-08-31 06:31:20	87dc1e131a1369fdf8f1c824a6a62dff
431	user431	user431@user.com	\N	2012-07-16 05:30:20	2012-08-15 05:30:20	user	t	2012-08-30 05:30:20	87dc1e131a1369fdf8f1c824a6a62dff
432	user432	user432@user.com	\N	2012-07-15 04:29:20	2012-08-14 04:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
433	user433	user433@user.com	\N	2012-07-14 03:28:20	2012-08-13 03:28:20	user	t	2012-08-28 03:28:20	87dc1e131a1369fdf8f1c824a6a62dff
434	user434	user434@user.com	\N	2012-07-13 02:27:20	2012-08-12 02:27:20	user	t	2012-08-27 02:27:20	87dc1e131a1369fdf8f1c824a6a62dff
435	user435	user435@user.com	\N	2012-07-12 01:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
436	user436	user436@user.com	\N	2012-07-11 00:25:20	2012-08-10 00:25:20	user	t	2012-08-25 00:25:20	87dc1e131a1369fdf8f1c824a6a62dff
437	user437	user437@user.com	\N	2012-07-09 23:24:20	2012-08-08 23:24:20	user	t	2012-08-23 23:24:20	87dc1e131a1369fdf8f1c824a6a62dff
438	user438	user438@user.com	\N	2012-07-08 22:23:20	2012-08-07 22:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
439	user439	user439@user.com	\N	2012-07-07 21:22:20	2012-08-06 21:22:20	user	t	2012-08-21 21:22:20	87dc1e131a1369fdf8f1c824a6a62dff
440	user440	user440@user.com	\N	2012-07-06 20:21:20	\N	user	t	2012-08-20 20:21:20	87dc1e131a1369fdf8f1c824a6a62dff
441	user441	user441@user.com	\N	2012-07-05 19:20:20	2012-08-04 19:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
442	user442	user442@user.com	\N	2012-07-04 18:19:20	2012-08-03 18:19:20	user	t	2012-08-18 18:19:20	87dc1e131a1369fdf8f1c824a6a62dff
443	user443	user443@user.com	\N	2012-07-03 17:18:20	2012-08-02 17:18:20	user	t	2012-08-17 17:18:20	87dc1e131a1369fdf8f1c824a6a62dff
444	user444	user444@user.com	\N	2012-07-02 16:17:20	2012-08-01 16:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
445	user445	user445@user.com	\N	2012-07-01 15:16:20	\N	user	t	2012-08-15 15:16:20	87dc1e131a1369fdf8f1c824a6a62dff
446	user446	user446@user.com	\N	2012-06-30 14:15:20	2012-07-30 14:15:20	user	t	2012-08-14 14:15:20	87dc1e131a1369fdf8f1c824a6a62dff
447	user447	user447@user.com	\N	2012-06-29 13:14:20	2012-07-29 13:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
448	user448	user448@user.com	\N	2012-06-28 12:13:20	2012-07-28 12:13:20	user	t	2012-08-12 12:13:20	87dc1e131a1369fdf8f1c824a6a62dff
449	user449	user449@user.com	\N	2012-06-27 11:12:20	2012-07-27 11:12:20	user	t	2012-08-11 11:12:20	87dc1e131a1369fdf8f1c824a6a62dff
450	user450	user450@user.com	\N	2012-06-26 10:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
451	user451	user451@user.com	\N	2012-06-25 09:10:20	2012-07-25 09:10:20	user	t	2012-08-09 09:10:20	87dc1e131a1369fdf8f1c824a6a62dff
452	user452	user452@user.com	\N	2012-06-24 08:09:20	2012-07-24 08:09:20	user	t	2012-08-08 08:09:20	87dc1e131a1369fdf8f1c824a6a62dff
453	user453	user453@user.com	\N	2012-06-23 07:08:20	2012-07-23 07:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
454	user454	user454@user.com	\N	2012-06-22 06:07:20	2012-07-22 06:07:20	user	t	2012-08-06 06:07:20	87dc1e131a1369fdf8f1c824a6a62dff
455	user455	user455@user.com	\N	2012-06-21 05:06:20	\N	user	t	2012-08-05 05:06:20	87dc1e131a1369fdf8f1c824a6a62dff
456	user456	user456@user.com	\N	2012-06-20 04:05:20	2012-07-20 04:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
457	user457	user457@user.com	\N	2012-06-19 03:04:20	2012-07-19 03:04:20	user	t	2012-08-03 03:04:20	87dc1e131a1369fdf8f1c824a6a62dff
458	user458	user458@user.com	\N	2012-06-18 02:03:20	2012-07-18 02:03:20	user	t	2012-08-02 02:03:20	87dc1e131a1369fdf8f1c824a6a62dff
459	user459	user459@user.com	\N	2012-06-17 01:02:20	2012-07-17 01:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
460	user460	user460@user.com	\N	2012-06-16 00:01:20	\N	user	t	2012-07-31 00:01:20	87dc1e131a1369fdf8f1c824a6a62dff
461	user461	user461@user.com	\N	2012-06-14 23:00:20	2012-07-14 23:00:20	user	t	2012-07-29 23:00:20	87dc1e131a1369fdf8f1c824a6a62dff
462	user462	user462@user.com	\N	2012-06-13 21:59:20	2012-07-13 21:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
463	user463	user463@user.com	\N	2012-06-12 20:58:20	2012-07-12 20:58:20	user	t	2012-07-27 20:58:20	87dc1e131a1369fdf8f1c824a6a62dff
464	user464	user464@user.com	\N	2012-06-11 19:57:20	2012-07-11 19:57:20	user	t	2012-07-26 19:57:20	87dc1e131a1369fdf8f1c824a6a62dff
465	user465	user465@user.com	\N	2012-06-10 18:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
466	user466	user466@user.com	\N	2012-06-09 17:55:20	2012-07-09 17:55:20	user	t	2012-07-24 17:55:20	87dc1e131a1369fdf8f1c824a6a62dff
467	user467	user467@user.com	\N	2012-06-08 16:54:20	2012-07-08 16:54:20	user	t	2012-07-23 16:54:20	87dc1e131a1369fdf8f1c824a6a62dff
468	user468	user468@user.com	\N	2012-06-07 15:53:20	2012-07-07 15:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
469	user469	user469@user.com	\N	2012-06-06 14:52:20	2012-07-06 14:52:20	user	t	2012-07-21 14:52:20	87dc1e131a1369fdf8f1c824a6a62dff
470	user470	user470@user.com	\N	2012-06-05 13:51:20	\N	user	t	2012-07-20 13:51:20	87dc1e131a1369fdf8f1c824a6a62dff
471	user471	user471@user.com	\N	2012-06-04 12:50:20	2012-07-04 12:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
472	user472	user472@user.com	\N	2012-06-03 11:49:20	2012-07-03 11:49:20	user	t	2012-07-18 11:49:20	87dc1e131a1369fdf8f1c824a6a62dff
473	user473	user473@user.com	\N	2012-06-02 10:48:20	2012-07-02 10:48:20	user	t	2012-07-17 10:48:20	87dc1e131a1369fdf8f1c824a6a62dff
474	user474	user474@user.com	\N	2012-06-01 09:47:20	2012-07-01 09:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
475	user475	user475@user.com	\N	2012-05-31 08:46:20	\N	user	t	2012-07-15 08:46:20	87dc1e131a1369fdf8f1c824a6a62dff
476	user476	user476@user.com	\N	2012-05-30 07:45:20	2012-06-29 07:45:20	user	t	2012-07-14 07:45:20	87dc1e131a1369fdf8f1c824a6a62dff
477	user477	user477@user.com	\N	2012-05-29 06:44:20	2012-06-28 06:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
478	user478	user478@user.com	\N	2012-05-28 05:43:20	2012-06-27 05:43:20	user	t	2012-07-12 05:43:20	87dc1e131a1369fdf8f1c824a6a62dff
479	user479	user479@user.com	\N	2012-05-27 04:42:20	2012-06-26 04:42:20	user	t	2012-07-11 04:42:20	87dc1e131a1369fdf8f1c824a6a62dff
480	user480	user480@user.com	\N	2012-05-26 03:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
481	user481	user481@user.com	\N	2012-05-25 02:40:20	2012-06-24 02:40:20	user	t	2012-07-09 02:40:20	87dc1e131a1369fdf8f1c824a6a62dff
482	user482	user482@user.com	\N	2012-05-24 01:39:20	2012-06-23 01:39:20	user	t	2012-07-08 01:39:20	87dc1e131a1369fdf8f1c824a6a62dff
483	user483	user483@user.com	\N	2012-05-23 00:38:20	2012-06-22 00:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
484	user484	user484@user.com	\N	2012-05-21 23:37:20	2012-06-20 23:37:20	user	t	2012-07-05 23:37:20	87dc1e131a1369fdf8f1c824a6a62dff
485	user485	user485@user.com	\N	2012-05-20 22:36:20	\N	user	t	2012-07-04 22:36:20	87dc1e131a1369fdf8f1c824a6a62dff
486	user486	user486@user.com	\N	2012-05-19 21:35:20	2012-06-18 21:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
487	user487	user487@user.com	\N	2012-05-18 20:34:20	2012-06-17 20:34:20	user	t	2012-07-02 20:34:20	87dc1e131a1369fdf8f1c824a6a62dff
488	user488	user488@user.com	\N	2012-05-17 19:33:20	2012-06-16 19:33:20	user	t	2012-07-01 19:33:20	87dc1e131a1369fdf8f1c824a6a62dff
489	user489	user489@user.com	\N	2012-05-16 18:32:20	2012-06-15 18:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
490	user490	user490@user.com	\N	2012-05-15 17:31:20	\N	user	t	2012-06-29 17:31:20	87dc1e131a1369fdf8f1c824a6a62dff
491	user491	user491@user.com	\N	2012-05-14 16:30:20	2012-06-13 16:30:20	user	t	2012-06-28 16:30:20	87dc1e131a1369fdf8f1c824a6a62dff
492	user492	user492@user.com	\N	2012-05-13 15:29:20	2012-06-12 15:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
493	user493	user493@user.com	\N	2012-05-12 14:28:20	2012-06-11 14:28:20	user	t	2012-06-26 14:28:20	87dc1e131a1369fdf8f1c824a6a62dff
494	user494	user494@user.com	\N	2012-05-11 13:27:20	2012-06-10 13:27:20	user	t	2012-06-25 13:27:20	87dc1e131a1369fdf8f1c824a6a62dff
495	user495	user495@user.com	\N	2012-05-10 12:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
496	user496	user496@user.com	\N	2012-05-09 11:25:20	2012-06-08 11:25:20	user	t	2012-06-23 11:25:20	87dc1e131a1369fdf8f1c824a6a62dff
497	user497	user497@user.com	\N	2012-05-08 10:24:20	2012-06-07 10:24:20	user	t	2012-06-22 10:24:20	87dc1e131a1369fdf8f1c824a6a62dff
498	user498	user498@user.com	\N	2012-05-07 09:23:20	2012-06-06 09:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
499	user499	user499@user.com	\N	2012-05-06 08:22:20	2012-06-05 08:22:20	user	t	2012-06-20 08:22:20	87dc1e131a1369fdf8f1c824a6a62dff
500	user500	user500@user.com	\N	2012-05-05 07:21:20	\N	user	t	2012-06-19 07:21:20	87dc1e131a1369fdf8f1c824a6a62dff
501	user501	user501@user.com	\N	2012-05-04 06:20:20	2012-06-03 06:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
502	user502	user502@user.com	\N	2012-05-03 05:19:20	2012-06-02 05:19:20	user	t	2012-06-17 05:19:20	87dc1e131a1369fdf8f1c824a6a62dff
503	user503	user503@user.com	\N	2012-05-02 04:18:20	2012-06-01 04:18:20	user	t	2012-06-16 04:18:20	87dc1e131a1369fdf8f1c824a6a62dff
504	user504	user504@user.com	\N	2012-05-01 03:17:20	2012-05-31 03:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
505	user505	user505@user.com	\N	2012-04-30 02:16:20	\N	user	t	2012-06-14 02:16:20	87dc1e131a1369fdf8f1c824a6a62dff
506	user506	user506@user.com	\N	2012-04-29 01:15:20	2012-05-29 01:15:20	user	t	2012-06-13 01:15:20	87dc1e131a1369fdf8f1c824a6a62dff
507	user507	user507@user.com	\N	2012-04-28 00:14:20	2012-05-28 00:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
508	user508	user508@user.com	\N	2012-04-26 23:13:20	2012-05-26 23:13:20	user	t	2012-06-10 23:13:20	87dc1e131a1369fdf8f1c824a6a62dff
509	user509	user509@user.com	\N	2012-04-25 22:12:20	2012-05-25 22:12:20	user	t	2012-06-09 22:12:20	87dc1e131a1369fdf8f1c824a6a62dff
510	user510	user510@user.com	\N	2012-04-24 21:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
511	user511	user511@user.com	\N	2012-04-23 20:10:20	2012-05-23 20:10:20	user	t	2012-06-07 20:10:20	87dc1e131a1369fdf8f1c824a6a62dff
512	user512	user512@user.com	\N	2012-04-22 19:09:20	2012-05-22 19:09:20	user	t	2012-06-06 19:09:20	87dc1e131a1369fdf8f1c824a6a62dff
513	user513	user513@user.com	\N	2012-04-21 18:08:20	2012-05-21 18:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
514	user514	user514@user.com	\N	2012-04-20 17:07:20	2012-05-20 17:07:20	user	t	2012-06-04 17:07:20	87dc1e131a1369fdf8f1c824a6a62dff
515	user515	user515@user.com	\N	2012-04-19 16:06:20	\N	user	t	2012-06-03 16:06:20	87dc1e131a1369fdf8f1c824a6a62dff
516	user516	user516@user.com	\N	2012-04-18 15:05:20	2012-05-18 15:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
517	user517	user517@user.com	\N	2012-04-17 14:04:20	2012-05-17 14:04:20	user	t	2012-06-01 14:04:20	87dc1e131a1369fdf8f1c824a6a62dff
518	user518	user518@user.com	\N	2012-04-16 13:03:20	2012-05-16 13:03:20	user	t	2012-05-31 13:03:20	87dc1e131a1369fdf8f1c824a6a62dff
519	user519	user519@user.com	\N	2012-04-15 12:02:20	2012-05-15 12:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
520	user520	user520@user.com	\N	2012-04-14 11:01:20	\N	user	t	2012-05-29 11:01:20	87dc1e131a1369fdf8f1c824a6a62dff
521	user521	user521@user.com	\N	2012-04-13 10:00:20	2012-05-13 10:00:20	user	t	2012-05-28 10:00:20	87dc1e131a1369fdf8f1c824a6a62dff
522	user522	user522@user.com	\N	2012-04-12 08:59:20	2012-05-12 08:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
523	user523	user523@user.com	\N	2012-04-11 07:58:20	2012-05-11 07:58:20	user	t	2012-05-26 07:58:20	87dc1e131a1369fdf8f1c824a6a62dff
524	user524	user524@user.com	\N	2012-04-10 06:57:20	2012-05-10 06:57:20	user	t	2012-05-25 06:57:20	87dc1e131a1369fdf8f1c824a6a62dff
525	user525	user525@user.com	\N	2012-04-09 05:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
526	user526	user526@user.com	\N	2012-04-08 04:55:20	2012-05-08 04:55:20	user	t	2012-05-23 04:55:20	87dc1e131a1369fdf8f1c824a6a62dff
527	user527	user527@user.com	\N	2012-04-07 03:54:20	2012-05-07 03:54:20	user	t	2012-05-22 03:54:20	87dc1e131a1369fdf8f1c824a6a62dff
528	user528	user528@user.com	\N	2012-04-06 02:53:20	2012-05-06 02:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
529	user529	user529@user.com	\N	2012-04-05 01:52:20	2012-05-05 01:52:20	user	t	2012-05-20 01:52:20	87dc1e131a1369fdf8f1c824a6a62dff
530	user530	user530@user.com	\N	2012-04-04 00:51:20	\N	user	t	2012-05-19 00:51:20	87dc1e131a1369fdf8f1c824a6a62dff
531	user531	user531@user.com	\N	2012-04-02 23:50:20	2012-05-02 23:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
532	user532	user532@user.com	\N	2012-04-01 22:49:20	2012-05-01 22:49:20	user	t	2012-05-16 22:49:20	87dc1e131a1369fdf8f1c824a6a62dff
533	user533	user533@user.com	\N	2012-03-31 21:48:20	2012-04-30 21:48:20	user	t	2012-05-15 21:48:20	87dc1e131a1369fdf8f1c824a6a62dff
534	user534	user534@user.com	\N	2012-03-30 20:47:20	2012-04-29 20:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
535	user535	user535@user.com	\N	2012-03-29 19:46:20	\N	user	t	2012-05-13 19:46:20	87dc1e131a1369fdf8f1c824a6a62dff
536	user536	user536@user.com	\N	2012-03-28 18:45:20	2012-04-27 18:45:20	user	t	2012-05-12 18:45:20	87dc1e131a1369fdf8f1c824a6a62dff
537	user537	user537@user.com	\N	2012-03-27 17:44:20	2012-04-26 17:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
538	user538	user538@user.com	\N	2012-03-26 16:43:20	2012-04-25 16:43:20	user	t	2012-05-10 16:43:20	87dc1e131a1369fdf8f1c824a6a62dff
539	user539	user539@user.com	\N	2012-03-25 15:42:20	2012-04-24 15:42:20	user	t	2012-05-09 15:42:20	87dc1e131a1369fdf8f1c824a6a62dff
540	user540	user540@user.com	\N	2012-03-24 14:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
541	user541	user541@user.com	\N	2012-03-23 13:40:20	2012-04-22 13:40:20	user	t	2012-05-07 13:40:20	87dc1e131a1369fdf8f1c824a6a62dff
542	user542	user542@user.com	\N	2012-03-22 12:39:20	2012-04-21 12:39:20	user	t	2012-05-06 12:39:20	87dc1e131a1369fdf8f1c824a6a62dff
543	user543	user543@user.com	\N	2012-03-21 11:38:20	2012-04-20 11:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
544	user544	user544@user.com	\N	2012-03-20 10:37:20	2012-04-19 10:37:20	user	t	2012-05-04 10:37:20	87dc1e131a1369fdf8f1c824a6a62dff
545	user545	user545@user.com	\N	2012-03-19 09:36:20	\N	user	t	2012-05-03 09:36:20	87dc1e131a1369fdf8f1c824a6a62dff
546	user546	user546@user.com	\N	2012-03-18 08:35:20	2012-04-17 08:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
547	user547	user547@user.com	\N	2012-03-17 07:34:20	2012-04-16 07:34:20	user	t	2012-05-01 07:34:20	87dc1e131a1369fdf8f1c824a6a62dff
548	user548	user548@user.com	\N	2012-03-16 06:33:20	2012-04-15 06:33:20	user	t	2012-04-30 06:33:20	87dc1e131a1369fdf8f1c824a6a62dff
549	user549	user549@user.com	\N	2012-03-15 05:32:20	2012-04-14 05:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
550	user550	user550@user.com	\N	2012-03-14 04:31:20	\N	user	t	2012-04-28 04:31:20	87dc1e131a1369fdf8f1c824a6a62dff
551	user551	user551@user.com	\N	2012-03-13 03:30:20	2012-04-12 03:30:20	user	t	2012-04-27 03:30:20	87dc1e131a1369fdf8f1c824a6a62dff
552	user552	user552@user.com	\N	2012-03-12 02:29:20	2012-04-11 02:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
553	user553	user553@user.com	\N	2012-03-11 01:28:20	2012-04-10 01:28:20	user	t	2012-04-25 01:28:20	87dc1e131a1369fdf8f1c824a6a62dff
554	user554	user554@user.com	\N	2012-03-10 00:27:20	2012-04-09 00:27:20	user	t	2012-04-24 00:27:20	87dc1e131a1369fdf8f1c824a6a62dff
555	user555	user555@user.com	\N	2012-03-08 23:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
556	user556	user556@user.com	\N	2012-03-07 22:25:20	2012-04-06 22:25:20	user	t	2012-04-21 22:25:20	87dc1e131a1369fdf8f1c824a6a62dff
557	user557	user557@user.com	\N	2012-03-06 21:24:20	2012-04-05 21:24:20	user	t	2012-04-20 21:24:20	87dc1e131a1369fdf8f1c824a6a62dff
558	user558	user558@user.com	\N	2012-03-05 20:23:20	2012-04-04 20:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
559	user559	user559@user.com	\N	2012-03-04 19:22:20	2012-04-03 19:22:20	user	t	2012-04-18 19:22:20	87dc1e131a1369fdf8f1c824a6a62dff
560	user560	user560@user.com	\N	2012-03-03 18:21:20	\N	user	t	2012-04-17 18:21:20	87dc1e131a1369fdf8f1c824a6a62dff
561	user561	user561@user.com	\N	2012-03-02 17:20:20	2012-04-01 17:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
562	user562	user562@user.com	\N	2012-03-01 16:19:20	2012-03-31 16:19:20	user	t	2012-04-15 16:19:20	87dc1e131a1369fdf8f1c824a6a62dff
563	user563	user563@user.com	\N	2012-02-29 15:18:20	2012-03-30 15:18:20	user	t	2012-04-14 15:18:20	87dc1e131a1369fdf8f1c824a6a62dff
564	user564	user564@user.com	\N	2012-02-28 14:17:20	2012-03-29 14:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
565	user565	user565@user.com	\N	2012-02-27 13:16:20	\N	user	t	2012-04-12 13:16:20	87dc1e131a1369fdf8f1c824a6a62dff
566	user566	user566@user.com	\N	2012-02-26 12:15:20	2012-03-27 12:15:20	user	t	2012-04-11 12:15:20	87dc1e131a1369fdf8f1c824a6a62dff
567	user567	user567@user.com	\N	2012-02-25 11:14:20	2012-03-26 11:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
568	user568	user568@user.com	\N	2012-02-24 10:13:20	2012-03-25 10:13:20	user	t	2012-04-09 10:13:20	87dc1e131a1369fdf8f1c824a6a62dff
569	user569	user569@user.com	\N	2012-02-23 09:12:20	2012-03-24 09:12:20	user	t	2012-04-08 09:12:20	87dc1e131a1369fdf8f1c824a6a62dff
570	user570	user570@user.com	\N	2012-02-22 08:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
571	user571	user571@user.com	\N	2012-02-21 07:10:20	2012-03-22 07:10:20	user	t	2012-04-06 07:10:20	87dc1e131a1369fdf8f1c824a6a62dff
572	user572	user572@user.com	\N	2012-02-20 06:09:20	2012-03-21 06:09:20	user	t	2012-04-05 06:09:20	87dc1e131a1369fdf8f1c824a6a62dff
573	user573	user573@user.com	\N	2012-02-19 05:08:20	2012-03-20 05:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
574	user574	user574@user.com	\N	2012-02-18 04:07:20	2012-03-19 04:07:20	user	t	2012-04-03 04:07:20	87dc1e131a1369fdf8f1c824a6a62dff
575	user575	user575@user.com	\N	2012-02-17 03:06:20	\N	user	t	2012-04-02 03:06:20	87dc1e131a1369fdf8f1c824a6a62dff
576	user576	user576@user.com	\N	2012-02-16 02:05:20	2012-03-17 02:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
577	user577	user577@user.com	\N	2012-02-15 01:04:20	2012-03-16 01:04:20	user	t	2012-03-31 01:04:20	87dc1e131a1369fdf8f1c824a6a62dff
578	user578	user578@user.com	\N	2012-02-14 00:03:20	2012-03-15 00:03:20	user	t	2012-03-30 00:03:20	87dc1e131a1369fdf8f1c824a6a62dff
579	user579	user579@user.com	\N	2012-02-12 23:02:20	2012-03-13 23:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
580	user580	user580@user.com	\N	2012-02-11 22:01:20	\N	user	t	2012-03-27 22:01:20	87dc1e131a1369fdf8f1c824a6a62dff
581	user581	user581@user.com	\N	2012-02-10 21:00:20	2012-03-11 21:00:20	user	t	2012-03-26 21:00:20	87dc1e131a1369fdf8f1c824a6a62dff
582	user582	user582@user.com	\N	2012-02-09 19:59:20	2012-03-10 19:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
583	user583	user583@user.com	\N	2012-02-08 18:58:20	2012-03-09 18:58:20	user	t	2012-03-24 18:58:20	87dc1e131a1369fdf8f1c824a6a62dff
584	user584	user584@user.com	\N	2012-02-07 17:57:20	2012-03-08 17:57:20	user	t	2012-03-23 17:57:20	87dc1e131a1369fdf8f1c824a6a62dff
585	user585	user585@user.com	\N	2012-02-06 16:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
586	user586	user586@user.com	\N	2012-02-05 15:55:20	2012-03-06 15:55:20	user	t	2012-03-21 15:55:20	87dc1e131a1369fdf8f1c824a6a62dff
587	user587	user587@user.com	\N	2012-02-04 14:54:20	2012-03-05 14:54:20	user	t	2012-03-20 14:54:20	87dc1e131a1369fdf8f1c824a6a62dff
588	user588	user588@user.com	\N	2012-02-03 13:53:20	2012-03-04 13:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
589	user589	user589@user.com	\N	2012-02-02 12:52:20	2012-03-03 12:52:20	user	t	2012-03-18 12:52:20	87dc1e131a1369fdf8f1c824a6a62dff
590	user590	user590@user.com	\N	2012-02-01 11:51:20	\N	user	t	2012-03-17 11:51:20	87dc1e131a1369fdf8f1c824a6a62dff
591	user591	user591@user.com	\N	2012-01-31 10:50:20	2012-03-01 10:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
592	user592	user592@user.com	\N	2012-01-30 09:49:20	2012-02-29 09:49:20	user	t	2012-03-15 09:49:20	87dc1e131a1369fdf8f1c824a6a62dff
593	user593	user593@user.com	\N	2012-01-29 08:48:20	2012-02-28 08:48:20	user	t	2012-03-14 08:48:20	87dc1e131a1369fdf8f1c824a6a62dff
594	user594	user594@user.com	\N	2012-01-28 07:47:20	2012-02-27 07:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
595	user595	user595@user.com	\N	2012-01-27 06:46:20	\N	user	t	2012-03-12 06:46:20	87dc1e131a1369fdf8f1c824a6a62dff
596	user596	user596@user.com	\N	2012-01-26 05:45:20	2012-02-25 05:45:20	user	t	2012-03-11 05:45:20	87dc1e131a1369fdf8f1c824a6a62dff
597	user597	user597@user.com	\N	2012-01-25 04:44:20	2012-02-24 04:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
598	user598	user598@user.com	\N	2012-01-24 03:43:20	2012-02-23 03:43:20	user	t	2012-03-09 03:43:20	87dc1e131a1369fdf8f1c824a6a62dff
599	user599	user599@user.com	\N	2012-01-23 02:42:20	2012-02-22 02:42:20	user	t	2012-03-08 02:42:20	87dc1e131a1369fdf8f1c824a6a62dff
600	user600	user600@user.com	\N	2012-01-22 01:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
601	user601	user601@user.com	\N	2012-01-21 00:40:20	2012-02-20 00:40:20	user	t	2012-03-06 00:40:20	87dc1e131a1369fdf8f1c824a6a62dff
602	user602	user602@user.com	\N	2012-01-19 23:39:20	2012-02-18 23:39:20	user	t	2012-03-04 23:39:20	87dc1e131a1369fdf8f1c824a6a62dff
603	user603	user603@user.com	\N	2012-01-18 22:38:20	2012-02-17 22:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
604	user604	user604@user.com	\N	2012-01-17 21:37:20	2012-02-16 21:37:20	user	t	2012-03-02 21:37:20	87dc1e131a1369fdf8f1c824a6a62dff
605	user605	user605@user.com	\N	2012-01-16 20:36:20	\N	user	t	2012-03-01 20:36:20	87dc1e131a1369fdf8f1c824a6a62dff
606	user606	user606@user.com	\N	2012-01-15 19:35:20	2012-02-14 19:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
607	user607	user607@user.com	\N	2012-01-14 18:34:20	2012-02-13 18:34:20	user	t	2012-02-28 18:34:20	87dc1e131a1369fdf8f1c824a6a62dff
608	user608	user608@user.com	\N	2012-01-13 17:33:20	2012-02-12 17:33:20	user	t	2012-02-27 17:33:20	87dc1e131a1369fdf8f1c824a6a62dff
609	user609	user609@user.com	\N	2012-01-12 16:32:20	2012-02-11 16:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
610	user610	user610@user.com	\N	2012-01-11 15:31:20	\N	user	t	2012-02-25 15:31:20	87dc1e131a1369fdf8f1c824a6a62dff
611	user611	user611@user.com	\N	2012-01-10 14:30:20	2012-02-09 14:30:20	user	t	2012-02-24 14:30:20	87dc1e131a1369fdf8f1c824a6a62dff
612	user612	user612@user.com	\N	2012-01-09 13:29:20	2012-02-08 13:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
613	user613	user613@user.com	\N	2012-01-08 12:28:20	2012-02-07 12:28:20	user	t	2012-02-22 12:28:20	87dc1e131a1369fdf8f1c824a6a62dff
614	user614	user614@user.com	\N	2012-01-07 11:27:20	2012-02-06 11:27:20	user	t	2012-02-21 11:27:20	87dc1e131a1369fdf8f1c824a6a62dff
615	user615	user615@user.com	\N	2012-01-06 10:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
616	user616	user616@user.com	\N	2012-01-05 09:25:20	2012-02-04 09:25:20	user	t	2012-02-19 09:25:20	87dc1e131a1369fdf8f1c824a6a62dff
617	user617	user617@user.com	\N	2012-01-04 08:24:20	2012-02-03 08:24:20	user	t	2012-02-18 08:24:20	87dc1e131a1369fdf8f1c824a6a62dff
618	user618	user618@user.com	\N	2012-01-03 07:23:20	2012-02-02 07:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
619	user619	user619@user.com	\N	2012-01-02 06:22:20	2012-02-01 06:22:20	user	t	2012-02-16 06:22:20	87dc1e131a1369fdf8f1c824a6a62dff
620	user620	user620@user.com	\N	2012-01-01 05:21:20	\N	user	t	2012-02-15 05:21:20	87dc1e131a1369fdf8f1c824a6a62dff
621	user621	user621@user.com	\N	2011-12-31 04:20:20	2012-01-30 04:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
622	user622	user622@user.com	\N	2011-12-30 03:19:20	2012-01-29 03:19:20	user	t	2012-02-13 03:19:20	87dc1e131a1369fdf8f1c824a6a62dff
623	user623	user623@user.com	\N	2011-12-29 02:18:20	2012-01-28 02:18:20	user	t	2012-02-12 02:18:20	87dc1e131a1369fdf8f1c824a6a62dff
624	user624	user624@user.com	\N	2011-12-28 01:17:20	2012-01-27 01:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
625	user625	user625@user.com	\N	2011-12-27 00:16:20	\N	user	t	2012-02-10 00:16:20	87dc1e131a1369fdf8f1c824a6a62dff
626	user626	user626@user.com	\N	2011-12-25 23:15:20	2012-01-24 23:15:20	user	t	2012-02-08 23:15:20	87dc1e131a1369fdf8f1c824a6a62dff
627	user627	user627@user.com	\N	2011-12-24 22:14:20	2012-01-23 22:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
628	user628	user628@user.com	\N	2011-12-23 21:13:20	2012-01-22 21:13:20	user	t	2012-02-06 21:13:20	87dc1e131a1369fdf8f1c824a6a62dff
629	user629	user629@user.com	\N	2011-12-22 20:12:20	2012-01-21 20:12:20	user	t	2012-02-05 20:12:20	87dc1e131a1369fdf8f1c824a6a62dff
630	user630	user630@user.com	\N	2011-12-21 19:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
631	user631	user631@user.com	\N	2011-12-20 18:10:20	2012-01-19 18:10:20	user	t	2012-02-03 18:10:20	87dc1e131a1369fdf8f1c824a6a62dff
632	user632	user632@user.com	\N	2011-12-19 17:09:20	2012-01-18 17:09:20	user	t	2012-02-02 17:09:20	87dc1e131a1369fdf8f1c824a6a62dff
633	user633	user633@user.com	\N	2011-12-18 16:08:20	2012-01-17 16:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
634	user634	user634@user.com	\N	2011-12-17 15:07:20	2012-01-16 15:07:20	user	t	2012-01-31 15:07:20	87dc1e131a1369fdf8f1c824a6a62dff
635	user635	user635@user.com	\N	2011-12-16 14:06:20	\N	user	t	2012-01-30 14:06:20	87dc1e131a1369fdf8f1c824a6a62dff
636	user636	user636@user.com	\N	2011-12-15 13:05:20	2012-01-14 13:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
637	user637	user637@user.com	\N	2011-12-14 12:04:20	2012-01-13 12:04:20	user	t	2012-01-28 12:04:20	87dc1e131a1369fdf8f1c824a6a62dff
638	user638	user638@user.com	\N	2011-12-13 11:03:20	2012-01-12 11:03:20	user	t	2012-01-27 11:03:20	87dc1e131a1369fdf8f1c824a6a62dff
639	user639	user639@user.com	\N	2011-12-12 10:02:20	2012-01-11 10:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
640	user640	user640@user.com	\N	2011-12-11 09:01:20	\N	user	t	2012-01-25 09:01:20	87dc1e131a1369fdf8f1c824a6a62dff
641	user641	user641@user.com	\N	2011-12-10 08:00:20	2012-01-09 08:00:20	user	t	2012-01-24 08:00:20	87dc1e131a1369fdf8f1c824a6a62dff
642	user642	user642@user.com	\N	2011-12-09 06:59:20	2012-01-08 06:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
643	user643	user643@user.com	\N	2011-12-08 05:58:20	2012-01-07 05:58:20	user	t	2012-01-22 05:58:20	87dc1e131a1369fdf8f1c824a6a62dff
644	user644	user644@user.com	\N	2011-12-07 04:57:20	2012-01-06 04:57:20	user	t	2012-01-21 04:57:20	87dc1e131a1369fdf8f1c824a6a62dff
645	user645	user645@user.com	\N	2011-12-06 03:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
646	user646	user646@user.com	\N	2011-12-05 02:55:20	2012-01-04 02:55:20	user	t	2012-01-19 02:55:20	87dc1e131a1369fdf8f1c824a6a62dff
647	user647	user647@user.com	\N	2011-12-04 01:54:20	2012-01-03 01:54:20	user	t	2012-01-18 01:54:20	87dc1e131a1369fdf8f1c824a6a62dff
648	user648	user648@user.com	\N	2011-12-03 00:53:20	2012-01-02 00:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
649	user649	user649@user.com	\N	2011-12-01 23:52:20	2011-12-31 23:52:20	user	t	2012-01-15 23:52:20	87dc1e131a1369fdf8f1c824a6a62dff
650	user650	user650@user.com	\N	2011-11-30 22:51:20	\N	user	t	2012-01-14 22:51:20	87dc1e131a1369fdf8f1c824a6a62dff
651	user651	user651@user.com	\N	2011-11-29 21:50:20	2011-12-29 21:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
652	user652	user652@user.com	\N	2011-11-28 20:49:20	2011-12-28 20:49:20	user	t	2012-01-12 20:49:20	87dc1e131a1369fdf8f1c824a6a62dff
653	user653	user653@user.com	\N	2011-11-27 19:48:20	2011-12-27 19:48:20	user	t	2012-01-11 19:48:20	87dc1e131a1369fdf8f1c824a6a62dff
654	user654	user654@user.com	\N	2011-11-26 18:47:20	2011-12-26 18:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
655	user655	user655@user.com	\N	2011-11-25 17:46:20	\N	user	t	2012-01-09 17:46:20	87dc1e131a1369fdf8f1c824a6a62dff
656	user656	user656@user.com	\N	2011-11-24 16:45:20	2011-12-24 16:45:20	user	t	2012-01-08 16:45:20	87dc1e131a1369fdf8f1c824a6a62dff
657	user657	user657@user.com	\N	2011-11-23 15:44:20	2011-12-23 15:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
658	user658	user658@user.com	\N	2011-11-22 14:43:20	2011-12-22 14:43:20	user	t	2012-01-06 14:43:20	87dc1e131a1369fdf8f1c824a6a62dff
659	user659	user659@user.com	\N	2011-11-21 13:42:20	2011-12-21 13:42:20	user	t	2012-01-05 13:42:20	87dc1e131a1369fdf8f1c824a6a62dff
660	user660	user660@user.com	\N	2011-11-20 12:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
661	user661	user661@user.com	\N	2011-11-19 11:40:20	2011-12-19 11:40:20	user	t	2012-01-03 11:40:20	87dc1e131a1369fdf8f1c824a6a62dff
662	user662	user662@user.com	\N	2011-11-18 10:39:20	2011-12-18 10:39:20	user	t	2012-01-02 10:39:20	87dc1e131a1369fdf8f1c824a6a62dff
663	user663	user663@user.com	\N	2011-11-17 09:38:20	2011-12-17 09:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
664	user664	user664@user.com	\N	2011-11-16 08:37:20	2011-12-16 08:37:20	user	t	2011-12-31 08:37:20	87dc1e131a1369fdf8f1c824a6a62dff
665	user665	user665@user.com	\N	2011-11-15 07:36:20	\N	user	t	2011-12-30 07:36:20	87dc1e131a1369fdf8f1c824a6a62dff
666	user666	user666@user.com	\N	2011-11-14 06:35:20	2011-12-14 06:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
667	user667	user667@user.com	\N	2011-11-13 05:34:20	2011-12-13 05:34:20	user	t	2011-12-28 05:34:20	87dc1e131a1369fdf8f1c824a6a62dff
668	user668	user668@user.com	\N	2011-11-12 04:33:20	2011-12-12 04:33:20	user	t	2011-12-27 04:33:20	87dc1e131a1369fdf8f1c824a6a62dff
669	user669	user669@user.com	\N	2011-11-11 03:32:20	2011-12-11 03:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
670	user670	user670@user.com	\N	2011-11-10 02:31:20	\N	user	t	2011-12-25 02:31:20	87dc1e131a1369fdf8f1c824a6a62dff
671	user671	user671@user.com	\N	2011-11-09 01:30:20	2011-12-09 01:30:20	user	t	2011-12-24 01:30:20	87dc1e131a1369fdf8f1c824a6a62dff
672	user672	user672@user.com	\N	2011-11-08 00:29:20	2011-12-08 00:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
673	user673	user673@user.com	\N	2011-11-06 23:28:20	2011-12-06 23:28:20	user	t	2011-12-21 23:28:20	87dc1e131a1369fdf8f1c824a6a62dff
674	user674	user674@user.com	\N	2011-11-05 22:27:20	2011-12-05 22:27:20	user	t	2011-12-20 22:27:20	87dc1e131a1369fdf8f1c824a6a62dff
675	user675	user675@user.com	\N	2011-11-04 21:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
676	user676	user676@user.com	\N	2011-11-03 20:25:20	2011-12-03 20:25:20	user	t	2011-12-18 20:25:20	87dc1e131a1369fdf8f1c824a6a62dff
677	user677	user677@user.com	\N	2011-11-02 19:24:20	2011-12-02 19:24:20	user	t	2011-12-17 19:24:20	87dc1e131a1369fdf8f1c824a6a62dff
678	user678	user678@user.com	\N	2011-11-01 18:23:20	2011-12-01 18:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
679	user679	user679@user.com	\N	2011-10-31 17:22:20	2011-11-30 17:22:20	user	t	2011-12-15 17:22:20	87dc1e131a1369fdf8f1c824a6a62dff
680	user680	user680@user.com	\N	2011-10-30 16:21:20	\N	user	t	2011-12-14 16:21:20	87dc1e131a1369fdf8f1c824a6a62dff
681	user681	user681@user.com	\N	2011-10-29 15:20:20	2011-11-28 15:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
682	user682	user682@user.com	\N	2011-10-28 14:19:20	2011-11-27 14:19:20	user	t	2011-12-12 14:19:20	87dc1e131a1369fdf8f1c824a6a62dff
683	user683	user683@user.com	\N	2011-10-27 13:18:20	2011-11-26 13:18:20	user	t	2011-12-11 13:18:20	87dc1e131a1369fdf8f1c824a6a62dff
684	user684	user684@user.com	\N	2011-10-26 12:17:20	2011-11-25 12:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
685	user685	user685@user.com	\N	2011-10-25 11:16:20	\N	user	t	2011-12-09 11:16:20	87dc1e131a1369fdf8f1c824a6a62dff
686	user686	user686@user.com	\N	2011-10-24 10:15:20	2011-11-23 10:15:20	user	t	2011-12-08 10:15:20	87dc1e131a1369fdf8f1c824a6a62dff
687	user687	user687@user.com	\N	2011-10-23 09:14:20	2011-11-22 09:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
688	user688	user688@user.com	\N	2011-10-22 08:13:20	2011-11-21 08:13:20	user	t	2011-12-06 08:13:20	87dc1e131a1369fdf8f1c824a6a62dff
689	user689	user689@user.com	\N	2011-10-21 07:12:20	2011-11-20 07:12:20	user	t	2011-12-05 07:12:20	87dc1e131a1369fdf8f1c824a6a62dff
690	user690	user690@user.com	\N	2011-10-20 06:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
691	user691	user691@user.com	\N	2011-10-19 05:10:20	2011-11-18 05:10:20	user	t	2011-12-03 05:10:20	87dc1e131a1369fdf8f1c824a6a62dff
692	user692	user692@user.com	\N	2011-10-18 04:09:20	2011-11-17 04:09:20	user	t	2011-12-02 04:09:20	87dc1e131a1369fdf8f1c824a6a62dff
693	user693	user693@user.com	\N	2011-10-17 03:08:20	2011-11-16 03:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
694	user694	user694@user.com	\N	2011-10-16 02:07:20	2011-11-15 02:07:20	user	t	2011-11-30 02:07:20	87dc1e131a1369fdf8f1c824a6a62dff
695	user695	user695@user.com	\N	2011-10-15 01:06:20	\N	user	t	2011-11-29 01:06:20	87dc1e131a1369fdf8f1c824a6a62dff
696	user696	user696@user.com	\N	2011-10-14 00:05:20	2011-11-13 00:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
697	user697	user697@user.com	\N	2011-10-12 23:04:20	2011-11-11 23:04:20	user	t	2011-11-26 23:04:20	87dc1e131a1369fdf8f1c824a6a62dff
698	user698	user698@user.com	\N	2011-10-11 22:03:20	2011-11-10 22:03:20	user	t	2011-11-25 22:03:20	87dc1e131a1369fdf8f1c824a6a62dff
699	user699	user699@user.com	\N	2011-10-10 21:02:20	2011-11-09 21:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
700	user700	user700@user.com	\N	2011-10-09 20:01:20	\N	user	t	2011-11-23 20:01:20	87dc1e131a1369fdf8f1c824a6a62dff
701	user701	user701@user.com	\N	2011-10-08 19:00:20	2011-11-07 19:00:20	user	t	2011-11-22 19:00:20	87dc1e131a1369fdf8f1c824a6a62dff
702	user702	user702@user.com	\N	2011-10-07 17:59:20	2011-11-06 17:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
703	user703	user703@user.com	\N	2011-10-06 16:58:20	2011-11-05 16:58:20	user	t	2011-11-20 16:58:20	87dc1e131a1369fdf8f1c824a6a62dff
704	user704	user704@user.com	\N	2011-10-05 15:57:20	2011-11-04 15:57:20	user	t	2011-11-19 15:57:20	87dc1e131a1369fdf8f1c824a6a62dff
705	user705	user705@user.com	\N	2011-10-04 14:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
706	user706	user706@user.com	\N	2011-10-03 13:55:20	2011-11-02 13:55:20	user	t	2011-11-17 13:55:20	87dc1e131a1369fdf8f1c824a6a62dff
707	user707	user707@user.com	\N	2011-10-02 12:54:20	2011-11-01 12:54:20	user	t	2011-11-16 12:54:20	87dc1e131a1369fdf8f1c824a6a62dff
708	user708	user708@user.com	\N	2011-10-01 11:53:20	2011-10-31 11:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
709	user709	user709@user.com	\N	2011-09-30 10:52:20	2011-10-30 10:52:20	user	t	2011-11-14 10:52:20	87dc1e131a1369fdf8f1c824a6a62dff
710	user710	user710@user.com	\N	2011-09-29 09:51:20	\N	user	t	2011-11-13 09:51:20	87dc1e131a1369fdf8f1c824a6a62dff
711	user711	user711@user.com	\N	2011-09-28 08:50:20	2011-10-28 08:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
712	user712	user712@user.com	\N	2011-09-27 07:49:20	2011-10-27 07:49:20	user	t	2011-11-11 07:49:20	87dc1e131a1369fdf8f1c824a6a62dff
713	user713	user713@user.com	\N	2011-09-26 06:48:20	2011-10-26 06:48:20	user	t	2011-11-10 06:48:20	87dc1e131a1369fdf8f1c824a6a62dff
714	user714	user714@user.com	\N	2011-09-25 05:47:20	2011-10-25 05:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
715	user715	user715@user.com	\N	2011-09-24 04:46:20	\N	user	t	2011-11-08 04:46:20	87dc1e131a1369fdf8f1c824a6a62dff
716	user716	user716@user.com	\N	2011-09-23 03:45:20	2011-10-23 03:45:20	user	t	2011-11-07 03:45:20	87dc1e131a1369fdf8f1c824a6a62dff
717	user717	user717@user.com	\N	2011-09-22 02:44:20	2011-10-22 02:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
718	user718	user718@user.com	\N	2011-09-21 01:43:20	2011-10-21 01:43:20	user	t	2011-11-05 01:43:20	87dc1e131a1369fdf8f1c824a6a62dff
719	user719	user719@user.com	\N	2011-09-20 00:42:20	2011-10-20 00:42:20	user	t	2011-11-04 00:42:20	87dc1e131a1369fdf8f1c824a6a62dff
720	user720	user720@user.com	\N	2011-09-18 23:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
721	user721	user721@user.com	\N	2011-09-17 22:40:20	2011-10-17 22:40:20	user	t	2011-11-01 22:40:20	87dc1e131a1369fdf8f1c824a6a62dff
722	user722	user722@user.com	\N	2011-09-16 21:39:20	2011-10-16 21:39:20	user	t	2011-10-31 21:39:20	87dc1e131a1369fdf8f1c824a6a62dff
723	user723	user723@user.com	\N	2011-09-15 20:38:20	2011-10-15 20:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
724	user724	user724@user.com	\N	2011-09-14 19:37:20	2011-10-14 19:37:20	user	t	2011-10-29 19:37:20	87dc1e131a1369fdf8f1c824a6a62dff
725	user725	user725@user.com	\N	2011-09-13 18:36:20	\N	user	t	2011-10-28 18:36:20	87dc1e131a1369fdf8f1c824a6a62dff
726	user726	user726@user.com	\N	2011-09-12 17:35:20	2011-10-12 17:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
727	user727	user727@user.com	\N	2011-09-11 16:34:20	2011-10-11 16:34:20	user	t	2011-10-26 16:34:20	87dc1e131a1369fdf8f1c824a6a62dff
728	user728	user728@user.com	\N	2011-09-10 15:33:20	2011-10-10 15:33:20	user	t	2011-10-25 15:33:20	87dc1e131a1369fdf8f1c824a6a62dff
729	user729	user729@user.com	\N	2011-09-09 14:32:20	2011-10-09 14:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
730	user730	user730@user.com	\N	2011-09-08 13:31:20	\N	user	t	2011-10-23 13:31:20	87dc1e131a1369fdf8f1c824a6a62dff
731	user731	user731@user.com	\N	2011-09-07 12:30:20	2011-10-07 12:30:20	user	t	2011-10-22 12:30:20	87dc1e131a1369fdf8f1c824a6a62dff
732	user732	user732@user.com	\N	2011-09-06 11:29:20	2011-10-06 11:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
733	user733	user733@user.com	\N	2011-09-05 10:28:20	2011-10-05 10:28:20	user	t	2011-10-20 10:28:20	87dc1e131a1369fdf8f1c824a6a62dff
734	user734	user734@user.com	\N	2011-09-04 09:27:20	2011-10-04 09:27:20	user	t	2011-10-19 09:27:20	87dc1e131a1369fdf8f1c824a6a62dff
735	user735	user735@user.com	\N	2011-09-03 08:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
736	user736	user736@user.com	\N	2011-09-02 07:25:20	2011-10-02 07:25:20	user	t	2011-10-17 07:25:20	87dc1e131a1369fdf8f1c824a6a62dff
737	user737	user737@user.com	\N	2011-09-01 06:24:20	2011-10-01 06:24:20	user	t	2011-10-16 06:24:20	87dc1e131a1369fdf8f1c824a6a62dff
738	user738	user738@user.com	\N	2011-08-31 05:23:20	2011-09-30 05:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
739	user739	user739@user.com	\N	2011-08-30 04:22:20	2011-09-29 04:22:20	user	t	2011-10-14 04:22:20	87dc1e131a1369fdf8f1c824a6a62dff
740	user740	user740@user.com	\N	2011-08-29 03:21:20	\N	user	t	2011-10-13 03:21:20	87dc1e131a1369fdf8f1c824a6a62dff
741	user741	user741@user.com	\N	2011-08-28 02:20:20	2011-09-27 02:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
742	user742	user742@user.com	\N	2011-08-27 01:19:20	2011-09-26 01:19:20	user	t	2011-10-11 01:19:20	87dc1e131a1369fdf8f1c824a6a62dff
743	user743	user743@user.com	\N	2011-08-26 00:18:20	2011-09-25 00:18:20	user	t	2011-10-10 00:18:20	87dc1e131a1369fdf8f1c824a6a62dff
744	user744	user744@user.com	\N	2011-08-24 23:17:20	2011-09-23 23:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
745	user745	user745@user.com	\N	2011-08-23 22:16:20	\N	user	t	2011-10-07 22:16:20	87dc1e131a1369fdf8f1c824a6a62dff
746	user746	user746@user.com	\N	2011-08-22 21:15:20	2011-09-21 21:15:20	user	t	2011-10-06 21:15:20	87dc1e131a1369fdf8f1c824a6a62dff
747	user747	user747@user.com	\N	2011-08-21 20:14:20	2011-09-20 20:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
748	user748	user748@user.com	\N	2011-08-20 19:13:20	2011-09-19 19:13:20	user	t	2011-10-04 19:13:20	87dc1e131a1369fdf8f1c824a6a62dff
749	user749	user749@user.com	\N	2011-08-19 18:12:20	2011-09-18 18:12:20	user	t	2011-10-03 18:12:20	87dc1e131a1369fdf8f1c824a6a62dff
750	user750	user750@user.com	\N	2011-08-18 17:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
751	user751	user751@user.com	\N	2011-08-17 16:10:20	2011-09-16 16:10:20	user	t	2011-10-01 16:10:20	87dc1e131a1369fdf8f1c824a6a62dff
752	user752	user752@user.com	\N	2011-08-16 15:09:20	2011-09-15 15:09:20	user	t	2011-09-30 15:09:20	87dc1e131a1369fdf8f1c824a6a62dff
753	user753	user753@user.com	\N	2011-08-15 14:08:20	2011-09-14 14:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
754	user754	user754@user.com	\N	2011-08-14 13:07:20	2011-09-13 13:07:20	user	t	2011-09-28 13:07:20	87dc1e131a1369fdf8f1c824a6a62dff
755	user755	user755@user.com	\N	2011-08-13 12:06:20	\N	user	t	2011-09-27 12:06:20	87dc1e131a1369fdf8f1c824a6a62dff
756	user756	user756@user.com	\N	2011-08-12 11:05:20	2011-09-11 11:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
757	user757	user757@user.com	\N	2011-08-11 10:04:20	2011-09-10 10:04:20	user	t	2011-09-25 10:04:20	87dc1e131a1369fdf8f1c824a6a62dff
758	user758	user758@user.com	\N	2011-08-10 09:03:20	2011-09-09 09:03:20	user	t	2011-09-24 09:03:20	87dc1e131a1369fdf8f1c824a6a62dff
759	user759	user759@user.com	\N	2011-08-09 08:02:20	2011-09-08 08:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
760	user760	user760@user.com	\N	2011-08-08 07:01:20	\N	user	t	2011-09-22 07:01:20	87dc1e131a1369fdf8f1c824a6a62dff
761	user761	user761@user.com	\N	2011-08-07 06:00:20	2011-09-06 06:00:20	user	t	2011-09-21 06:00:20	87dc1e131a1369fdf8f1c824a6a62dff
762	user762	user762@user.com	\N	2011-08-06 04:59:20	2011-09-05 04:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
763	user763	user763@user.com	\N	2011-08-05 03:58:20	2011-09-04 03:58:20	user	t	2011-09-19 03:58:20	87dc1e131a1369fdf8f1c824a6a62dff
764	user764	user764@user.com	\N	2011-08-04 02:57:20	2011-09-03 02:57:20	user	t	2011-09-18 02:57:20	87dc1e131a1369fdf8f1c824a6a62dff
765	user765	user765@user.com	\N	2011-08-03 01:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
766	user766	user766@user.com	\N	2011-08-02 00:55:20	2011-09-01 00:55:20	user	t	2011-09-16 00:55:20	87dc1e131a1369fdf8f1c824a6a62dff
767	user767	user767@user.com	\N	2011-07-31 23:54:20	2011-08-30 23:54:20	user	t	2011-09-14 23:54:20	87dc1e131a1369fdf8f1c824a6a62dff
768	user768	user768@user.com	\N	2011-07-30 22:53:20	2011-08-29 22:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
769	user769	user769@user.com	\N	2011-07-29 21:52:20	2011-08-28 21:52:20	user	t	2011-09-12 21:52:20	87dc1e131a1369fdf8f1c824a6a62dff
770	user770	user770@user.com	\N	2011-07-28 20:51:20	\N	user	t	2011-09-11 20:51:20	87dc1e131a1369fdf8f1c824a6a62dff
771	user771	user771@user.com	\N	2011-07-27 19:50:20	2011-08-26 19:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
772	user772	user772@user.com	\N	2011-07-26 18:49:20	2011-08-25 18:49:20	user	t	2011-09-09 18:49:20	87dc1e131a1369fdf8f1c824a6a62dff
773	user773	user773@user.com	\N	2011-07-25 17:48:20	2011-08-24 17:48:20	user	t	2011-09-08 17:48:20	87dc1e131a1369fdf8f1c824a6a62dff
774	user774	user774@user.com	\N	2011-07-24 16:47:20	2011-08-23 16:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
775	user775	user775@user.com	\N	2011-07-23 15:46:20	\N	user	t	2011-09-06 15:46:20	87dc1e131a1369fdf8f1c824a6a62dff
776	user776	user776@user.com	\N	2011-07-22 14:45:20	2011-08-21 14:45:20	user	t	2011-09-05 14:45:20	87dc1e131a1369fdf8f1c824a6a62dff
777	user777	user777@user.com	\N	2011-07-21 13:44:20	2011-08-20 13:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
778	user778	user778@user.com	\N	2011-07-20 12:43:20	2011-08-19 12:43:20	user	t	2011-09-03 12:43:20	87dc1e131a1369fdf8f1c824a6a62dff
779	user779	user779@user.com	\N	2011-07-19 11:42:20	2011-08-18 11:42:20	user	t	2011-09-02 11:42:20	87dc1e131a1369fdf8f1c824a6a62dff
780	user780	user780@user.com	\N	2011-07-18 10:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
781	user781	user781@user.com	\N	2011-07-17 09:40:20	2011-08-16 09:40:20	user	t	2011-08-31 09:40:20	87dc1e131a1369fdf8f1c824a6a62dff
782	user782	user782@user.com	\N	2011-07-16 08:39:20	2011-08-15 08:39:20	user	t	2011-08-30 08:39:20	87dc1e131a1369fdf8f1c824a6a62dff
783	user783	user783@user.com	\N	2011-07-15 07:38:20	2011-08-14 07:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
784	user784	user784@user.com	\N	2011-07-14 06:37:20	2011-08-13 06:37:20	user	t	2011-08-28 06:37:20	87dc1e131a1369fdf8f1c824a6a62dff
785	user785	user785@user.com	\N	2011-07-13 05:36:20	\N	user	t	2011-08-27 05:36:20	87dc1e131a1369fdf8f1c824a6a62dff
786	user786	user786@user.com	\N	2011-07-12 04:35:20	2011-08-11 04:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
787	user787	user787@user.com	\N	2011-07-11 03:34:20	2011-08-10 03:34:20	user	t	2011-08-25 03:34:20	87dc1e131a1369fdf8f1c824a6a62dff
788	user788	user788@user.com	\N	2011-07-10 02:33:20	2011-08-09 02:33:20	user	t	2011-08-24 02:33:20	87dc1e131a1369fdf8f1c824a6a62dff
789	user789	user789@user.com	\N	2011-07-09 01:32:20	2011-08-08 01:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
790	user790	user790@user.com	\N	2011-07-08 00:31:20	\N	user	t	2011-08-22 00:31:20	87dc1e131a1369fdf8f1c824a6a62dff
791	user791	user791@user.com	\N	2011-07-06 23:30:20	2011-08-05 23:30:20	user	t	2011-08-20 23:30:20	87dc1e131a1369fdf8f1c824a6a62dff
792	user792	user792@user.com	\N	2011-07-05 22:29:20	2011-08-04 22:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
793	user793	user793@user.com	\N	2011-07-04 21:28:20	2011-08-03 21:28:20	user	t	2011-08-18 21:28:20	87dc1e131a1369fdf8f1c824a6a62dff
794	user794	user794@user.com	\N	2011-07-03 20:27:20	2011-08-02 20:27:20	user	t	2011-08-17 20:27:20	87dc1e131a1369fdf8f1c824a6a62dff
795	user795	user795@user.com	\N	2011-07-02 19:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
796	user796	user796@user.com	\N	2011-07-01 18:25:20	2011-07-31 18:25:20	user	t	2011-08-15 18:25:20	87dc1e131a1369fdf8f1c824a6a62dff
797	user797	user797@user.com	\N	2011-06-30 17:24:20	2011-07-30 17:24:20	user	t	2011-08-14 17:24:20	87dc1e131a1369fdf8f1c824a6a62dff
798	user798	user798@user.com	\N	2011-06-29 16:23:20	2011-07-29 16:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
799	user799	user799@user.com	\N	2011-06-28 15:22:20	2011-07-28 15:22:20	user	t	2011-08-12 15:22:20	87dc1e131a1369fdf8f1c824a6a62dff
800	user800	user800@user.com	\N	2011-06-27 14:21:20	\N	user	t	2011-08-11 14:21:20	87dc1e131a1369fdf8f1c824a6a62dff
801	user801	user801@user.com	\N	2011-06-26 13:20:20	2011-07-26 13:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
802	user802	user802@user.com	\N	2011-06-25 12:19:20	2011-07-25 12:19:20	user	t	2011-08-09 12:19:20	87dc1e131a1369fdf8f1c824a6a62dff
803	user803	user803@user.com	\N	2011-06-24 11:18:20	2011-07-24 11:18:20	user	t	2011-08-08 11:18:20	87dc1e131a1369fdf8f1c824a6a62dff
804	user804	user804@user.com	\N	2011-06-23 10:17:20	2011-07-23 10:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
805	user805	user805@user.com	\N	2011-06-22 09:16:20	\N	user	t	2011-08-06 09:16:20	87dc1e131a1369fdf8f1c824a6a62dff
806	user806	user806@user.com	\N	2011-06-21 08:15:20	2011-07-21 08:15:20	user	t	2011-08-05 08:15:20	87dc1e131a1369fdf8f1c824a6a62dff
807	user807	user807@user.com	\N	2011-06-20 07:14:20	2011-07-20 07:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
808	user808	user808@user.com	\N	2011-06-19 06:13:20	2011-07-19 06:13:20	user	t	2011-08-03 06:13:20	87dc1e131a1369fdf8f1c824a6a62dff
809	user809	user809@user.com	\N	2011-06-18 05:12:20	2011-07-18 05:12:20	user	t	2011-08-02 05:12:20	87dc1e131a1369fdf8f1c824a6a62dff
810	user810	user810@user.com	\N	2011-06-17 04:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
811	user811	user811@user.com	\N	2011-06-16 03:10:20	2011-07-16 03:10:20	user	t	2011-07-31 03:10:20	87dc1e131a1369fdf8f1c824a6a62dff
812	user812	user812@user.com	\N	2011-06-15 02:09:20	2011-07-15 02:09:20	user	t	2011-07-30 02:09:20	87dc1e131a1369fdf8f1c824a6a62dff
813	user813	user813@user.com	\N	2011-06-14 01:08:20	2011-07-14 01:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
814	user814	user814@user.com	\N	2011-06-13 00:07:20	2011-07-13 00:07:20	user	t	2011-07-28 00:07:20	87dc1e131a1369fdf8f1c824a6a62dff
815	user815	user815@user.com	\N	2011-06-11 23:06:20	\N	user	t	2011-07-26 23:06:20	87dc1e131a1369fdf8f1c824a6a62dff
816	user816	user816@user.com	\N	2011-06-10 22:05:20	2011-07-10 22:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
817	user817	user817@user.com	\N	2011-06-09 21:04:20	2011-07-09 21:04:20	user	t	2011-07-24 21:04:20	87dc1e131a1369fdf8f1c824a6a62dff
818	user818	user818@user.com	\N	2011-06-08 20:03:20	2011-07-08 20:03:20	user	t	2011-07-23 20:03:20	87dc1e131a1369fdf8f1c824a6a62dff
819	user819	user819@user.com	\N	2011-06-07 19:02:20	2011-07-07 19:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
820	user820	user820@user.com	\N	2011-06-06 18:01:20	\N	user	t	2011-07-21 18:01:20	87dc1e131a1369fdf8f1c824a6a62dff
821	user821	user821@user.com	\N	2011-06-05 17:00:20	2011-07-05 17:00:20	user	t	2011-07-20 17:00:20	87dc1e131a1369fdf8f1c824a6a62dff
822	user822	user822@user.com	\N	2011-06-04 15:59:20	2011-07-04 15:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
823	user823	user823@user.com	\N	2011-06-03 14:58:20	2011-07-03 14:58:20	user	t	2011-07-18 14:58:20	87dc1e131a1369fdf8f1c824a6a62dff
824	user824	user824@user.com	\N	2011-06-02 13:57:20	2011-07-02 13:57:20	user	t	2011-07-17 13:57:20	87dc1e131a1369fdf8f1c824a6a62dff
825	user825	user825@user.com	\N	2011-06-01 12:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
826	user826	user826@user.com	\N	2011-05-31 11:55:20	2011-06-30 11:55:20	user	t	2011-07-15 11:55:20	87dc1e131a1369fdf8f1c824a6a62dff
827	user827	user827@user.com	\N	2011-05-30 10:54:20	2011-06-29 10:54:20	user	t	2011-07-14 10:54:20	87dc1e131a1369fdf8f1c824a6a62dff
828	user828	user828@user.com	\N	2011-05-29 09:53:20	2011-06-28 09:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
829	user829	user829@user.com	\N	2011-05-28 08:52:20	2011-06-27 08:52:20	user	t	2011-07-12 08:52:20	87dc1e131a1369fdf8f1c824a6a62dff
830	user830	user830@user.com	\N	2011-05-27 07:51:20	\N	user	t	2011-07-11 07:51:20	87dc1e131a1369fdf8f1c824a6a62dff
831	user831	user831@user.com	\N	2011-05-26 06:50:20	2011-06-25 06:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
832	user832	user832@user.com	\N	2011-05-25 05:49:20	2011-06-24 05:49:20	user	t	2011-07-09 05:49:20	87dc1e131a1369fdf8f1c824a6a62dff
833	user833	user833@user.com	\N	2011-05-24 04:48:20	2011-06-23 04:48:20	user	t	2011-07-08 04:48:20	87dc1e131a1369fdf8f1c824a6a62dff
834	user834	user834@user.com	\N	2011-05-23 03:47:20	2011-06-22 03:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
835	user835	user835@user.com	\N	2011-05-22 02:46:20	\N	user	t	2011-07-06 02:46:20	87dc1e131a1369fdf8f1c824a6a62dff
836	user836	user836@user.com	\N	2011-05-21 01:45:20	2011-06-20 01:45:20	user	t	2011-07-05 01:45:20	87dc1e131a1369fdf8f1c824a6a62dff
837	user837	user837@user.com	\N	2011-05-20 00:44:20	2011-06-19 00:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
838	user838	user838@user.com	\N	2011-05-18 23:43:20	2011-06-17 23:43:20	user	t	2011-07-02 23:43:20	87dc1e131a1369fdf8f1c824a6a62dff
839	user839	user839@user.com	\N	2011-05-17 22:42:20	2011-06-16 22:42:20	user	t	2011-07-01 22:42:20	87dc1e131a1369fdf8f1c824a6a62dff
840	user840	user840@user.com	\N	2011-05-16 21:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
841	user841	user841@user.com	\N	2011-05-15 20:40:20	2011-06-14 20:40:20	user	t	2011-06-29 20:40:20	87dc1e131a1369fdf8f1c824a6a62dff
842	user842	user842@user.com	\N	2011-05-14 19:39:20	2011-06-13 19:39:20	user	t	2011-06-28 19:39:20	87dc1e131a1369fdf8f1c824a6a62dff
843	user843	user843@user.com	\N	2011-05-13 18:38:20	2011-06-12 18:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
844	user844	user844@user.com	\N	2011-05-12 17:37:20	2011-06-11 17:37:20	user	t	2011-06-26 17:37:20	87dc1e131a1369fdf8f1c824a6a62dff
845	user845	user845@user.com	\N	2011-05-11 16:36:20	\N	user	t	2011-06-25 16:36:20	87dc1e131a1369fdf8f1c824a6a62dff
846	user846	user846@user.com	\N	2011-05-10 15:35:20	2011-06-09 15:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
847	user847	user847@user.com	\N	2011-05-09 14:34:20	2011-06-08 14:34:20	user	t	2011-06-23 14:34:20	87dc1e131a1369fdf8f1c824a6a62dff
848	user848	user848@user.com	\N	2011-05-08 13:33:20	2011-06-07 13:33:20	user	t	2011-06-22 13:33:20	87dc1e131a1369fdf8f1c824a6a62dff
849	user849	user849@user.com	\N	2011-05-07 12:32:20	2011-06-06 12:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
850	user850	user850@user.com	\N	2011-05-06 11:31:20	\N	user	t	2011-06-20 11:31:20	87dc1e131a1369fdf8f1c824a6a62dff
851	user851	user851@user.com	\N	2011-05-05 10:30:20	2011-06-04 10:30:20	user	t	2011-06-19 10:30:20	87dc1e131a1369fdf8f1c824a6a62dff
852	user852	user852@user.com	\N	2011-05-04 09:29:20	2011-06-03 09:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
853	user853	user853@user.com	\N	2011-05-03 08:28:20	2011-06-02 08:28:20	user	t	2011-06-17 08:28:20	87dc1e131a1369fdf8f1c824a6a62dff
854	user854	user854@user.com	\N	2011-05-02 07:27:20	2011-06-01 07:27:20	user	t	2011-06-16 07:27:20	87dc1e131a1369fdf8f1c824a6a62dff
855	user855	user855@user.com	\N	2011-05-01 06:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
856	user856	user856@user.com	\N	2011-04-30 05:25:20	2011-05-30 05:25:20	user	t	2011-06-14 05:25:20	87dc1e131a1369fdf8f1c824a6a62dff
857	user857	user857@user.com	\N	2011-04-29 04:24:20	2011-05-29 04:24:20	user	t	2011-06-13 04:24:20	87dc1e131a1369fdf8f1c824a6a62dff
858	user858	user858@user.com	\N	2011-04-28 03:23:20	2011-05-28 03:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
859	user859	user859@user.com	\N	2011-04-27 02:22:20	2011-05-27 02:22:20	user	t	2011-06-11 02:22:20	87dc1e131a1369fdf8f1c824a6a62dff
860	user860	user860@user.com	\N	2011-04-26 01:21:20	\N	user	t	2011-06-10 01:21:20	87dc1e131a1369fdf8f1c824a6a62dff
861	user861	user861@user.com	\N	2011-04-25 00:20:20	2011-05-25 00:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
862	user862	user862@user.com	\N	2011-04-23 23:19:20	2011-05-23 23:19:20	user	t	2011-06-07 23:19:20	87dc1e131a1369fdf8f1c824a6a62dff
863	user863	user863@user.com	\N	2011-04-22 22:18:20	2011-05-22 22:18:20	user	t	2011-06-06 22:18:20	87dc1e131a1369fdf8f1c824a6a62dff
864	user864	user864@user.com	\N	2011-04-21 21:17:20	2011-05-21 21:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
865	user865	user865@user.com	\N	2011-04-20 20:16:20	\N	user	t	2011-06-04 20:16:20	87dc1e131a1369fdf8f1c824a6a62dff
866	user866	user866@user.com	\N	2011-04-19 19:15:20	2011-05-19 19:15:20	user	t	2011-06-03 19:15:20	87dc1e131a1369fdf8f1c824a6a62dff
867	user867	user867@user.com	\N	2011-04-18 18:14:20	2011-05-18 18:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
868	user868	user868@user.com	\N	2011-04-17 17:13:20	2011-05-17 17:13:20	user	t	2011-06-01 17:13:20	87dc1e131a1369fdf8f1c824a6a62dff
869	user869	user869@user.com	\N	2011-04-16 16:12:20	2011-05-16 16:12:20	user	t	2011-05-31 16:12:20	87dc1e131a1369fdf8f1c824a6a62dff
870	user870	user870@user.com	\N	2011-04-15 15:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
871	user871	user871@user.com	\N	2011-04-14 14:10:20	2011-05-14 14:10:20	user	t	2011-05-29 14:10:20	87dc1e131a1369fdf8f1c824a6a62dff
872	user872	user872@user.com	\N	2011-04-13 13:09:20	2011-05-13 13:09:20	user	t	2011-05-28 13:09:20	87dc1e131a1369fdf8f1c824a6a62dff
873	user873	user873@user.com	\N	2011-04-12 12:08:20	2011-05-12 12:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
874	user874	user874@user.com	\N	2011-04-11 11:07:20	2011-05-11 11:07:20	user	t	2011-05-26 11:07:20	87dc1e131a1369fdf8f1c824a6a62dff
875	user875	user875@user.com	\N	2011-04-10 10:06:20	\N	user	t	2011-05-25 10:06:20	87dc1e131a1369fdf8f1c824a6a62dff
876	user876	user876@user.com	\N	2011-04-09 09:05:20	2011-05-09 09:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
877	user877	user877@user.com	\N	2011-04-08 08:04:20	2011-05-08 08:04:20	user	t	2011-05-23 08:04:20	87dc1e131a1369fdf8f1c824a6a62dff
878	user878	user878@user.com	\N	2011-04-07 07:03:20	2011-05-07 07:03:20	user	t	2011-05-22 07:03:20	87dc1e131a1369fdf8f1c824a6a62dff
879	user879	user879@user.com	\N	2011-04-06 06:02:20	2011-05-06 06:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
880	user880	user880@user.com	\N	2011-04-05 05:01:20	\N	user	t	2011-05-20 05:01:20	87dc1e131a1369fdf8f1c824a6a62dff
881	user881	user881@user.com	\N	2011-04-04 04:00:20	2011-05-04 04:00:20	user	t	2011-05-19 04:00:20	87dc1e131a1369fdf8f1c824a6a62dff
882	user882	user882@user.com	\N	2011-04-03 02:59:20	2011-05-03 02:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
883	user883	user883@user.com	\N	2011-04-02 01:58:20	2011-05-02 01:58:20	user	t	2011-05-17 01:58:20	87dc1e131a1369fdf8f1c824a6a62dff
884	user884	user884@user.com	\N	2011-04-01 00:57:20	2011-05-01 00:57:20	user	t	2011-05-16 00:57:20	87dc1e131a1369fdf8f1c824a6a62dff
885	user885	user885@user.com	\N	2011-03-30 23:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
886	user886	user886@user.com	\N	2011-03-29 22:55:20	2011-04-28 22:55:20	user	t	2011-05-13 22:55:20	87dc1e131a1369fdf8f1c824a6a62dff
887	user887	user887@user.com	\N	2011-03-28 21:54:20	2011-04-27 21:54:20	user	t	2011-05-12 21:54:20	87dc1e131a1369fdf8f1c824a6a62dff
888	user888	user888@user.com	\N	2011-03-27 20:53:20	2011-04-26 20:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
889	user889	user889@user.com	\N	2011-03-26 19:52:20	2011-04-25 19:52:20	user	t	2011-05-10 19:52:20	87dc1e131a1369fdf8f1c824a6a62dff
890	user890	user890@user.com	\N	2011-03-25 18:51:20	\N	user	t	2011-05-09 18:51:20	87dc1e131a1369fdf8f1c824a6a62dff
891	user891	user891@user.com	\N	2011-03-24 17:50:20	2011-04-23 17:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
892	user892	user892@user.com	\N	2011-03-23 16:49:20	2011-04-22 16:49:20	user	t	2011-05-07 16:49:20	87dc1e131a1369fdf8f1c824a6a62dff
893	user893	user893@user.com	\N	2011-03-22 15:48:20	2011-04-21 15:48:20	user	t	2011-05-06 15:48:20	87dc1e131a1369fdf8f1c824a6a62dff
894	user894	user894@user.com	\N	2011-03-21 14:47:20	2011-04-20 14:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
895	user895	user895@user.com	\N	2011-03-20 13:46:20	\N	user	t	2011-05-04 13:46:20	87dc1e131a1369fdf8f1c824a6a62dff
896	user896	user896@user.com	\N	2011-03-19 12:45:20	2011-04-18 12:45:20	user	t	2011-05-03 12:45:20	87dc1e131a1369fdf8f1c824a6a62dff
897	user897	user897@user.com	\N	2011-03-18 11:44:20	2011-04-17 11:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
898	user898	user898@user.com	\N	2011-03-17 10:43:20	2011-04-16 10:43:20	user	t	2011-05-01 10:43:20	87dc1e131a1369fdf8f1c824a6a62dff
899	user899	user899@user.com	\N	2011-03-16 09:42:20	2011-04-15 09:42:20	user	t	2011-04-30 09:42:20	87dc1e131a1369fdf8f1c824a6a62dff
900	user900	user900@user.com	\N	2011-03-15 08:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
901	user901	user901@user.com	\N	2011-03-14 07:40:20	2011-04-13 07:40:20	user	t	2011-04-28 07:40:20	87dc1e131a1369fdf8f1c824a6a62dff
902	user902	user902@user.com	\N	2011-03-13 06:39:20	2011-04-12 06:39:20	user	t	2011-04-27 06:39:20	87dc1e131a1369fdf8f1c824a6a62dff
903	user903	user903@user.com	\N	2011-03-12 05:38:20	2011-04-11 05:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
904	user904	user904@user.com	\N	2011-03-11 04:37:20	2011-04-10 04:37:20	user	t	2011-04-25 04:37:20	87dc1e131a1369fdf8f1c824a6a62dff
905	user905	user905@user.com	\N	2011-03-10 03:36:20	\N	user	t	2011-04-24 03:36:20	87dc1e131a1369fdf8f1c824a6a62dff
906	user906	user906@user.com	\N	2011-03-09 02:35:20	2011-04-08 02:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
907	user907	user907@user.com	\N	2011-03-08 01:34:20	2011-04-07 01:34:20	user	t	2011-04-22 01:34:20	87dc1e131a1369fdf8f1c824a6a62dff
908	user908	user908@user.com	\N	2011-03-07 00:33:20	2011-04-06 00:33:20	user	t	2011-04-21 00:33:20	87dc1e131a1369fdf8f1c824a6a62dff
909	user909	user909@user.com	\N	2011-03-05 23:32:20	2011-04-04 23:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
910	user910	user910@user.com	\N	2011-03-04 22:31:20	\N	user	t	2011-04-18 22:31:20	87dc1e131a1369fdf8f1c824a6a62dff
911	user911	user911@user.com	\N	2011-03-03 21:30:20	2011-04-02 21:30:20	user	t	2011-04-17 21:30:20	87dc1e131a1369fdf8f1c824a6a62dff
912	user912	user912@user.com	\N	2011-03-02 20:29:20	2011-04-01 20:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
913	user913	user913@user.com	\N	2011-03-01 19:28:20	2011-03-31 19:28:20	user	t	2011-04-15 19:28:20	87dc1e131a1369fdf8f1c824a6a62dff
914	user914	user914@user.com	\N	2011-02-28 18:27:20	2011-03-30 18:27:20	user	t	2011-04-14 18:27:20	87dc1e131a1369fdf8f1c824a6a62dff
915	user915	user915@user.com	\N	2011-02-27 17:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
916	user916	user916@user.com	\N	2011-02-26 16:25:20	2011-03-28 16:25:20	user	t	2011-04-12 16:25:20	87dc1e131a1369fdf8f1c824a6a62dff
917	user917	user917@user.com	\N	2011-02-25 15:24:20	2011-03-27 15:24:20	user	t	2011-04-11 15:24:20	87dc1e131a1369fdf8f1c824a6a62dff
918	user918	user918@user.com	\N	2011-02-24 14:23:20	2011-03-26 14:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
919	user919	user919@user.com	\N	2011-02-23 13:22:20	2011-03-25 13:22:20	user	t	2011-04-09 13:22:20	87dc1e131a1369fdf8f1c824a6a62dff
920	user920	user920@user.com	\N	2011-02-22 12:21:20	\N	user	t	2011-04-08 12:21:20	87dc1e131a1369fdf8f1c824a6a62dff
921	user921	user921@user.com	\N	2011-02-21 11:20:20	2011-03-23 11:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
922	user922	user922@user.com	\N	2011-02-20 10:19:20	2011-03-22 10:19:20	user	t	2011-04-06 10:19:20	87dc1e131a1369fdf8f1c824a6a62dff
923	user923	user923@user.com	\N	2011-02-19 09:18:20	2011-03-21 09:18:20	user	t	2011-04-05 09:18:20	87dc1e131a1369fdf8f1c824a6a62dff
924	user924	user924@user.com	\N	2011-02-18 08:17:20	2011-03-20 08:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
925	user925	user925@user.com	\N	2011-02-17 07:16:20	\N	user	t	2011-04-03 07:16:20	87dc1e131a1369fdf8f1c824a6a62dff
926	user926	user926@user.com	\N	2011-02-16 06:15:20	2011-03-18 06:15:20	user	t	2011-04-02 06:15:20	87dc1e131a1369fdf8f1c824a6a62dff
927	user927	user927@user.com	\N	2011-02-15 05:14:20	2011-03-17 05:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
928	user928	user928@user.com	\N	2011-02-14 04:13:20	2011-03-16 04:13:20	user	t	2011-03-31 04:13:20	87dc1e131a1369fdf8f1c824a6a62dff
929	user929	user929@user.com	\N	2011-02-13 03:12:20	2011-03-15 03:12:20	user	t	2011-03-30 03:12:20	87dc1e131a1369fdf8f1c824a6a62dff
930	user930	user930@user.com	\N	2011-02-12 02:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
931	user931	user931@user.com	\N	2011-02-11 01:10:20	2011-03-13 01:10:20	user	t	2011-03-28 01:10:20	87dc1e131a1369fdf8f1c824a6a62dff
932	user932	user932@user.com	\N	2011-02-10 00:09:20	2011-03-12 00:09:20	user	t	2011-03-27 00:09:20	87dc1e131a1369fdf8f1c824a6a62dff
933	user933	user933@user.com	\N	2011-02-08 23:08:20	2011-03-10 23:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
934	user934	user934@user.com	\N	2011-02-07 22:07:20	2011-03-09 22:07:20	user	t	2011-03-24 22:07:20	87dc1e131a1369fdf8f1c824a6a62dff
935	user935	user935@user.com	\N	2011-02-06 21:06:20	\N	user	t	2011-03-23 21:06:20	87dc1e131a1369fdf8f1c824a6a62dff
936	user936	user936@user.com	\N	2011-02-05 20:05:20	2011-03-07 20:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
937	user937	user937@user.com	\N	2011-02-04 19:04:20	2011-03-06 19:04:20	user	t	2011-03-21 19:04:20	87dc1e131a1369fdf8f1c824a6a62dff
938	user938	user938@user.com	\N	2011-02-03 18:03:20	2011-03-05 18:03:20	user	t	2011-03-20 18:03:20	87dc1e131a1369fdf8f1c824a6a62dff
939	user939	user939@user.com	\N	2011-02-02 17:02:20	2011-03-04 17:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
940	user940	user940@user.com	\N	2011-02-01 16:01:20	\N	user	t	2011-03-18 16:01:20	87dc1e131a1369fdf8f1c824a6a62dff
941	user941	user941@user.com	\N	2011-01-31 15:00:20	2011-03-02 15:00:20	user	t	2011-03-17 15:00:20	87dc1e131a1369fdf8f1c824a6a62dff
942	user942	user942@user.com	\N	2011-01-30 13:59:20	2011-03-01 13:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
943	user943	user943@user.com	\N	2011-01-29 12:58:20	2011-02-28 12:58:20	user	t	2011-03-15 12:58:20	87dc1e131a1369fdf8f1c824a6a62dff
944	user944	user944@user.com	\N	2011-01-28 11:57:20	2011-02-27 11:57:20	user	t	2011-03-14 11:57:20	87dc1e131a1369fdf8f1c824a6a62dff
945	user945	user945@user.com	\N	2011-01-27 10:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
946	user946	user946@user.com	\N	2011-01-26 09:55:20	2011-02-25 09:55:20	user	t	2011-03-12 09:55:20	87dc1e131a1369fdf8f1c824a6a62dff
947	user947	user947@user.com	\N	2011-01-25 08:54:20	2011-02-24 08:54:20	user	t	2011-03-11 08:54:20	87dc1e131a1369fdf8f1c824a6a62dff
948	user948	user948@user.com	\N	2011-01-24 07:53:20	2011-02-23 07:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
949	user949	user949@user.com	\N	2011-01-23 06:52:20	2011-02-22 06:52:20	user	t	2011-03-09 06:52:20	87dc1e131a1369fdf8f1c824a6a62dff
950	user950	user950@user.com	\N	2011-01-22 05:51:20	\N	user	t	2011-03-08 05:51:20	87dc1e131a1369fdf8f1c824a6a62dff
951	user951	user951@user.com	\N	2011-01-21 04:50:20	2011-02-20 04:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
952	user952	user952@user.com	\N	2011-01-20 03:49:20	2011-02-19 03:49:20	user	t	2011-03-06 03:49:20	87dc1e131a1369fdf8f1c824a6a62dff
953	user953	user953@user.com	\N	2011-01-19 02:48:20	2011-02-18 02:48:20	user	t	2011-03-05 02:48:20	87dc1e131a1369fdf8f1c824a6a62dff
954	user954	user954@user.com	\N	2011-01-18 01:47:20	2011-02-17 01:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
955	user955	user955@user.com	\N	2011-01-17 00:46:20	\N	user	t	2011-03-03 00:46:20	87dc1e131a1369fdf8f1c824a6a62dff
956	user956	user956@user.com	\N	2011-01-15 23:45:20	2011-02-14 23:45:20	user	t	2011-03-01 23:45:20	87dc1e131a1369fdf8f1c824a6a62dff
957	user957	user957@user.com	\N	2011-01-14 22:44:20	2011-02-13 22:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
958	user958	user958@user.com	\N	2011-01-13 21:43:20	2011-02-12 21:43:20	user	t	2011-02-27 21:43:20	87dc1e131a1369fdf8f1c824a6a62dff
959	user959	user959@user.com	\N	2011-01-12 20:42:20	2011-02-11 20:42:20	user	t	2011-02-26 20:42:20	87dc1e131a1369fdf8f1c824a6a62dff
960	user960	user960@user.com	\N	2011-01-11 19:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
961	user961	user961@user.com	\N	2011-01-10 18:40:20	2011-02-09 18:40:20	user	t	2011-02-24 18:40:20	87dc1e131a1369fdf8f1c824a6a62dff
962	user962	user962@user.com	\N	2011-01-09 17:39:20	2011-02-08 17:39:20	user	t	2011-02-23 17:39:20	87dc1e131a1369fdf8f1c824a6a62dff
963	user963	user963@user.com	\N	2011-01-08 16:38:20	2011-02-07 16:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
964	user964	user964@user.com	\N	2011-01-07 15:37:20	2011-02-06 15:37:20	user	t	2011-02-21 15:37:20	87dc1e131a1369fdf8f1c824a6a62dff
965	user965	user965@user.com	\N	2011-01-06 14:36:20	\N	user	t	2011-02-20 14:36:20	87dc1e131a1369fdf8f1c824a6a62dff
966	user966	user966@user.com	\N	2011-01-05 13:35:20	2011-02-04 13:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
967	user967	user967@user.com	\N	2011-01-04 12:34:20	2011-02-03 12:34:20	user	t	2011-02-18 12:34:20	87dc1e131a1369fdf8f1c824a6a62dff
968	user968	user968@user.com	\N	2011-01-03 11:33:20	2011-02-02 11:33:20	user	t	2011-02-17 11:33:20	87dc1e131a1369fdf8f1c824a6a62dff
969	user969	user969@user.com	\N	2011-01-02 10:32:20	2011-02-01 10:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
970	user970	user970@user.com	\N	2011-01-01 09:31:20	\N	user	t	2011-02-15 09:31:20	87dc1e131a1369fdf8f1c824a6a62dff
971	user971	user971@user.com	\N	2010-12-31 08:30:20	2011-01-30 08:30:20	user	t	2011-02-14 08:30:20	87dc1e131a1369fdf8f1c824a6a62dff
972	user972	user972@user.com	\N	2010-12-30 07:29:20	2011-01-29 07:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
973	user973	user973@user.com	\N	2010-12-29 06:28:20	2011-01-28 06:28:20	user	t	2011-02-12 06:28:20	87dc1e131a1369fdf8f1c824a6a62dff
974	user974	user974@user.com	\N	2010-12-28 05:27:20	2011-01-27 05:27:20	user	t	2011-02-11 05:27:20	87dc1e131a1369fdf8f1c824a6a62dff
975	user975	user975@user.com	\N	2010-12-27 04:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
976	user976	user976@user.com	\N	2010-12-26 03:25:20	2011-01-25 03:25:20	user	t	2011-02-09 03:25:20	87dc1e131a1369fdf8f1c824a6a62dff
977	user977	user977@user.com	\N	2010-12-25 02:24:20	2011-01-24 02:24:20	user	t	2011-02-08 02:24:20	87dc1e131a1369fdf8f1c824a6a62dff
978	user978	user978@user.com	\N	2010-12-24 01:23:20	2011-01-23 01:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
979	user979	user979@user.com	\N	2010-12-23 00:22:20	2011-01-22 00:22:20	user	t	2011-02-06 00:22:20	87dc1e131a1369fdf8f1c824a6a62dff
980	user980	user980@user.com	\N	2010-12-21 23:21:20	\N	user	t	2011-02-04 23:21:20	87dc1e131a1369fdf8f1c824a6a62dff
981	user981	user981@user.com	\N	2010-12-20 22:20:20	2011-01-19 22:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
982	user982	user982@user.com	\N	2010-12-19 21:19:20	2011-01-18 21:19:20	user	t	2011-02-02 21:19:20	87dc1e131a1369fdf8f1c824a6a62dff
983	user983	user983@user.com	\N	2010-12-18 20:18:20	2011-01-17 20:18:20	user	t	2011-02-01 20:18:20	87dc1e131a1369fdf8f1c824a6a62dff
984	user984	user984@user.com	\N	2010-12-17 19:17:20	2011-01-16 19:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
985	user985	user985@user.com	\N	2010-12-16 18:16:20	\N	user	t	2011-01-30 18:16:20	87dc1e131a1369fdf8f1c824a6a62dff
986	user986	user986@user.com	\N	2010-12-15 17:15:20	2011-01-14 17:15:20	user	t	2011-01-29 17:15:20	87dc1e131a1369fdf8f1c824a6a62dff
987	user987	user987@user.com	\N	2010-12-14 16:14:20	2011-01-13 16:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
988	user988	user988@user.com	\N	2010-12-13 15:13:20	2011-01-12 15:13:20	user	t	2011-01-27 15:13:20	87dc1e131a1369fdf8f1c824a6a62dff
989	user989	user989@user.com	\N	2010-12-12 14:12:20	2011-01-11 14:12:20	user	t	2011-01-26 14:12:20	87dc1e131a1369fdf8f1c824a6a62dff
990	user990	user990@user.com	\N	2010-12-11 13:11:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
991	user991	user991@user.com	\N	2010-12-10 12:10:20	2011-01-09 12:10:20	user	t	2011-01-24 12:10:20	87dc1e131a1369fdf8f1c824a6a62dff
992	user992	user992@user.com	\N	2010-12-09 11:09:20	2011-01-08 11:09:20	user	t	2011-01-23 11:09:20	87dc1e131a1369fdf8f1c824a6a62dff
993	user993	user993@user.com	\N	2010-12-08 10:08:20	2011-01-07 10:08:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
994	user994	user994@user.com	\N	2010-12-07 09:07:20	2011-01-06 09:07:20	user	t	2011-01-21 09:07:20	87dc1e131a1369fdf8f1c824a6a62dff
995	user995	user995@user.com	\N	2010-12-06 08:06:20	\N	user	t	2011-01-20 08:06:20	87dc1e131a1369fdf8f1c824a6a62dff
996	user996	user996@user.com	\N	2010-12-05 07:05:20	2011-01-04 07:05:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
997	user997	user997@user.com	\N	2010-12-04 06:04:20	2011-01-03 06:04:20	user	t	2011-01-18 06:04:20	87dc1e131a1369fdf8f1c824a6a62dff
998	user998	user998@user.com	\N	2010-12-03 05:03:20	2011-01-02 05:03:20	user	t	2011-01-17 05:03:20	87dc1e131a1369fdf8f1c824a6a62dff
999	user999	user999@user.com	\N	2010-12-02 04:02:20	2011-01-01 04:02:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1000	user1000	user1000@user.com	\N	2010-12-01 03:01:20	\N	user	t	2011-01-15 03:01:20	87dc1e131a1369fdf8f1c824a6a62dff
1001	user1001	user1001@user.com	\N	2010-11-30 02:00:20	2010-12-30 02:00:20	user	t	2011-01-14 02:00:20	87dc1e131a1369fdf8f1c824a6a62dff
1002	user1002	user1002@user.com	\N	2010-11-29 00:59:20	2010-12-29 00:59:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1003	user1003	user1003@user.com	\N	2010-11-27 23:58:20	2010-12-27 23:58:20	user	t	2011-01-11 23:58:20	87dc1e131a1369fdf8f1c824a6a62dff
1004	user1004	user1004@user.com	\N	2010-11-26 22:57:20	2010-12-26 22:57:20	user	t	2011-01-10 22:57:20	87dc1e131a1369fdf8f1c824a6a62dff
1005	user1005	user1005@user.com	\N	2010-11-25 21:56:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1006	user1006	user1006@user.com	\N	2010-11-24 20:55:20	2010-12-24 20:55:20	user	t	2011-01-08 20:55:20	87dc1e131a1369fdf8f1c824a6a62dff
1007	user1007	user1007@user.com	\N	2010-11-23 19:54:20	2010-12-23 19:54:20	user	t	2011-01-07 19:54:20	87dc1e131a1369fdf8f1c824a6a62dff
1008	user1008	user1008@user.com	\N	2010-11-22 18:53:20	2010-12-22 18:53:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1009	user1009	user1009@user.com	\N	2010-11-21 17:52:20	2010-12-21 17:52:20	user	t	2011-01-05 17:52:20	87dc1e131a1369fdf8f1c824a6a62dff
1010	user1010	user1010@user.com	\N	2010-11-20 16:51:20	\N	user	t	2011-01-04 16:51:20	87dc1e131a1369fdf8f1c824a6a62dff
1011	user1011	user1011@user.com	\N	2010-11-19 15:50:20	2010-12-19 15:50:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1012	user1012	user1012@user.com	\N	2010-11-18 14:49:20	2010-12-18 14:49:20	user	t	2011-01-02 14:49:20	87dc1e131a1369fdf8f1c824a6a62dff
1013	user1013	user1013@user.com	\N	2010-11-17 13:48:20	2010-12-17 13:48:20	user	t	2011-01-01 13:48:20	87dc1e131a1369fdf8f1c824a6a62dff
1014	user1014	user1014@user.com	\N	2010-11-16 12:47:20	2010-12-16 12:47:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1015	user1015	user1015@user.com	\N	2010-11-15 11:46:20	\N	user	t	2010-12-30 11:46:20	87dc1e131a1369fdf8f1c824a6a62dff
1016	user1016	user1016@user.com	\N	2010-11-14 10:45:20	2010-12-14 10:45:20	user	t	2010-12-29 10:45:20	87dc1e131a1369fdf8f1c824a6a62dff
1017	user1017	user1017@user.com	\N	2010-11-13 09:44:20	2010-12-13 09:44:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1018	user1018	user1018@user.com	\N	2010-11-12 08:43:20	2010-12-12 08:43:20	user	t	2010-12-27 08:43:20	87dc1e131a1369fdf8f1c824a6a62dff
1019	user1019	user1019@user.com	\N	2010-11-11 07:42:20	2010-12-11 07:42:20	user	t	2010-12-26 07:42:20	87dc1e131a1369fdf8f1c824a6a62dff
1020	user1020	user1020@user.com	\N	2010-11-10 06:41:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1021	user1021	user1021@user.com	\N	2010-11-09 05:40:20	2010-12-09 05:40:20	user	t	2010-12-24 05:40:20	87dc1e131a1369fdf8f1c824a6a62dff
1022	user1022	user1022@user.com	\N	2010-11-08 04:39:20	2010-12-08 04:39:20	user	t	2010-12-23 04:39:20	87dc1e131a1369fdf8f1c824a6a62dff
1023	user1023	user1023@user.com	\N	2010-11-07 03:38:20	2010-12-07 03:38:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1024	user1024	user1024@user.com	\N	2010-11-06 02:37:20	2010-12-06 02:37:20	user	t	2010-12-21 02:37:20	87dc1e131a1369fdf8f1c824a6a62dff
1025	user1025	user1025@user.com	\N	2010-11-05 01:36:20	\N	user	t	2010-12-20 01:36:20	87dc1e131a1369fdf8f1c824a6a62dff
1026	user1026	user1026@user.com	\N	2010-11-04 00:35:20	2010-12-04 00:35:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1027	user1027	user1027@user.com	\N	2010-11-02 23:34:20	2010-12-02 23:34:20	user	t	2010-12-17 23:34:20	87dc1e131a1369fdf8f1c824a6a62dff
1028	user1028	user1028@user.com	\N	2010-11-01 22:33:20	2010-12-01 22:33:20	user	t	2010-12-16 22:33:20	87dc1e131a1369fdf8f1c824a6a62dff
1029	user1029	user1029@user.com	\N	2010-10-31 21:32:20	2010-11-30 21:32:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1030	user1030	user1030@user.com	\N	2010-10-30 20:31:20	\N	user	t	2010-12-14 20:31:20	87dc1e131a1369fdf8f1c824a6a62dff
1031	user1031	user1031@user.com	\N	2010-10-29 19:30:20	2010-11-28 19:30:20	user	t	2010-12-13 19:30:20	87dc1e131a1369fdf8f1c824a6a62dff
1032	user1032	user1032@user.com	\N	2010-10-28 18:29:20	2010-11-27 18:29:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1033	user1033	user1033@user.com	\N	2010-10-27 17:28:20	2010-11-26 17:28:20	user	t	2010-12-11 17:28:20	87dc1e131a1369fdf8f1c824a6a62dff
1034	user1034	user1034@user.com	\N	2010-10-26 16:27:20	2010-11-25 16:27:20	user	t	2010-12-10 16:27:20	87dc1e131a1369fdf8f1c824a6a62dff
1035	user1035	user1035@user.com	\N	2010-10-25 15:26:20	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1036	user1036	user1036@user.com	\N	2010-10-24 14:25:20	2010-11-23 14:25:20	user	t	2010-12-08 14:25:20	87dc1e131a1369fdf8f1c824a6a62dff
1037	user1037	user1037@user.com	\N	2010-10-23 13:24:20	2010-11-22 13:24:20	user	t	2010-12-07 13:24:20	87dc1e131a1369fdf8f1c824a6a62dff
1038	user1038	user1038@user.com	\N	2010-10-22 12:23:20	2010-11-21 12:23:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1039	user1039	user1039@user.com	\N	2010-10-21 11:22:20	2010-11-20 11:22:20	user	t	2010-12-05 11:22:20	87dc1e131a1369fdf8f1c824a6a62dff
1040	user1040	user1040@user.com	\N	2010-10-20 10:21:20	\N	user	t	2010-12-04 10:21:20	87dc1e131a1369fdf8f1c824a6a62dff
1041	user1041	user1041@user.com	\N	2010-10-19 09:20:20	2010-11-18 09:20:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1042	user1042	user1042@user.com	\N	2010-10-18 08:19:20	2010-11-17 08:19:20	user	t	2010-12-02 08:19:20	87dc1e131a1369fdf8f1c824a6a62dff
1043	user1043	user1043@user.com	\N	2010-10-17 07:18:20	2010-11-16 07:18:20	user	t	2010-12-01 07:18:20	87dc1e131a1369fdf8f1c824a6a62dff
1044	user1044	user1044@user.com	\N	2010-10-16 06:17:20	2010-11-15 06:17:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1045	user1045	user1045@user.com	\N	2010-10-15 05:16:20	\N	user	t	2010-11-29 05:16:20	87dc1e131a1369fdf8f1c824a6a62dff
1046	user1046	user1046@user.com	\N	2010-10-14 04:15:20	2010-11-13 04:15:20	user	t	2010-11-28 04:15:20	87dc1e131a1369fdf8f1c824a6a62dff
1047	user1047	user1047@user.com	\N	2010-10-13 03:14:20	2010-11-12 03:14:20	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
1048	user1048	user1048@user.com	\N	2010-10-12 02:13:20	2010-11-11 02:13:20	user	t	2010-11-26 02:13:20	87dc1e131a1369fdf8f1c824a6a62dff
1049	user1049	user1049@user.com	\N	2010-10-11 01:12:20	2010-11-10 01:12:20	user	t	2010-11-25 01:12:20	87dc1e131a1369fdf8f1c824a6a62dff
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_id_seq', 10000, true);


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
-- Name: user_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_place_id_seq', 1915, true);


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
-- Name: user_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_settings_id_seq', 6, true);


--
-- Data for Name: user_social; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_social (id, user_id, social_service, user_social_id, additional_data) FROM stdin;
1	101	twitter	71662685	\N
\.


--
-- Name: user_social_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_social_id_seq', 1, true);


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
-- Name: smtp_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY smtp
    ADD CONSTRAINT smtp_pkey PRIMARY KEY (id);


--
-- Name: user_email_unique; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


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
-- Name: _idx_user_place_cx_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--
CREATE INDEX _idx_user_place_cx_cy ON user_place USING btree (cx, cy);
CREATE INDEX _idx_user_place_cx ON user_place USING btree (cx);
CREATE INDEX _idx_user_place_cy ON user_place USING btree (cy);


--
-- Name: _idx_user_place_cx_p_cy_cx_m_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--
CREATE INDEX _idx_user_place_cx_p_cy_cx_m_cy ON user_place USING btree (cx_p_cy, cx_m_cy);
CREATE INDEX _idx_user_place_cx_p_cy ON user_place USING btree (cx_p_cy);
CREATE INDEX _idx_user_place_cx_m_cy ON user_place USING btree (cx_m_cy);


--
-- Name: _idx_user_place_is_spirit; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_is_spirit ON user_place USING btree (is_spirit);


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

