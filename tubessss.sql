/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     30/12/2021 22:27:26                          */
/*==============================================================*/


alter table HAVE
   drop constraint FK_HAVE_HAVE_MOVIES;

alter table HAVE
   drop constraint FK_HAVE_HAVE2_CASTS;

alter table INCLUDE
   drop constraint FK_INCLUDE_INCLUDE_MOVIES;

alter table INCLUDE
   drop constraint FK_INCLUDE_INCLUDE2_MOVIES_G;

alter table MEMBERS
   drop constraint FK_MEMBERS_WANT_PACKAGES;

alter table MOVIES
   drop constraint FK_MOVIES_DIRECTED_DIRECTOR;

alter table MOVIES
   drop constraint FK_MOVIES_WATCH_MEMBERS;

alter table MOVIES_FORMAT
   drop constraint FK_MOVIES_F_HAS_MOVIES;

alter table PACKAGES
   drop constraint FK_PACKAGES_PAY2_PAYMENTS;

alter table SUBTITLES
   drop constraint FK_SUBTITLE_USE_MOVIES;

drop table CASTS cascade constraints;

drop table DIRECTORS cascade constraints;

drop index HAVE2_FK;

drop index HAVE_FK;

drop table HAVE cascade constraints;

drop index INCLUDE2_FK;

drop index INCLUDE_FK;

drop table INCLUDE cascade constraints;

drop index WANT_FK;

drop table MEMBERS cascade constraints;

drop index DIRECTED_FK;

drop index WATCH_FK;

drop table MOVIES cascade constraints;

drop index HAS_FK;

drop table MOVIES_FORMAT cascade constraints;

drop table MOVIES_GENRE cascade constraints;

drop index PAY2_FK;

drop table PACKAGES cascade constraints;

drop table PAYMENTS cascade constraints;

drop index USE_FK;

drop table SUBTITLES cascade constraints;

/*==============================================================*/
/* Table: CASTS                                                 */
/*==============================================================*/
create table CASTS 
(
   ID_CAST              INTEGER              not null,
   FNAME_CAST           VARCHAR2(25)         not null,
   LNAME_CAST           VARCHAR2(25)         not null,
   BIRTH_CAST           DATE,
   GENDER_CAST          CHAR(1)              not null,
   PICTURE              BLOB,
   constraint PK_CASTS primary key (ID_CAST)
);

/*==============================================================*/
/* Table: DIRECTORS                                             */
/*==============================================================*/
create table DIRECTORS 
(
   ID_DIRECTOR          INTEGER              not null,
   FNAME_DIR            VARCHAR2(25)         not null,
   LNAME_DIR            VARCHAR2(25)         not null,
   BIRTH_DIR            DATE,
   GENDER_DIR           CHAR(1)              not null,
   constraint PK_DIRECTORS primary key (ID_DIRECTOR)
);

/*==============================================================*/
/* Table: HAVE                                                  */
/*==============================================================*/
create table HAVE 
(
   ID_MOVIE             INTEGER              not null,
   ID_CAST              INTEGER              not null,
   constraint PK_HAVE primary key (ID_MOVIE, ID_CAST)
);

/*==============================================================*/
/* Index: HAVE_FK                                               */
/*==============================================================*/
create index HAVE_FK on HAVE (
   ID_MOVIE ASC
);

/*==============================================================*/
/* Index: HAVE2_FK                                              */
/*==============================================================*/
create index HAVE2_FK on HAVE (
   ID_CAST ASC
);

/*==============================================================*/
/* Table: INCLUDE                                               */
/*==============================================================*/
create table INCLUDE 
(
   ID_MOVIE             INTEGER              not null,
   ID_GENRE             INTEGER              not null,
   constraint PK_INCLUDE primary key (ID_MOVIE, ID_GENRE)
);

/*==============================================================*/
/* Index: INCLUDE_FK                                            */
/*==============================================================*/
create index INCLUDE_FK on INCLUDE (
   ID_MOVIE ASC
);

/*==============================================================*/
/* Index: INCLUDE2_FK                                           */
/*==============================================================*/
create index INCLUDE2_FK on INCLUDE (
   ID_GENRE ASC
);

/*==============================================================*/
/* Table: MEMBERS                                               */
/*==============================================================*/
create table MEMBERS 
(
   ID_MEMBER            INTEGER              not null,
   ID_PACKAGE           INTEGER              not null,
   USERNAME             VARCHAR2(100)        not null,
   EMAIL                VARCHAR2(50)         not null,
   PASSWORD             VARCHAR2(50)         not null,
   PHONE_NUMBER         VARCHAR2(15)         not null,
   BIRTH                DATE                 not null,
   STATUS               SMALLINT             not null,
   DEVICE               VARCHAR2(20)         not null,
   constraint PK_MEMBERS primary key (ID_MEMBER)
);

/*==============================================================*/
/* Index: WANT_FK                                               */
/*==============================================================*/
create index WANT_FK on MEMBERS (
   ID_PACKAGE ASC
);

/*==============================================================*/
/* Table: MOVIES                                                */
/*==============================================================*/
create table MOVIES 
(
   ID_MOVIE             INTEGER              not null,
   ID_MEMBER            INTEGER              not null,
   ID_DIRECTOR          INTEGER              not null,
   TITLE                VARCHAR2(100)        not null,
   RELEASE_YEAR         INTEGER              not null,
   DURATION             NUMBER,
   RATING               FLOAT                not null,
   COUNTRY              VARCHAR2(100),
   DESCRIPTION          VARCHAR2(5000),
   COVER                BLOB,
   constraint PK_MOVIES primary key (ID_MOVIE)
);

/*==============================================================*/
/* Index: WATCH_FK                                              */
/*==============================================================*/
create index WATCH_FK on MOVIES (
   ID_MEMBER ASC
);

/*==============================================================*/
/* Index: DIRECTED_FK                                           */
/*==============================================================*/
create index DIRECTED_FK on MOVIES (
   ID_DIRECTOR ASC
);

/*==============================================================*/
/* Table: MOVIES_FORMAT                                         */
/*==============================================================*/
create table MOVIES_FORMAT 
(
   ID_FORMAT            INTEGER              not null,
   ID_MOVIE             INTEGER              not null,
   RESOLUTION           NUMBER               not null,
   constraint PK_MOVIES_FORMAT primary key (ID_FORMAT)
);

/*==============================================================*/
/* Index: HAS_FK                                                */
/*==============================================================*/
create index HAS_FK on MOVIES_FORMAT (
   ID_MOVIE ASC
);

/*==============================================================*/
/* Table: MOVIES_GENRE                                          */
/*==============================================================*/
create table MOVIES_GENRE 
(
   ID_GENRE             INTEGER              not null,
   GENRE_NAME           VARCHAR2(20)         not null,
   constraint PK_MOVIES_GENRE primary key (ID_GENRE)
);

/*==============================================================*/
/* Table: PACKAGES                                              */
/*==============================================================*/
create table PACKAGES 
(
   ID_PACKAGE           INTEGER              not null,
   ID_PAYMENT           INTEGER,
   CATEGORY_PACKAGE     VARCHAR2(20)         not null,
   DURATION_PACKAGE     INTEGER              not null,
   PRICE                NUMBER               not null,
   START_DATE           DATE                 not null,
   END_DATE             DATE                 not null,
   constraint PK_PACKAGES primary key (ID_PACKAGE)
);

/*==============================================================*/
/* Index: PAY2_FK                                               */
/*==============================================================*/
create index PAY2_FK on PACKAGES (
   ID_PAYMENT ASC
);

/*==============================================================*/
/* Table: PAYMENTS                                              */
/*==============================================================*/
create table PAYMENTS 
(
   ID_PAYMENT           INTEGER              not null,
   PAYMENT_TYPE         CHAR(1)              not null,
   constraint PK_PAYMENTS primary key (ID_PAYMENT)
);

/*==============================================================*/
/* Table: SUBTITLES                                             */
/*==============================================================*/
create table SUBTITLES 
(
   ID_SUBTITLE          INTEGER              not null,
   ID_MOVIE             INTEGER              not null,
   LANGUAGE             VARCHAR2(255)        not null,
   TEXT                 CLOB                 not null,
   constraint PK_SUBTITLES primary key (ID_SUBTITLE)
);

/*==============================================================*/
/* Index: USE_FK                                                */
/*==============================================================*/
create index USE_FK on SUBTITLES (
   ID_MOVIE ASC
);

alter table HAVE
   add constraint FK_HAVE_HAVE_MOVIES foreign key (ID_MOVIE)
      references MOVIES (ID_MOVIE);

alter table HAVE
   add constraint FK_HAVE_HAVE2_CASTS foreign key (ID_CAST)
      references CASTS (ID_CAST);

alter table INCLUDE
   add constraint FK_INCLUDE_INCLUDE_MOVIES foreign key (ID_MOVIE)
      references MOVIES (ID_MOVIE);

alter table INCLUDE
   add constraint FK_INCLUDE_INCLUDE2_MOVIES_G foreign key (ID_GENRE)
      references MOVIES_GENRE (ID_GENRE);

alter table MEMBERS
   add constraint FK_MEMBERS_WANT_PACKAGES foreign key (ID_PACKAGE)
      references PACKAGES (ID_PACKAGE);

alter table MOVIES
   add constraint FK_MOVIES_DIRECTED_DIRECTOR foreign key (ID_DIRECTOR)
      references DIRECTORS (ID_DIRECTOR);

alter table MOVIES
   add constraint FK_MOVIES_WATCH_MEMBERS foreign key (ID_MEMBER)
      references MEMBERS (ID_MEMBER);

alter table MOVIES_FORMAT
   add constraint FK_MOVIES_F_HAS_MOVIES foreign key (ID_MOVIE)
      references MOVIES (ID_MOVIE);

alter table PACKAGES
   add constraint FK_PACKAGES_PAY2_PAYMENTS foreign key (ID_PAYMENT)
      references PAYMENTS (ID_PAYMENT);

alter table SUBTITLES
   add constraint FK_SUBTITLE_USE_MOVIES foreign key (ID_MOVIE)
      references MOVIES (ID_MOVIE);

