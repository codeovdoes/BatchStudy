@echo off&chcp 936&color 0a&Setlocal Enabledelayedexpansion&mode con cols=80 lines=30
set Version=1.0
title ������ѹ %Version%
set /p input=������ѹ���ļ����ܵ����룬��������0:
if %input%==0 (set secrets=) else (set secrets=-p%input%)

rem ��ȡ��ǰ��Ŀ¼
set main=%cd%
rem set secret=maiguaren
set ziphome=%main%\ZipDir
set unziphome=%main%\UnZipDir

set date=%date:~0,-3%
set date=%date:/=%

if not exist %ziphome% (mkdir %ziphome% & @echo ����ѹ������Ŀ¼)
if not exist %unziphome% (mkdir %unziphome% & @echo ������ѹ������Ŀ¼)

for /f "delims=" %%a in ('dir %ziphome% /ad/b') do (
	
	set b=%%a
	
	rem ���Ҷ�Ӧ�� unzipĿ¼ ����������򴴽�������ȶ�����Ŀ¼�ļ�

	set zipdir=!ziphome!\!b!\
	set unzipdir=!unziphome!\!b!\

	if not exist !unzipdir! (mkdir !unzipdir!) 

	echo ********* ��ʼĿ¼ !unzipdir! ���ļ� ********** 
	echo ********* ��ʼĿ¼ !unzipdir! ���ļ� ********** >> successUNZIP!date!.log

	        
	        set target=!unzipdir!
	        set source=!zipdir!*.zip
	
	        start winrar e !secrets! -ibck -o+ !source! !target!

)
echo ********** ȫ��Ŀ¼���ѽ�ѹ��� **********
echo ********** ȫ��Ŀ¼���ѽ�ѹ��� ********** >> successUNZIP!date!.log
echo ��ʾ����ѹ���������Ѿ�����������ȴ����̽�����
timeout 3 >nul
rem cls
pause:>nul 
