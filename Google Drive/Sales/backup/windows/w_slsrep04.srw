$PBExportHeader$w_slsrep04.srw
forward
global type w_slsrep04 from window
end type
type cb_view from commandbutton within w_slsrep04
end type
type st_4 from statictext within w_slsrep04
end type
type em_to from editmask within w_slsrep04
end type
type em_from from editmask within w_slsrep04
end type
type ddlb_area from dropdownlistbox within w_slsrep04
end type
type st_3 from statictext within w_slsrep04
end type
type st_2 from statictext within w_slsrep04
end type
type ddlb_supplier from dropdownlistbox within w_slsrep04
end type
type st_1 from statictext within w_slsrep04
end type
type rb_both from radiobutton within w_slsrep04
end type
type rb_internal from radiobutton within w_slsrep04
end type
type rb_open from radiobutton within w_slsrep04
end type
type gb_1 from groupbox within w_slsrep04
end type
type gb_2 from groupbox within w_slsrep04
end type
end forward

global type w_slsrep04 from window
integer width = 1362
integer height = 840
boolean titlebar = true
string title = "Monthly Sales Report"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
cb_view cb_view
st_4 st_4
em_to em_to
em_from em_from
ddlb_area ddlb_area
st_3 st_3
st_2 st_2
ddlb_supplier ddlb_supplier
st_1 st_1
rb_both rb_both
rb_internal rb_internal
rb_open rb_open
gb_1 gb_1
gb_2 gb_2
end type
global w_slsrep04 w_slsrep04

on w_slsrep04.create
this.cb_view=create cb_view
this.st_4=create st_4
this.em_to=create em_to
this.em_from=create em_from
this.ddlb_area=create ddlb_area
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_supplier=create ddlb_supplier
this.st_1=create st_1
this.rb_both=create rb_both
this.rb_internal=create rb_internal
this.rb_open=create rb_open
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_view,&
this.st_4,&
this.em_to,&
this.em_from,&
this.ddlb_area,&
this.st_3,&
this.st_2,&
this.ddlb_supplier,&
this.st_1,&
this.rb_both,&
this.rb_internal,&
this.rb_open,&
this.gb_1,&
this.gb_2}
end on

on w_slsrep04.destroy
destroy(this.cb_view)
destroy(this.st_4)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.ddlb_area)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_supplier)
destroy(this.st_1)
destroy(this.rb_both)
destroy(this.rb_internal)
destroy(this.rb_open)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string &
	ls_scode, ls_sname, ls_area

declare suppcur cursor for
	select scode, sname 
	from supmast;
open suppcur;
ddlb_supplier.additem( "ALL")
do while sqlca.sqlcode = 0 
	fetch suppcur into :ls_scode, :ls_sname;
	if sqlca.sqlcode = 0 then
		ddlb_supplier.additem( ls_scode + " | " + ls_sname)
	end if
loop
close suppcur;
ddlb_supplier.selectitem(1)

declare areacur cursor for 
	select area 
	from custmast
	group by 1;
open areacur;
ddlb_area.additem( "ALL")
do while sqlca.sqlcode = 0
	fetch areacur into :ls_area;
	if sqlca.sqlcode = 0 then
		ddlb_area.additem( ls_area)
	end if
loop
close areacur;
ddlb_area.selectitem(1)	
	
end event

type cb_view from commandbutton within w_slsrep04
integer x = 393
integer y = 588
integer width = 507
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;string &
	ls_filter, ls_cust[], ls_sql, ls_market, ls_supplier[], &
	ls_area
integer &
	i
date &
	ld_from, ld_to
	
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_from.getdata( ld_from)
em_to.getdata( ld_to)

if trim( ddlb_area.text) = "ALL" then
	ls_area = "%"
else
	ls_area = ddlb_area.text
end if

if trim( ddlb_supplier.text) = "ALL" then
	ls_supplier[1] = "%"
	ls_supplier[3] = "ALL"
else
	ls_supplier = f_split_string( ddlb_supplier.text, "|")
	ls_supplier[3] = trim( ls_supplier[1]) + " - " + &
		trim( ls_supplier[2])
end if

if rb_internal.checked = true then
	ls_sql = "select custnum from custmast " + &
		"where op_in = 'I'"
	ls_market = "INTERNAL MARKET"
else 
	if rb_open.checked = true then
		ls_sql = "select custnum from custmast " + &
			"where op_in = 'O'"
		ls_market = "OPEN MARKET"
	else
		ls_sql = "select custnum from custmast "
		ls_market = "ALL MARKET"
	end if
end if

declare custcur dynamic cursor for sqlsa;
prepare sqlsa from :ls_sql;
open dynamic custcur;
i = 0
do while sqlca.sqlcode = 0
	i = i + 1
	fetch custcur into :ls_cust[i];
loop
close custcur;

// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep04"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ld_from, ld_to, ls_cust[], ls_supplier[1], ls_area)
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_area.text = ddlb_area.text
lds_report_viewer.object.t_supplier.text = ls_supplier[3]
lds_report_viewer.object.t_market.text = ls_market
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)

end event

type st_4 from statictext within w_slsrep04
integer x = 722
integer y = 440
integer width = 101
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
alignment alignment = center!
boolean focusrectangle = false
end type

type em_to from editmask within w_slsrep04
integer x = 823
integer y = 432
integer width = 402
integer height = 88
integer taborder = 50
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

type em_from from editmask within w_slsrep04
integer x = 315
integer y = 428
integer width = 402
integer height = 88
integer taborder = 40
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

type ddlb_area from dropdownlistbox within w_slsrep04
integer x = 315
integer y = 324
integer width = 910
integer height = 352
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_slsrep04
integer x = 46
integer y = 440
integer width = 251
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "From :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_slsrep04
integer x = 46
integer y = 340
integer width = 251
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_supplier from dropdownlistbox within w_slsrep04
integer x = 315
integer y = 224
integer width = 905
integer height = 352
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_slsrep04
integer x = 14
integer y = 236
integer width = 283
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier :"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_both from radiobutton within w_slsrep04
integer x = 997
integer y = 96
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Both"
end type

type rb_internal from radiobutton within w_slsrep04
integer x = 494
integer y = 96
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Internal"
end type

type rb_open from radiobutton within w_slsrep04
integer x = 78
integer y = 96
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Open"
end type

type gb_1 from groupbox within w_slsrep04
integer x = 41
integer y = 32
integer width = 1202
integer height = 176
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Market"
end type

type gb_2 from groupbox within w_slsrep04
integer x = 32
integer y = 536
integer width = 1207
integer height = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

