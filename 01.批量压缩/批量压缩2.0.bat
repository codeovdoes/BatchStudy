@echo off&chcp 936&title ����ѹ��&color 0a&Setlocal Enabledelayedexpansion&mode con cols=80 lines=30

set /p input=������ѹ���ļ����ܵ����룬��������0:
if %input%==0 (set secrets=) else (set secrets=-hp%input%)

rem ��ȡ��ǰ��Ŀ¼
set main=%cd%
rem set secret=maiguaren
set ziphome=%main%\ZipDir
set unziphome=%main%\UnZipDir
set date=%date:~0,-3%
set date=%date:/=%

if not exist %ziphome% (mkdir %ziphome% & @echo ����ѹ������Ŀ¼)
if not exist %unziphome% (mkdir %unziphome% & @echo ������ѹ������Ŀ¼)

for /f "delims=" %%a in ('dir %unziphome% /ad/b') do (
	
	set b=%%a
	
	rem ���Ҷ�Ӧ�� zipĿ¼ ����������򴴽�������ȶ�����Ŀ¼�ļ�

	set zipdir=!ziphome!\!b!
	set unzipdir=!unziphome!\!b!

	rem ���������ѹ��Ŀ¼�򴴽���zip��β��ͬ��Ŀ¼
	if not exist !zipdir! (mkdir !zipdir!) 

	echo ********* ��ʼĿ¼ !zipdir! ���ļ� ********** 
	echo ********* ��ʼĿ¼ !zipdir! ���ļ� ********** >> success!date!.log
                
	    rem �����ļ��������������
	    set j=0
	    for /f %%i in ('dir !unzipdir! /b /on') do (
	            set /a j=!j!+1
                            set filearr1[!j!]=%%~ni
	            set filearr2[!j!]=%%i
	     )

                   rem �жϵ�ǰ���ļ��Ƿ�Ӧ�ñ�ѹ��
                   rem �����ļ�������
                   
	   for /l %%k in (1,1,!j!) do (
	       rem echo !filearr1[%%k]! ������׺��
	       rem echo !filearr2[%%k]! ȫ��
                       rem ��ǰ����ѹ�����̵�����
                       for /f %%d in ('qprocess^|find /i /c /n "WinRAR.exe"') do (
		set qps=%%d
                       )
	       
	       set target=!zipdir!\!filearr1[%%k]!.zip
	       set source=!unzipdir!\!filearr2[%%k]!
	     
     
	        if !qps!==0 (	    
	            rem �жϸ��ļ��Ƿ��ڶ�Ӧ�ļ����У������������ѹ��������������
	            if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo !filearr2[%%k]!)
	            rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	            if !errorlevel!==0 (echo !filearr2[%%k]! >> success!date!.log) else (
	    	echo !filearr2[%%k]! ѹ������. �������:  !errorlevel!   ����ʱ��:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	             )
	        ) else (
                             rem set /a c=!j!+1
	             rem set filearr1[!c!]=!filearr1[%%k]!
	             rem set filearr2[!c!]=!filearr2[%%k]!
	             rem set /a j=!j!+1
	             rem ��ݹ�����ݷŵ����к��

	             rem �жϸ��ļ��Ƿ��ڶ�Ӧ�ļ����У������������ѹ��������������
	             if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo !filearr2[%%k]!)
	             rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	             if !errorlevel!==0 (echo !filearr2[%%k]! >> success!date!.log) else (
	    	echo !filearr2[%%k]! ѹ������. �������:  !errorlevel!   ����ʱ��:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	             )
	             timeout !qps! >nul
	        )
	   )
)
echo ********** ȫ��Ŀ¼����ѹ����� **********
echo ********** ȫ��Ŀ¼����ѹ����� ********** >> success!date!.log
timeout 3 >nul
rem cls
pause:>nul 
