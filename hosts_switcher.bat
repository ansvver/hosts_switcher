@echo off

cd /d %~dp0
cls

:main
findstr "45.58.54.220" c:\windows\system32\drivers\etc\hosts > nul
set _mode=%errorlevel%
call:print_main
choice /c 1234 -m "请选择："
if errorlevel 4 exit
if errorlevel 3 goto type_hosts
if errorlevel 2 goto update_hosts
if errorlevel 1 goto swtich_mode

:print_main
echo.
echo.
echo **********************************
echo *   模式切换神器：Host环境设置   *
echo *   (请以管理员身份运行！)       *
echo *                                *
if %_mode% equ 0 (
echo *   ●当前模式　：工作模式       *
echo *                                *
echo *   1.切换至【非工作模式】       *
) else (
echo *   ●当前模式　：非工作模式     *
echo *                                *
echo *   1.切换至【工作模式】         *
)
echo *   2.更新当前hosts文件          *
echo *   3.查看当前hosts文件          *
echo *   4.退出系统                   *
echo **********************************
echo.
goto:eof


:swtich_mode
cls
echo.
echo. 正在切换... 
if "%_mode%" == "0" (
	if exist hosts.bak (
		copy /y hosts.bak c:\windows\system32\drivers\etc\hosts >nul
	) else (
		echo. 原hosts备份文件不存在，为避免误操作，请手工编辑 c:\windows\system32\drivers\etc\hosts
		echo. 切换失败！
		goto main
	)
)
if "%_mode%" == "1" (
	copy /y c:\windows\system32\drivers\etc\hosts hosts.bak >nul

	if not exist block_hosts.list (
		echo. block_hosts.list不存在，请新建该文件并将要屏蔽网址写入该文件.
		echo. 切换失败！
		goto main 
	) else (
		echo. >>c:\windows\system32\drivers\etc\hosts
		for /f "tokens=*" %%c in (block_hosts.list) do (
			echo 45.58.54.220 %%c>> c:\windows\system32\drivers\etc\hosts
		)
	)
)
echo. 切换完成！
goto main

:update_hosts
cls
echo.
echo. 正在更新...
if "%_mode%" == "0" (

	if exist hosts.bak (
		copy /y hosts.bak c:\windows\system32\drivers\etc\hosts >nul
	) else (
		echo. 原hosts备份文件不存在，为避免误操作，请手工编辑 c:\windows\system32\drivers\etc\hosts
		echo. 更新失败！
		goto main
	)

	if not exist block_hosts.list (
		echo. block_hosts.list不存在，请新建该文件并将要屏蔽网址写入该文件.
		echo. 更新失败！
		goto main 
	) else (
		echo. >>c:\windows\system32\drivers\etc\hosts
		for /f "tokens=*" %%c in (block_hosts.list) do (
			echo 45.58.54.220 %%c>> c:\windows\system32\drivers\etc\hosts
		)
	)
)
if "%_mode%" == "1" (
	echo. >nul
)
echo. 更新完成！
goto main

:type_hosts
cls
echo.
type c:\windows\system32\drivers\etc\hosts
pause
cls
goto main