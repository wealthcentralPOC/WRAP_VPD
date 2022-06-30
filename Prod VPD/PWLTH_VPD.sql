################ Required Privileges ################

GRANT EXECUTE ON SYS.DBMS_RLS TO SRVWEALTHDBA;
GRANT EXECUTE ON SYS.DBMS_RLS TO WEALTHDBA;

################ Creating a VPD Function to control access ################

create or replace function wealthdba.VPD_MASKING_FNCT( p_owner in varchar2, p_name in varchar2 ) return varchar2
as
begin
if sys_context( 'userenv', 'session_user' ) not in ('WEALTHDBA', 'SYS', 'SYSTEM', 'SRVWEALTHDBA', 'PRDNLINK_ICR','PRDWLINK','PRDRLINK','PRDSLINK','PRDNLINK','ICR_PRD','PRDFEED','PRDDATAMOD','PRDNLINK_SEC','RFSUSER')
then
    return  '1=0';
else 
  return '1=1';
  end if;
end;
/

################ Adding a policy to the sensitive columns of the table ################

exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINK', object_name=>'DRAFT_GOVT_CO_CONT', sec_relevant_cols=>'TAX_FILE_NUMBER', policy_name=>'PWLTH_VPD_POLICY1',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINK', object_name=>'DRAFT_GOVT_CO_CONT', sec_relevant_cols=>'TFN_PREVIOUSLY_QUOTED', policy_name=>'PWLTH_VPD_POLICY2',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINK', object_name=>'PROVIDER_IDENTITY', sec_relevant_cols=>'TFN_NUMBER', policy_name=>'PWLTH_VPD_POLICY3',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINK', object_name=>'RARN_FILE_SEGMENT', sec_relevant_cols=>'TFN_NUMBER', policy_name=>'PWLTH_VPD_POLICY4',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINK', object_name=>'TRANSACT', sec_relevant_cols=>'RAWDATA', policy_name=>'PWLTH_VPD_POLICY5',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'RLINK', object_name=>'REPORT_STORAGE', sec_relevant_cols=>'REPORT_IMAGE', policy_name=>'PWLTH_VPD_POLICY6',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								

################ Check the column value for the unauthorised users ################

select draft_govt_co_cont_id, tax_file_number from nlink.DRAFT_GOVT_CO_CONT where rownum<=10;