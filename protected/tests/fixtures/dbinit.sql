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

SELECT pg_catalog.setval('user_id_seq', 100, true);


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

SELECT pg_catalog.setval('user_social_id_seq', 1, false);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE cron_mail ALTER COLUMN id SET DEFAULT nextval('cron_mail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE smtp ALTER COLUMN id SET DEFAULT nextval('smtp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


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
\.


--
-- Data for Name: user_social; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_social (id, user_id, social_service, user_social_id, additional_data) FROM stdin;
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
-- Name: Ref_user_social_to_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_social
    ADD CONSTRAINT "Ref_user_social_to_user" FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- PostgreSQL database dump complete
--

