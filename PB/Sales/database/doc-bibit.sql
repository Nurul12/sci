
DBSCHEMA Schema Utility       INFORMIX-SQL Version 7.24.UC5  
Copyright (C) Informix Software, Inc., 1984-1997
Software Serial Number AAD#J223463
grant dba to "mis";
grant dba to "hendra";
grant dba to "ratna";
grant dba to "doc";
grant dba to "dba";
grant dba to "atik";
grant dba to "tono";
grant dba to "lyana";
grant dba to "ninuk";
grant dba to "yuni";
grant dba to "ana";
grant dba to "ndari";
grant dba to "husni";
grant dba to "vina";
grant dba to "winarsih";
grant dba to "ronald";
grant dba to "nita";
grant dba to "naldo";
grant dba to "tjandra";
grant connect to "user";
grant dba to "eva";
grant dba to "yoko";
grant dba to "liya";
grant dba to "titin";
grant dba to "susilo";
grant dba to "lia";
grant dba to "romadin";
grant dba to "aini";
grant dba to "rohma";
grant dba to "davidtsl";
grant dba to "test";
grant dba to "pipit";
grant dba to "rifka";
grant dba to "sukma";
grant dba to "mutia";
grant dba to "indah";
grant dba to "indahdoc";
grant connect to "public";
grant dba to "amin";

{ TABLE "informix".pbcattbl row size = 368 number of columns = 25 index size = 45 
              }
create table "informix".pbcattbl 
  (
    pbt_tnam char(18) not null ,
    pbt_tid integer,
    pbt_ownr char(8) not null ,
    pbd_fhgt smallint,
    pbd_fwgt smallint,
    pbd_fitl char(1),
    pbd_funl char(1),
    pbd_fchr smallint,
    pbd_fptc smallint,
    pbd_ffce char(18),
    pbh_fhgt smallint,
    pbh_fwgt smallint,
    pbh_fitl char(1),
    pbh_funl char(1),
    pbh_fchr smallint,
    pbh_fptc smallint,
    pbh_ffce char(18),
    pbl_fhgt smallint,
    pbl_fwgt smallint,
    pbl_fitl char(1),
    pbl_funl char(1),
    pbl_fchr smallint,
    pbl_fptc smallint,
    pbl_ffce char(18),
    pbt_cmnt char(254)
  );
revoke all on "informix".pbcattbl from "public";

create unique index "informix".pbcattbl_idx on "informix".pbcattbl 
    (pbt_tnam,pbt_ownr);
{ TABLE "informix".pbcatcol row size = 1422 number of columns = 19 index size = 72 
              }
create table "informix".pbcatcol 
  (
    pbc_tnam char(18) not null ,
    pbc_tid integer,
    pbc_ownr char(8) not null ,
    pbc_cnam char(18) not null ,
    pbc_labl char(254),
    pbc_lpos smallint,
    pbc_hdr char(254),
    pbc_hpos smallint,
    pbc_jtfy smallint,
    pbc_mask char(30),
    pbc_case smallint,
    pbc_hght smallint,
    pbc_wdth smallint,
    pbc_ptrn char(30),
    pbc_bmap char(1),
    pbc_init char(254),
    pbc_edit char(31),
    pbc_cmnt char(254),
    pbc_tag char(254)
  );
revoke all on "informix".pbcatcol from "public";

create unique index "informix".pbccol_idx on "informix".pbcatcol 
    (pbc_tnam,pbc_ownr,pbc_cnam);
{ TABLE "informix".pbcatfmt row size = 290 number of columns = 4 index size = 51 
              }
create table "informix".pbcatfmt 
  (
    pbf_name char(30) not null ,
    pbf_frmt char(254) not null ,
    pbf_type smallint not null ,
    pbf_cntr integer not null 
  );
revoke all on "informix".pbcatfmt from "public";

create unique index "informix".pbcatfmt_idx on "informix".pbcatfmt 
    (pbf_name);
{ TABLE "informix".pbcatvld row size = 544 number of columns = 5 index size = 51 
              }
create table "informix".pbcatvld 
  (
    pbv_name char(30) not null ,
    pbv_vald char(254) not null ,
    pbv_type smallint not null ,
    pbv_cntr integer not null ,
    pbv_msg char(254)
  );
revoke all on "informix".pbcatvld from "public";

create unique index "informix".pbcatvld_idx on "informix".pbcatvld 
    (pbv_name);
{ TABLE "informix".pbcatedt row size = 328 number of columns = 7 index size = 54 
              }
create table "informix".pbcatedt 
  (
    pbe_name char(30) not null ,
    pbe_edit char(254),
    pbe_type smallint,
    pbe_cntr integer,
    pbe_seqn smallint,
    pbe_flag integer,
    pbe_work char(32)
  );
revoke all on "informix".pbcatedt from "public";

create unique index "informix".pbcatedt_idx on "informix".pbcatedt 
    (pbe_name,pbe_seqn);
{ TABLE "mis".sysgroup row size = 49 number of columns = 11 index size = 36 }
create table "mis".sysgroup 
  (
    group_id char(10) not null ,
    appl_id char(10) not null ,
    add char(1),
    modify char(1),
    del char(1),
    s1 char(1),
    s2 char(1),
    create_by char(8) not null ,
    create_date date not null ,
    update_by char(8),
    update_date date
  );
revoke all on "mis".sysgroup from "public";

create unique index "mis".sysgroup_idx on "mis".sysgroup (group_id,
    appl_id);
{ TABLE "mis".userid row size = 74 number of columns = 5 index size = 18 }
create table "mis".userid 
  (
    u_id char(8) not null ,
    u_name char(30) not null ,
    u_class char(10) not null ,
    u_level smallint,
    u_pswd char(24)
  );
revoke all on "mis".userid from "public";

create unique index "mis".userid_idx on "mis".userid (u_id);
{ TABLE "mis".cnmas row size = 234 number of columns = 14 index size = 18 }
create table "mis".cnmas 
  (
    cnnum char(8) not null constraint "mis".n105_27,
    custnum char(8) not null ,
    cndate date not null constraint "mis".n105_28,
    cnstatus char(1) not null constraint "mis".n105_29,
    cnref char(20),
    cnamt money(16,2) not null constraint "mis".n105_30,
    cnrem1 char(30),
    cnrem2 char(30),
    cnrem3 char(30),
    cnrem4 char(30),
    create_by char(20) not null constraint "mis".n105_31,
    create_date date not null constraint "mis".n105_32,
    update_by char(20),
    update_date char(20)
  );
revoke all on "mis".cnmas from "public";

create unique index "mis".cnmas_idx on "mis".cnmas (cnnum);
{ TABLE "mis".dnmas row size = 234 number of columns = 14 index size = 18 }
create table "mis".dnmas 
  (
    dnnum char(8) not null constraint "mis".n106_33,
    custnum char(8) not null ,
    dndate date not null constraint "mis".n106_34,
    dnstatus char(1) not null constraint "mis".n106_35,
    dnref char(20),
    dnamt money(16,2) not null constraint "mis".n106_36,
    dnrem1 char(30),
    dnrem2 char(30),
    dnrem3 char(30),
    dnrem4 char(30),
    create_by char(20) not null constraint "mis".n106_37,
    create_date date not null constraint "mis".n106_38,
    update_by char(20),
    update_date char(20)
  );
revoke all on "mis".dnmas from "public";

create unique index "mis".dnmas_idx on "mis".dnmas (dnnum);
{ TABLE "mis".sysuser row size = 100 number of columns = 4 index size = 21 }
create table "mis".sysuser 
  (
    user_id char(10),
    user_password char(50),
    user_name char(30),
    group_id char(10)
  );
revoke all on "mis".sysuser from "public";

create unique index "mis".sysuser_idx on "mis".sysuser (user_id);
    
{ TABLE "mis".sysgrouphdr row size = 60 number of columns = 2 index size = 21 }
create table "mis".sysgrouphdr 
  (
    group_id char(10),
    group_desc char(50)
  );
revoke all on "mis".sysgrouphdr from "public";

create unique index "mis".sysgrouphdr_idx on "mis".sysgrouphdr 
    (group_id);
{ TABLE "mis".sysgroupdet row size = 46 number of columns = 10 index size = 51 }
create table "mis".sysgroupdet 
  (
    group_id char(10),
    menu_id char(20),
    group_add smallint,
    group_modify smallint,
    group_delete smallint,
    group_s1 smallint,
    group_s2 smallint,
    group_s3 smallint,
    group_s4 smallint,
    group_s5 smallint
  );
revoke all on "mis".sysgroupdet from "public";

create unique index "mis".sysgroupdet_idx on "mis".sysgroupdet 
    (group_id,menu_id);
{ TABLE "mis".sysmenu row size = 58 number of columns = 4 index size = 36 }
create table "mis".sysmenu 
  (
    menu_id char(20),
    menu_desc char(30),
    menu_sort integer,
    menu_level integer
  );
revoke all on "mis".sysmenu from "public";

create unique index "mis".sysmenu_idx on "mis".sysmenu (menu_id);
    
{ TABLE "mis".company row size = 162 number of columns = 8 index size = 0 }
create table "mis".company 
  (
    cp_name char(30),
    cp_addr1 char(30),
    cp_addr2 char(30),
    cp_addr3 char(24),
    cp_post_code char(6),
    cp_phone char(12),
    cp_fax char(12),
    cp_telex char(18)
  );
revoke all on "mis".company from "public";

{ TABLE "mis".plan_hdr row size = 63 number of columns = 7 index size = 18 }
create table "mis".plan_hdr 
  (
    plan_num char(8) not null ,
    attn char(30),
    status char(1),
    create_by char(8),
    create_date date,
    update_by char(8),
    update_date date,
    primary key (plan_num) 
  );
revoke all on "mis".plan_hdr from "public";

{ TABLE "mis".plan_det row size = 82 number of columns = 6 index size = 48 }
create table "mis".plan_det 
  (
    plan_num char(8) not null ,
    custnum char(8) not null ,
    subcode char(8) not null ,
    plan_dt date not null ,
    qty integer,
    remark char(50),
    primary key (plan_num,custnum,subcode,plan_dt) 
  );
revoke all on "mis".plan_det from "public";

{ TABLE "mis".area row size = 69 number of columns = 7 index size = 21 }
create table "mis".area 
  (
    areanum char(10),
    areadesc char(30),
    areastat char(1),
    create_by char(10),
    create_date date,
    update_by char(10),
    update_date date,
    primary key (areanum) 
  );
revoke all on "mis".area from "public";

{ TABLE "mis".sdomas2 row size = 81 number of columns = 11 index size = 18 }
create table "mis".sdomas2 
  (
    donum char(8) not null ,
    dostat char(1) not null ,
    dodate date not null ,
    custnum char(8) not null ,
    subcode char(8) not null ,
    batch char(8),
    scode char(8),
    create_by char(8) not null ,
    create_date date not null ,
    update_by char(20),
    update_date date,
    primary key (donum) 
  );
revoke all on "mis".sdomas2 from "public";

{ TABLE "mis".sdodet2 row size = 107 number of columns = 9 index size = 30 }
create table "mis".sdodet2 
  (
    donum char(8) not null ,
    icode char(8) not null ,
    uprice decimal(16,2) not null ,
    qty integer not null ,
    remark char(30),
    create_by char(20) not null ,
    create_date date not null ,
    update_by char(20),
    update_date date,
    primary key (donum,icode) 
  );
revoke all on "mis".sdodet2 from "public";

{ TABLE "mis".sysset row size = 316 number of columns = 10 index size = 51 }
create table "mis".sysset 
  (
    moducd char(20),
    settype char(10),
    settnm char(150),
    textvl char(100),
    numevl decimal(20,6),
    statcd char(1),
    create_by char(8),
    create_date date,
    update_by char(8),
    update_date date,
    primary key (moducd,settype) 
  );
revoke all on "mis".sysset from "public";

{ TABLE "mis".syslog row size = 88 number of columns = 5 index size = 0 }
create table "mis".syslog 
  (
    logdate datetime year to second,
    userid char(10),
    modul char(10),
    trannum char(10),
    remark char(50)
  );
revoke all on "mis".syslog from "public";

{ TABLE "mis".tbprogram row size = 81 number of columns = 3 index size = 19 }
create table "mis".tbprogram 
  (
    chprogramid char(9) not null ,
    chprogramname char(60) not null ,
    chfolderid char(12) not null ,
    primary key (chprogramid) 
  );
revoke all on "mis".tbprogram from "public";

{ TABLE "mis".tboperator row size = 50 number of columns = 3 index size = 21 }
create table "mis".tboperator 
  (
    choperatorid char(10) not null ,
    chpassword char(10) not null ,
    choperatorname char(30),
    primary key (choperatorid) 
  );
revoke all on "mis".tboperator from "public";

{ TABLE "mis".tbaccess row size = 21 number of columns = 4 index size = 34 }
create table "mis".tbaccess 
  (
    chuserid char(10) not null ,
    chprogramid char(9) not null ,
    chupdate char(1) not null ,
    chprint char(1) not null ,
    primary key (chuserid,chprogramid) 
  );
revoke all on "mis".tbaccess from "public";

{ TABLE "mis".dptmnt row size = 24 number of columns = 3 index size = 9 }
create table "mis".dptmnt 
  (
    dpt_code char(2) not null ,
    dpt_desc char(20),
    dpt_subsys char(2),
    primary key (dpt_code) 
  );
revoke all on "mis".dptmnt from "public";

{ TABLE "mis".dptmnt2 row size = 52 number of columns = 2 index size = 9 }
create table "mis".dptmnt2 
  (
    dpt_code char(2) not null ,
    dpt_email char(50),
    primary key (dpt_code) 
  );
revoke all on "mis".dptmnt2 from "public";

{ TABLE "mis".delivery_master row size = 6 number of columns = 2 index size = 15 
              }
create table "mis".delivery_master 
  (
    dtdate date not null ,
    stfarm char(2) not null ,
    primary key (dtdate,stfarm) 
  );
revoke all on "mis".delivery_master from "public";

{ TABLE "mis".delivery_detail row size = 274 number of columns = 10 index size = 
              111 }
create table "mis".delivery_detail 
  (
    dtdate date not null ,
    stfarm char(2) not null ,
    stvehicle char(10) not null ,
    stdriver char(30),
    stcustomer char(8) not null ,
    stsubcode char(8),
    inqty integer,
    stuom char(4),
    stremarks char(200),
    inkey serial not null ,
    unique (dtdate,stfarm,stvehicle,stdriver,stcustomer,stsubcode)  constraint "mis".deldet,
    primary key (inkey) 
  );
revoke all on "mis".delivery_detail from "public";

{ TABLE "mis".applog row size = 88 number of columns = 5 index size = 0 }
create table "mis".applog 
  (
    logdate datetime year to second,
    userid char(10),
    modul char(10),
    trannum char(10),
    remark char(50)
  );
revoke all on "mis".applog from "public";

{ TABLE "mis".custhist row size = 230 number of columns = 6 index size = 24 }
create table "mis".custhist 
  (
    custnum char(8) not null ,
    hist_date date,
    seq integer,
    remark char(200),
    create_by char(10),
    create_date date,
    primary key (custnum,seq) 
  );
revoke all on "mis".custhist from "public";

{ TABLE "mis".sdomas row size = 89 number of columns = 12 index size = 18 }
create table "mis".sdomas 
  (
    donum char(8) not null constraint "mis".n169_110,
    dostat char(1) not null constraint "mis".n169_111,
    dodate date not null constraint "mis".n169_112,
    custnum char(8) not null constraint "mis".n169_113,
    subcode char(8) not null constraint "mis".n169_114,
    batch char(8),
    scode char(8),
    create_by char(8) not null constraint "mis".n169_115,
    create_date date not null constraint "mis".n169_116,
    update_by char(20),
    update_date date,
    donumact char(8),
    primary key (donum)  constraint "mis".u169_109
  );
revoke all on "mis".sdomas from "public";

{ TABLE "mis".supmast row size = 112 number of columns = 9 index size = 18 }
create table "mis".supmast 
  (
    scode char(8) not null constraint "mis".n130_77,
    sname char(50) not null constraint "mis".n131_81,
    create_by char(20) not null constraint "mis".n130_79,
    create_date date not null constraint "mis".n130_80,
    update_by char(20),
    update_date date,
    balcalc smallint,
    intprice smallint,
    dept char(2)
  );
revoke all on "mis".supmast from "public";

create unique index "mis".supmast_idx on "mis".supmast (scode);
    
{ TABLE "mis".itemast row size = 115 number of columns = 10 index size = 18 }
create table "mis".itemast 
  (
    icode char(8),
    desc char(30),
    create_by char(20) not null constraint "mis".n104_25,
    create_date date not null constraint "mis".n104_26,
    update_by char(20),
    update_date date,
    umeas char(4),
    upmeas decimal(5,2),
    itemtype char(20),
    stat char(1)
  );
revoke all on "mis".itemast from "public";

create unique index "mis".itemast_idx on "mis".itemast (icode);
    
{ TABLE "mis".subdept row size = 264 number of columns = 16 index size = 30 }
create table "mis".subdept 
  (
    custnum char(8) not null constraint "mis".n103_21,
    subcode char(8) not null constraint "mis".n103_22,
    subdesc char(25),
    addr1 char(30),
    addr2 char(30),
    addr3 char(30),
    city char(20),
    area char(20),
    tel char(12),
    fax char(12),
    contact char(20),
    create_by char(20) not null constraint "mis".n103_23,
    create_date date not null constraint "mis".n103_24,
    update_by char(20),
    update_date date,
    status char(1)
  );
revoke all on "mis".subdept from "public";

create unique index "mis".subdept_idx on "mis".subdept (custnum,
    subcode);
{ TABLE "mis".rcmas row size = 253 number of columns = 17 index size = 18 }
create table "mis".rcmas 
  (
    rcnum char(8) not null constraint "mis".n107_39,
    custnum char(8) not null constraint "mis".n119_73,
    rcdate date not null constraint "mis".n107_40,
    rcstatus char(1) not null constraint "mis".n107_41,
    rcref char(20),
    rcamt money(16,2) not null constraint "mis".n107_42,
    rcbank_inch money(16,2),
    rcbank_outch money(16,2),
    rcrem1 char(30),
    rcrem2 char(30),
    rcrem3 char(30),
    rcrem4 char(30),
    create_by char(20) not null constraint "mis".n107_43,
    create_date date not null constraint "mis".n107_44,
    update_by char(20),
    update_date char(20),
    is_exprt char(1) 
        default '0'
  );
revoke all on "mis".rcmas from "public";

create unique index "mis".rcmas_idx on "mis".rcmas (rcnum);
{ TABLE "mis".syshist row size = 311 number of columns = 5 index size = 0 }
create table "mis".syshist 
  (
    userid char(16),
    logdate date,
    is_table char(18),
    is_stat char(18),
    description char(255)
  );
revoke all on "mis".syshist from "public";

{ TABLE "mis".custmast row size = 287 number of columns = 20 index size = 18 }
create table "mis".custmast 
  (
    custnum char(8) not null constraint "mis".n102_15,
    custname char(30) not null constraint "mis".n102_16,
    title char(10),
    custstat char(1) not null constraint "mis".n102_17,
    op_in char(1) not null constraint "mis".n129_76,
    addr1 char(30),
    addr2 char(30),
    addr3 char(30),
    city char(20),
    area char(10),
    postcode char(5),
    tel char(18),
    fax char(18),
    contact char(25),
    terms smallint not null constraint "mis".n102_18,
    create_by char(20) not null constraint "mis".n102_19,
    create_date date not null constraint "mis".n102_20,
    update_by char(20),
    update_date date,
    blist char(1) 
        default 'N'
  );
revoke all on "mis".custmast from "public";

create unique index "mis".custmast_idx on "mis".custmast (custnum);
    
{ TABLE "mis".tmp_custleong row size = 15 number of columns = 2 index size = 18 }
create table "mis".tmp_custleong 
  (
    oldcode char(8),
    newcode char(7),
    primary key (oldcode) 
  );
revoke all on "mis".tmp_custleong from "public";

{ TABLE "mis".tmp_custbibit row size = 15 number of columns = 2 index size = 18 }
create table "mis".tmp_custbibit 
  (
    oldcode char(8),
    newcode char(7),
    primary key (oldcode) 
  );
revoke all on "mis".tmp_custbibit from "public";

{ TABLE "mis".tmp_customer row size = 19 number of columns = 3 index size = 18 }
create table "mis".tmp_customer 
  (
    oldcode char(8),
    newcode char(7),
    created_date date 
        default today,
    primary key (oldcode)  constraint "mis".u193_157
  );
revoke all on "mis".tmp_customer from "public";

{ TABLE "mis".sdonum2 row size = 32 number of columns = 9 index size = 10 }
create table "mis".sdonum2 
  (
    prefix char(3),
    prefix_cnt char(1),
    mindono decimal(7,0),
    maxdono decimal(7,0),
    nextdono decimal(8,0),
    ttyid char(10),
    ceck char(1),
    ipfx char(1),
    fipfx char(1),
    primary key (prefix) 
  );
revoke all on "mis".sdonum2 from "public";

{ TABLE "mis".categorymast row size = 33 number of columns = 2 index size = 7 }
create table "mis".categorymast 
  (
    code char(1) not null ,
    cname char(32),
    primary key (code) 
  );
revoke all on "mis".categorymast from "public";

{ TABLE "mis".sdodet row size = 124 number of columns = 12 index size = 43 }
create table "mis".sdodet 
  (
    donum char(8) not null constraint "mis".n170_118,
    icode char(8) not null constraint "mis".n170_119,
    uprice decimal(16,2) not null constraint "mis".n170_120,
    qty decimal(10,2),
    remark char(30),
    create_by char(20) not null constraint "mis".n170_122,
    create_date date not null constraint "mis".n170_123,
    update_by char(20),
    update_date date,
    trspt decimal(8,2),
    pqty decimal(10,2) 
        default 0.00,
    weekly integer 
        default 1,
    primary key (donum,icode,uprice)  constraint "mis".u200_159
  );
revoke all on "mis".sdodet from "public";



grant select on "informix".pbcattbl to "public" as "informix";
grant update on "informix".pbcattbl to "public" as "informix";
grant insert on "informix".pbcattbl to "public" as "informix";
grant delete on "informix".pbcattbl to "public" as "informix";
grant index on "informix".pbcattbl to "public" as "informix";
grant select on "informix".pbcatcol to "public" as "informix";
grant update on "informix".pbcatcol to "public" as "informix";
grant insert on "informix".pbcatcol to "public" as "informix";
grant delete on "informix".pbcatcol to "public" as "informix";
grant index on "informix".pbcatcol to "public" as "informix";
grant select on "informix".pbcatfmt to "public" as "informix";
grant update on "informix".pbcatfmt to "public" as "informix";
grant insert on "informix".pbcatfmt to "public" as "informix";
grant delete on "informix".pbcatfmt to "public" as "informix";
grant index on "informix".pbcatfmt to "public" as "informix";
grant select on "informix".pbcatvld to "public" as "informix";
grant update on "informix".pbcatvld to "public" as "informix";
grant insert on "informix".pbcatvld to "public" as "informix";
grant delete on "informix".pbcatvld to "public" as "informix";
grant index on "informix".pbcatvld to "public" as "informix";
grant select on "informix".pbcatedt to "public" as "informix";
grant update on "informix".pbcatedt to "public" as "informix";
grant insert on "informix".pbcatedt to "public" as "informix";
grant delete on "informix".pbcatedt to "public" as "informix";
grant index on "informix".pbcatedt to "public" as "informix";
grant select on "mis".sysgroup to "public" as "mis";
grant update on "mis".sysgroup to "public" as "mis";
grant insert on "mis".sysgroup to "public" as "mis";
grant delete on "mis".sysgroup to "public" as "mis";
grant index on "mis".sysgroup to "public" as "mis";
grant select on "mis".userid to "public" as "mis";
grant update on "mis".userid to "public" as "mis";
grant insert on "mis".userid to "public" as "mis";
grant delete on "mis".userid to "public" as "mis";
grant index on "mis".userid to "public" as "mis";
grant select on "mis".cnmas to "public" as "mis";
grant update on "mis".cnmas to "public" as "mis";
grant insert on "mis".cnmas to "public" as "mis";
grant delete on "mis".cnmas to "public" as "mis";
grant index on "mis".cnmas to "public" as "mis";
grant select on "mis".dnmas to "public" as "mis";
grant update on "mis".dnmas to "public" as "mis";
grant insert on "mis".dnmas to "public" as "mis";
grant delete on "mis".dnmas to "public" as "mis";
grant index on "mis".dnmas to "public" as "mis";
grant select on "mis".sysuser to "public" as "mis";
grant update on "mis".sysuser to "public" as "mis";
grant insert on "mis".sysuser to "public" as "mis";
grant delete on "mis".sysuser to "public" as "mis";
grant index on "mis".sysuser to "public" as "mis";
grant select on "mis".sysgrouphdr to "public" as "mis";
grant update on "mis".sysgrouphdr to "public" as "mis";
grant insert on "mis".sysgrouphdr to "public" as "mis";
grant delete on "mis".sysgrouphdr to "public" as "mis";
grant index on "mis".sysgrouphdr to "public" as "mis";
grant select on "mis".sysgroupdet to "public" as "mis";
grant update on "mis".sysgroupdet to "public" as "mis";
grant insert on "mis".sysgroupdet to "public" as "mis";
grant delete on "mis".sysgroupdet to "public" as "mis";
grant index on "mis".sysgroupdet to "public" as "mis";
grant select on "mis".sysmenu to "public" as "mis";
grant update on "mis".sysmenu to "public" as "mis";
grant insert on "mis".sysmenu to "public" as "mis";
grant delete on "mis".sysmenu to "public" as "mis";
grant index on "mis".sysmenu to "public" as "mis";
grant select on "mis".company to "public" as "mis";
grant update on "mis".company to "public" as "mis";
grant insert on "mis".company to "public" as "mis";
grant delete on "mis".company to "public" as "mis";
grant index on "mis".company to "public" as "mis";
grant select on "mis".plan_hdr to "public" as "mis";
grant update on "mis".plan_hdr to "public" as "mis";
grant insert on "mis".plan_hdr to "public" as "mis";
grant delete on "mis".plan_hdr to "public" as "mis";
grant index on "mis".plan_hdr to "public" as "mis";
grant select on "mis".plan_det to "public" as "mis";
grant update on "mis".plan_det to "public" as "mis";
grant insert on "mis".plan_det to "public" as "mis";
grant delete on "mis".plan_det to "public" as "mis";
grant index on "mis".plan_det to "public" as "mis";
grant select on "mis".area to "public" as "mis";
grant update on "mis".area to "public" as "mis";
grant insert on "mis".area to "public" as "mis";
grant delete on "mis".area to "public" as "mis";
grant index on "mis".area to "public" as "mis";
grant select on "mis".sdomas2 to "public" as "mis";
grant update on "mis".sdomas2 to "public" as "mis";
grant insert on "mis".sdomas2 to "public" as "mis";
grant delete on "mis".sdomas2 to "public" as "mis";
grant index on "mis".sdomas2 to "public" as "mis";
grant select on "mis".sdodet2 to "public" as "mis";
grant update on "mis".sdodet2 to "public" as "mis";
grant insert on "mis".sdodet2 to "public" as "mis";
grant delete on "mis".sdodet2 to "public" as "mis";
grant index on "mis".sdodet2 to "public" as "mis";
grant select on "mis".sysset to "public" as "mis";
grant update on "mis".sysset to "public" as "mis";
grant insert on "mis".sysset to "public" as "mis";
grant delete on "mis".sysset to "public" as "mis";
grant index on "mis".sysset to "public" as "mis";
grant select on "mis".syslog to "public" as "mis";
grant update on "mis".syslog to "public" as "mis";
grant insert on "mis".syslog to "public" as "mis";
grant delete on "mis".syslog to "public" as "mis";
grant index on "mis".syslog to "public" as "mis";
grant select on "mis".tbprogram to "public" as "mis";
grant update on "mis".tbprogram to "public" as "mis";
grant insert on "mis".tbprogram to "public" as "mis";
grant delete on "mis".tbprogram to "public" as "mis";
grant index on "mis".tbprogram to "public" as "mis";
grant select on "mis".tboperator to "public" as "mis";
grant update on "mis".tboperator to "public" as "mis";
grant insert on "mis".tboperator to "public" as "mis";
grant delete on "mis".tboperator to "public" as "mis";
grant index on "mis".tboperator to "public" as "mis";
grant select on "mis".tbaccess to "public" as "mis";
grant update on "mis".tbaccess to "public" as "mis";
grant insert on "mis".tbaccess to "public" as "mis";
grant delete on "mis".tbaccess to "public" as "mis";
grant index on "mis".tbaccess to "public" as "mis";
grant select on "mis".dptmnt to "public" as "mis";
grant update on "mis".dptmnt to "public" as "mis";
grant insert on "mis".dptmnt to "public" as "mis";
grant delete on "mis".dptmnt to "public" as "mis";
grant index on "mis".dptmnt to "public" as "mis";
grant select on "mis".dptmnt2 to "public" as "mis";
grant update on "mis".dptmnt2 to "public" as "mis";
grant insert on "mis".dptmnt2 to "public" as "mis";
grant delete on "mis".dptmnt2 to "public" as "mis";
grant index on "mis".dptmnt2 to "public" as "mis";
grant select on "mis".delivery_master to "public" as "mis";
grant update on "mis".delivery_master to "public" as "mis";
grant insert on "mis".delivery_master to "public" as "mis";
grant delete on "mis".delivery_master to "public" as "mis";
grant index on "mis".delivery_master to "public" as "mis";
grant select on "mis".delivery_detail to "public" as "mis";
grant update on "mis".delivery_detail to "public" as "mis";
grant insert on "mis".delivery_detail to "public" as "mis";
grant delete on "mis".delivery_detail to "public" as "mis";
grant index on "mis".delivery_detail to "public" as "mis";
grant select on "mis".applog to "public" as "mis";
grant update on "mis".applog to "public" as "mis";
grant insert on "mis".applog to "public" as "mis";
grant delete on "mis".applog to "public" as "mis";
grant index on "mis".applog to "public" as "mis";
grant select on "mis".custhist to "public" as "mis";
grant update on "mis".custhist to "public" as "mis";
grant insert on "mis".custhist to "public" as "mis";
grant delete on "mis".custhist to "public" as "mis";
grant index on "mis".custhist to "public" as "mis";
grant select on "mis".sdomas to "public" as "mis";
grant update on "mis".sdomas to "public" as "mis";
grant insert on "mis".sdomas to "public" as "mis";
grant delete on "mis".sdomas to "public" as "mis";
grant index on "mis".sdomas to "public" as "mis";
grant select on "mis".supmast to "public" as "mis";
grant update on "mis".supmast to "public" as "mis";
grant insert on "mis".supmast to "public" as "mis";
grant delete on "mis".supmast to "public" as "mis";
grant index on "mis".supmast to "public" as "mis";
grant select on "mis".itemast to "public" as "mis";
grant update on "mis".itemast to "public" as "mis";
grant insert on "mis".itemast to "public" as "mis";
grant delete on "mis".itemast to "public" as "mis";
grant index on "mis".itemast to "public" as "mis";
grant select on "mis".subdept to "public" as "mis";
grant update on "mis".subdept to "public" as "mis";
grant insert on "mis".subdept to "public" as "mis";
grant delete on "mis".subdept to "public" as "mis";
grant index on "mis".subdept to "public" as "mis";
grant select on "mis".rcmas to "public" as "mis";
grant update on "mis".rcmas to "public" as "mis";
grant insert on "mis".rcmas to "public" as "mis";
grant delete on "mis".rcmas to "public" as "mis";
grant index on "mis".rcmas to "public" as "mis";
grant select on "mis".syshist to "public" as "mis";
grant update on "mis".syshist to "public" as "mis";
grant insert on "mis".syshist to "public" as "mis";
grant delete on "mis".syshist to "public" as "mis";
grant index on "mis".syshist to "public" as "mis";
grant select on "mis".custmast to "public" as "mis";
grant update on "mis".custmast to "public" as "mis";
grant insert on "mis".custmast to "public" as "mis";
grant delete on "mis".custmast to "public" as "mis";
grant index on "mis".custmast to "public" as "mis";
grant select on "mis".tmp_custleong to "public" as "mis";
grant update on "mis".tmp_custleong to "public" as "mis";
grant insert on "mis".tmp_custleong to "public" as "mis";
grant delete on "mis".tmp_custleong to "public" as "mis";
grant index on "mis".tmp_custleong to "public" as "mis";
grant select on "mis".tmp_custbibit to "public" as "mis";
grant update on "mis".tmp_custbibit to "public" as "mis";
grant insert on "mis".tmp_custbibit to "public" as "mis";
grant delete on "mis".tmp_custbibit to "public" as "mis";
grant index on "mis".tmp_custbibit to "public" as "mis";
grant select on "mis".tmp_customer to "public" as "mis";
grant update on "mis".tmp_customer to "public" as "mis";
grant insert on "mis".tmp_customer to "public" as "mis";
grant delete on "mis".tmp_customer to "public" as "mis";
grant index on "mis".tmp_customer to "public" as "mis";
grant select on "mis".sdonum2 to "public" as "mis";
grant update on "mis".sdonum2 to "public" as "mis";
grant insert on "mis".sdonum2 to "public" as "mis";
grant delete on "mis".sdonum2 to "public" as "mis";
grant index on "mis".sdonum2 to "public" as "mis";
grant select on "mis".categorymast to "public" as "mis";
grant update on "mis".categorymast to "public" as "mis";
grant insert on "mis".categorymast to "public" as "mis";
grant delete on "mis".categorymast to "public" as "mis";
grant index on "mis".categorymast to "public" as "mis";
grant select on "mis".sdodet to "public" as "mis";
grant update on "mis".sdodet to "public" as "mis";
grant insert on "mis".sdodet to "public" as "mis";
grant delete on "mis".sdodet to "public" as "mis";
grant index on "mis".sdodet to "public" as "mis";



create procedure "mis".get_cust_bal( d_from date, d_to date, c_custnum char(8))
    returning decimal(16,2);

    define vdoamt, vrcamt, vcnamt, vdnamt, bal decimal(16,2);

    let vdoamt = 0;
    let vrcamt = 0;
    let vcnamt = 0;
    let vdnamt = 0;
    let bal = 0;

    -- payment
	select sum( rcamt) into vrcamt
	from rcmas
	where custnum = c_custnum
	and rcdate between d_from and d_to
	and rcstatus <> 'X';

    -- do amount
	select sum( (d.uprice+d.trspt) * d.qty) into vdoamt
	from sdomas h, sdodet d, supmast s
	where h.donum = d.donum
	and h.scode = s.scode
	and h.custnum = c_custnum
	and h.dodate between d_from and d_to
	and h.dostat in ( 'L', 'E')
	and s.balcalc = 1;

    -- debit note
	select sum( dnamt) into vdnamt
	from dnmas
	where custnum = c_custnum
	and dndate between d_from and d_to
	and dnstatus <> 'X';

    -- credit note
	select sum( cnamt) into vcnamt
	from cnmas
	where custnum = c_custnum
	and cndate between d_from and d_to
	and cnstatus <> 'X';

    -- null value check
    if vdoamt is null then
        let vdoamt = 0;
    end if

    if vrcamt is null then
        let vrcamt = 0;
    end if

    if vdnamt is null then
        let vdnamt = 0;
    end if

    if vcnamt is null then
        let vcnamt = 0;
    end if

    let bal = ( vdoamt + vdnamt) - ( vrcamt + vcnamt);

    return bal;
end procedure;

create procedure "mis".get_cust_age( balance decimal(16,2), printdate date,  c_custnum char(8), terms integer)
    returning integer, decimal(16,2);

    define age integer;
    define runningdate date;
    define doamt decimal(16,2);
    define vdnamt decimal(16,2);
    define debt decimal(16,2);
    define overdue decimal(16,2);

    -- create temp table for do date and dn date
    -- to increase performance
    create temp table datelist
        ( trdate date);

    insert into datelist
    select distinct dodate
        from sdomas
        where custnum = c_custnum
        and dodate <= printdate;

	insert into datelist
	select distinct dndate
		from dnmas
		where custnum = c_custnum
		and dndate <= printdate;

	let age = 0;
	let overdue = 0;

	foreach cur_date for
		select trdate into runningdate
		from datelist
		order by 1 desc

		let doamt = 0;
		let vdnamt = 0;

		if balance = 0 then
			exit foreach;
		end if

		select sum( d.qty * (d.uprice+d.trspt)) into doamt
		from sdomas h, sdodet d, supmast s
		where h.donum = d.donum
		and h.scode = s.scode
		and h.dodate = runningdate
		and h.dostat in ( 'E', 'L')
		and s.balcalc = 1
		and h.custnum = c_custnum;
		if doamt is null then
			let doamt = 0;
		end if

		select sum( dnamt) into vdnamt
		from dnmas
		where dndate = runningdate
		and custnum = c_custnum
		and dnstatus <> 'X';
		if vdnamt is null then
			let vdnamt = 0;
		end if

		let debt = doamt + vdnamt;

		if debt > balance then
			let debt = balance;
			let balance = 0;
		else
			let balance = balance - debt;
		end if

		let age = printdate - runningdate;

		if age > terms and debt > 0 then
			let overdue = overdue + debt;
		end if

	end foreach

    -- drop temp table datelist
    drop table datelist;
	return age, overdue;
end procedure;

create procedure "mis".get_cust_aging(
    d_from date,
    d_to date,
    c_custnum char(8),
    col_a_from integer, col_a_to integer,
    col_b_from integer, col_b_to integer,
    col_c_from integer, col_c_to integer,
    col_d_from integer)
    returning money,money,money,money,money;

    define unpaid, invamt, doamt, vrcamt, vcnamt, vdnamt, bal money(16,2);
    define d_trdate date;
    define age integer;
    define col_a, col_b, col_c, col_d decimal(16,2);

    let doamt = 0;
    let vrcamt = 0;
    let vcnamt = 0;
    let vdnamt = 0;
    let bal = 0;

    -- do amount
    select sum(qty* (uprice+trspt)) into doamt
    from sdomas h, sdodet d
    where h.donum = d.donum and h.dostat <> 'X'
    and h.custnum = c_custnum
    and h.dodate between d_from and d_to;

    -- payment
    select sum(rcamt) into vrcamt
    from rcmas
    where rcstatus <> 'X' and custnum = c_custnum
    and rcdate between d_from and d_to;

    -- debit note
    select sum(dnamt) into vdnamt
    from dnmas
    where dnstatus <> 'X' and custnum = c_custnum
    and dndate between d_from and d_to;

    -- credit note
    select sum(cnamt) into vcnamt
    from cnmas
    where cnstatus <> 'X' and custnum = c_custnum
    and cndate between d_from and d_to;

    -- null value check
    if doamt is null then
        let doamt = 0;
    end if

    if vrcamt is null then
        let vrcamt = 0;
    end if

    if vdnamt is null then
        let vdnamt = 0;
    end if

    if vcnamt is null then
        let vcnamt = 0;
    end if

    let bal = doamt + vdnamt - vrcamt - vcnamt;
    let unpaid = bal;


    if bal <= 0 then
      return bal,0,0,0,bal;
    end if

    -- create temp table for do date
    -- to increase performance
    create temp table datelist
        ( trdate date);

    insert into datelist
    select distinct dodate
        from sdomas
        where custnum = c_custnum
        and dodate <= d_to and dostat <> "X";

    -- variable init
    let col_a = 0;
    let col_b = 0;
    let col_c = 0;
    let col_d = 0;

    foreach cur_date for select trdate into d_trdate
        from datelist
        order by 1 desc

        -- variable initialization
        let doamt = 0;
        let age = 0;

        -- get do amount
        select sum(qty*(uprice+trspt)) into doamt
            from sdodet d, sdomas h
            where d.donum = h.donum
            and h.custnum = c_custnum
            and h.dostat <> 'X'
            and h.dodate = d_trdate;
        if doamt is null then
            let doamt = 0;
        end if

        if unpaid < doamt then
            let doamt = unpaid;
            let unpaid = 0;
        else
            let unpaid = unpaid - doamt;
        end if
        let age = d_to - d_trdate;

        if age >= col_a_from and age <= col_a_to then
            let col_a = col_a + doamt;
        elif age >= col_b_from and age <= col_b_to then
            let col_b = col_b + doamt;
        elif age >= col_c_from and age <= col_c_to then
            let col_c = col_c + doamt;
        elif age > col_d_from then
            let col_d = col_d + doamt;
        end if

        if unpaid = 0 then
           exit foreach;
        end if
    end foreach

    -- drop temp table datelist
    drop table datelist;

    -- return result
    return col_a, col_b, col_c, col_d, bal;

end procedure;


 

grant  execute on "mis".get_cust_bal to "public" as "mis";
grant  execute on "mis".get_cust_age to "public" as "mis";
grant  execute on "mis".get_cust_aging to "public" as "mis";

create view "mis".vw_reportdolist (dodate,custnum,custname,scode,sname,icode,pqty,qty,uprice,donum,create_date,avg) as 
  select x0.dodate ,x3.custnum ,x3.custname ,x1.scode ,x1.sname 
    ,x2.icode ,x2.pqty ,x2.qty ,x2.uprice ,x0.donum [1,1] ,x0.create_date 
    ,(x2.pqty / x2.qty ) from "mis".sdomas x0 ,"mis".supmast x1 
    ,"mis".sdodet x2 ,"mis".custmast x3 where ((((x0.scode = x1.scode 
    ) AND (x0.custnum = x3.custnum ) ) AND (x0.donum = x2.donum 
    ) ) AND (x1.balcalc = 1 ) ) ;                            
                      
create view "mis".vw_reportsolist (dodate,sname,scode,icode,desc,qty,uprice,trspt,pqty,donum,custnum,custname,avg) as 
  select x2.dodate ,x3.sname ,x3.scode ,x1.icode ,x0.desc ,x1.qty 
    ,x1.uprice ,x1.trspt ,x1.pqty ,x2.donum [1,1] ,x2.custnum 
    ,x4.custname ,(x1.pqty / x1.qty ) from "mis".itemast x0 ,"mis".sdodet 
    x1 ,"mis".sdomas x2 ,"mis".supmast x3 ,"mis".custmast x4 where 
    (((((x2.custnum = x4.custnum ) AND (x1.donum = x2.donum ) 
    ) AND (x2.scode = x3.scode ) ) AND (x0.icode = x1.icode ) 
    ) AND (x2.dostat != 'X' ) ) ;                             
                                 




