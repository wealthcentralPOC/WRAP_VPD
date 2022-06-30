/* *******************************************************************************
* 
* WI-3823
*
* Purpose:   Create a new schema called STAR_ARCHIVE, which obsolete tables
*            can be moved into
*
* Revision History:
* Date			Developer		    Description
* 21/02/2020    Yvette Armstrong    Initial Version
*
* Notes: Process duration :  1 mins
*
******************************************************************************** */
CREATE USER STAR_ARCHIVE IDENTIFIED BY VALUES 'E6A976214BAC352D'
    DEFAULT TABLESPACE STAR_ARCHIVE_DATA
    TEMPORARY TABLESPACE TEMP
    PROFILE DEFAULT
    ACCOUNT UNLOCK
/
GRANT CONNECT TO STAR_ARCHIVE
/
GRANT RESOURCE TO STAR_ARCHIVE
/
ALTER USER STAR_ARCHIVE DEFAULT ROLE ALL
/
GRANT ALTER ANY MATERIALIZED VIEW TO STAR_ARCHIVE
/
GRANT CREATE ANY MATERIALIZED VIEW TO STAR_ARCHIVE
/
GRANT DROP ANY MATERIALIZED VIEW TO STAR_ARCHIVE
/
GRANT UNLIMITED TABLESPACE TO STAR_ARCHIVE
/
GRANT READ, WRITE ON DIRECTORY ORACLE_EXPORT TO STAR_ARCHIVE
/
GRANT READ, WRITE ON DIRECTORY ORACLE_OCM_CONFIG_DIR TO STAR_ARCHIVE
/

