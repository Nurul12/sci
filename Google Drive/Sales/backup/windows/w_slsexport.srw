$PBExportHeader$w_slsexport.srw
forward
global type w_slsexport from window
end type
type em_to from editmask within w_slsexport
end type
type st_1 from statictext within w_slsexport
end type
type cb_view from commandbutton within w_slsexport
end type
type st_2 from statictext within w_slsexport
end type
type em_from from editmask within w_slsexport
end type
type gb_1 from groupbox within w_slsexport
end type
end forward

global type w_slsexport from window
string tag = "m_slsexport"
integer width = 1298
integer height = 464
boolean titlebar = true
string title = "Export Sales"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_to em_to
st_1 st_1
cb_view cb_view
st_2 st_2
em_from em_from
gb_1 gb_1
end type
global w_slsexport w_slsexport

on w_slsexport.create
this.em_to=create em_to
this.st_1=create st_1
this.cb_view=create cb_view
this.st_2=create st_2
this.em_from=create em_from
this.gb_1=create gb_1
this.Control[]={this.em_to,&
this.st_1,&
this.cb_view,&
this.st_2,&
this.em_from,&
this.gb_1}
end on

on w_slsexport.destroy
destroy(this.em_to)
destroy(this.st_1)
destroy(this.cb_view)
destroy(this.st_2)
destroy(this.em_from)
destroy(this.gb_1)
end on

event open;em_from.text = string( gd_serverdate)
em_to.text = string( gd_serverdate)
end event

type em_to from editmask within w_slsexport
integer x = 800
integer y = 64
integer width = 375
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_slsexport
integer x = 672
integer y = 72
integer width = 78
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "to"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_slsexport
integer x = 283
integer y = 240
integer width = 640
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;string &
	ls_custcode,	ls_subcode,	ls_icode, ls_custnum,	ls_addr1, ls_addr2, ls_addr3, ls_fax, ls_contact,ls_path, ls_values[], &
	ls_zipfile, ls_fsdomas, ls_fsdodet, ls_fcsdodet, ls_fcustmast, ls_fsubdept,  & 
	ls_sdomas, ls_sdodet, ls_csdodet, ls_custmast, ls_subdept,&
	ls_donum, ls_donumact, ls_create_by, ls_subdesc, ls_area, ls_tel, ls_dept, ls_custname, ls_filename, &
	ls_7z, ls_command, ls_file[]
date &
	ld_from, ld_to, ld_dodate
integer &
	li_sdomas, li_sdodet, li_subdept, li_csdodet, li_custmast, li_terms, &
	li_rc, i, li_max_array
long &
	ll_count
decimal {2} &
	ldc_uprice, ldc_qty, ldc_pqty
mailSession &
	lms_export
mailReturnCode &
	lmrt_export
mailMessage &
	lmm_export
mailfiledescription &
	lmfd_attchexport
ContextKeyword &
	lcxk_base
OleObject wsh

CONSTANT integer MAXIMIZED = 3
CONSTANT integer MINIMIZED = 2
CONSTANT integer NORMAL = 1
CONSTANT boolean WAIT = TRUE
CONSTANT boolean NOWAIT = FALSE

this.GetContextService("Keyword", lcxk_base)
lcxk_base.GetContextKeywords("TEMP", ls_values)
if Upperbound(ls_values) > 0 then
   ls_Path = ls_values[1]
else
   ls_Path = "*UNDEFINED*"
end if

em_from.getdata( ld_from)
em_to.getdata( ld_to)


/* check data */
ll_count = 0
select count(*) into :ll_count
	from sdomas
	where dodate between :ld_from and :ld_to ;
if ll_count = 0 then
	messagebox( "Export", "Tidak ada penjualan di tanggal "+ "~r~n" + &
		string (ld_from, "dd-mmm-yyyy") + " s/d "+ string (ld_to, "dd-mmm-yyyy") + "~r~n" +&
		", export tidak bisa dilanjutkan")	
	return
end if

select count(*) into :ll_count
	from sdomas
	where dostat = 'A' and dodate between :ld_from and :ld_to ;
if ll_count > 0 then
	messagebox( "Export", "Masih ada DO dengan status 'A', export tidak bisa dilanjutkan")	
	return
end if

select count(*) into :ll_count
	from sdomas a, supmast b
	where a.scode = b.scode
	and b.scode <> "D002"
	and donumact is null and dodate between :ld_from and :ld_to ;
	
if ll_count > 0 then
	messagebox( "Export", "Masih ada No DO Aktual yang belum diisi, export tidak bisa dilanjutkan")	
	return
else
	select count(*) into :ll_count
		from sdomas a, supmast b
		where a.scode = b.scode
		and b.scode <> "D002"
		and donumact = "" and dodate between :ld_from and :ld_to and dostat <> 'X' ;
	if ll_count > 0 then
		messagebox( "Export", "Masih ada No DO Aktual yang belum diisi, export tidak bisa dilanjutkan")	
		return
	end if	
end if

/* end - check data */

open( w_busy)
w_busy.st_remark.text = "Sedang memproses data ..."

declare sdomascur cursor for
	select donumact, a.create_by, custnum, dodate, subcode, donum, dept	
	from sdomas a, supmast b
	where a.scode = b.scode
	and b.scode <> "D002"
	and dodate between :ld_from and :ld_to and dostat <> 'X';
open sdomascur;

ls_fsdomas = ls_path + "\sdomas.txt"
ls_fsdodet = ls_path + "\sdodet.txt"
ls_fcsdodet = ls_path + "\csdodet.txt"
ls_fcustmast = ls_path + "\custmast.txt"
ls_fsubdept = ls_path + "\subdept.txt"
ls_filename =  "\" + string(ld_from,"ddmmyyyy") + "_" + string(ld_to,"ddmmyyyy") + ".7z"
ls_zipfile = ls_path + ls_filename

li_sdomas = FileOpen( ls_fsdomas, &
	LineMode!, Write!, LockWrite!, Replace!)
li_sdodet = FileOpen( ls_fsdodet, &
	LineMode!, Write!, LockWrite!, Replace!)
li_csdodet = FileOpen( ls_fcsdodet, &
	LineMode!, Write!, LockWrite!, Replace!)

do while sqlca.sqlcode = 0
	fetch sdomascur into :ls_donumact, :ls_create_by, :ls_custnum, :ld_dodate, :ls_subcode, :ls_donum, :ls_dept;
	
	if sqlca.sqlcode = 0 then		
		
		// check null value
		ls_donumact = f_check_null_string( ls_donumact)
		ls_create_by = f_check_null_string( ls_create_by)
		ls_custnum = f_check_null_string( ls_custnum)
		ls_subcode = f_check_null_string( ls_subcode)	
		
		ls_sdomas = &
			trim( ls_donumact) + "||" + &
			trim( ls_create_by) + "|" + &
			"A|" + &
			trim( ls_custnum) + "|" +&
			"W|D|OFFICE||A||" + &					
			string( ld_dodate, "dd/mm/yyyy") + "|" + &
			string( ld_dodate, "dd/mm/yyyy") + "|" + &
			trim( ls_subcode) + "|||" + &
			"0|0|0|RP|1|N|F||RP|0|" 
		filewrite( li_sdomas, ls_sdomas)
		
		declare sdodetcur cursor for 
			select icode, uprice, qty,pqty
				from sdodet
				where donum = :ls_donum;
		open sdodetcur;
		do while sqlca.sqlcode = 0
			fetch sdodetcur into :ls_icode, :ldc_uprice, :ldc_qty, :ldc_pqty;
			if sqlca.sqlcode = 0 then
				ls_sdodet = &
					trim( ls_donumact) + "|" + &
					string( ld_dodate, "dd/mm/yyyy") + "|" + &
					trim(ls_dept) + "|" + &
					trim( ls_icode) + "|" + &
					string( ldc_uprice) + "|" + &
					string( ldc_qty) + "|" + &
					"0|0|0|"
					
				ls_csdodet = &
					trim( ls_donumact) + "|" + &
					string( ld_dodate, "dd/mm/yyyy") + "|" + &
					trim(ls_dept) + "|" + &
					trim( ls_icode) + "|" + &
					string( ldc_uprice) + "|"+ &
					string(ldc_pqty)+"|"
					
				filewrite( li_sdodet, ls_sdodet)
				filewrite( li_csdodet, ls_csdodet)	
			end if
		loop
		close sdodetcur;
	end if
loop
close sdomascur;
fileclose( li_sdomas)
fileclose( li_sdodet)
fileclose( li_csdodet)



/***** Build Master File *****/

/* custmast */
li_custmast = FileOpen( ls_fcustmast, &
	LineMode!, Write!, LockWrite!, Replace!)
declare docustmastcur cursor for
	select distinct a.custnum, a.custname, a.create_by, a.addr1, a. addr2, a. addr3, tel, 
	fax, contact, area, terms	
		from custmast a, sdomas b
		where a.custnum = b.custnum
		and b.dodate between :ld_from and :ld_to and b.dostat <> 'X' and scode <> 'D002';		
open docustmastcur;
do while sqlca.sqlcode = 0
	fetch docustmastcur into :ls_custnum, :ls_custname, :ls_create_by, :ls_addr1, :ls_addr2, :ls_addr3,
		:ls_tel, :ls_fax, :ls_contact, :ls_area, :li_terms;
	if sqlca.sqlcode = 0 then
		ls_custnum = trim( f_check_null_string( ls_custnum))
		ls_custname = trim( f_check_null_string( ls_custname))
		ls_create_by = trim( f_check_null_string( ls_create_by))
		ls_addr1 = trim( f_check_null_string( ls_addr1))
		ls_addr2 = trim( f_check_null_string( ls_addr2))
		ls_addr3 = trim( f_check_null_string( ls_addr3))
		ls_tel = trim( f_check_null_string( ls_tel))
		ls_fax = trim( f_check_null_string( ls_fax))
		ls_contact = trim( f_check_null_string( ls_contact))
		ls_area = trim( f_check_null_string( ls_area))
		
		ls_custmast = ls_custnum + "|" +&
			ls_custname + "|" +&
			ls_create_by + "|D|D|" +&				
			ls_addr1 + "|" +&
			ls_addr2 + "|" +&
			ls_addr3 + "||" +&
			ls_tel + "||" +&
			ls_fax + "|" +& 
			ls_contact + "|RP|OFFICE|" +&
			ls_area + "|"+&
			string(li_terms) + "|0|||||"	
			
		filewrite( li_custmast, ls_custmast)
	end if
loop
close docustmastcur;
fileclose( li_custmast)




/* subdept */
li_subdept = FileOpen( ls_fsubdept, &
	LineMode!, Write!, LockWrite!, Replace!)
declare dosubdeptcur cursor for
	select distinct a.custnum, a.subcode, b.subdesc, b.area, b.addr1, 
	b.addr2, b.addr3, b.tel, b.fax, b.contact  
	from sdomas a, subdept b
	where a.custnum = b.custnum
	and a.subcode = b.subcode 
	and a.dodate between :ld_from and :ld_to and dostat <> 'X' and a.scode <> 'D002';
open dosubdeptcur;
do while sqlca.sqlcode = 0
	fetch dosubdeptcur into :ls_custnum, :ls_subcode,
		:ls_subdesc, :ls_area, :ls_addr1, 
		:ls_addr2, :ls_addr3, :ls_tel, :ls_fax, :ls_contact;
	if sqlca.sqlcode = 0 then
		ls_custnum = trim( ls_custnum)
		ls_subcode = trim( ls_subcode)
		ls_subdesc = trim( f_check_null_string( ls_subdesc))
		ls_area = trim( f_check_null_string( ls_area))
		ls_addr1 = trim( f_check_null_string( ls_addr1))
		ls_addr2 = trim( f_check_null_string( ls_addr2))
		ls_addr3 = trim( f_check_null_string( ls_addr3))
		ls_tel = trim( f_check_null_string( ls_tel))
		ls_fax = trim( f_check_null_string( ls_fax))
		ls_contact = trim( f_check_null_string( ls_contact))		
		
		ls_subdept = ls_custcode + "|" +&
			ls_custnum + "|" +&
			ls_subcode + "|" +&
			ls_subdesc + "|" +&			
			ls_area + "|" +&
			ls_addr1 + "|" +&
			ls_addr2 + "|" +&
			ls_addr3 + "|" +&
			ls_tel + "|" +&
			ls_fax + "||" +& 
			ls_contact + "|"			
				
		filewrite( li_subdept, ls_subdept)			
	end if
loop
close dosubdeptcur;
fileclose( li_subdept)

/***** end - Build Master File *****/


/* compress and encrypt */
changedirectory( ls_path)
ls_7z = "c:\7za.exe"
wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "WScript.Shell" )
//ls_password = "123superduper456"
ls_file[] = {ls_fsdomas, ls_fsdodet, ls_fcsdodet, ls_fcustmast, ls_fsubdept}
li_max_array = upperbound( ls_file)

for i = 1 to li_max_array	
	ls_command = '"' + ls_7z + '"' + 'a "' + ls_zipfile +&
		'" "' + ls_file[i]  // + '" -p' + ls_password
	li_rc = wsh.Run(ls_command , NORMAL, WAIT)	
next
destroy wsh
/* end - compress and encrypt */



close( w_busy)

// mail it
// Create a mail session
lms_export = create mailSession
lmrt_export = lms_export.mailLogon( mailNewSession!)
if lmrt_export <> mailReturnSuccess! then
 messagebox( "Mail", "Logon failed")
 return
end if
lmm_export.subject = "Data Sales DOC tanggal " + &	
	string( ld_from, "dd-mmmm-yyyy") + " s/d " + &
	string( ld_to, "dd-mmmm-yyyy") 
lmm_export.notetext = "from " + gs_userid

// set file attachment
lmfd_attchexport.filetype = mailattach!
lmfd_attchexport.pathname = ls_zipfile
lmfd_attchexport.filename = ls_filename
lmm_export.attachmentfile[1]= lmfd_attchexport

// Send the mail
lmrt_export = lms_export.mailSend( lmm_export)
if lmrt_export <> mailReturnSuccess! then
 MessageBox("Mail Send",'Mail not sent')
 return
end if
lms_export.mailLogoff()
destroy lms_export	

// delete file
filedelete( ls_fsdomas)
filedelete( ls_fsdodet)
filedelete ( ls_fcsdodet)
filedelete ( ls_fsubdept)
filedelete (ls_fcustmast)
filedelete( ls_zipfile)
end event

type st_2 from statictext within w_slsexport
integer x = 41
integer y = 72
integer width = 160
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "From"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_from from editmask within w_slsexport
integer x = 251
integer y = 64
integer width = 375
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_slsexport
integer x = 55
integer y = 172
integer width = 1097
integer height = 20
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

