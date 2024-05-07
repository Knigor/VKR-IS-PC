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
-- Name: componets; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.componets (
    id_components integer NOT NULL,
    name_components character varying(100) NOT NULL,
    price_components character varying(200) NOT NULL,
    img_components character varying(200) NOT NULL,
    id_score integer
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
-- Name: review; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.review (
    id_score integer NOT NULL,
    id_user integer NOT NULL,
    text_review text NOT NULL
);


ALTER TABLE public.review OWNER TO "user";

--
-- Name: review_id_score_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.review_id_score_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.review_id_score_seq OWNER TO "user";

--
-- Name: review_id_score_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.review_id_score_seq OWNED BY public.review.id_score;


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
-- Name: componets id_components; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets ALTER COLUMN id_components SET DEFAULT nextval('public.componets_id_components_seq'::regclass);


--
-- Name: property_components id_property; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.property_components ALTER COLUMN id_property SET DEFAULT nextval('public.property_components_id_property_seq'::regclass);


--
-- Name: review id_score; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.review ALTER COLUMN id_score SET DEFAULT nextval('public.review_id_score_seq'::regclass);


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
-- Data for Name: componets; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.componets (id_components, name_components, price_components, img_components, id_score) FROM stdin;
3	Оперативная память Kingston Fury Beast KF432C16BB1K2/32 DDR4 - 2x 16ГБ 3200МГц, DIMM, Ret	10990	memory2.jpg	\N
1	Оперативная память Kingston Fury Beast Black KF432C16BBK2/16 DDR4 - 2x 8ГБ 3200МГц, DIMM, Ret	5990	memory.jpg	\N
4	Оперативная память Patriot Signature PSD48G266681 DDR4 - 1x 8ГБ 2666МГц, DIMM, Ret	2090	memory3.jpg	\N
5	Оперативная память Patriot Viper Elite II PVE2432G400C0K DDR4 - 2x 16ГБ 4000МГц, DIMM, Ret	9990	memory4.jpg	\N
7	Материнская плата MSI PRO H610M-E DDR4, LGA 1700, Intel H610, mATX, Ret	8670	matherboard1.jpg	\N
8	Материнская плата ASUS PRIME B650-PLUS, SocketAM5, AMD B650, ATX, Ret	22610	matherboard2.jpg	\N
9	Материнская плата MSI A520M-A PRO, SocketAM4, AMD A520, mATX, Ret	7220	matherboard3.jpg	\N
11	Материнская плата MSI MPG B550 GAMING PLUS, SocketAM4, AMD B550, ATX, Ret	16890	matherboard4.jpg	\N
12	Видеокарта Palit NVIDIA GeForce RTX 4080 Super RTX4080 SUPER GAMINGPRO 16ГБ GamingPro, GDDR6X, Ret 	147500	videocard.jpg	\N
13	Видеокарта ASUS NVIDIA GeForce RTX 3050 DUAL-RTX3050-O6G 6ГБ Dual, GDDR6, OC, Ret	24900	videocard1.jpg	\N
14	Видеокарта Palit NVIDIA GeForce RTX 3060 PA-RTX3060 DUAL 12G 12ГБ Dual, GDDR6, LHR, Ret	38500	videocard2.jpg	\N
15	Видеокарта GIGABYTE NVIDIA GeForce RTX 3060 GV-N3060GAMING OC-12GD 2.0 LHR 12ГБ GDDR6, OC, LHR, Ret	44100	videocard3.jpg	\N
16	Процессор Intel Core i5 12400F, LGA 1700, OEM [cm8071504650609 srl5z]	14490	cpu1.jpg	\N
17	Процессор AMD Ryzen 3 2200G, AM4, OEM [yd2200c5m4mfb]	7490	cpu2.jpg	\N
6	Оперативная память Kingston Fury Beast Black KF432C16BBK2/32 DDR4 - 2x 16ГБ 3200МГц, DIMM, Ret	9880	memory4.jpg	\N
19	Процессор AMD Ryzen 5 5600, AM4, OEM [100-000000927]	13190	cpu3.jpg	\N
18	Процессор AMD Ryzen 5 5600, AM4, BOX [100-100000927cbx]	15990	cpu3.jpg	\N
\.


--
-- Data for Name: property_components; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.property_components (id_property, value_property, key_property) FROM stdin;
1	Объем	2 x 8 гб
2	Частота	3200МГц
3	Латентность	CL16
4	Тайминги	16-18-18
14	Форм-фактор	mATX
15	Сокет	LGA, 1700; чипсет: Intel Z790
16	Память	частотой до 5600 мГЦ
17	Слоты	PCI-E E 4.0 x16 x 1
18	Разъемы	M.2 x 4
\.


--
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.review (id_score, id_user, text_review) FROM stdin;
1	1	Абоба
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
14	7
15	7
16	7
17	7
18	7
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id_user, email, fio, hash_password, login, role) FROM stdin;
3	test@mail.ru	Давыдов Дмитрий Антонович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	dima	Admin
1	example@mail.ru	Петров Иван Сидорович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	ivan123	Admin
9	test123@mail.ru	Зубенко Михаил Петрович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	aboba	User
10	aboba@mail.ru	Кретов Игорь Олегович	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	aboba1	User
11	test1@mail.ru	Тест Тест Тест	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	test	User
\.


--
-- Name: category_product_id_catergory_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.category_product_id_catergory_seq', 4, true);


--
-- Name: componets_id_components_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.componets_id_components_seq', 19, true);


--
-- Name: property_components_id_property_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.property_components_id_property_seq', 18, true);


--
-- Name: review_id_score_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.review_id_score_seq', 1, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_user_seq', 11, true);


--
-- Name: category_product pk_category_product; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.category_product
    ADD CONSTRAINT pk_category_product PRIMARY KEY (id_catergory);


--
-- Name: componets pk_componets; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets
    ADD CONSTRAINT pk_componets PRIMARY KEY (id_components);


--
-- Name: property_components pk_property_components; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.property_components
    ADD CONSTRAINT pk_property_components PRIMARY KEY (id_property);


--
-- Name: review pk_review; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT pk_review PRIMARY KEY (id_score);


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
-- Name: componets_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX componets_pk ON public.componets USING btree (id_components);


--
-- Name: property_components_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX property_components_pk ON public.property_components USING btree (id_property);


--
-- Name: puts_score_fk; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX puts_score_fk ON public.review USING btree (id_user);


--
-- Name: rating_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX rating_pk ON public.review USING btree (id_score);


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
-- Name: users_pk; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX users_pk ON public.users USING btree (id_user);


--
-- Name: componets fk_componet_stores_re_review; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.componets
    ADD CONSTRAINT fk_componet_stores_re_review FOREIGN KEY (id_score) REFERENCES public.review(id_score) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: review fk_review_puts_revi_users; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT fk_review_puts_revi_users FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON UPDATE RESTRICT ON DELETE RESTRICT;


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

