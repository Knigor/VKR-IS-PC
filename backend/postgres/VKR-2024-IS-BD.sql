--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category_product; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.category_product (
    id_catergory integer NOT NULL,
    name_category character varying(100) NOT NULL
);


ALTER TABLE public.category_product OWNER TO "user";

--
-- Name: category_product_id_catergory_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.category_product_id_catergory_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_product_id_catergory_seq OWNER TO "user";

--
-- Name: category_product_id_catergory_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.category_product_id_catergory_seq OWNED BY public.category_product.id_catergory;


--
-- Name: components_stock; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.components_stock (
    stock_id integer NOT NULL,
    id_components integer,
    quantity_stock integer NOT NULL
);


ALTER TABLE public.components_stock OWNER TO "user";

--
-- Name: components_stock_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.components_stock_stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.components_stock_stock_id_seq OWNER TO "user";

--
-- Name: components_stock_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.components_stock_stock_id_seq OWNED BY public.components_stock.stock_id;


--
-- Name: componets; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.componets (
    id_components integer NOT NULL,
    id_score integer,
    name_components character varying(100) NOT NULL,
    price_components character varying(200) NOT NULL,
    img_components character varying(200) NOT NULL
);


ALTER TABLE public.componets OWNER TO "user";

--
-- Name: componets_id_components_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.componets_id_components_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.componets_id_components_seq OWNER TO "user";

--
-- Name: componets_id_components_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.componets_id_components_seq OWNED BY public.componets.id_components;


--
-- Name: order; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public."order" (
    id_order integer NOT NULL,
    id_user integer NOT NULL,
    id_components integer,
    date_order date NOT NULL,
    status_order character varying(50) NOT NULL,
    phone character varying(40) NOT NULL,
    quantity integer
);


ALTER TABLE public."order" OWNER TO "user";

--
-- Name: order_id_order_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.order_id_order_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_order_seq OWNER TO "user";

--
-- Name: order_id_order_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.order_id_order_seq OWNED BY public."order".id_order;


--
-- Name: property_components; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.property_components (
    id_property integer NOT NULL,
    value_property character varying(255) NOT NULL,
    key_property character varying(255) NOT NULL
);


ALTER TABLE public.property_components OWNER TO "user";

--
-- Name: property_components_id_property_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.property_components_id_property_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.property_components_id_property_seq OWNER TO "user";

--
-- Name: property_components_id_property_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.property_components_id_property_seq OWNED BY public.property_components.id_property;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.rating (
    id_score integer NOT NULL,
    id_user integer NOT NULL,
    score integer NOT NULL
);


ALTER TABLE public.rating OWNER TO "user";

--
-- Name: rating_id_score_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.rating_id_score_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rating_id_score_seq OWNER TO "user";

--
-- Name: rating_id_score_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.rating_id_score_seq OWNED BY public.rating.id_score;


--
-- Name: stores_product; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.stores_product (
    id_catergory integer NOT NULL,
    id_components integer NOT NULL
);


ALTER TABLE public.stores_product OWNER TO "user";

--
-- Name: stores_property; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.stores_property (
    id_property integer NOT NULL,
    id_components integer NOT NULL
);


ALTER TABLE public.stores_property OWNER TO "user";

--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id_user integer NOT NULL,
    email character varying(100) NOT NULL,
    fio character varying(100) NOT NULL,
    hash_password character varying(255) NOT NULL,
    login character varying(20) NOT NULL,
    role character varying(30) NOT NULL
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_user_seq OWNER TO "user";

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- Name: category_product id_catergory; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.category_product ALTER COLUMN id_catergory SET DEFAULT nextval('public.category_product_id_catergory_seq'::regclass);


--
-- Name: components_stock stock_id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.components_stock ALTER COLUMN stock_id SET DEFAULT nextval('public.components_stock_stock_id_seq'::regclass);


--
-- Name: componets id_components; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets ALTER COLUMN id_components SET DEFAULT nextval('public.componets_id_components_seq'::regclass);


--
-- Name: order id_order; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."order" ALTER COLUMN id_order SET DEFAULT nextval('public.order_id_order_seq'::regclass);


--
-- Name: property_components id_property; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.property_components ALTER COLUMN id_property SET DEFAULT nextval('public.property_components_id_property_seq'::regclass);


--
-- Name: rating id_score; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.rating ALTER COLUMN id_score SET DEFAULT nextval('public.rating_id_score_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Data for Name: category_product; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.category_product (id_catergory, name_category) FROM stdin;
1	Материнская плата
2	Видеокарта
3	Оперативная память
4	Процессор
\.


--
-- Data for Name: components_stock; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.components_stock (stock_id, id_components, quantity_stock) FROM stdin;
1	1	5
\.


--
-- Data for Name: componets; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.componets (id_components, id_score, name_components, price_components, img_components) FROM stdin;
3	\N	Оперативная память Kingston Fury Beast KF432C16BB1K2/32 DDR4 - 2x 16ГБ 3200МГц, DIMM, Ret	10990	memory2.jpg
1	1	Оперативная память Kingston Fury Beast Black KF432C16BBK2/16 DDR4 - 2x 8ГБ 3200МГц, DIMM, Ret	5990	memory.jpg
4	\N	Оперативная память Patriot Signature PSD48G266681 DDR4 - 1x 8ГБ 2666МГц, DIMM, Ret	2090	memory3.jpg
5	\N	Оперативная память Patriot Viper Elite II PVE2432G400C0K DDR4 - 2x 16ГБ 4000МГц, DIMM, Ret	9990	memory4.jpg
7	\N	Материнская плата MSI PRO H610M-E DDR4, LGA 1700, Intel H610, mATX, Ret	8670	matherboard1.jpg
8	\N	Материнская плата ASUS PRIME B650-PLUS, SocketAM5, AMD B650, ATX, Ret	22610	matherboard2.jpg
9	\N	Материнская плата MSI A520M-A PRO, SocketAM4, AMD A520, mATX, Ret	7220	matherboard3.jpg
11	\N	Материнская плата MSI MPG B550 GAMING PLUS, SocketAM4, AMD B550, ATX, Ret	16890	matherboard4.jpg
12	\N	Видеокарта Palit NVIDIA GeForce RTX 4080 Super RTX4080 SUPER GAMINGPRO 16ГБ GamingPro, GDDR6X, Ret 	147500	videocard.jpg
13	\N	Видеокарта ASUS NVIDIA GeForce RTX 3050 DUAL-RTX3050-O6G 6ГБ Dual, GDDR6, OC, Ret	24900	videocard1.jpg
14	\N	Видеокарта Palit NVIDIA GeForce RTX 3060 PA-RTX3060 DUAL 12G 12ГБ Dual, GDDR6, LHR, Ret	38500	videocard2.jpg
15	\N	Видеокарта GIGABYTE NVIDIA GeForce RTX 3060 GV-N3060GAMING OC-12GD 2.0 LHR 12ГБ GDDR6, OC, LHR, Ret	44100	videocard3.jpg
16	\N	Процессор Intel Core i5 12400F, LGA 1700, OEM [cm8071504650609 srl5z]	14490	cpu1.jpg
17	\N	Процессор AMD Ryzen 3 2200G, AM4, OEM [yd2200c5m4mfb]	7490	cpu2.jpg
6	\N	Оперативная память Kingston Fury Beast Black KF432C16BBK2/32 DDR4 - 2x 16ГБ 3200МГц, DIMM, Ret	9880	memory4.jpg
19	\N	Процессор AMD Ryzen 5 5600, AM4, OEM [100-000000927]	13190	cpu3.jpg
18	\N	Процессор AMD Ryzen 5 5600, AM4, BOX [100-100000927cbx]	15990	cpu3.jpg
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."order" (id_order, id_user, id_components, date_order, status_order, phone, quantity) FROM stdin;
1	1	1	2024-04-04	В процессе	88005553535	2
\.


--
-- Data for Name: property_components; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.property_components (id_property, value_property, key_property) FROM stdin;
1	Объем	2 x 8 гб
2	Частота	3200МГц
3	Латентность	CL16
4	Тайминги	16-18-18
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.rating (id_score, id_user, score) FROM stdin;
1	1	4
\.


--
-- Data for Name: stores_product; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.stores_product (id_catergory, id_components) FROM stdin;
3	1
3	3
3	4
3	5
3	6
1	7
1	8
1	9
1	11
2	12
2	13
2	14
2	15
4	16
4	17
4	18
4	19
\.


--
-- Data for Name: stores_property; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.stores_property (id_property, id_components) FROM stdin;
1	1
2	1
3	1
4	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id_user, email, fio, hash_password, login, role) FROM stdin;
3	test@mail.ru	Давыдов Дмитрий Антонович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	dima	Admin
1	example@mail.ru	Петров Иван Сидорович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	ivan123	Admin
9	test123@mail.ru	Зубенко Михаил Петрович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	aboba	User
\.


--
-- Name: category_product_id_catergory_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.category_product_id_catergory_seq', 4, true);


--
-- Name: components_stock_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.components_stock_stock_id_seq', 1, true);


--
-- Name: componets_id_components_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.componets_id_components_seq', 19, true);


--
-- Name: order_id_order_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_id_order_seq', 1, true);


--
-- Name: property_components_id_property_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.property_components_id_property_seq', 13, true);


--
-- Name: rating_id_score_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.rating_id_score_seq', 1, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_user_seq', 9, true);


--
-- Name: category_product pk_category_product; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.category_product
    ADD CONSTRAINT pk_category_product PRIMARY KEY (id_catergory);


--
-- Name: components_stock pk_components_stock; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.components_stock
    ADD CONSTRAINT pk_components_stock PRIMARY KEY (stock_id);


--
-- Name: componets pk_componets; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets
    ADD CONSTRAINT pk_componets PRIMARY KEY (id_components);


--
-- Name: order pk_order; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT pk_order PRIMARY KEY (id_order);


--
-- Name: property_components pk_property_components; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.property_components
    ADD CONSTRAINT pk_property_components PRIMARY KEY (id_property);


--
-- Name: rating pk_rating; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT pk_rating PRIMARY KEY (id_score);


--
-- Name: stores_product pk_stores_product; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_product
    ADD CONSTRAINT pk_stores_product PRIMARY KEY (id_catergory, id_components);


--
-- Name: stores_property pk_stores_property; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_property
    ADD CONSTRAINT pk_stores_property PRIMARY KEY (id_property, id_components);


--
-- Name: users pk_users; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_users PRIMARY KEY (id_user);


--
-- Name: category_product_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX category_product_pk ON public.category_product USING btree (id_catergory);


--
-- Name: components_stock_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX components_stock_pk ON public.components_stock USING btree (stock_id);


--
-- Name: componets_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX componets_pk ON public.componets USING btree (id_components);


--
-- Name: makes_order_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX makes_order_fk ON public."order" USING btree (id_user);


--
-- Name: order_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX order_pk ON public."order" USING btree (id_order);


--
-- Name: property_components_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX property_components_pk ON public.property_components USING btree (id_property);


--
-- Name: puts_score_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX puts_score_fk ON public.rating USING btree (id_user);


--
-- Name: rating_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX rating_pk ON public.rating USING btree (id_score);


--
-- Name: stores_category_product_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_category_product_fk ON public.stores_product USING btree (id_catergory);


--
-- Name: stores_product2_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_product2_fk ON public.stores_product USING btree (id_components);


--
-- Name: stores_product_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX stores_product_pk ON public.stores_product USING btree (id_catergory, id_components);


--
-- Name: stores_property_components_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_property_components_fk ON public.stores_property USING btree (id_components);


--
-- Name: stores_property_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_property_fk ON public.stores_property USING btree (id_property);


--
-- Name: stores_property_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX stores_property_pk ON public.stores_property USING btree (id_property, id_components);


--
-- Name: stores_rating_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_rating_fk ON public.componets USING btree (id_score);


--
-- Name: stores_stock_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX stores_stock_fk ON public.components_stock USING btree (id_components);


--
-- Name: users_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX users_pk ON public.users USING btree (id_user);


--
-- Name: components_stock fk_componen_stores_st_componet; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.components_stock
    ADD CONSTRAINT fk_componen_stores_st_componet FOREIGN KEY (id_components) REFERENCES public.componets(id_components) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: componets fk_componet_stores_ra_rating; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets
    ADD CONSTRAINT fk_componet_stores_ra_rating FOREIGN KEY (id_score) REFERENCES public.rating(id_score) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: order fk_order_makes_ord_users; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_order_makes_ord_users FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: order fk_order_stores_co_componet; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_order_stores_co_componet FOREIGN KEY (id_components) REFERENCES public.componets(id_components) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: rating fk_rating_puts_scor_users; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT fk_rating_puts_scor_users FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: stores_product fk_stores_p_stores_ca_category; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_product
    ADD CONSTRAINT fk_stores_p_stores_ca_category FOREIGN KEY (id_catergory) REFERENCES public.category_product(id_catergory) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: stores_product fk_stores_p_stores_pr_componet; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_product
    ADD CONSTRAINT fk_stores_p_stores_pr_componet FOREIGN KEY (id_components) REFERENCES public.componets(id_components) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: stores_property fk_stores_p_stores_pr_componet; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_property
    ADD CONSTRAINT fk_stores_p_stores_pr_componet FOREIGN KEY (id_components) REFERENCES public.componets(id_components) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: stores_property fk_stores_p_stores_pr_property; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.stores_property
    ADD CONSTRAINT fk_stores_p_stores_pr_property FOREIGN KEY (id_property) REFERENCES public.property_components(id_property) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

