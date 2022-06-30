################ Required Privileges ################

GRANT EXECUTE ON SYS.DBMS_RLS TO SRVWEALTHDBA;
GRANT EXECUTE ON SYS.DBMS_RLS TO WEALTHDBA;

################ Creating a VPD Function to control access ################

create or replace function wealthdba.VPD_MASKING_FNCT( p_owner in varchar2, p_name in varchar2 ) return varchar2
as
begin
if sys_context( 'userenv', 'session_user' ) not in ('P696229', 'P694030', 'TSTSLINK', 'TSTRLINK', 'TSTFORTE', 'TSTNLINK', 'STAR', 'WEALTHDBA', 'SYS', 'SYSTEM', 'SRVWEALTHDBA', 'TSTDATAMOD','TSTFORTE','TSTRLINK','TSTRESEARCH','TSTNLINK','TSTFEED','TSTSLINK','TSTANGE','TSTWORKFLOW','TSTOLT','TST_NLINK_APP')
then
    return  '1=0';
else 
  return '1=1';
  end if;
end;
 /

 
################ Adding a policy to the sensitive columns of the table ################

exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'VPDTEST', object_name=>'VPD_OBJECTS', sec_relevant_cols=>'TFN', policy_name=>'VPD_POLICY1',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'VPDTEST', object_name=>'VPD_TABLES', sec_relevant_cols=>'SAMPLE_SIZE', policy_name=>'VPD_POLICY2', function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'VPDTEST', object_name=>'VPD_INDEXES', sec_relevant_cols=>'UNIQUENESS', policy_name=>'VPD_POLICY3', function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);

################ Check the column value for the unauthorised users ################

SQL> select owner, object_id, object_name, object_type from vpdtest.vpd_objects where object_name in ('ICOL$', 'CON$', 'UNDO$');

OWNER                          OBJECT_ID OBJECT_NAME                              OBJECT_TYPE
------------------------------ --------- ---------------------------------------- -------------------
SYS                                   20 ICOL$                                    TABLE
SYS                                   28 CON$                                     TABLE
SYS                                   15 UNDO$                                    TABLE

SQL> select owner, table_name,status, sample_size from VPDTEST.VPD_TABLES where table_name in ('CON$', 'UNDO$', 'SEG$');

OWNER                          TABLE_NAME                     STATUS   SAMPLE_SIZE
------------------------------ ------------------------------ -------- -----------
SYS                            CON$                           VALID          13863
SYS                            UNDO$                          VALID            633
SYS                            SEG$                           VALID           9854

SQL> select owner, index_name, index_type, UNIQUENESS From vpdtest.vpd_indexes where index_name in ('XDBHI_IDX', 'PK_CP_TBS', 'SYS_IOT_TOP_411668');

OWNER                          INDEX_NAME                     INDEX_TYPE                  UNIQUENES
------------------------------ ------------------------------ --------------------------- ---------
XDB                            XDBHI_IDX                      FUNCTION-BASED DOMAIN       NONUNIQUE
WEALTHDBA                      PK_CP_TBS                      NORMAL                      UNIQUE
AQ_OWNER                       SYS_IOT_TOP_411668             IOT - TOP                   UNIQUE

################ Data is hide for the unauthorised users ################

SQL> select owner, object_id, object_name, object_type from vpdtest.vpd_objects where object_name in ('ICOL$', 'CON$', 'UNDO$');

OWNER                          OBJECT_ID OBJECT_NAME                              OBJECT_TYPE
------------------------------ --------- ---------------------------------------- -------------------
SYS                                      ICOL$                                    TABLE
SYS                                      CON$                                     TABLE
SYS                                      UNDO$                                    TABLE

SQL> select owner, table_name,status, sample_size from VPDTEST.VPD_TABLES where table_name in ('CON$', 'UNDO$', 'SEG$');

OWNER                          TABLE_NAME                     STATUS   SAMPLE_SIZE
------------------------------ ------------------------------ -------- -----------
SYS                            CON$                           VALID
SYS                            UNDO$                          VALID
SYS                            SEG$                           VALID

SQL> select owner, index_name, index_type, UNIQUENESS From vpdtest.vpd_indexes where index_name in ('XDBHI_IDX', 'PK_CP_TBS', 'SYS_IOT_TOP_411668');

OWNER                          INDEX_NAME                     INDEX_TYPE                  U
------------------------------ ------------------------------ --------------------------- -
XDB                            XDBHI_IDX                      FUNCTION-BASED DOMAIN
WEALTHDBA                      PK_CP_TBS                      NORMAL
AQ_OWNER                       SYS_IOT_TOP_411668             IOT - TOP

exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'INV_ACC_DEATH_BEN_RBS', sec_relevant_cols=>'TFN', policy_name=>'VPD_POLICY1', function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'VPDTEST', object_name=>'VPD_TABLES', sec_relevant_cols=>'SAMPLE_SIZE', policy_name=>'VPD_POLICY2', function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'VPDTEST', object_name=>'VPD_INDEXES', sec_relevant_cols=>'UNIQUENESS', policy_name=>'VPD_POLICY3', function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);

