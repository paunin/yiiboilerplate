--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'WIN1251';
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
    email character varying NOT NULL,
    key character varying,
    created_at timestamp without time zone DEFAULT now(),
    role character varying NOT NULL,
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

SELECT pg_catalog.setval('user_id_seq', 2, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE smtp ALTER COLUMN id SET DEFAULT nextval('smtp_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: AuthAssignment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthAssignment" (itemname, userid, bizrule, data) FROM stdin;
\.


--
-- Data for Name: AuthItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthItem" (name, type, description, bizrule, data) FROM stdin;
\.


--
-- Data for Name: AuthItemChild; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "AuthItemChild" (parent, child) FROM stdin;
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
2	admin	admin@admin.com	\N	2013-09-16 11:47:38.564	admin	t	\N	21232f297a57a5a743894a0e4a801fc3
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
-- PostgreSQL database dump complete
--

