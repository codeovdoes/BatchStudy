@echo off&chcp 936&color 0a&Setlocal Enabledelayedexpansion&mode con cols=80 lines=30
set Version=1.0
title ����ѹ�� %Version%
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
                
	    rem ����unzip ���ļ��Ƿ��ڶ�Ӧ zipĿ¼�´��ڣ�����������������������ִ��ѹ��
	    for /f %%i in ('dir !unzipdir! /b /on') do (
	       
	       rem ��ǰ����ѹ����������
                       for /f %%d in ('qprocess^|find /i /c /n "WinRAR.exe"') do (
                           set qps=%%d
                        )

	        set target=!zipdir!\%%~ni.zip
	        set source=!unzipdir!\%%i

 	    rem ��ǰû��ռ��WinRAR �Ż�ʹ��
	    if !qps!==0 (	    
	        rem �жϸ��ļ��Ƿ��ڶ�Ӧ�ļ����У������������ѹ��������������
	        if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo %%i) else (echo %%i �ѱ�ѹ�����˴�����)
	        rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	        if !errorlevel!==0 (echo %%i >> success!date!.log) else (
	    	echo %%i ѹ������. �������:  !errorlevel!   ����ʱ��:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	        )
	     ) else (

                                rem �жϸ��ļ��Ƿ��ڶ�Ӧ�ļ����У������������ѹ��������������
	                if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo %%i)
	                rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	                if !errorlevel!==0 (echo %%i >> success!date!.log) else (
	    	echo %%i ѹ������. �������:  !errorlevel!   ����ʱ��:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	                )

		rem ԭ�����뽫�������ý�����������ȴ��ڶ����С���ʱ���ᡣ���˹��ȵ�
		timeout !qps! > nul
		)				
  	    )
)
echo ********** ȫ��Ŀ¼����ѹ����� **********
echo ********** ȫ��Ŀ¼����ѹ����� ********** >> success!date!.log
timeout 3 >nul
rem cls
pause:>nul 
