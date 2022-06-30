################ Required Privileges ################

GRANT EXECUTE ON SYS.DBMS_RLS TO SRVWEALTHDBA;
GRANT EXECUTE ON SYS.DBMS_RLS TO WEALTHDBA;

################ Creating a VPD Function to control access ################

create or replace function wealthdba.VPD_MASKING_FNCT( p_owner in varchar2, p_name in varchar2 ) return varchar2
as
begin
if sys_context( 'userenv', 'session_user' ) not in ('WEALTHDBA', 'SYS', 'SYSTEM', 'SRVWEALTHDBA', 'PRDOLTRADA','PRDNLINKRADA','PRDNLINKRADA','PRDSLINKRADA','PRDRLINKRADA','PRDNLINKRADA','PRDWLINKRADA','PRDRLINKREPRADA','PRDSTARRORADA','MBATCHRGISP','RLINKRGISP','WLINKGISP','NLINKGISP')
then
    return  '1=0';
else 
  return '1=1';
  end if;
end;
 / 
 
################ Adding a policy to the sensitive columns of the table ################

exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'ATO_RECIPIENT', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY1',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'CNTRB_FILE_MEMBER_DET', sec_relevant_cols=>'MEMBER_TFN', policy_name=>'PRADAG_VPD_POLICY2',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'CNTRB_FILE_MEMBER_DET_HIST', sec_relevant_cols=>'MEMBER_TFN', policy_name=>'PRADAG_VPD_POLICY3',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'DOCUMENT_STORAGE', sec_relevant_cols=>'FILE_CONTENT', policy_name=>'PRADAG_VPD_POLICY4',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'INV_ACC_DEATH_BEN_RBS', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY5',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'MATS_CNTRB_EXPORT', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY6',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'MF_PLAN', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY7',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'MF_PLAN', sec_relevant_cols=>'GRP_TFN', policy_name=>'PRADAG_VPD_POLICY8',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'MMA_DET', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY9',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'PARTY', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY10',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'POD_DET', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY11',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'TBAR_DET', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY12',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'TBAR_DET', sec_relevant_cols=>'SRC_TFN', policy_name=>'PRADAG_VPD_POLICY13',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR', object_name=>'WDRWL_PMT_DET', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY14',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'STAR_ARCHIVE', object_name=>'WORK_MKC_WELCOME', sec_relevant_cols=>'TFN', policy_name=>'PRADAG_VPD_POLICY15',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINKGISP', object_name=>'DRAFT_GOVT_CO_CONT', sec_relevant_cols=>'TAX_FILE_NUMBER', policy_name=>'PRADAG_VPD_POLICY16',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINKGISP', object_name=>'DRAFT_GOVT_CO_CONT', sec_relevant_cols=>'TFN_PREVIOUSLY_QUOTED', policy_name=>'PRADAG_VPD_POLICY17',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINKGISP', object_name=>'PROVIDER_IDENTITY', sec_relevant_cols=>'TFN_NUMBER', policy_name=>'PRADAG_VPD_POLICY18',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINKGISP', object_name=>'RARN_FILE_SEGMENT', sec_relevant_cols=>'TFN_NUMBER', policy_name=>'PRADAG_VPD_POLICY19',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'NLINKGISP', object_name=>'TRANSACT', sec_relevant_cols=>'RAWDATA', policy_name=>'PRADAG_VPD_POLICY20',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								
exec sys.DBMS_RLS.ADD_POLICY(object_schema=>'RLINKRGISP', object_name=>'REPORT_STORAGE', sec_relevant_cols=>'REPORT_IMAGE', policy_name=>'PRADAG_VPD_POLICY21',function_schema=>'WEALTHDBA',policy_function=>'VPD_MASKING_FNCT', sec_relevant_cols_opt=>sys.DBMS_RLS.ALL_ROWS);																								

################ Check the column value for the unauthorised users ################

SQL> select ato_index, job_req_id, tfn from star.ATO_RECIPIENT where rownum<=10;