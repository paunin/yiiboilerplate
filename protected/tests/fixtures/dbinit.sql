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
-- Name: baby; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE baby (
    id integer NOT NULL,
    created_by integer NOT NULL,
    name character varying(255),
    born_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: baby_action_category; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE baby_action_category (
    id integer NOT NULL,
    created_by integer,
    title character varying(256) NOT NULL,
    description text,
    color character varying(8) DEFAULT 0 NOT NULL
);


--
-- Name: baby_action_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE baby_action_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: baby_action_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE baby_action_category_id_seq OWNED BY baby_action_category.id;


--
-- Name: baby_action_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('baby_action_category_id_seq', 6, true);


--
-- Name: baby_action_log; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE baby_action_log (
    id integer NOT NULL,
    baby_id integer NOT NULL,
    baby_action_category_id integer,
    description text,
    time_start timestamp without time zone NOT NULL,
    time_finish timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: baby_action_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE baby_action_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: baby_action_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE baby_action_log_id_seq OWNED BY baby_action_log.id;


--
-- Name: baby_action_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('baby_action_log_id_seq', 1, false);


--
-- Name: baby_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE baby_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: baby_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE baby_id_seq OWNED BY baby.id;


--
-- Name: baby_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('baby_id_seq', 5, true);


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
-- Name: user; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying,
    key character varying,
    created_at timestamp without time zone DEFAULT now(),
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

SELECT pg_catalog.setval('user_id_seq', 101, true);


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

ALTER TABLE ONLY baby ALTER COLUMN id SET DEFAULT nextval('baby_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby_action_category ALTER COLUMN id SET DEFAULT nextval('baby_action_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby_action_log ALTER COLUMN id SET DEFAULT nextval('baby_action_log_id_seq'::regclass);


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
-- Data for Name: baby; Type: TABLE DATA; Schema: public; Owner: -
--

COPY baby (id, created_by, name, born_date, created_at) FROM stdin;
5	101	My baby	\N	2013-11-12 12:08:14
\.


--
-- Data for Name: baby_action_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY baby_action_category (id, created_by, title, description, color) FROM stdin;
1	\N	Sleep	\N	777
2	\N	Diaper change	\N	777
3	\N	Eat	\N	777
4	\N	Bath	\N	777
5	\N	Walk	\N	777
6	\N	Massage	\N	777
\.


--
-- Data for Name: baby_action_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY baby_action_log (id, baby_id, baby_action_category_id, description, time_start, time_finish, created_at) FROM stdin;
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
-- Data for Name: smtp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY smtp (id, host, username, password, port, encryption, timeout, "extensionHandlers", using_count, banned) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "user" (id, username, email, key, created_at, role, is_active, last_login, password) FROM stdin;
2	admin	admin@admin.com	\N	2013-09-16 11:47:38.564	admin	t	\N	1341215dbe9acab4361fd6417b2b11bc
3	user	user@user.com	\N	2013-09-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
4	user2	user2@user.com	\N	2013-09-16 12:26:14.018	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
5	user3	user3@user.com	\N	2013-08-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
6	user4	user4@user.com	\N	2013-07-16 12:26:14.018	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
7	user5	user5@user.com	\N	2013-06-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
8	user6	user6@user.com	\N	2013-05-16 12:26:14.018	user	f	\N	87dc1e131a1369fdf8f1c824a6a62dff
9	user7	user7@user.com	\N	2013-04-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
10	user8	user8@user.com	\N	2013-03-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
11	user9	user9@user.com	\N	2013-02-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
12	user10	user10@user.com	\N	2013-01-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
13	user11	user11@user.com	\N	2012-12-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
14	user12	user12@user.com	\N	2012-11-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
15	user13	\N	\N	2012-09-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
16	user14	user14@user.com	\N	2012-08-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
17	user15	user15@user.com	\N	2012-07-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
18	user16	user16@user.com	\N	2012-06-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
19	user17	user17@user.com	\N	2012-05-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
20	user18	user18@user.com	\N	2012-04-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
21	user19	user19@user.com	\N	2012-03-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
22	user20	user20@user.com	\N	2012-02-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
23	user21	user21@user.com	\N	2012-01-16 12:26:14.018	user	t	\N	87dc1e131a1369fdf8f1c824a6a62dff
101	U_twitter_71662685	\N	\N	\N	user	t	2013-11-12 12:08:13	\N
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
-- Name: baby_action_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY baby_action_category
    ADD CONSTRAINT baby_action_category_pkey PRIMARY KEY (id);


--
-- Name: baby_action_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY baby_action_log
    ADD CONSTRAINT baby_action_log_pkey PRIMARY KEY (id);


--
-- Name: baby_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY baby
    ADD CONSTRAINT baby_pkey PRIMARY KEY (id);


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
-- Name: Ref_baby_action_category_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby_action_category
    ADD CONSTRAINT "Ref_baby_action_category_to_user" FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- Name: Ref_baby_action_log_to_baby; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby_action_log
    ADD CONSTRAINT "Ref_baby_action_log_to_baby" FOREIGN KEY (baby_id) REFERENCES baby(id);


--
-- Name: Ref_baby_action_log_to_baby_action_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby_action_log
    ADD CONSTRAINT "Ref_baby_action_log_to_baby_action_category" FOREIGN KEY (baby_action_category_id) REFERENCES baby_action_category(id);


--
-- Name: Ref_baby_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY baby
    ADD CONSTRAINT "Ref_baby_to_user" FOREIGN KEY (created_by) REFERENCES "user"(id);


--
-- Name: Ref_user_social_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_social
    ADD CONSTRAINT "Ref_user_social_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- PostgreSQL database dump complete
--

