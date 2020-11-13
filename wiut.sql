--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-1.pgdg16.04+1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_driver; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_driver (
    id integer NOT NULL,
    car_type integer NOT NULL,
    car_speed integer NOT NULL,
    shift_start timestamp with time zone,
    shift_end timestamp with time zone,
    user_id integer NOT NULL
);


ALTER TABLE public.api_driver OWNER TO wiut;

--
-- Name: api_driver_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_driver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_driver_id_seq OWNER TO wiut;

--
-- Name: api_driver_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_driver_id_seq OWNED BY public.api_driver.id;


--
-- Name: api_order; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_order (
    id integer NOT NULL,
    pick_time_window timestamp with time zone,
    drop_time_windows timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    capacity integer NOT NULL,
    weight double precision,
    status integer NOT NULL,
    user_id integer NOT NULL,
    drop_point character varying(42),
    pick_point character varying(42)
);


ALTER TABLE public.api_order OWNER TO wiut;

--
-- Name: api_order_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_order_id_seq OWNER TO wiut;

--
-- Name: api_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_order_id_seq OWNED BY public.api_order.id;


--
-- Name: api_sprint; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_sprint (
    id integer NOT NULL,
    status integer NOT NULL,
    lateness timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    start_time timestamp with time zone,
    finish_time timestamp with time zone,
    driver_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.api_sprint OWNER TO wiut;

--
-- Name: api_sprint_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_sprint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_sprint_id_seq OWNER TO wiut;

--
-- Name: api_sprint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_sprint_id_seq OWNED BY public.api_sprint.id;


--
-- Name: api_user; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_staff boolean NOT NULL,
    dob date,
    phone character varying(60),
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254),
    user_type character varying(60) NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.api_user OWNER TO wiut;

--
-- Name: api_user_groups; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.api_user_groups OWNER TO wiut;

--
-- Name: api_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_groups_id_seq OWNER TO wiut;

--
-- Name: api_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_user_groups_id_seq OWNED BY public.api_user_groups.id;


--
-- Name: api_user_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_id_seq OWNER TO wiut;

--
-- Name: api_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_user_id_seq OWNED BY public.api_user.id;


--
-- Name: api_user_user_permissions; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.api_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.api_user_user_permissions OWNER TO wiut;

--
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.api_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_user_user_permissions_id_seq OWNER TO wiut;

--
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.api_user_user_permissions_id_seq OWNED BY public.api_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO wiut;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO wiut;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO wiut;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO wiut;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO wiut;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO wiut;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO wiut;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO wiut;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO wiut;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO wiut;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO wiut;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wiut
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO wiut;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiut
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: wiut
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO wiut;

--
-- Name: api_driver id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_driver ALTER COLUMN id SET DEFAULT nextval('public.api_driver_id_seq'::regclass);


--
-- Name: api_order id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_order ALTER COLUMN id SET DEFAULT nextval('public.api_order_id_seq'::regclass);


--
-- Name: api_sprint id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_sprint ALTER COLUMN id SET DEFAULT nextval('public.api_sprint_id_seq'::regclass);


--
-- Name: api_user id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user ALTER COLUMN id SET DEFAULT nextval('public.api_user_id_seq'::regclass);


--
-- Name: api_user_groups id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_groups ALTER COLUMN id SET DEFAULT nextval('public.api_user_groups_id_seq'::regclass);


--
-- Name: api_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.api_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: api_driver; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_driver (id, car_type, car_speed, shift_start, user_id) FROM stdin;
\.


--
-- Data for Name: api_order; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_order (id, pick_time_window, drop_time_windows, created_at, capacity, weight, status, user_id, drop_point, pick_point) FROM stdin;
\.


--
-- Data for Name: api_sprint; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_sprint (id, status, lateness, created_at, start_time, finish_time, driver_id, order_id) FROM stdin;
\.


--
-- Data for Name: api_user; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_user (id, password, last_login, is_superuser, is_staff, dob, phone, username, first_name, last_name, email, user_type, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$180000$wCJqRdlDsMei$770VzPPVfz5FdiHnBF+6qU3SbhfXsivxfJ42xyqL9ZE=	2019-12-21 23:25:22.758328+05	t	t	\N	\N	admin					t	2019-12-21 23:25:18.855759+05
\.


--
-- Data for Name: api_user_groups; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: api_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.api_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add order	7	add_order
26	Can change order	7	change_order
27	Can delete order	7	delete_order
28	Can view order	7	view_order
29	Can add driver	8	add_driver
30	Can change driver	8	change_driver
31	Can delete driver	8	delete_driver
32	Can view driver	8	view_driver
33	Can add sprint	9	add_sprint
34	Can change sprint	9	change_sprint
35	Can delete sprint	9	delete_sprint
36	Can view sprint	9	view_sprint
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	api	user
7	api	order
8	api	driver
9	api	sprint
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-12-21 22:46:37.884087+05
2	contenttypes	0002_remove_content_type_name	2019-12-21 22:46:37.931263+05
3	auth	0001_initial	2019-12-21 22:46:38.292542+05
4	auth	0002_alter_permission_name_max_length	2019-12-21 22:46:38.662249+05
5	auth	0003_alter_user_email_max_length	2019-12-21 22:46:38.69779+05
6	auth	0004_alter_user_username_opts	2019-12-21 22:46:38.713651+05
7	auth	0005_alter_user_last_login_null	2019-12-21 22:46:38.723926+05
8	auth	0006_require_contenttypes_0002	2019-12-21 22:46:38.730829+05
9	auth	0007_alter_validators_add_error_messages	2019-12-21 22:46:38.747694+05
10	auth	0008_alter_user_username_max_length	2019-12-21 22:46:38.758865+05
11	auth	0009_alter_user_last_name_max_length	2019-12-21 22:46:38.768608+05
12	auth	0010_alter_group_name_max_length	2019-12-21 22:46:38.780123+05
13	auth	0011_update_proxy_permissions	2019-12-21 22:46:38.790206+05
14	api	0001_initial	2019-12-21 22:46:39.081207+05
15	admin	0001_initial	2019-12-21 22:46:39.571151+05
16	admin	0002_logentry_remove_auto_add	2019-12-21 22:46:39.712219+05
17	admin	0003_logentry_add_action_flag_choices	2019-12-21 22:46:39.733279+05
18	sessions	0001_initial	2019-12-21 22:46:39.85099+05
19	api	0002_driver_order_sprint	2019-12-21 22:51:20.343422+05
20	api	0003_auto_20191223_1924	2019-12-24 00:24:56.61623+05
21	api	0004_auto_20191223_1943	2019-12-24 00:43:57.998953+05
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: wiut
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
q5ljzkplxfoego4bekmrv64y4t5wtcd8	ZDFhN2ZmYmYzNTNmMWViNGQxOGEyNzRiNTQ2OTU2YjkxYmI3ZTdlNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNmE0NmNkNGQ2MDFlMmIxYTFiN2ZiMjFkYTUxN2UyNTAzZGVjZDQxIn0=	2020-01-04 23:25:22.804486+05
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: api_driver_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_driver_id_seq', 1, false);


--
-- Name: api_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_order_id_seq', 1, false);


--
-- Name: api_sprint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_sprint_id_seq', 1, false);


--
-- Name: api_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_user_groups_id_seq', 1, false);


--
-- Name: api_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_user_id_seq', 1, true);


--
-- Name: api_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.api_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 36, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 9, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiut
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 21, true);


--
-- Name: api_driver api_driver_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_driver
    ADD CONSTRAINT api_driver_pkey PRIMARY KEY (id);


--
-- Name: api_order api_order_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_pkey PRIMARY KEY (id);


--
-- Name: api_sprint api_sprint_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_sprint
    ADD CONSTRAINT api_sprint_pkey PRIMARY KEY (id);


--
-- Name: api_user_groups api_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_pkey PRIMARY KEY (id);


--
-- Name: api_user_groups api_user_groups_user_id_group_id_9c7ddfb5_uniq; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_group_id_9c7ddfb5_uniq UNIQUE (user_id, group_id);


--
-- Name: api_user api_user_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_pkey PRIMARY KEY (id);


--
-- Name: api_user_user_permissions api_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: api_user_user_permissions api_user_user_permissions_user_id_permission_id_a06dd704_uniq; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_permission_id_a06dd704_uniq UNIQUE (user_id, permission_id);


--
-- Name: api_user api_user_username_key; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user
    ADD CONSTRAINT api_user_username_key UNIQUE (username);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: api_driver_user_id_15aa6cdd; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_driver_user_id_15aa6cdd ON public.api_driver USING btree (user_id);


--
-- Name: api_order_user_id_52781ff0; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_order_user_id_52781ff0 ON public.api_order USING btree (user_id);


--
-- Name: api_sprint_driver_id_2e5b9bbb; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_sprint_driver_id_2e5b9bbb ON public.api_sprint USING btree (driver_id);


--
-- Name: api_sprint_order_id_57bb95a4; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_sprint_order_id_57bb95a4 ON public.api_sprint USING btree (order_id);


--
-- Name: api_user_groups_group_id_3af85785; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_user_groups_group_id_3af85785 ON public.api_user_groups USING btree (group_id);


--
-- Name: api_user_groups_user_id_a5ff39fa; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_user_groups_user_id_a5ff39fa ON public.api_user_groups USING btree (user_id);


--
-- Name: api_user_user_permissions_permission_id_305b7fea; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_user_user_permissions_permission_id_305b7fea ON public.api_user_user_permissions USING btree (permission_id);


--
-- Name: api_user_user_permissions_user_id_f3945d65; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_user_user_permissions_user_id_f3945d65 ON public.api_user_user_permissions USING btree (user_id);


--
-- Name: api_user_username_cf4e88d2_like; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX api_user_username_cf4e88d2_like ON public.api_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: wiut
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: api_driver api_driver_user_id_15aa6cdd_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_driver
    ADD CONSTRAINT api_driver_user_id_15aa6cdd_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_order api_order_user_id_52781ff0_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_order
    ADD CONSTRAINT api_order_user_id_52781ff0_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_sprint api_sprint_driver_id_2e5b9bbb_fk_api_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_sprint
    ADD CONSTRAINT api_sprint_driver_id_2e5b9bbb_fk_api_driver_id FOREIGN KEY (driver_id) REFERENCES public.api_driver(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_sprint api_sprint_order_id_57bb95a4_fk_api_order_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_sprint
    ADD CONSTRAINT api_sprint_order_id_57bb95a4_fk_api_order_id FOREIGN KEY (order_id) REFERENCES public.api_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_user_groups api_user_groups_group_id_3af85785_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_group_id_3af85785_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_user_groups api_user_groups_user_id_a5ff39fa_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_groups
    ADD CONSTRAINT api_user_groups_user_id_a5ff39fa_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_user_user_permissions api_user_user_permis_permission_id_305b7fea_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permis_permission_id_305b7fea_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_user_user_permissions api_user_user_permissions_user_id_f3945d65_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.api_user_user_permissions
    ADD CONSTRAINT api_user_user_permissions_user_id_f3945d65_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_api_user_id; Type: FK CONSTRAINT; Schema: public; Owner: wiut
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_user_id FOREIGN KEY (user_id) REFERENCES public.api_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

