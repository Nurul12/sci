-- Query data custmast
unload to /hd_ext/yudi/data/custmast.unl
select custnum,custname,'-','1','O',addr1,addr2,addr3,
                terr,terr,postcode,tel,fax,contact,terms,userid,
                '19/04/2015','','19/04/2015'
from custmast
where
1=1 and custnum IN
( select b.cust
from csdodet a, sdomas b
where (a.item[1,2] ='OB' OR a.item[1,2] ='LT')
and a.donum = b.donum
);
-- Revisi query unload sdomas
unload to /hd_ext/yudi/data/sdomas.unl
select distinct 'PF', b.dostat,
        b.dodate,b.cust,'-','',
        a.dept, b.userid,
        b.dodate,'','',b.donum,a.item[1,2]
from csdodet a, sdomas b
where a.item[1,2] IN ('LT','OB')
and a.donum = b.donum
order by b.dodate,a.item[1,2]
;
--Query  insert sdodet
unload to /hd_ext/yudi/data/sdodet.unl
select
'PF', b.item,
 b.uprice,
 b.qtywght,'-',
 a.userid,
 b.regdate,'','',
 0,c.qty,1,b.donum
from
sdomas a, sdodet b, csdodet c
where b.item[1,2] IN ('LT','OB')
and a.donum= b.donum
and b.donum = c.donum
and b.item = c.item
and b.uprice = c.uprice

;





























/****************************************************************************************************/

-- Query data custmast
unload to /hd_ext/yudi/data/custmast.unl
select custnum,custname,'-','1','O',addr1,addr2,addr3,
                terr,terr,postcode,tel,fax,contact,terms,userid,
                '19/04/2015','','19/04/2015'
from custmast
where
1=1 and custnum IN
( select b.cust
from csdodet a, sdomas b
where (a.item[1,2] ='OB' OR a.item[1,2] ='LT')
and a.donum = b.donum
);


-- Query  insert sdomas 
unload to /hd_ext/yudi/data/sdomasP.unl
select distinct 'PP', b.dostat,
        b.dodate,b.cust,'-','',
        a.dept, b.userid,
        b.dodate,'','',b.donum
from csdodet a, sdomas b
where a.item[1,2] ='LT'
and a.donum = b.donum
order by dodate;
--UNION ALL
unload to /hd_ext/yudi/data/sdomasF.unl
select distinct 'FF', b.dostat,
        b.dodate,b.cust,'-','',
        a.dept, b.userid,
        b.dodate,'','',b.donum
from csdodet a, sdomas b
where a.item[1,2] ='OB'
and a.donum = b.donum
order by dodate
;

-- Query  insert sdodet
unload to /hd_ext/yudi/data/sdodetP.unl
select
'PP', b.item,
 b.uprice,
 b.qtywght,'-',
 a.userid,
 b.regdate,'','',
 0,c.qty,1,b.donum
from
sdomas a, sdodet b, csdodet c
where b.item[1,2] ='LT'
and a.donum= b.donum
and b.donum = c.donum
and b.item = c.item
and b.uprice = c.uprice
;
--UNION ALL
unload to /hd_ext/yudi/data/sdodetF.unl
select
'FF', b.item,
 b.uprice,
 b.qtywght,'-',
 a.userid,
 b.regdate,'','',
 0,c.qty,1,b.donum
from
sdomas a, sdodet b, csdodet c
where b.item[1,2] ='OB'
and a.donum= b.donum
and b.donum = c.donum
and b.item = c.item
and b.uprice = c.uprice;




-- Query  insert sdomas 
unload to /hd_ext/yudi/data/sdomas.unl
select distinct 'PP', b.dostat,
        b.dodate,b.cust,'-','',
        a.dept, b.userid,
        b.dodate,'','',b.donum
from csdodet a, sdomas b
where a.item[1,2] ='LT'
and a.donum = b.donum
UNION ALL
select distinct 'FF', b.dostat,
        b.dodate,b.cust,'-','',
        a.dept, b.userid,
        b.dodate,'','',b.donum
from csdodet a, sdomas b
where a.item[1,2] ='OB'
and a.donum = b.donum
;
