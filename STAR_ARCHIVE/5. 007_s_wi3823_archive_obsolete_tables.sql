/* *******************************************************************************
* 
* WI-3823
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
            'WORK_MKC_WELCOME',
            'WORK_MKC_IAP',
            'WORK_MKC_IA',
            'WORK_MKC_EFT',
            'MKC_INV_INVT_BAL'
        ) and owner='STAR'
    )
    LOOP
    
        DBMS_OUTPUT.PUT_LINE('Creating table in archive for: ' || rec.table_name);
        v_SQLCommand := 'CREATE TABLE STAR_ARCHIVE.' || rec.table_name || ' COMPRESS AS SELECT * FROM STAR.' || rec.table_name;
        DBMS_OUTPUT.PUT_LINE(v_SQLCommand);
        EXECUTE IMMEDIATE(v_SQLCommand);
        
        DBMS_OUTPUT.PUT_LINE('Now dropping table from STAR schema...');
        EXECUTE IMMEDIATE ('DROP TABLE STAR.' || rec.table_name );        

    END LOOP;
    
END;
/
