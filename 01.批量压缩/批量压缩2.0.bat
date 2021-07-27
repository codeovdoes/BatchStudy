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
                
	    rem 遍历文件名并保存进数组
	    set j=0
	    for /f %%i in ('dir !unzipdir! /b /on') do (
	            set /a j=!j!+1
                            set filearr1[!j!]=%%~ni
	            set filearr2[!j!]=%%i
	     )

                   rem 判断当前的文件是否应该被压缩
                   rem 遍历文件名数组
                   
	   for /l %%k in (1,1,!j!) do (
	       rem echo !filearr1[%%k]! 不带后缀名
	       rem echo !filearr2[%%k]! 全名
                       rem 当前开启压缩进程的数量
                       for /f %%d in ('qprocess^|find /i /c /n "WinRAR.exe"') do (
		set qps=%%d
                       )
	       
	       set target=!zipdir!\!filearr1[%%k]!.zip
	       set source=!unzipdir!\!filearr2[%%k]!
	     
     
	        if !qps!==0 (	    
	            rem 判断该文件是否在对应文件夹中，如果不存在则压缩，存在则跳过
	            if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo !filearr2[%%k]!)
	            rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	            if !errorlevel!==0 (echo !filearr2[%%k]! >> success!date!.log) else (
	    	echo !filearr2[%%k]! 压缩错误. 错误代码:  !errorlevel!   错误时间:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	             )
	        ) else (
                             rem set /a c=!j!+1
	             rem set filearr1[!c!]=!filearr1[%%k]!
	             rem set filearr2[!c!]=!filearr2[%%k]!
	             rem set /a j=!j!+1
	             rem 想递归把数据放到队列后的

	             rem 判断该文件是否在对应文件夹中，如果不存在则压缩，存在则跳过
	             if not exist !target! (start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source! & echo !filearr2[%%k]!)
	             rem echo start winrar a -k -ep1 -ibck -m5 !secrets! !target! !source!
	             if !errorlevel!==0 (echo !filearr2[%%k]! >> success!date!.log) else (
	    	echo !filearr2[%%k]! 压缩错误. 错误代码:  !errorlevel!   错误时间:  !time!  >> error!date!.log
		echo ---------------------------------------- >> error!date!.log 
	             )
	             timeout !qps! >nul
	        )
	   )
)
echo ********** 全部目录均已压缩完毕 **********
echo ********** 全部目录均已压缩完毕 ********** >> success!date!.log
timeout 3 >nul
rem cls
pause:>nul 
