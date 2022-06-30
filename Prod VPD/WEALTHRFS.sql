################ Required Privileges ################

GRANT EXECUTE ON SYS.DBMS_RLS TO SRVWEALTHDBA;
GRANT EXECUTE ON SYS.DBMS_RLS TO WEALTHDBA;

################ Creating a VPD Function to control access ################

create or replace function wealthdba.VPD_MASKING_FNCT( p_owner in varchar2, p_name in varchar2 ) return varchar2
as
begin
if sys_context( 'userenv', 'session_user' ) not in ('WEALTHDBA', 'SYS', 'SYSTEM', 'SRVWEALTHDBA', 'RFS_USER', 'RFS_LINKSUSER')
then
    return  '1=0';
else 
  return '1=1';
  end if;
end;
/

################ Adding a policy to the sensitive columns of the table ################

exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'WEALTHRFS', object_name=>'FILE_ENTRY', sec_relevant_cols=>'FILE_IMAGE', policy_name=>'PWHA01DB_VPD_POLICY1',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);

################ Check the column value for the unauthorised users ################

select * from WEALTHRFS.FILE_ENTRY where rownum<=10;