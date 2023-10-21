--
-- PostgreSQL database dump
--

-- Dumped from database version 12.15
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: vapor_username
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO vapor_username;

--
-- Name: category_enum; Type: TYPE; Schema: public; Owner: asadan
--

CREATE TYPE public.category_enum AS ENUM (
    'Transportation',
    'Grocery Store',
    'Park',
    'Child Care',
    'School',
    'Community Centre'
);


ALTER TYPE public.category_enum OWNER TO asadan;

--
-- Name: category_enum_new; Type: TYPE; Schema: public; Owner: asadan
--

CREATE TYPE public.category_enum_new AS ENUM (
    'Transportation',
    'Grocery Store',
    'Child Care',
    'School',
    'Community Centre'
);


ALTER TYPE public.category_enum_new OWNER TO asadan;

--
-- Name: city_planning_progress_category_enum; Type: TYPE; Schema: public; Owner: asadan
--

CREATE TYPE public.city_planning_progress_category_enum AS ENUM (
    'Report',
    'Approval'
);


ALTER TYPE public.city_planning_progress_category_enum OWNER TO asadan;

--
-- Name: city_planning_progress_status_enum; Type: TYPE; Schema: public; Owner: asadan
--

CREATE TYPE public.city_planning_progress_status_enum AS ENUM (
    'Complete',
    'Pending'
);


ALTER TYPE public.city_planning_progress_status_enum OWNER TO asadan;

--
-- Name: planning_precedents_status_enum; Type: TYPE; Schema: public; Owner: asadan
--

CREATE TYPE public.planning_precedents_status_enum AS ENUM (
    'Approved',
    'Constructed'
);


ALTER TYPE public.planning_precedents_status_enum OWNER TO asadan;

--
-- Name: update_last_amended_by(); Type: FUNCTION; Schema: public; Owner: asadan
--

CREATE FUNCTION public.update_last_amended_by() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_amended_by := CURRENT_USER;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_last_amended_by() OWNER TO asadan;

--
-- Name: update_record_amend_date(); Type: FUNCTION; Schema: public; Owner: asadan
--

CREATE FUNCTION public.update_record_amend_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.record_amend_date = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_record_amend_date() OWNER TO asadan;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _fluent_migrations; Type: TABLE; Schema: public; Owner: vapor_username
--

CREATE TABLE public._fluent_migrations (
    id uuid NOT NULL,
    name text NOT NULL,
    batch bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public._fluent_migrations OWNER TO vapor_username;

--
-- Name: acronym-category-pivot; Type: TABLE; Schema: public; Owner: vapor_username
--

CREATE TABLE public."acronym-category-pivot" (
    id uuid NOT NULL,
    "acronymID" uuid NOT NULL,
    "categoryID" uuid NOT NULL
);


ALTER TABLE public."acronym-category-pivot" OWNER TO vapor_username;

--
-- Name: acronyms; Type: TABLE; Schema: public; Owner: vapor_username
--

CREATE TABLE public.acronyms (
    id uuid NOT NULL,
    short text NOT NULL,
    long text NOT NULL,
    "userID" uuid NOT NULL
);


ALTER TABLE public.acronyms OWNER TO vapor_username;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: vapor_username
--

CREATE TABLE public.categories (
    id uuid NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.categories OWNER TO vapor_username;

--
-- Name: city_planning_precedents; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.city_planning_precedents (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    project_id integer,
    address text,
    height double precision,
    distance_to_subject double precision,
    status public.planning_precedents_status_enum
);


ALTER TABLE public.city_planning_precedents OWNER TO asadan;

--
-- Name: city_planning_progress; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.city_planning_progress (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    project_id integer,
    progress_item text,
    category public.city_planning_progress_status_enum,
    status character varying,
    target date
);


ALTER TABLE public.city_planning_progress OWNER TO asadan;

--
-- Name: city_planning_progress_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.city_planning_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_planning_progress_id_seq OWNER TO asadan;

--
-- Name: city_planning_progress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.city_planning_progress_id_seq OWNED BY public.city_planning_progress.id;


--
-- Name: community_services; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.community_services (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    project_id integer NOT NULL,
    name character varying,
    address text,
    city character varying,
    province character varying,
    country character varying,
    postal_code character varying,
    category public.category_enum,
    subcategory character varying,
    description text,
    distance_km double precision,
    travel_time_foot double precision,
    travel_time_car double precision,
    travel_time_transit double precision
);


ALTER TABLE public.community_services OWNER TO asadan;

--
-- Name: community_services_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.community_services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.community_services_id_seq OWNER TO asadan;

--
-- Name: community_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.community_services_id_seq OWNED BY public.community_services.id;


--
-- Name: planning_precedents_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.planning_precedents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planning_precedents_id_seq OWNER TO asadan;

--
-- Name: planning_precedents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.planning_precedents_id_seq OWNED BY public.city_planning_precedents.id;


--
-- Name: project_teams_association; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.project_teams_association (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    project_id integer,
    team_id integer
);


ALTER TABLE public.project_teams_association OWNER TO asadan;

--
-- Name: project_teams_association_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.project_teams_association_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.project_teams_association_id_seq OWNER TO asadan;

--
-- Name: project_teams_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.project_teams_association_id_seq OWNED BY public.project_teams_association.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    project_name character varying,
    about_text text,
    url text,
    legal_name character varying,
    nick_name character varying,
    address text,
    city character varying,
    province character varying,
    country character varying,
    postal_code character varying,
    telephone character varying,
    fax character varying,
    email_address character varying,
    slug text
);


ALTER TABLE public.projects OWNER TO asadan;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO asadan;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: team_bio_bullets; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.team_bio_bullets (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    team_id integer,
    bullet_text text,
    bullet_order integer
);


ALTER TABLE public.team_bio_bullets OWNER TO asadan;

--
-- Name: team_bio_bullets_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.team_bio_bullets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_bio_bullets_id_seq OWNER TO asadan;

--
-- Name: team_bio_bullets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.team_bio_bullets_id_seq OWNED BY public.team_bio_bullets.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: asadan
--

CREATE TABLE public.teams (
    id integer NOT NULL,
    record_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    record_amend_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by character varying DEFAULT CURRENT_USER,
    last_amended_by character varying DEFAULT CURRENT_USER,
    category character varying,
    first_name character varying(40),
    last_name character varying(40),
    "position" character varying,
    company character varying,
    linkedin text,
    bio_link text
);


ALTER TABLE public.teams OWNER TO asadan;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: asadan
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO asadan;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: asadan
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vapor_username
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name text NOT NULL,
    username text NOT NULL
);


ALTER TABLE public.users OWNER TO vapor_username;

--
-- Name: web_pages; Type: TABLE; Schema: public; Owner: ayoung
--

CREATE TABLE public.web_pages (
    id uuid NOT NULL,
    name text NOT NULL,
    leaf_template text NOT NULL,
    project_id uuid NOT NULL,
    parent_id uuid,
    time_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.web_pages OWNER TO ayoung;

--
-- Name: city_planning_precedents id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_precedents ALTER COLUMN id SET DEFAULT nextval('public.planning_precedents_id_seq'::regclass);


--
-- Name: city_planning_progress id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_progress ALTER COLUMN id SET DEFAULT nextval('public.city_planning_progress_id_seq'::regclass);


--
-- Name: community_services id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.community_services ALTER COLUMN id SET DEFAULT nextval('public.community_services_id_seq'::regclass);


--
-- Name: project_teams_association id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.project_teams_association ALTER COLUMN id SET DEFAULT nextval('public.project_teams_association_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: team_bio_bullets id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.team_bio_bullets ALTER COLUMN id SET DEFAULT nextval('public.team_bio_bullets_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Data for Name: _fluent_migrations; Type: TABLE DATA; Schema: public; Owner: vapor_username
--

COPY public._fluent_migrations (id, name, batch, created_at, updated_at) FROM stdin;
969f38bb-cac1-49a5-9200-84e61f251eac	App.CreateUser	1	2023-05-30 00:35:52.83976+00	2023-05-30 00:35:52.83976+00
afdea573-77a8-41d7-b8e4-6bf2ee07289d	App.CreateAcronym	1	2023-05-30 00:35:52.879117+00	2023-05-30 00:35:52.879117+00
4da5ba55-98d1-4335-bbd3-5956b901f96a	App.CreateCategory	1	2023-05-30 00:35:52.887321+00	2023-05-30 00:35:52.887321+00
52c1a9a0-3fb0-4aec-9ad5-0a2a86cfbaf6	App.CreateAcronymCategoryPivot	1	2023-05-30 00:35:52.894832+00	2023-05-30 00:35:52.894832+00
065ecb58-d2d1-4b31-959c-6ac05d408b28	App.CreateWebpage	2	2023-07-25 12:01:22.783578+00	2023-07-25 12:01:22.783578+00
fa7a1a82-739a-4a65-a073-64c6aea7de94	App.AddSlugFieldToProjectsTable	3	2023-07-28 16:13:38.319819+00	2023-07-28 16:13:38.319819+00
e4dbed35-678f-4052-bbbb-d4f0db8fe1c2	App.CreateProject	4	2023-08-13 15:38:35.162464+00	2023-08-13 15:38:35.162464+00
cfeb7073-5421-442f-bd6b-e5a7329677b7	App.CreateTeam	5	2023-08-21 21:38:20.53364+00	2023-08-21 21:38:20.53364+00
40ae49e4-b80c-4d67-a6b3-5da353dad1e7	App.AddLinkedInAndBioLinkFieldsToTeams	5	2023-08-21 21:38:20.830607+00	2023-08-21 21:38:20.830607+00
\.


--
-- Data for Name: acronym-category-pivot; Type: TABLE DATA; Schema: public; Owner: vapor_username
--

COPY public."acronym-category-pivot" (id, "acronymID", "categoryID") FROM stdin;
\.


--
-- Data for Name: acronyms; Type: TABLE DATA; Schema: public; Owner: vapor_username
--

COPY public.acronyms (id, short, long, "userID") FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vapor_username
--

COPY public.categories (id, name) FROM stdin;
\.


--
-- Data for Name: city_planning_precedents; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.city_planning_precedents (id, record_creation_date, record_amend_date, created_by, last_amended_by, project_id, address, height, distance_to_subject, status) FROM stdin;
1	2023-07-21 03:45:54.018776	2023-07-21 03:45:54.018776	asadan	asadan	4	325 Highway 8	11	550	Approved
2	2023-07-21 03:45:54.796725	2023-07-21 03:45:54.796725	asadan	asadan	4	319 Highway 8	7	600	Constructed
3	2023-07-21 03:45:55.615673	2023-07-21 03:45:55.615673	asadan	asadan	4	495 Highway 8	7	700	Constructed
4	2023-07-21 03:47:21.879471	2023-07-21 03:47:21.879471	asadan	asadan	1	325 Highway 8	11	550	Approved
5	2023-07-21 03:47:22.755855	2023-07-21 03:47:22.755855	asadan	asadan	1	319 Highway 8	7	600	Constructed
6	2023-07-21 03:47:23.677827	2023-07-21 03:47:23.677827	asadan	asadan	1	495 Highway 8	7	700	Constructed
\.


--
-- Data for Name: city_planning_progress; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.city_planning_progress (id, record_creation_date, record_amend_date, created_by, last_amended_by, project_id, progress_item, category, status, target) FROM stdin;
7	2023-07-20 10:19:22.594554	2023-07-21 10:39:51.388425	asadan	asadan	4	Formal Consultation	Complete	Complete	\N
8	2023-07-20 10:40:16.009585	2023-07-21 10:39:51.388425	asadan	asadan	4	Official Plan Amendment & Re-Zoning	Pending	Pending	2023-06-01
9	2023-07-20 10:40:16.708565	2023-07-21 10:39:51.388425	asadan	asadan	4	Site Plan	Pending	Pending	2023-09-01
10	2023-07-20 10:40:17.802495	2023-07-21 10:39:51.388425	asadan	asadan	4	Building Permit	Pending	Pending	2023-12-01
17	2023-07-20 10:42:53.961338	2023-07-21 10:39:51.388425	asadan	asadan	1	Formal Consultation	Complete	Complete	\N
18	2023-07-20 10:42:54.706339	2023-07-21 10:39:51.388425	asadan	asadan	1	Official Plan Amendment & Re-Zoning	Pending	Pending	2023-06-01
19	2023-07-20 10:42:55.593381	2023-07-21 10:39:51.388425	asadan	asadan	1	Site Plan	Pending	Pending	2023-09-01
20	2023-07-20 10:42:56.427599	2023-07-21 10:39:51.388425	asadan	asadan	1	Building Permit	Pending	Pending	2023-12-01
1	2023-07-20 10:19:16.916701	2023-07-21 10:40:03.164648	asadan	asadan	4	Environmental Phase I & II	Complete	Complete	\N
2	2023-07-20 10:19:17.911412	2023-07-21 10:40:03.164648	asadan	asadan	4	Preliminary Geotchnnical Study	Complete	Complete	\N
3	2023-07-20 10:19:18.704591	2023-07-21 10:40:03.164648	asadan	asadan	4	Archeological Assessment	Complete	Complete	\N
4	2023-07-20 10:19:19.931435	2023-07-21 10:40:03.164648	asadan	asadan	4	Preliminary Architectural Design	Complete	Complete	\N
5	2023-07-20 10:19:20.627465	2023-07-21 10:40:03.164648	asadan	asadan	4	Noise Assessment	Complete	Complete	\N
6	2023-07-20 10:19:21.570522	2023-07-21 10:40:03.164648	asadan	asadan	4	Site Servicing Assessment	Complete	Complete	\N
11	2023-07-20 10:42:47.720141	2023-07-21 10:40:03.164648	asadan	asadan	1	Environmental Phase I & II	Complete	Complete	\N
12	2023-07-20 10:42:48.759191	2023-07-21 10:40:03.164648	asadan	asadan	1	Preliminary Geotchnnical Study	Complete	Complete	\N
13	2023-07-20 10:42:49.98707	2023-07-21 10:40:03.164648	asadan	asadan	1	Archeological Assessment	Complete	Complete	\N
14	2023-07-20 10:42:50.909611	2023-07-21 10:40:03.164648	asadan	asadan	1	Preliminary Architectural Design	Complete	Complete	\N
15	2023-07-20 10:42:52.137279	2023-07-21 10:40:03.164648	asadan	asadan	1	Noise Assessment	Complete	Complete	\N
16	2023-07-20 10:42:53.207095	2023-07-21 10:40:03.164648	asadan	asadan	1	Site Servicing Assessment	Complete	Complete	\N
\.


--
-- Data for Name: community_services; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.community_services (id, record_creation_date, record_amend_date, created_by, last_amended_by, project_id, name, address, city, province, country, postal_code, category, subcategory, description, distance_km, travel_time_foot, travel_time_car, travel_time_transit) FROM stdin;
3	2023-07-21 10:21:23.545653	2023-07-21 10:21:23.545653	asadan	asadan	4	Bus Route East on Highway 8		\N	\N	\N	\N	Transportation	Public Transit		0.04	0	0	0
4	2023-07-21 10:21:24.2976	2023-07-21 10:21:24.2976	asadan	asadan	4	Queen Elizabeth Way (QEW)		\N	\N	\N	\N	Transportation	Freeway to Toronto		0	0	4	0
5	2023-07-21 10:21:25.042616	2023-07-21 10:21:25.042616	asadan	asadan	4	Farm Fresh Country Market	390 Barton Street	\N	\N	\N	\N	Grocery Store			0	12	3	0
6	2023-07-21 10:21:25.754724	2023-07-21 10:21:25.754724	asadan	asadan	4	Fortinos	102 Highway 8	\N	\N	\N	\N	Grocery Store			0	0	4	6
7	2023-07-21 10:21:26.618578	2023-07-21 10:21:26.618578	asadan	asadan	4	Food Basics	2500 Barton Street East	\N	\N	\N	\N	Grocery Store			0	0	7	21
8	2023-07-21 10:21:27.540052	2023-07-21 10:21:27.540052	asadan	asadan	4	No Frills	640 QUeenston Road	\N	\N	\N	\N	Grocery Store			0	0	10	23
9	2023-07-21 10:21:28.318926	2023-07-21 10:21:28.318926	asadan	asadan	4	South Meadow Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
10	2023-07-21 10:21:29.074923	2023-07-21 10:21:29.074923	asadan	asadan	4	St. Francis Xavier Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
11	2023-07-21 10:21:29.945842	2023-07-21 10:21:29.945842	asadan	asadan	4	St. Clare of Assisi Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
12	2023-07-21 10:21:30.81601	2023-07-21 10:21:30.81601	asadan	asadan	4	Peachwood Parkette		\N	\N	\N	\N	Park	Parkette	Passive	0	0	0	0
13	2023-07-21 10:21:31.666949	2023-07-21 10:21:31.666949	asadan	asadan	4	Memorial Park		\N	\N	\N	\N	Park	Neighbourhood Park	Passive	0	0	0	0
14	2023-07-21 10:21:32.375892	2023-07-21 10:21:32.375892	asadan	asadan	4	John Santarelli Plateau Park		\N	\N	\N	\N	Park	Parkette	Passive	0	0	0	0
15	2023-07-21 10:21:33.273999	2023-07-21 10:21:33.273999	asadan	asadan	4	King Street Parkette		\N	\N	\N	\N	Park	Parkette	Historical	0	0	0	0
16	2023-07-21 10:21:34.093396	2023-07-21 10:21:34.093396	asadan	asadan	4	Hunter Estates Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
17	2023-07-21 10:21:34.805854	2023-07-21 10:21:34.805854	asadan	asadan	4	Ferris Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
18	2023-07-21 10:21:35.557806	2023-07-21 10:21:35.557806	asadan	asadan	4	Dewitt Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
19	2023-07-21 10:21:36.344897	2023-07-21 10:21:36.344897	asadan	asadan	4	Cenotaph Park		\N	\N	\N	\N	Park	Parkette	Historical	0	0	0	0
20	2023-07-21 10:23:37.930405	2023-07-21 10:23:37.930405	asadan	asadan	1	On-Site Parking		\N	\N	\N	\N	Transportation	Private		0	0	0	0
22	2023-07-21 10:23:40.326032	2023-07-21 10:23:40.326032	asadan	asadan	1	Bus Route East on Highway 8		\N	\N	\N	\N	Transportation	Public Transit		0.04	0	0	0
23	2023-07-21 10:23:41.530341	2023-07-21 10:23:41.530341	asadan	asadan	1	Queen Elizabeth Way (QEW)		\N	\N	\N	\N	Transportation	Freeway to Toronto		0	0	4	0
24	2023-07-21 10:23:42.613144	2023-07-21 10:23:42.613144	asadan	asadan	1	Farm Fresh Country Market	390 Barton Street	\N	\N	\N	\N	Grocery Store			0	12	3	0
25	2023-07-21 10:23:43.740488	2023-07-21 10:23:43.740488	asadan	asadan	1	Fortinos	102 Highway 8	\N	\N	\N	\N	Grocery Store			0	0	4	6
26	2023-07-21 10:23:44.96968	2023-07-21 10:23:44.96968	asadan	asadan	1	Food Basics	2500 Barton Street East	\N	\N	\N	\N	Grocery Store			0	0	7	21
27	2023-07-21 10:23:46.176304	2023-07-21 10:23:46.176304	asadan	asadan	1	No Frills	640 QUeenston Road	\N	\N	\N	\N	Grocery Store			0	0	10	23
28	2023-07-21 10:23:47.324824	2023-07-21 10:23:47.324824	asadan	asadan	1	South Meadow Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
29	2023-07-21 10:23:48.438262	2023-07-21 10:23:48.438262	asadan	asadan	1	St. Francis Xavier Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
30	2023-07-21 10:23:49.465568	2023-07-21 10:23:49.465568	asadan	asadan	1	St. Clare of Assisi Elementary		\N	\N	\N	\N	Park	School	School Grounds	0	0	0	0
31	2023-07-21 10:23:50.57259	2023-07-21 10:23:50.57259	asadan	asadan	1	Peachwood Parkette		\N	\N	\N	\N	Park	Parkette	Passive	0	0	0	0
32	2023-07-21 10:23:51.735837	2023-07-21 10:23:51.735837	asadan	asadan	1	Memorial Park		\N	\N	\N	\N	Park	Neighbourhood Park	Passive	0	0	0	0
33	2023-07-21 10:23:52.770224	2023-07-21 10:23:52.770224	asadan	asadan	1	John Santarelli Plateau Park		\N	\N	\N	\N	Park	Parkette	Passive	0	0	0	0
34	2023-07-21 10:23:53.874948	2023-07-21 10:23:53.874948	asadan	asadan	1	King Street Parkette		\N	\N	\N	\N	Park	Parkette	Historical	0	0	0	0
35	2023-07-21 10:23:55.011613	2023-07-21 10:23:55.011613	asadan	asadan	1	Hunter Estates Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
36	2023-07-21 10:23:56.16631	2023-07-21 10:23:56.16631	asadan	asadan	1	Ferris Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
37	2023-07-21 10:23:57.305259	2023-07-21 10:23:57.305259	asadan	asadan	1	Dewitt Park		\N	\N	\N	\N	Park	Neighbourhood Park	Sports	0	0	0	0
38	2023-07-21 10:23:58.139974	2023-07-21 10:23:58.139974	asadan	asadan	1	Cenotaph Park		\N	\N	\N	\N	Park	Parkette	Historical	0	0	0	0
39	2023-07-21 10:30:24.091274	2023-07-21 10:30:24.091274	asadan	asadan	4	St Francis Early Learning and Care Centre	298 Highway #8	\N	\N	\N	\N	Child Care	Todler to Primary/Junior		0	0	0	0
40	2023-07-21 10:30:24.904574	2023-07-21 10:30:24.904574	asadan	asadan	4	South Meadow Childcare Centre	23 Royce Avenue	\N	\N	\N	\N	Child Care	Infant to Primary/Junior		0	0	0	0
41	2023-07-21 10:30:25.684583	2023-07-21 10:30:25.684583	asadan	asadan	4	Sunshine & Rainbows Christian Day Care Centre	440 Highway #8	\N	\N	\N	\N	Child Care	Todler & Pre-School		0	0	0	0
42	2023-07-21 10:30:26.537475	2023-07-21 10:30:26.537475	asadan	asadan	4	St. Clare of Assisi Before & After School Program	185 Glenashton Drive	\N	\N	\N	\N	Child Care	Kindergarten & Primary/Junior		0	0	0	0
43	2023-07-21 10:30:27.324786	2023-07-21 10:30:27.324786	asadan	asadan	4	South Meadow Elementary School	23 Royce Avenue	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
44	2023-07-21 10:30:28.14183	2023-07-21 10:30:28.14183	asadan	asadan	4	Orchard Park Secondary School	200 Dewitt Road	\N	\N	\N	\N	School	Grades 9 – 12		0	0	0	0
45	2023-07-21 10:30:29.029738	2023-07-21 10:30:29.029738	asadan	asadan	4	St. Francis Xavier Elementary School	298 Highway No. 8	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
46	2023-07-21 10:30:29.738715	2023-07-21 10:30:29.738715	asadan	asadan	4	St. Clare of Assisi Elementary School	185 Glenashton Drive	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
47	2023-07-21 10:30:30.536865	2023-07-21 10:30:30.536865	asadan	asadan	4	H.G. Brewster Pool	206 Dewitt Road	\N	\N	\N	\N	School	Pool, Lockers, Activity Room		0	0	0	0
1	2023-07-21 10:21:21.946918	2023-08-14 13:12:11.650366	asadan	ayoung	4	On-Site Parking		\N	\N	\N	\N	Transportation	Private		0.01	0	0	0
21	2023-07-21 10:23:39.159054	2023-08-14 13:13:06.181352	asadan	ayoung	1	Bus Route West on Highway 8		\N	\N	\N	\N	Transportation	Public Transit		0.01	0	0	0
48	2023-07-21 10:32:25.979199	2023-07-21 10:32:25.979199	asadan	asadan	1	St Francis Early Learning and Care Centre	298 Highway #8	\N	\N	\N	\N	Child Care	Todler to Primary/Junior		0	0	0	0
49	2023-07-21 10:32:26.768896	2023-07-21 10:32:26.768896	asadan	asadan	1	South Meadow Childcare Centre	23 Royce Avenue	\N	\N	\N	\N	Child Care	Infant to Primary/Junior		0	0	0	0
50	2023-07-21 10:32:27.565456	2023-07-21 10:32:27.565456	asadan	asadan	1	Sunshine & Rainbows Christian Day Care Centre	440 Highway #8	\N	\N	\N	\N	Child Care	Todler & Pre-School		0	0	0	0
51	2023-07-21 10:32:28.425164	2023-07-21 10:32:28.425164	asadan	asadan	1	St. Clare of Assisi Before & After School Program	185 Glenashton Drive	\N	\N	\N	\N	Child Care	Kindergarten & Primary/Junior		0	0	0	0
52	2023-07-21 10:32:29.348366	2023-07-21 10:32:29.348366	asadan	asadan	1	South Meadow Elementary School	23 Royce Avenue	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
53	2023-07-21 10:32:30.269408	2023-07-21 10:32:30.269408	asadan	asadan	1	Orchard Park Secondary School	200 Dewitt Road	\N	\N	\N	\N	School	Grades 9 – 12		0	0	0	0
54	2023-07-21 10:32:30.972258	2023-07-21 10:32:30.972258	asadan	asadan	1	St. Francis Xavier Elementary School	298 Highway No. 8	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
55	2023-07-21 10:32:31.733235	2023-07-21 10:32:31.733235	asadan	asadan	1	St. Clare of Assisi Elementary School	185 Glenashton Drive	\N	\N	\N	\N	School	Kindergarten – Grade 8		0	0	0	0
56	2023-07-21 10:32:32.478539	2023-07-21 10:32:32.478539	asadan	asadan	1	H.G. Brewster Pool	206 Dewitt Road	\N	\N	\N	\N	School	Pool, Lockers, Activity Room		0	0	0	0
2	2023-07-21 10:21:22.760794	2023-08-14 13:12:11.650366	asadan	ayoung	4	Bus Route West on Highway 8		\N	\N	\N	\N	Transportation	Public Transit		0.01	0	0	0
\.


--
-- Data for Name: project_teams_association; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.project_teams_association (id, record_creation_date, record_amend_date, created_by, last_amended_by, project_id, team_id) FROM stdin;
1	2023-07-24 05:48:33.49011	2023-07-24 05:48:33.49011	asadan	asadan	1	1
2	2023-07-24 05:48:34.271084	2023-07-24 05:48:34.271084	asadan	asadan	4	1
3	2023-07-24 05:48:36.258074	2023-07-24 05:48:36.258074	asadan	asadan	1	2
4	2023-07-24 05:48:36.999332	2023-07-24 05:48:36.999332	asadan	asadan	4	2
5	2023-07-24 05:48:38.654336	2023-07-24 05:48:38.654336	asadan	asadan	1	3
6	2023-07-24 05:48:39.532306	2023-07-24 05:48:39.532306	asadan	asadan	4	3
7	2023-07-24 05:48:41.273283	2023-07-24 05:48:41.273283	asadan	asadan	1	4
8	2023-07-24 05:48:42.137503	2023-07-24 05:48:42.137503	asadan	asadan	4	4
9	2023-07-24 05:48:43.620267	2023-07-24 05:48:43.620267	asadan	asadan	1	5
10	2023-07-24 05:48:44.359348	2023-07-24 05:48:44.359348	asadan	asadan	4	5
11	2023-07-24 05:48:46.08629	2023-07-24 05:48:46.08629	asadan	asadan	1	6
12	2023-07-24 05:48:46.826575	2023-07-24 05:48:46.826575	asadan	asadan	4	6
13	2023-07-24 05:48:48.882591	2023-07-24 05:48:48.882591	asadan	asadan	1	7
14	2023-07-24 05:48:49.65256	2023-07-24 05:48:49.65256	asadan	asadan	4	7
15	2023-07-24 05:48:51.133618	2023-07-24 05:48:51.133618	asadan	asadan	1	8
16	2023-07-24 05:48:51.906651	2023-07-24 05:48:51.906651	asadan	asadan	4	8
17	2023-07-24 05:48:53.665521	2023-07-24 05:48:53.665521	asadan	asadan	1	9
18	2023-07-24 05:48:54.48354	2023-07-24 05:48:54.48354	asadan	asadan	4	9
19	2023-07-24 05:48:56.121507	2023-07-24 05:48:56.121507	asadan	asadan	1	10
20	2023-07-24 05:48:57.086157	2023-07-24 05:48:57.086157	asadan	asadan	4	10
21	2023-07-24 05:48:58.77575	2023-07-24 05:48:58.77575	asadan	asadan	1	11
22	2023-07-24 05:48:59.602817	2023-07-24 05:48:59.602817	asadan	asadan	4	11
23	2023-07-24 05:49:01.385835	2023-07-24 05:49:01.385835	asadan	asadan	1	12
24	2023-07-24 05:49:02.265837	2023-07-24 05:49:02.265837	asadan	asadan	4	12
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.projects (id, record_creation_date, record_amend_date, created_by, last_amended_by, project_name, about_text, url, legal_name, nick_name, address, city, province, country, postal_code, telephone, fax, email_address, slug) FROM stdin;
4	2023-07-19 11:57:34.065048	2023-07-28 16:21:09.434087	asadan	ayoung	Dewitt Road	One Way Path Communities builds multi-residential housing in liveable  communities in and around the Greater Toronto Hamilton Area. These  projects present an opportunity for equity investors to earn high rates  of return with limited risk. Intrested equity and debt partners are  invited to contact info@onewaypath.com for more information.	/dewitt/index	One Way Path at Dewitt Road LP	@DEWITT	100 King Street West, Suite 5600	Toronto	Ontario	Canada	M5X 1C9	(416) 848-1746	(416) 848-1162	info@onewaypath.com	dewitt
1	2023-07-19 11:55:50.031697	2023-07-28 16:21:09.434087	asadan	ayoung	Millen Road	One Way Path Communities builds multi-residential housing in liveable  communities in and around the Greater Toronto Hamilton Area. These  projects present an opportunity for equity investors to earn high rates  of return with limited risk. Intrested equity and debt partners are  invited to contact info@onewaypath.com for more information.	/millen/index	One Way Path at Millen Road LP	@MILLEN	100 King Street West, Suite 5600	Toronto	Ontario	Canada	M5X 1C9	(416) 848-1746	(416) 848-1162	info@onewaypath.com	millen
\.


--
-- Data for Name: team_bio_bullets; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.team_bio_bullets (id, record_creation_date, record_amend_date, created_by, last_amended_by, team_id, bullet_text, bullet_order) FROM stdin;
1	2023-07-24 06:10:00.689546	2023-07-24 06:10:00.689546	asadan	asadan	1	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
2	2023-07-24 06:10:01.520198	2023-07-24 06:10:01.520198	asadan	asadan	1	Lawyer & member of Law Society of Ontario	2
3	2023-07-24 06:10:02.3972	2023-07-24 06:10:02.3972	asadan	asadan	1	Worked for over 10 years in federal and provincial government	3
7	2023-07-24 06:10:05.674256	2023-07-24 06:10:05.674256	asadan	asadan	3	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
8	2023-07-24 06:10:06.596626	2023-07-24 06:10:06.596626	asadan	asadan	3	Lawyer & member of Law Society of Ontario	2
9	2023-07-24 06:10:07.41539	2023-07-24 06:10:07.41539	asadan	asadan	3	Worked for over 10 years in federal and provincial government	3
10	2023-07-24 06:10:08.33534	2023-07-24 06:10:08.33534	asadan	asadan	4	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
11	2023-07-24 06:10:09.259378	2023-07-24 06:10:09.259378	asadan	asadan	4	Lawyer & member of Law Society of Ontario	2
12	2023-07-24 06:10:09.993357	2023-07-24 06:10:09.993357	asadan	asadan	4	Worked for over 10 years in federal and provincial government	3
13	2023-07-24 06:10:10.731347	2023-07-24 06:10:10.731347	asadan	asadan	5	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
14	2023-07-24 06:10:11.51034	2023-07-24 06:10:11.51034	asadan	asadan	5	Lawyer & member of Law Society of Ontario	2
15	2023-07-24 06:10:12.268389	2023-07-24 06:10:12.268389	asadan	asadan	5	Worked for over 10 years in federal and provincial government	3
16	2023-07-24 06:10:13.148333	2023-07-24 06:10:13.148333	asadan	asadan	6	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
17	2023-07-24 06:10:13.97135	2023-07-24 06:10:13.97135	asadan	asadan	6	Lawyer & member of Law Society of Ontario	2
18	2023-07-24 06:10:15.299538	2023-07-24 06:10:15.299538	asadan	asadan	6	Worked for over 10 years in federal and provincial government	3
19	2023-07-24 06:10:16.159407	2023-07-24 06:10:16.159407	asadan	asadan	7	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
20	2023-07-24 06:10:16.977648	2023-07-24 06:10:16.977648	asadan	asadan	7	Lawyer & member of Law Society of Ontario	2
21	2023-07-24 06:10:17.86073	2023-07-24 06:10:17.86073	asadan	asadan	7	Worked for over 10 years in federal and provincial government	3
22	2023-07-24 06:10:18.77277	2023-07-24 06:10:18.77277	asadan	asadan	8	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
23	2023-07-24 06:10:19.702684	2023-07-24 06:10:19.702684	asadan	asadan	8	Lawyer & member of Law Society of Ontario	2
24	2023-07-24 06:10:20.563581	2023-07-24 06:10:20.563581	asadan	asadan	8	Worked for over 10 years in federal and provincial government	3
25	2023-07-24 06:10:21.44462	2023-07-24 06:10:21.44462	asadan	asadan	9	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
26	2023-07-24 06:10:22.364599	2023-07-24 06:10:22.364599	asadan	asadan	9	Lawyer & member of Law Society of Ontario	2
27	2023-07-24 06:10:23.184876	2023-07-24 06:10:23.184876	asadan	asadan	9	Worked for over 10 years in federal and provincial government	3
28	2023-07-24 06:10:23.987716	2023-07-24 06:10:23.987716	asadan	asadan	10	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
29	2023-07-24 06:10:24.764644	2023-07-24 06:10:24.764644	asadan	asadan	10	Lawyer & member of Law Society of Ontario	2
30	2023-07-24 06:10:25.520604	2023-07-24 06:10:25.520604	asadan	asadan	10	Worked for over 10 years in federal and provincial government	3
31	2023-07-24 06:10:26.460818	2023-07-24 06:10:26.460818	asadan	asadan	11	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
32	2023-07-24 06:10:27.321175	2023-07-24 06:10:27.321175	asadan	asadan	11	Lawyer & member of Law Society of Ontario	2
33	2023-07-24 06:10:28.099973	2023-07-24 06:10:28.099973	asadan	asadan	11	Worked for over 10 years in federal and provincial government	3
34	2023-07-24 06:10:28.919011	2023-07-24 06:10:28.919011	asadan	asadan	12	In private sector, provided financial and legal oversight of large infrastructure programs for First Nations in mining, transportation and energy sectors	1
35	2023-07-24 06:10:29.67699	2023-07-24 06:10:29.67699	asadan	asadan	12	Lawyer & member of Law Society of Ontario	2
36	2023-07-24 06:10:30.558885	2023-07-24 06:10:30.558885	asadan	asadan	12	Worked for over 10 years in federal and provincial government	3
5	2023-07-24 06:10:04.036056	2023-08-22 01:20:48.460563	asadan	ayoung	2	Bullet Order 2	2
6	2023-07-24 06:10:04.7692	2023-08-22 01:20:48.460563	asadan	ayoung	2	Bullet Order 3	3
4	2023-07-24 06:10:03.217708	2023-08-22 01:21:14.230156	asadan	ayoung	2	Bullet Order 1	1
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: asadan
--

COPY public.teams (id, record_creation_date, record_amend_date, created_by, last_amended_by, category, first_name, last_name, "position", company, linkedin, bio_link) FROM stdin;
4	2023-07-24 05:48:40.395273	2023-07-24 05:48:40.395273	asadan	asadan	Planning and Community Engagement	Robert	Walter-Joseph	Urban Planner	Gladki Planning & Associates	\N	\N
5	2023-07-24 05:48:42.879299	2023-07-24 05:48:42.879299	asadan	asadan	Design and Construction	Sam	Spagnuolo	Lead Architect	CS&P Architects	\N	\N
6	2023-07-24 05:48:45.209329	2023-07-24 05:48:45.209329	asadan	asadan	Design and Construction	Aaron	Engel	Construction Manager	AEC Developments	\N	\N
7	2023-07-24 05:48:47.665674	2023-07-24 05:48:47.665674	asadan	asadan	Design and Construction	James	Samuel	Structural Engineer		\N	\N
8	2023-07-24 05:48:50.393539	2023-07-24 05:48:50.393539	asadan	asadan	Design and Construction	Ashraff	Abass	Geotechnical Engineer		\N	\N
9	2023-07-24 05:48:52.742616	2023-07-24 05:48:52.742616	asadan	asadan	Design and Construction	Brian	Verspagen	Civil Engineer	WalterFedy	\N	\N
10	2023-07-24 05:48:55.303751	2023-07-24 05:48:55.303751	asadan	asadan	Finance, Accounting and Legal	Brent	Walker	Financial Advisor	Morrison Park Advisors	\N	\N
11	2023-07-24 05:48:57.966852	2023-07-24 05:48:57.966852	asadan	asadan	Finance, Accounting and Legal	Jennifer	Agro	Assurance Accountant	BDO Canada LLP	\N	\N
12	2023-07-24 05:49:00.523804	2023-07-24 05:49:00.523804	asadan	asadan	Finance, Accounting and Legal	Danny	McMullen	Legal Advisor	Northview Law	\N	\N
13	2023-08-22 01:27:38.801995	2023-08-22 01:27:38.801995	ayoung	ayoung	Finance, Accounting and Legal	Lorenzo	Bonnano	Tax Accountant	BDO Canada LLP	\N	\N
3	2023-07-24 05:48:37.740328	2023-08-22 01:31:03.780259	asadan	ayoung	Planning and Community Engagement	Joe	Mihevc	Community Enagement Lead		\N	\N
2	2023-07-24 05:48:35.010059	2023-08-22 01:33:01.933342	asadan	ayoung	Leadership	Miriam	Young	Director, Health Design	One Way Path Communities	\N	\N
1	2023-07-24 05:48:32.691105	2023-08-22 01:37:29.321869	asadan	ayoung	Leadership	Alex	Young	Director, Finance	One Way Path Communities	\N	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vapor_username
--

COPY public.users (id, name, username) FROM stdin;
\.


--
-- Data for Name: web_pages; Type: TABLE DATA; Schema: public; Owner: ayoung
--

COPY public.web_pages (id, name, leaf_template, project_id, parent_id, time_created) FROM stdin;
\.


--
-- Name: city_planning_progress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.city_planning_progress_id_seq', 20, true);


--
-- Name: community_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.community_services_id_seq', 56, true);


--
-- Name: planning_precedents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.planning_precedents_id_seq', 6, true);


--
-- Name: project_teams_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.project_teams_association_id_seq', 24, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.projects_id_seq', 4, true);


--
-- Name: team_bio_bullets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.team_bio_bullets_id_seq', 36, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: asadan
--

SELECT pg_catalog.setval('public.teams_id_seq', 1, true);


--
-- Name: _fluent_migrations _fluent_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public._fluent_migrations
    ADD CONSTRAINT _fluent_migrations_pkey PRIMARY KEY (id);


--
-- Name: acronym-category-pivot acronym-category-pivot_pkey; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public."acronym-category-pivot"
    ADD CONSTRAINT "acronym-category-pivot_pkey" PRIMARY KEY (id);


--
-- Name: acronyms acronyms_pkey; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public.acronyms
    ADD CONSTRAINT acronyms_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: city_planning_progress city_planning_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_progress
    ADD CONSTRAINT city_planning_progress_pkey PRIMARY KEY (id);


--
-- Name: community_services community_services_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.community_services
    ADD CONSTRAINT community_services_pkey PRIMARY KEY (id);


--
-- Name: city_planning_precedents planning_precedents_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_precedents
    ADD CONSTRAINT planning_precedents_pkey PRIMARY KEY (id);


--
-- Name: project_teams_association project_teams_association_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.project_teams_association
    ADD CONSTRAINT project_teams_association_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: team_bio_bullets team_bio_bullets_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.team_bio_bullets
    ADD CONSTRAINT team_bio_bullets_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: _fluent_migrations uq:_fluent_migrations.name; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public._fluent_migrations
    ADD CONSTRAINT "uq:_fluent_migrations.name" UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: web_pages web_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: ayoung
--

ALTER TABLE ONLY public.web_pages
    ADD CONSTRAINT web_pages_pkey PRIMARY KEY (id);


--
-- Name: city_planning_precedents set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.city_planning_precedents FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: city_planning_progress set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.city_planning_progress FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: community_services set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.community_services FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: project_teams_association set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.project_teams_association FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: projects set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.projects FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: team_bio_bullets set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.team_bio_bullets FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: teams set_last_amended_by; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER set_last_amended_by BEFORE UPDATE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.update_last_amended_by();


--
-- Name: city_planning_precedents update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.city_planning_precedents FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: city_planning_progress update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.city_planning_progress FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: community_services update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.community_services FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: project_teams_association update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.project_teams_association FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: projects update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.projects FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: team_bio_bullets update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.team_bio_bullets FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: teams update_amend_date_trigger; Type: TRIGGER; Schema: public; Owner: asadan
--

CREATE TRIGGER update_amend_date_trigger BEFORE UPDATE ON public.teams FOR EACH ROW EXECUTE FUNCTION public.update_record_amend_date();


--
-- Name: acronym-category-pivot acronym-category-pivot_acronymID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public."acronym-category-pivot"
    ADD CONSTRAINT "acronym-category-pivot_acronymID_fkey" FOREIGN KEY ("acronymID") REFERENCES public.acronyms(id) ON DELETE CASCADE;


--
-- Name: acronym-category-pivot acronym-category-pivot_categoryID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public."acronym-category-pivot"
    ADD CONSTRAINT "acronym-category-pivot_categoryID_fkey" FOREIGN KEY ("categoryID") REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: acronyms acronyms_userID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vapor_username
--

ALTER TABLE ONLY public.acronyms
    ADD CONSTRAINT "acronyms_userID_fkey" FOREIGN KEY ("userID") REFERENCES public.users(id);


--
-- Name: city_planning_progress fk_project_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_progress
    ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: city_planning_precedents fk_project_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.city_planning_precedents
    ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: community_services fk_project_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.community_services
    ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_teams_association fk_project_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.project_teams_association
    ADD CONSTRAINT fk_project_id FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_teams_association fk_team_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.project_teams_association
    ADD CONSTRAINT fk_team_id FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: team_bio_bullets fk_team_id; Type: FK CONSTRAINT; Schema: public; Owner: asadan
--

ALTER TABLE ONLY public.team_bio_bullets
    ADD CONSTRAINT fk_team_id FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: web_pages web_pages_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ayoung
--

ALTER TABLE ONLY public.web_pages
    ADD CONSTRAINT web_pages_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.web_pages(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: vapor_username
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE _fluent_migrations; Type: ACL; Schema: public; Owner: vapor_username
--

GRANT ALL ON TABLE public._fluent_migrations TO ayoung;


--
-- Name: TABLE "acronym-category-pivot"; Type: ACL; Schema: public; Owner: vapor_username
--

GRANT ALL ON TABLE public."acronym-category-pivot" TO ayoung;


--
-- Name: TABLE acronyms; Type: ACL; Schema: public; Owner: vapor_username
--

GRANT ALL ON TABLE public.acronyms TO ayoung;


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: vapor_username
--

GRANT ALL ON TABLE public.categories TO ayoung;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: vapor_username
--

GRANT ALL ON TABLE public.users TO ayoung;


--
-- PostgreSQL database dump complete
--

