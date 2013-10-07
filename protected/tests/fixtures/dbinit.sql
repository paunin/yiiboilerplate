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
3	user	user@user.com	\N	2013-09-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
4	user2	user2@user.com	\N	2013-09-16 12:26:14	\N	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
5	user3	user3@user.com	\N	2013-08-16 12:26:14	2013-08-16 12:26:14	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
6	user4	user4@user.com	\N	2013-07-16 12:26:14	\N	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
7	user5	user5@user.com	\N	2013-06-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
8	user6	user6@user.com	\N	2013-05-16 12:26:14	\N	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
9	user7	user7@user.com	\N	2013-04-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
10	user8	user8@user.com	\N	2013-03-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
11	user9	user9@user.com	\N	2013-02-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
12	user10	user10@user.com	\N	2013-01-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
13	user11	user11@user.com	\N	2012-12-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
14	user12	user12@user.com	\N	2012-11-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
15	user13	\N	\N	2012-09-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
16	user14	user14@user.com	\N	2012-08-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
17	user15	user15@user.com	\N	2012-07-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
18	user16	user16@user.com	\N	2012-06-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
19	user17	user17@user.com	\N	2012-05-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
20	user18	user18@user.com	\N	2012-04-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
21	user19	user19@user.com	\N	2012-03-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
22	user20	user20@user.com	\N	2012-02-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
23	user21	user21@user.com	\N	2012-01-16 12:26:14	\N	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
2	admin	admin@admin.com	\N	2013-09-16 11:47:38	2013-10-07 12:42:38	admin	t	2013-10-07 12:42:38	1341215dbe9acab4361fd6417b2b11bc
101	U_twitter_71662685	\N	\N	2013-10-07 14:40:22	2013-10-07 14:40:22	user	t	2013-10-07 14:40:22	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_id_seq', 101, true);


--
-- Data for Name: user_place; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_place (id, user_id, name, cx, cy, cx_p_cy, cx_m_cy, created_at, updated_at, radius, permissions, is_spirit) FROM stdin;
1	2	My place 1 spirit	1	1	2	0	2013-10-07 12:43:38	\N	44	2	f
2	4	My place 2 spirit	1	2	3	-1	2013-10-07 12:44:02	\N	\N	2	f
3	6	My place 3 spirit	10	30	40	-20	2013-10-07 12:44:22	\N	\N	2	f
4	8	My place 4 spirit	100	300	400	-200	2013-10-07 12:44:31	\N	\N	2	f
5	12	My place 5 spirit	1000	3000	4000	-2000	2013-10-07 12:44:38	\N	\N	2	f
6	14	My place 6 spirit	10000	30000	40000	-20000	2013-10-07 12:44:43	\N	\N	2	f
7	16	My place 7 spirit	100000	300000	400000	-200000	2013-10-07 12:44:48	\N	\N	2	f
\.


--
-- Name: user_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_place_id_seq', 7, true);


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


--
-- Name: _idx_user_place_cx_p_cy_cx_m_cy; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX _idx_user_place_cx_p_cy_cx_m_cy ON user_place USING btree (cx_p_cy, cx_m_cy);


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

