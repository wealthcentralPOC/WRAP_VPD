/* *******************************************************************************
* 
* WI-3822
*
* Purpose:  Move tables that store data in relation to obsolete batches, into new
*           STAR_ARCHIVE schema   
*
* Revision History:
* Date			Developer		    Description
* 21/02/2020    Yvette Armstrong    Initial Version
*
* Notes: Process duration :  1 mins
*
******************************************************************************** */

DECLARE

    v_SQLCommand        VARCHAR2(500);

BEGIN

    FOR rec IN
    (
        SELECT  TABLE_NAME
        FROM    DBA_TABLES
        WHERE   TABLE_NAME IN
        (
            'ACS_EXPORT_CLIENT_HDR',
            'ACS_EXPORT_CMT_HDR',
            'ACS_EXPORT_TFN_HDR',
            'SPAD_IMP_PROVIDER_INTER_DATA',
            'SPAD_IMP_TOT_PROV_ASSESS_DATA',
            'SPAD_IMPORT_PVDR_ASSESS_DATA'
        ) and owner='STAR'
    )
    LOOP
    
        DBMS_OUTPUT.PUT_LINE('Creating table in archive for: ' || rec.table_name);
        v_SQLCommand := 'CREATE TABLE STAR_ARCHIVE.' || rec.table_name || ' COMPRESS  AS SELECT * FROM STAR.' || rec.table_name;
        DBMS_OUTPUT.PUT_LINE(v_SQLCommand);
        EXECUTE IMMEDIATE(v_SQLCommand);
        
        DBMS_OUTPUT.PUT_LINE('Now dropping table from STAR schema...');
        EXECUTE IMMEDIATE ('DROP TABLE STAR.' || rec.table_name );        

    END LOOP;
    
END;
/
