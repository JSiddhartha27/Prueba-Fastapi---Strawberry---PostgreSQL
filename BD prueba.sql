PGDMP     .    '             
    z            publication    15.0    15.0                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            
           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16399    publication    DATABASE     ?   CREATE DATABASE publication WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE publication;
                postgres    false                        2615    16400    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false                       0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   postgres    false    5                       0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   postgres    false    5            ?            1259    16435    comments    TABLE     ?   CREATE TABLE public.comments (
    id_comm integer NOT NULL,
    description character varying(250),
    created_at date,
    post_id integer NOT NULL
);
    DROP TABLE public.comments;
       public         heap    postgres    false    5            ?            1259    16433    Comments_id_seq    SEQUENCE     ?   CREATE SEQUENCE public."Comments_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Comments_id_seq";
       public          postgres    false    218    5                       0    0    Comments_id_seq    SEQUENCE OWNED BY     J   ALTER SEQUENCE public."Comments_id_seq" OWNED BY public.comments.id_comm;
          public          postgres    false    216            ?            1259    16434    Comments_post_id_seq    SEQUENCE     ?   CREATE SEQUENCE public."Comments_post_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public."Comments_post_id_seq";
       public          postgres    false    218    5                       0    0    Comments_post_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."Comments_post_id_seq" OWNED BY public.comments.post_id;
          public          postgres    false    217            ?            1259    16405    posts    TABLE     ?   CREATE TABLE public.posts (
    id_post integer NOT NULL,
    descripcion character varying(250),
    video_url character varying,
    created_at date
);
    DROP TABLE public.posts;
       public         heap    postgres    false    5            ?            1259    16408    Posts_id_seq    SEQUENCE     ?   CREATE SEQUENCE public."Posts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Posts_id_seq";
       public          postgres    false    5    214                       0    0    Posts_id_seq    SEQUENCE OWNED BY     D   ALTER SEQUENCE public."Posts_id_seq" OWNED BY public.posts.id_post;
          public          postgres    false    215            l           2604    16438    comments id_comm    DEFAULT     q   ALTER TABLE ONLY public.comments ALTER COLUMN id_comm SET DEFAULT nextval('public."Comments_id_seq"'::regclass);
 ?   ALTER TABLE public.comments ALTER COLUMN id_comm DROP DEFAULT;
       public          postgres    false    218    216    218            m           2604    16439    comments post_id    DEFAULT     v   ALTER TABLE ONLY public.comments ALTER COLUMN post_id SET DEFAULT nextval('public."Comments_post_id_seq"'::regclass);
 ?   ALTER TABLE public.comments ALTER COLUMN post_id DROP DEFAULT;
       public          postgres    false    218    217    218            k           2604    16409    posts id_post    DEFAULT     k   ALTER TABLE ONLY public.posts ALTER COLUMN id_post SET DEFAULT nextval('public."Posts_id_seq"'::regclass);
 <   ALTER TABLE public.posts ALTER COLUMN id_post DROP DEFAULT;
       public          postgres    false    215    214                      0    16435    comments 
   TABLE DATA           M   COPY public.comments (id_comm, description, created_at, post_id) FROM stdin;
    public          postgres    false    218   l                 0    16405    posts 
   TABLE DATA           L   COPY public.posts (id_post, descripcion, video_url, created_at) FROM stdin;
    public          postgres    false    214   ?                  0    0    Comments_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Comments_id_seq"', 1, false);
          public          postgres    false    216                       0    0    Comments_post_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public."Comments_post_id_seq"', 1, false);
          public          postgres    false    217                       0    0    Posts_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Posts_id_seq"', 1, true);
          public          postgres    false    215            q           2606    16441    comments Comments_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT "Comments_pkey" PRIMARY KEY (id_comm);
 B   ALTER TABLE ONLY public.comments DROP CONSTRAINT "Comments_pkey";
       public            postgres    false    218            o           2606    16414    posts Posts_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT "Posts_pkey" PRIMARY KEY (id_post);
 <   ALTER TABLE ONLY public.posts DROP CONSTRAINT "Posts_pkey";
       public            postgres    false    214            r           2606    16442    comments fk_comm_id_post    FK CONSTRAINT     ?   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_comm_id_post FOREIGN KEY (post_id) REFERENCES public.posts(id_post) NOT VALID;
 B   ALTER TABLE ONLY public.comments DROP CONSTRAINT fk_comm_id_post;
       public          postgres    false    3183    214    218               A   x?3?????4200?50?54?4?2??J?JD3?2?t)R??/-N??????ss??qqq ???         R   x?3?LO?M-??())(???????4202?54 ".#Ό?,?$P??H??$j??R???_Z?
?j?p??J?u??b???? ??     