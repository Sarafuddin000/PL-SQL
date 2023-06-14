----Returns OT in varchar2
create or replace FUNCTION SUM_OT(p_Emp_id number) RETURN VARCHAR2 IS
    v_Total_ot VARCHAR2(30);

BEGIN
select trunc(s/(60*60))||':'||lpad(mod(trunc(s/60),60),2,'0')Total_ot into v_Total_ot
 from ( 
 select sum(substr(h.over_time_hour,1,2)*60*60+substr(h.over_time_hour,4,2)*60) s
   from HRM_Attendance h where emp_id = p_Emp_id);

RETURN v_Total_ot;        -----Returns: 36.30

EXCEPTION
    WHEN OTHERS THEN
    RETURN SQLERRM;
END;
-----------------------------------------------------------------------------
----Returns OT in number
create or replace FUNCTION SUM_OT_MIN(p_Emp_id number) RETURN number IS
    v_Total_ot_min number;

BEGIN

 select sum(substr(h.over_time_hour,1,2)*60+substr(h.over_time_hour,-2))/60 into v_Total_ot_min
   from HRM_Attendance h where emp_id = p_Emp_id;

RETURN v_Total_ot_min;        -----Returns: 36.5

EXCEPTION
    WHEN OTHERS THEN
    RETURN SQLERRM;
END;
