@echo off&chcp 936&color 0a&Setlocal Enabledelayedexpansion&mode con cols=80 lines=30
set Version=1.0
title 批量解压 %Version%
set /p input=请输入压缩文件加密的密码，不加密填0:
if %input%==0 (set secrets=) else (set secrets=-p%input%)

rem 获取当前家目录
set main=%cd%
rem set secret=maiguaren
set ziphome=%main%\ZipDir
set unziphome=%main%\UnZipDir

set date=%date:~0,-3%
set date=%date:/=%

if not exist %ziphome% (mkdir %ziphome% & @echo 创建压缩工作目录)
if not exist %unziphome% (mkdir %unziphome% & @echo 创建解压缩工作目录)

for /f "delims=" %%a in ('dir %ziphome% /ad/b') do (
	
	set b=%%a
	
	rem 查找对应的 unzip目录 如果不存在则创建，否则比对两个目录文件

	set zipdir=!ziphome!\!b!\
	set unzipdir=!unziphome!\!b!\

	if not exist !unzipdir! (mkdir !unzipdir!) 

	echo ********* 开始目录 !unzipdir! 中文件 ********** 
	echo ********* 开始目录 !unzipdir! 中文件 ********** >> successUNZIP!date!.log

	        
	        set target=!unzipdir!
	        set source=!zipdir!*.zip
	
	        start winrar e !secrets! -ibck -o+ !source! !target!

)
echo ********** 全部目录均已解压完毕 **********
echo ********** 全部目录均已解压完毕 ********** >> successUNZIP!date!.log
echo 提示：解压工作进程已经开启，还需等待进程结束。
timeout 3 >nul
rem cls
pause:>nul 
