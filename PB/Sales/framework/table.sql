create table sysuser (
	user_id char(10),
	user_password char(50),
	user_name char(30),
	group_id char(10),
	primary key( user_id);
create table sysgrouphdr (
	group_id char(10),
	group_desc char(50),
	primary key( group_id));
create table sysgroupdet (
	group_id char(10),
	menu_id char(20),
	group_add smallint,
	group_modify smallint,
	group_delete smallint,
	group_s1 smallint,
	group_s2 smallint,
	group_s3 smallint,
	group_s4 smallint,
	group_s5 smallint,
	primary key(group_id, menu_id);
create table sysmenu (
	menu_id char(20),
	menu_desc char(30),
	menu_sort integer,
	menu_level integer,
	primary key(menu_id));

