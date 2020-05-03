libname Dth12 "...\2012"; 
libname Dth13 "...\2013"; 
libname Dth14 "...\2014"; 


*************************;
** Infants **************;
*************************;

PROC FORMAT;
value cause_inftFMT
1= 'Diarrhea/GI infectious'
2= 'Tuberculosis'
3= 'Tetanus'
4= 'Diphtheria'
5= 'Whooping cough'
6= 'Meningococcal infection'
7= 'Septicemia'
8= 'Congenital syphilis'
9= 'Gonococcal infection'
10= 'Acute poliomyelitis'
11= 'Varicella'
12= 'Measles'
13= 'HIV'
14= 'Mumps'
15= 'Candidiasis'
16= 'Malaria'
17= 'Pneumocyctosis'
18= 'Malignant neoplasms'
19= 'Benign neoplasms'
20= 'Diseases of blood etc.'
21= 'Short stature, NEC'
22= 'Nutritional deficiencies'
23= 'Cystic fibrosis'
24= 'Volume depletion etc.'
25= 'Meningitis'
26= 'Spinal muscular atrophy'
27= 'Cerebral palsy'
28= 'Anoxic brain damage, NEC'
29= 'Diseases ear & mastoid'
30= 'Dis. circulatory system'
31= 'Acute upper resp. inf.'
32= 'Influenza and pneumonia'
33= 'Acute bronchitis'
34= 'Bronchitis, chronic & unspec'
35= 'Asthma'
36= 'Pneumonitis'
37= 'Gastritis, duodenitis, etc.'
38= 'Hernia abdominal cavity etc.'
39= 'Renal failure etc.'
40= 'Maternal hypertensive disorders'
41= 'Other maternal conditions'
42= 'Maternal compl.of pregnancy'
43= 'Complications of placenta etc.'
44= 'Other compl. labor & delivery'
45= 'Noxious infl. placenta etc.'
46= 'Slow fetal growth etc.'
47= 'Short gest. low birth weight'
48= 'Long gest. high birth weight'
49= 'Birth trauma'
50= 'Intrauterine hypoxia etc.'
51= 'Respiratory distress of newborn'
52= 'Congenital pneumonia'
53= 'Neonatal aspiration syndromes'
54= 'Interstitial emphysema etc.'
55= 'Pulmonary hemorrhage etc.'
56= 'Chronic respiratory dis. etc.'
57= 'Atelectasis'
58= 'Bacterial sepsis of newborn'
59= 'Omphalitis of newborn etc.'
60= 'Neonatal hemorrhage'
61= 'Hemorrhagic disease of newborn'
62= 'Hemolytic disease etc.'
63= 'Hematological disorders'
64= 'Syndrome diabetic mother etc.'
65= 'Necrotizing entercolitis'
66= 'Hydrops fetalis etc.'
67= 'Congenital anomalies'
68= 'Sudden infant death syndrome'
69= 'Unintentional injuries'
70= 'Homicide'
71= 'Comp med surg care';
run;

data cause71;
infile datalines dsd;
  input cause71 cause71_C & $30.; 
 datalines;
1,"Diarrhea/GI infectious"
2,"Tuberculosis"
3,"Tetanus"
4,"Diphtheria"
5,"Whooping cough"
6,"Meningococcal infection"
7,"Septicemia"
8,"Congenital syphilis"
9,"Gonococcal infection"
10,"Acute poliomyelitis"
11,"Varicella"
12,"Measles"
13,"HIV"
14,"Mumps"
15,"Candidiasis"
16,"Malaria"
17,"Pneumocyctosis"
18,"Malignant neoplasms"
19,"Benign neoplasms"
20,"Diseases of blood etc."
21,"Short stature, NEC"
22,"Nutritional deficiencies"
23,"Cystic fibrosis"
24,"Volume depletion etc."
25,"Meningitis"
26,"Spinal muscular atrophy"
27,"Cerebral palsy"
28,"Anoxic brain damage, NEC"
29,"Diseases ear & mastoid"
30,"Dis. circulatory system"
31,"Acute upper resp. inf."
32,"Influenza and pneumonia"
33,"Acute bronchitis"
34,"Bronchitis, chronic & unspec"
35,"Asthma"
36,"Pneumonitis"
37,"Gastritis, duodenitis, etc."
38,"Hernia abdominal cavity etc."
39,"Renal failure etc."
40,"Maternal hypertensive disorders"
41,"Other maternal conditions"
42,"Maternal pregnancy comp."
43,"Complications of placenta etc."
44,"Other compl. labor & delivery"
45,"Noxious infl. placenta etc."
46,"Slow fetal growth etc."
47,"Short gestation"
48,"Long gestation"
49,"Birth trauma"
50,"Intrauterine hypoxia etc."
51,"Respiratory distress of newborn"
52,"Congenital pneumonia"
53,"Neonatal aspiration syndromes"
54,"Interstitial emphysema etc."
55,"Pulmonary hemorrhage etc."
56,"Chronic respiratory dis. etc."
57,"Atelectasis"
58,"Bacterial sepsis of newborn"
59,"Omphalitis of newborn etc."
60,"Neonatal hemorrhage"
61,"Hemorrhagic disease of newborn"
62,"Hemolytic disease etc."
63,"Hematological disorders"
64,"Syndrome diabetic mother etc."
65,"Necrotizing entercolitis"
66,"Hydrops fetalis etc."
67,"Congenital anomalies"
68,"Sudden infant death syndrome"
69,"Unintentional injuries"
70,"Homicide"
71,"Comp med surg care"
;
run;

************************************;
** SELECT INFANT CASES AND RECODE **;
************************************;

data selectDC_infant; 
  set Dth14.Death2014_feb2016 Dth13.Death2013_jan2016 Dth12.Death2012;  
  if R_STATE_VS='KENTUCKY' && R_COUNTY_FP='067';
  if D_age=0;
run;

%let includeOtherUnspec=0;

* Recode death cases;
data recodeDC_infant; set selectDC_infant; 
  
  cause1=substr(C_UNDER_C, 1, 3);
 
/*infant mortality 130 major causes*/
/*from National Vital Staistics reports Volume49, number2, May 18,2001. page18-19*/
/*revised by same reports volume53, Number17, March7, 2005, injury cate more detailed*/
 
cause71=99;
if (cause1 =: 'A09') then cause71=1;
else if ('A16'<=: cause1 <=: 'A19') then cause71=2;
else if (cause1 =: 'A33'|cause1 =: 'A35') then cause71=3;
else if (cause1 =: 'A36') then cause71=4;
else if (cause1 =: 'A37') then cause71=5;
else if (cause1 =: 'A39') then cause71=6;
else if ('A40'<=: cause1 <=: 'A41') then cause71=7;
else if (cause1<=:'A50') then cause71=8; 
else if (cause1 =: 'A54') then cause71=9;
else if (cause1 =: 'A80') then cause71=10;
else if (cause1 =: 'B01') then cause71=11;
else if (cause1 =: 'B05') then cause71=12;
else if ('B20'<=: cause1 <=: 'B24') then cause71=13;
else if (cause1 =: 'B26') then cause71=14;
else if (cause1 =: 'B37') then cause71=15;
else if ('B50'<=: cause1 <=: 'B54') then cause71=16;
else if (cause1 =: 'B59') then cause71=17;
else if ('C00'<=: cause1 <=:'C97') then cause71=18;
else if ('D00'<=: cause1 <=: 'D48') then cause71=19;
else if ('D50'<=: cause1 <=: 'D89') then cause71=20;
else if (cause1=: 'E343') then cause71=21;
else if ('E40'<=: cause1 <=: 'E64') then cause71=22;
else if (cause1 =: 'E84') then cause71=23;
else if ('E86'<=: cause1 <=: 'E87') then cause71=24;
else if (cause1 =:'G00' | cause1 =: 'G03') then cause71=25;
else if (cause1 =: 'G120') then cause71=26;
else if (cause1 =: 'G80') then cause71=27;
else if (cause1 =: 'G931') then cause71=28;
else if ('H60'<=: cause1 <=:'H93') then cause71=29;
else if ('I00'<=: cause1 <=:'I99') then cause71=30;
else if ('J00'<=: cause1 <=:'J06') then cause71=31;
else if ('J09'<=: cause1 <=:'J18') then cause71=32;
else if ('J20'<=: cause1 <=:'J21') then cause71=33;
else if ('J40'<=: cause1 <=:'J42') then cause71=34;
else if ('J45'<=: cause1 <=:'J46') then cause71=35;
else if (cause1 =:'J69') then cause71=36;
else if (cause1 =:'K29' | 'K50'<=: cause1 <=:'K55') then cause71=37; 
else if ('K40'<=: cause1 <=:'K46' | cause1 =:'K56' ) then cause71=38;
else if ('N17'<=: cause1 <=:'N19' | cause1 =:'N25' | cause1 =:'N27') then cause71=39;
else if (cause1 =:'P000') then cause71=40;
else if ('P001'<=: cause1 <=:'P009') then cause71=41;
else if (cause1 =:'P01') then cause71=42;
else if (cause1 =:'P02') then cause71=43;
else if (cause1 =:'P03') then cause71=44;
else if (cause1 =:'P04') then cause71=45;
else if (cause1 =:'P05') then cause71=46;
else if (cause1 =:'P07') then cause71=47;
else if (cause1 =:'P08') then cause71=48;
else if ('P10'<=: cause1 <=:'P15') then cause71=49;
else if ('P20'<=: cause1 <=:'P21') then cause71=50;
else if (cause1 =:'P22') then cause71=51;
else if (cause1 =:'P23') then cause71=52;
else if (cause1 =:'P24') then cause71=53;
else if (cause1 =:'P25') then cause71=54;
else if (cause1 =:'P26') then cause71=55;
else if (cause1 =:'P27') then cause71=56;
else if ('P280'<=: cause1 <=:'P281') then cause71=57;
else if (cause1 =:'P36') then cause71=58;
else if (cause1 =:'P38') then cause71=59;
else if ('P50'<=: cause1 <=:'P52' | cause1 =:'P54' ) then cause71=60;
else if (cause1 =:'P53') then cause71=61;
else if ('P55'<=: cause1 <=:'P59') then cause71=62;
else if ('P60'<=: cause1 <=:'P61') then cause71=63;
else if ('P700'<=: cause1 <=:'P702') then cause71=64;
else if (cause1 =:'P77') then cause71=65;
else if (cause1 =:'P832') then cause71=66;
else if ('Q00'<=: cause1 <=:'Q99') then cause71=67;
else if (cause1 =:'R95') then cause71=68;
else if ('V01'<=: cause1 <=:'X59') then cause71=69;
else if (cause1 =: 'U01' | 'X85'<=: cause1 <=:'Y09') then cause71=70;
else if ('Y40'<=: cause1 <=:'Y84') then cause71=71;

if cause71=99 && &includeOtherUnspec=0 then delete;

run;
/*proc freq data=recodeDC_infant; tables cause71; run;
proc freq data=recodeDC_infant; tables cause1; where cause71=999; run;*/

*calculate the total number of each cause, keep the top 10 cause; 
proc freq data=recodedc_infant; table cause71/nocol norow nopercent out=matrix_infant; run;
data recodedc_1_infant; set matrix_infant;   AgeGroup=0;run;
proc sort data=recodedc_1_infant out=recodedc_2_infant; by descending count; run;

data recodedc_3_infant; set recodedc_2_infant(obs=10); 
  rank=_n_;
  drop PERCENT;
run;

* If less than 10 causes with frequency >= 1 then add dummy cases to give 10 causes;
data recodedc_4_infant; set recodedc_3_infant end=done;
retain n 0; 
if _n_=1 then n=1; else n+1;
output;
if done then do;
  do i=1 to 10-n;
  	cause71=.; count=.;rank=n+i; output;
  end;
end;	
drop n i;
run;

* merge with the cause71 table to add descriptions and comma-formatted numbers;
proc sort data=recodedc_4_infant; by cause71; run;
proc sort data=cause71; by cause71; run;
data merged_infant; 
  merge recodedc_4_infant cause71; by cause71; 
  if rank=. then delete; 
  length count_c $ 12;
  count_c = strip(PUT(count,comma8.0));
  if 1 <= count < 5 then count_c = '*';
run;



*************************;
** Age >= 1 and totals **;
*************************;

PROC FORMAT;
value causeFMT
1=	'Salmonella infections'
2=	'Shigellosis'
3=	'Tuberculosis'
4=	'Whooping cough'
5=	'Scarlet fever'
6=	'Meningococcal infection'
7=	'Septicemia'
8=	'Syphilis'
9=	'Acute poliomyelitis'
10=	'Viral encephalitis'
11=	'Measles'
12=	'Viral hepatitis'
13=	'HIV'
14=	'Malaria'
15=	'Malignant neoplasms'
16=	'Benign neoplasms'
17=	'Anemias'
18=	'Diabetes mellitus'
19=	'Nutritional deficiencies'
20=	'Meningitis'
21=	'Parkinsons disease'
22=	'Alzheimers disease'
23=	'Diseases of heart'
24=	'Hypertension'
25=	'Cerebrovascular diseases'
26=	'Atherosclerosis'
27=	'Aortic aneurysm'
28=	'Influenza and pneumonia'
29=	'Acute bronchitis'
30=	'Chronic lower resp dis'
31=	'Pneumoconioses'
32=	'Pneumonitis'
33=	'Peptic ulcer'
34=	'Diseases of appendix'
35=	'Hernia'
36=	'Chronic liver disease'
37=	'Disorders of gallbladder'
38=	'Nephritis'
39=	'Infections of kidney'
40=	'Hyperplasia of prostate'
41=	'Inflam dis female pelvic'
42=	'Preg, childbirth, puer'
43=	'Cond perinatal period'
44=	'Congenital anomalies'
45=	'Unintentional injuries'
46=	'Suicide'
47=	'Homicide'
48=	'Legal intervention'
49=	'Operations of war'
50=	'Comp med surgl care';run;

data cause50;
infile datalines dsd;
  input cause50 cause50_C & $30.; 
 datalines;
1,"Salmonella infections"
2,"Shigellosis"
3,"Tuberculosis"
4,"Whooping cough"
5,"Scarlet fever"
6,"Meningococcal infection"
7,"Septicemia"
8,"Syphilis"
9,"Acute poliomyelitis"
10,"Viral encephalitis"
11,"Measles"
12,"Viral hepatitis"
13,"HIV"
14,"Malaria"
15,"Malignant neoplasms"
16,"Benign neoplasms"
17,"Anemias"
18,"Diabetes mellitus"
19,"Nutritional deficiencies"
20,"Meningitis"
21,"Parkinsons disease"
22,"Alzheimers disease"
23,"Diseases of heart"
24,"Hypertension"
25,"Cerebrovascular diseases"
26,"Atherosclerosis"
27,"Aortic aneurysm"
28,"Influenza and pneumonia"
29,"Acute bronchitis"
30,"Chronic lower resp dis"
31,"Pneumoconioses"
32,"Pneumonitis"
33,"Peptic ulcer"
34,"Diseases of appendix"
35,"Hernia"
36,"Chronic liver disease"
37,"Disorders of gallbladder"
38,"Nephritis"
39,"Infections of kidney"
40,"Hyperplasia of prostate"
41,"Inflam dis female pelvic"
42,"Preg, childbirth, puer"
43,"Cond perinatal period"
44,"Congenital anomalies"
45,"Unintentional injuries"
46,"Suicide"
47,"Homicide"
48,"Legal intervention"
49,"Operations of war"
50,"Comp med surgl care"
;
run;

*****************************;
** SELECT CASES AND RECODE **;
*****************************;

* Deaths with underlying of death = suicide;
data selectDC; 
  set Dth14.Death2014_feb2016 Dth13.Death2013_jan2016 Dth12.Death2012;  
  if R_STATE_VS='KENTUCKY' && R_COUNTY_FP='067';
  if D_age>=1;
run;

%let includeOtherUnspec=0;

* Recode death cases;
data recodeDC; set selectDC; 
  *Age group;
  if d_age=. then AgeGroup=.;
  else if 1<=d_age<=4 then AgeGroup=1;
  else if 5<=d_age<=9 then AgeGroup=2;
  else if 10<=d_age<=14 then AgeGroup=3;
  else if 15<=d_age<=24 then AgeGroup=4;
  else if 25<=d_age<=34 then AgeGroup=5;
  else if 35<=d_age<=44 then AgeGroup=6;
  else if 45<=d_age<=54 then AgeGroup=7;
  else if 55<=d_age<=64 then AgeGroup=8;
  else if d_age>=65 then AgeGroup=9;


  cause1=substr(C_UNDER_C, 1, 3);
 
cause50=99;
if ('A01' <=: cause1 <=:'A02') then cause50 =1;
else if cause1 =:'A03' | cause1 =:'A06' then cause50 =2;
else if ('A16' <=: cause1 <=:'A19') then cause50 =3;
else if cause1 =:'A37' then cause50 =4;
else if (cause1=:'A38'|cause1=:'A46') then cause50 =5;
else if cause1 =:'A39' then cause50 =6;
else if'A40' <=: cause1 <=:'A41' then cause50 =7;
else if ('A50' <=: cause1 <=:'A57') then cause50 =8;
else if cause1 =:'A80' then cause50 =9;
else if ('A83' <=: cause1 <=:'A84')|cause1=:'A852' then cause50 =10;
else if cause1 =:'B05' then cause50 =11;
else if'B15' <=:cause1 <=:'B19' then cause50 =12;
else if ('B20' <=: cause1 <=:'B24') then cause50 =13;
else if'B50' <=:cause1 <=:'B54' then cause50 =14;
else if ('C00' <=: cause1 <=:'C97') then cause50 =15;
else if ('D00' <=: cause1 <=:'D48') then cause50 =16;
else if ('D50' <=: cause1 <=:'D64') then cause50 =17;
else if'E10' <=:cause1 <=:'E14' then cause50 =18;
else if ('E40' <=: cause1 <=:'E64') then cause50 =19;

else if ('G00' <=: cause1 <=:'G03') then cause50 =20;
else if 'G20' <=:cause1 <=:'G21' then cause50 =21;
else if cause1 =:'G30' then cause50 =22;
else if ('I00' <=: cause1 <=:'I09')|cause1=:'I11'|cause1=:'I13'|
   ('I20' <=: cause1 <=:'I51')  then cause50 =23;
else if cause1 =:'I10' | cause1 =:'I12' then cause50 =24;
else if ('I60' <=: cause1 <=:'I69') then cause50 =25;
else if cause1 =:'I70' then cause50 =26;
else if cause1 =:'I71' then cause50 =27;
else if ('J10' <=: cause1 <=:'J18') then cause50 =28;
else if'J20' <=:cause1 <=:'J21' then cause50 =29;
else if'J40' <=:cause1 <=:'J47' then cause50 =30;

else if ('J60' <=: cause1 <=:'J66')|cause1=:'J68' then cause50 =31;
else if cause1 =:'J69' then cause50 =32;
else if ('K25' <=: cause1 <=:'K28') then cause50 =33;
else if ('K35' <=: cause1 <=:'K38') then cause50 =34;
else if ('K40' <=: cause1 <=:'K46') then cause50 =35;
else if ('K73' <=: cause1 <=:'K74')| cause1=:'K70' then cause50 =36;
else if ('K80' <=: cause1 <=:'K82') then cause50 =37;
else if ('N00' <=: cause1 <=:'N07')|('N17' <=: cause1 <=:'N19')|('N25' <=: cause1 <=:'N27')
 then cause50 =38;
else if'N10'<=:cause1 <=:'N12'|cause1=:'N136'|cause1=:'N151' then cause50 =39;
else if cause1 =:'N40' then cause50 =40;

else if ('N70' <=: cause1 <=:'N76') then cause50 =41;
else if ('O00' <=: cause1 <=:'O99') then cause50 =42;
else if ('P00' <=: cause1 <=:'P96') then cause50 =43;
else if ('Q00' <=: cause1 <=:'Q99') then cause50 =44;
else if ('V01' <=: cause1 <=:'X59')|('Y85' <=: cause1 <=:'Y86') then cause50 =45;
else if ('X60' <=: cause1 <=:'X84')|cause1 =:'Y870'|cause1 =:'U03' then cause50 =46;
else if ('X85' <=: cause1 <=:'Y09')|cause1 =:'Y871'|cause1 =: 'U01'|cause1=: 'U02' then cause50 =47;
else if (cause1 =:'Y35')|cause1 =:'Y890' then cause50 =48;
else if (cause1 =:'Y36')|cause1=:'Y891' then cause50 =49;
else if ('Y40' <=: cause1 <=:'Y84') | cause1 =:'Y88' then cause50 =50;

if cause50=99 && &includeOtherUnspec=0 then delete;

run;

*calculate the total number of each cause, keep the top 10 cause,add Agegroup variable as value 11; 
proc freq data=recodedc; table cause50/nocol norow nopercent out=matrix_tot; run;
proc sort data=matrix_tot; by descending count; run;
data matrix_tot_top10; set matrix_tot(obs=10); 
  AgeGroup=11; 
  rank=_n_;
  drop PERCENT;
run;

proc freq data=recodedc; table Agegroup; run;

*calculate the total number of each cause by agegroup, keep the top 10 cause of each agegroup; 
proc freq data=recodedc; table agegroup*cause50/nocol norow nopercent out=matrix; run;
data recodedc_1(keep=AgeGroup cause50 count); set matrix; run;
proc sort data=recodedc_1 out=recodedc_2; by AgeGroup descending count; run;
data recodedc_3; set recodedc_2; by AgeGroup descending count;
retain n 0; 
*drop n;
if first.AgeGroup then n=1; else n+1;	
if n lt 11; run;

*make sure each agegroup has 10 causes;
data recodedc_4; set recodedc_3(rename=(n=rank));
by AgeGroup;
format count comma8.0;
retain n 0; 
if first.AgeGroup then n=1; else n+1;
output;
if last.Agegroup then do;
  do i=1 to 10-n;
  	cause50=.; count=.;rank=n+i; output;
  end;
end;	
drop n i;
*format cause50 causeFMT.;
run;

*append the agegroup columns with the total columns;
data recodedc_4; set recodedc_4 matrix_tot_top10; run;

*merge the recoded data with the cause 50 data;
proc sort data=recodedc_4; by cause50; run;
proc sort data=cause50; by cause50; run;
data merged; 
  merge recodedc_4 cause50; by cause50; 
  if rank=. then delete; 
  length count_c $ 12;
  count_c = strip(PUT(count,comma8.0));
  if 1 <= count < 5 then count_c = '*';
run;

data combined; set merged (rename=(cause50_c=cause_c)) merged_infant(rename=(cause71_c=cause_c));run;

proc sort data=combined; by rank agegroup; *format cause50 causeFMT.; run;

options orientation=landscape;

ods pdf file='...\Leading cause of death Fayette 2012-2014.pdf' style=style.newfonts;
options nodate nonumber;
title "10 Leading Causes of Death by Age Group: Fayette County, KY (2012-2014)";
footnote;

ods escapechar='^';
data _null_;
set combined end=done;BY Rank;
if _n_ eq 1 then do;
  declare odsout t();
  t.table_start();
  t.row_start();
  t.format_cell(text: '', overrides: 'cellwidth=0.5in fontsize=6pt');
  t.format_cell(text: 'Age Groups', column_span: 11, overrides: 'fontsize=8pt');
  t.row_end();
  t.row_start();
  t.format_cell(text: 'Rank', overrides: 'cellwidth=0.5in fontsize=8pt');
    t.format_cell(text: '<1', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '1-4', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '5-9', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '10-14', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '15-24', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '25-34', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '35-44', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '45-54', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '55-64', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: '65+', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.format_cell(text: 'Total', overrides: 'cellwidth=0.75in fontsize=8pt');
  t.row_end();
end;

if first.rank then do;
  t.row_start();
  t.format_cell(text: rank, overrides: 'cellwidth=0.75in fontsize=6pt');
  if AgeGroup=0 then do;
    if cause71=69 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=70 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
  end;
  else do; 
    if cause50=45 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=46 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=green color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=47 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
   end;
end;

else if last.rank then do;
  if AgeGroup=0 then do;
    if cause71=69 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=70 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
  end;
  else do; 
    if cause50=45 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=46 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=green color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=47 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
   end;
  t.row_end();

end;

else do;
 if AgeGroup=0 then do;
    if cause71=69 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=70 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause71=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
  end;
  else do; 
    if cause50=45 then t.format_cell(data:  cause_C || "^n" || count_c, overrides: 'background=blue color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=46 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=green color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=47 then t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'background=red color=white cellwidth=0.75in fontsize=6pt');
    else if cause50=. then t.format_cell(data: '', overrides: 'cellwidth=0.75in fontsize=6pt');
    else t.format_cell(data:  cause_c || "^n" || count_c, overrides: 'cellwidth=0.75in fontsize=6pt');
   end;
end;

if done then do; 
  t.row_start();
    t.format_cell(text: '* indicates that a count of at least one but fewer than five was suppressed', column_span: 12, overrides: 'just=left vjust=top fontsize=6pt', inhibit: 'LRB');
	*t.format_cell(text: '', overrides: "preimage='...\logo-2 color small.gif'", row_span: 3, column_span: 2);
  t.row_end();
  t.row_start();
    t.format_cell(text: 'Data Source: Kentucky Death Certificates Files, Frankfort, KY [2012-2014]. Kentucky Department for Public Health,^n 
Cabinet for Health and Family Services. Data for 2009-2014 are provisional and subject to change.', 
                  column_span:12, overrides:'just=left fontsize=6pt', inhibit: 'LRB');
  t.row_end();
  tday=today();
  month_name=PUT(tday,monname.);
  year=year(tday);
  t.row_start();
    t.format_cell(text: 'Produced by: Kentucky Injury Prevention and Research Center,' || ' ' || strip(month_name) || ' ' || strip(year), 
                  column_span:12, overrides:'just=left fontsize=6pt', inhibit: 'LRB');
  t.row_end();

 t.row_start();
    t.format_cell(text: 'Cause of death for ages >=1 was classfied according to the 50 rankable causes of death as defined by the National Center for Health Statistics: 
National Vital Statistics Reports, Vol. 58, No. 8, December 23, 2009 (Table A)', column_span: 12, overrides: 'just=left vjust=top fontsize=6pt', inhibit: 'LRB');
  t.row_end();

    t.row_start();
    t.format_cell(text: 'Cause of death for infants was classfied according to the 71 rankable causes of death as defined by the National Center for Health Statistics: 
National Vital Statistics Reports, Vol. 58, No. 8, December 23, 2009 (Table B)', column_span: 12, overrides: 'just=left vjust=top fontsize=6pt', inhibit: 'LRB');
  t.row_end();

  t.table_end(); 

end;
run;

/*ods layout absolute;
  ods region x=75pct;
  ODS PDF text="^S={preimage='...\logo-2 color small.gif'}";
ods layout end;*/

ods pdf close;






