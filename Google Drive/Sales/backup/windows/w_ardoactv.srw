$PBExportHeader$w_ardoactv.srw
forward
global type w_ardoactv from window
end type
type st_2 from statictext within w_ardoactv
end type
type mle_reason from multilineedit within w_ardoactv
end type
type dw_data from datawindow within w_ardoactv
end type
type cb_activate from commandbutton within w_ardoactv
end type
type cb_retrieve from commandbutton within w_ardoactv
end type
type em_dodate from editmask within w_ardoactv
end type
type st_1 from statictext within w_ardoactv
end type
type gb_1 from groupbox within w_ardoactv
end type
end forward

global type w_ardoactv from window
integer width = 3963
integer height = 2048
boolean titlebar = true
string title = "Activate DO"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
mle_reason mle_reason
dw_data dw_data
cb_activate cb_activate
cb_retrieve cb_retrieve
em_dodate em_dodate
st_1 st_1
gb_1 gb_1
end type
global w_ardoactv w_ardoactv

on w_ardoactv.create
this.st_2=create st_2
this.mle_reason=create mle_reason
this.dw_data=create dw_data
this.cb_activate=create cb_activate
this.cb_retrieve=create cb_retrieve
this.em_dodate=create em_dodate
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.mle_reason,&
this.dw_data,&
this.cb_activate,&
this.cb_retrieve,&
this.em_dodate,&
this.st_1,&
this.gb_1}
end on

on w_ardoactv.destroy
destroy(this.st_2)
destroy(this.mle_reason)
destroy(this.dw_data)
destroy(this.cb_activate)
destroy(this.cb_retrieve)
destroy(this.em_dodate)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;dw_data.settransobject( sqlca)
em_dodate.text= string( gd_serverdate, "dd-mm-yyyy")

end event

type st_2 from statictext within w_ardoactv
integer x = 64
integer y = 192
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reason :"
alignment alignment = right!
boolean focusrectangle = false
end type

type mle_reason from multilineedit within w_ardoactv
integer x = 494
integer y = 192
integer width = 1527
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
integer limit = 50
borderstyle borderstyle = stylelowered!
end type

type dw_data from datawindow within w_ardoactv
integer x = 50
integer y = 376
integer width = 3831
integer height = 1544
integer taborder = 50
string title = "none"
string dataobject = "d_ardoactv"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_activate from commandbutton within w_ardoactv
integer x = 1385
integer y = 80
integer width = 635
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Activate selected DO"
end type

event clicked;long &
	ll_rowcount, i, ll_arrcount, ll_upper
string &
	ls_messages, ls_arrdonum[], ls_pick, ls_donum, ls_customer
integer &
	li_return
	

ll_rowcount = dw_data.rowcount()

if ll_rowcount = 0 then
	messagebox( "Activate DO", "Data DO kosong, "+&
		"silahkan pilih data terlebih dahulu")
	return
end if

ll_arrcount = 1
for i = 1 to ll_rowcount
	ls_pick = dw_data.getitemstring( i, "pick")	
	if ls_pick = "1" then
		ls_donum = dw_data.getitemstring( i, "sdomas_donum")	
		ls_customer = dw_data.getitemstring( i, "customer")	
		ls_messages = ls_messages + &
			ls_donum + " - " + ls_customer + "~r~n"
		ls_arrdonum[ ll_arrcount] = ls_donum
		ll_arrcount ++
	end if		
next

ll_upper = upperbound( ls_arrdonum)

if ll_upper = 0 then
	messagebox( "Activate DO", &
		"Silahkan centang DO yang akan di aktifkan")
	return
end if

// check alasan aktivasi
if trim( mle_reason.text) = "" then
	messagebox( "Activate DO", &
		"Alasan aktivasi harus diisi")
	return
end if	

// pesan konfirmasi sebelum di update
li_return = messagebox( "Activate DO", &
	"Aktifkan DO dibawah ini?~r~n" + ls_messages, &
	question!, yesno!)
if li_return <> 1 then
	return
end if

for i = 1 to ll_upper
	update sdomas set dostat = "A"
		where donum = :ls_arrdonum[i];
	
	insert into applog (
		logdate,
		userid,
		modul,
		trannum,
		remark)	values (
		:gdt_serverdatetime,
		:gs_userid,
		"w_slsdo",
		:ls_arrdonum[i],
		:mle_reason.text);	

next

messagebox( "Activate DO", "Aktivasi DO telah selesai")

end event

type cb_retrieve from commandbutton within w_ardoactv
integer x = 937
integer y = 80
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Retrieve"
end type

event clicked;date &
	ld_dodate
long &
	ll_rowcount

em_dodate.getdata( ld_dodate)
dw_data.retrieve( ld_dodate)
ll_rowcount = dw_data.rowcount()
if ll_rowcount = 0 then
	messagebox( "Data DO", "Tidak ada penjualan untuk tanggal "+&
		string( ld_dodate, "dd-mmmm-yyyy"))
end if
end event

type em_dodate from editmask within w_ardoactv
integer x = 494
integer y = 84
integer width = 402
integer height = 92
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
string mask = "[date]"
end type

type st_1 from statictext within w_ardoactv
integer x = 64
integer y = 100
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "DO Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ardoactv
integer x = 50
integer y = 16
integer width = 3831
integer height = 324
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

