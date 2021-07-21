@echo off&chcp 936&title 批量压缩&color 0a&Setlocal Enabledelayedexpansion&mode con cols=80 lines=30

set /p input=请输入压缩文件加密的密码，不加密填0:
if %input%==0 (set secrets=) else (set secrets=-hp%input%)

rem 获取当前家目录
set main=%cd%
rem set secret=maiguaren
set ziphome=%main%\ZipDir
set unziphome=%main%\UnZipDir
set date=%date:~0,-3%
set date=%date:/=%

if not exist %ziphome% (mkdir %ziphome% & @echo 创建压缩工作目录)
if not exist %unziphome% (mkdir %unziphome% & @echo 创建解压缩工作目录)

for /f "delims=" %%a in ('dir %unziphome% /ad/b') do (
	
	set b=%%a
	
	rem 查找对应的 zip目录 如果不存在则创建，否则比对两个目录文件

	set zipdir=!ziphome!\!b!
	set unzipdir=!unziphome!\!b!

	rem 如果不存在压缩目录则创建以zip结尾的同名目录
	if not exist !zipdir! (mkdir !zipdir!) 

	echo ********* 开始目录 !zipdir! 中文件 ********** 
	echo ********* 开始目录 !zipdir! 中文件 ********** >> success!date!.log
                
	    rem 遍历unzip 中文件是否在对应 zip目录下存在，若存在则跳过，不存在则执行压缩
	    for /f %%i in ('dir !unzipdir! /b /on') do (
	       
	        rem 当前开启压缩进程数量
                       for /f %%d in ('qprocess^|find /i /c /n "WinRAR.exe"') do (
                           set qps=%%d
                        )

	        set target=!zipdir!\%%~ni.zip
	        set source=!unzipdir!\%%i

 	    rem 当前没有占用WinRAR 才会使用
	    if !qps!==0 (	    
	        rem 判断该文件是否在对应文件夹中，如果不存在则压缩，存在则跳过
	        if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!)
	        rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	        if !errorlevel!==0 (echo %%i & echo %%i >> success!date!.log) else (
	    	echo %%i 压缩错误. 错误代码:  !errorlevel!   错误时间:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	        )
	     ) else (
		set i=%%i 
		echo !i! 
		)				
  	    )
)
echo ********** 全部目录均已压缩完毕 **********
echo ********** 全部目录均已压缩完毕 ********** >> success!date!.log
timeout 3
rem cls
pause:>nul 
