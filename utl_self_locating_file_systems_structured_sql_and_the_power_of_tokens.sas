Self locating file systems, structured SQL and the power of tokens

This is a general structure with may exceptions but the
skeleton really helps.

Suppose I mail the following file to John Doe in April 2014.
John and I worked on the promotion for "Fabulous SAS Claasic Editor Compaign"

   fab_100OraDem.xls

John asked me to recreate the excel sheet using 2015 data

  I know the following from just the file name

  1. Location of file (location is in in the filename)

        root is project token 'fab'
        subdirectory is xls

        d:/fab/xls/fab_100OraDem.xlsx

  2. Program that created the xls (all programs are in utl directory (40 years of code 20k programs)

          c:/utl/fab_100OraDem.sas

  3. Program sequence(project flow), 100 is first program, I sequence programs 100,200 ..nnn for sequence

     I use macro wrappers for most of my programs

     %macro fab_100OraDem/des="Fabulous Campaign step 100..
       data fab.fab_100OraDem(label="Fabulous Campaign step 100 extract oracle demographics");
     %mend fab_100OraDem;

     %macro fab_200OraLab/des="Fabulous Campaign step 100;
     ....
     %mend fab_200OraFab;


  Other properties

     %fab_100OraDem;
     %fab_200OraLab;

  4. Datasets created by program

   d:/fab

      fab_100OraDem.sas7bdat


Emails  all subjects lines for FabulousCampaign start with fab

Subject: fab FabulousCampaign: Ora data extracts

*    _ _               _
  __| (_)_ __ ___  ___| |_ ___  _ __ _   _
 / _` | | '__/ _ \/ __| __/ _ \| '__| | | |
| (_| | | | |  __/ (__| || (_) | |  | |_| |
 \__,_|_|_|  \___|\___|\__\___/|_|   \__, |
                                     |___/
;


 d:/fab (this is where I keep SAS datasets)

   fab_100OraDem.sas7bdat
   fab_200OraLab.sas7bdat

  /xls
     fab_100OraDem.xls
     ..
  /pdf
  /htm
  /msg (emails)
     fab FabulousCampaign: Ora data extracts.msg
  /png
  /rtf


After database freeze I rename thr root directory

d:/fab_Fabulous_SAS_Claasic_Editor_Compaign/

*               _ _   _                   _   _        _     _
 _ __ ___  __ _| | |_(_) ___  _ __   __ _| | | |_ __ _| |__ | | ___  ___
| '__/ _ \/ _` | | __| |/ _ \| '_ \ / _` | | | __/ _` | '_ \| |/ _ \/ __|
| | |  __/ (_| | | |_| | (_) | | | | (_| | | | || (_| | |_) | |  __/\__ \
|_|  \___|\__,_|_|\__|_|\___/|_| |_|\__,_|_|  \__\__,_|_.__/|_|\___||___/

;

If I have the good fortune to build my our 'relational' database schema I like to create tables? with names

Table
dem_demographics

Variables
   dem_pid
   dem_age
   dem_sex
   dem_race   * no easy TLA for race so use the entire word;
   dem_dob
   dem_die or dem_doa

lab_laboratory
  lab_prikey
  lab_nam
  lab_dem_pid    * foreign key only use second _ for foreign keys
  lab_dte
  lab_age
  lab_sex
  lab_agecat
  lab_val

This leads to clean sql code, no collisions
* Tmp tables have mixed names

  No collisions
  proc sql;
      create
         table Ldm_DemJynLab as
      select
         l.*
        ,r.*
      from
         de_Demographics left join lab_laboratory
      on
         dem_pid = lab_dem_pid
  ;quit;


  proc sql;
      create
         table Ldm_DemJynLab as
      select
         lab_dem_pid
        ,lab_nam
        ,lab_dte
        ,dem_die
      from
         de_Demographics left join lab_laboratory
      on
         dem_pid = lab_dem_pid
  ;quit;


  proc sql;
      select
        distinct
        ,lab_nam
        ,lab_sex
      into
         :lab_nam separated by " "
        ,:lab_sex separated by " "
      from
        lab_laboratory
  ;quit;

