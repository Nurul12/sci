$PBExportHeader$w_arcusthist.srw
forward
global type w_arcusthist from window
end type
type st_5 from statictext within w_arcusthist
end type
type st_4 from statictext within w_arcusthist
end type
type cb_close from commandbutton within w_arcusthist
end type
type st_2 from statictext within w_arcusthist
end type
type st_1 from statictext within w_arcusthist
end type
type cb_add from commandbutton within w_arcusthist
end type
type mle_remark from multilineedit within w_arcusthist
end type
type em_hist_date from editmask within w_arcusthist
end type
type dw_custhist from datawindow within w_arcusthist
end type
type gb_1 from groupbox within w_arcusthist
end type
end forward

global type w_arcusthist from window
integer width = 2400
integer height = 1840
boolean titlebar = true
string title = "Customer History"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_5 st_5
st_4 st_4
cb_close cb_close
st_2 st_2
st_1 st_1
cb_add cb_add
mle_remark mle_remark
em_hist_date em_hist_date
dw_custhist dw_custhist
gb_1 gb_1
end type
global w_arcusthist w_arcusthist

type variables
string &
	is_custnum
end variables

on w_arcusthist.create
this.st_5=create st_5
this.st_4=create st_4
this.cb_close=create cb_close
this.st_2=create st_2
this.st_1=create st_1
this.cb_add=create cb_add
this.mle_remark=create mle_remark
this.em_hist_date=create em_hist_date
this.dw_custhist=create dw_custhist
this.gb_1=create gb_1
this.Control[]={this.st_5,&
this.st_4,&
this.cb_close,&
this.st_2,&
this.st_1,&
this.cb_add,&
this.mle_remark,&
this.em_hist_date,&
this.dw_custhist,&
this.gb_1}
end on

on w_arcusthist.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_add)
destroy(this.mle_remark)
destroy(this.em_hist_date)
destroy(this.dw_custhist)
destroy(this.gb_1)
end on

event open;string &
	ls_custnum
	
dw_custhist.settransobject(sqlca)
is_custnum = message.stringparm
ls_custnum = trim(is_custnum)
dw_custhist.retrieve(ls_custnum)
end event

type st_5 from statictext within w_arcusthist
integer x = 343
integer y = 1340
integer width = 64
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = ":"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_arcusthist
integer x = 343
integer y = 1180
integer width = 64
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = ":"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_arcusthist
integer x = 1893
integer y = 1304
integer width = 402
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Close"
end type

event clicked;close (parent)
end event

type st_2 from statictext within w_arcusthist
integer x = 73
integer y = 1344
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Remark"
boolean focusrectangle = false
end type

type st_1 from statictext within w_arcusthist
integer x = 82
integer y = 1172
integer width = 201
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date"
boolean focusrectangle = false
end type

type cb_add from commandbutton within w_arcusthist
integer x = 1893
integer y = 1160
integer width = 402
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Add"
end type

event clicked;string &
	ls_custnum, ls_remark
integer &
	li_seq, li_return
date &
	ld_hist_date, ld_approved_on


ls_custnum = trim(is_custnum)
setnull (ls_remark)
ls_remark = mle_remark.text
em_hist_date.getdata (ld_hist_date)

if isnull(ld_hist_date) or isnull(ls_remark) or (ls_remark) = ""  then
	messagebox ("Customer History","Tanggal dan remark harus diisi")
	return
end if

li_return = messagebox( "Print", "Perhatian!"+"~r~n"+"~r~n"+"Periksa kembali data anda, data yang sudah disimpan tidak bisa dirubah", information!, yesno!,2)
if li_return = 1 then
	
	//get running seq
	select max(seq) into :li_seq
		from custhist
		where custnum = :ls_custnum;
		
	if isnull (li_seq) then
		li_seq = 1
	else
		li_seq = + li_seq + 1
	end if
	
	
	//insert into table
	insert into custhist (
		custnum,
		hist_date,
		seq,
		remark,
		create_by,
		create_date	)
		values (
		:ls_custnum,
		:ld_hist_date,
		:li_seq,
		:ls_remark,
		:gs_userid,
		:gd_serverdate	 );
	
	dw_custhist.retrieve(ls_custnum)	
	em_hist_date.replacetext( "")
	
else
	return
end if
		
		
end event

type mle_remark from multilineedit within w_arcusthist
integer x = 439
integer y = 1272
integer width = 1371
integer height = 324
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
integer limit = 200
integer tabstop[] = {0}
borderstyle borderstyle = stylelowered!
end type

type em_hist_date from editmask within w_arcusthist
integer x = 443
integer y = 1172
integer width = 402
integer height = 84
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
string mask = "dd-mm-yyyy"
end type

type dw_custhist from datawindow within w_arcusthist
integer x = 41
integer y = 80
integer width = 2226
integer height = 988
string title = "none"
string dataobject = "d_arcusthist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_arcusthist
integer x = 41
integer y = 1104
integer width = 1824
integer height = 576
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

