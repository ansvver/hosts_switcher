@echo off

cd /d %~dp0
cls

:main
findstr "45.58.54.220" c:\windows\system32\drivers\etc\hosts > nul
set _mode=%errorlevel%
call:print_main
choice /c 1234 -m "��ѡ��"
if errorlevel 4 exit
if errorlevel 3 goto type_hosts
if errorlevel 2 goto update_hosts
if errorlevel 1 goto swtich_mode

:print_main
echo.
echo.
echo **********************************
echo *   ģʽ�л�������Host��������   *
echo *   (���Թ���Ա������У�)       *
echo *                                *
if %_mode% equ 0 (
echo *   ��ǰģʽ��������ģʽ       *
echo *                                *
echo *   1.�л������ǹ���ģʽ��       *
) else (
echo *   ��ǰģʽ�����ǹ���ģʽ     *
echo *                                *
echo *   1.�л���������ģʽ��         *
)
echo *   2.���µ�ǰhosts�ļ�          *
echo *   3.�鿴��ǰhosts�ļ�          *
echo *   4.�˳�ϵͳ                   *
echo **********************************
echo.
goto:eof


:swtich_mode
cls
echo.
echo. �����л�... 
if "%_mode%" == "0" (
	if exist hosts.bak (
		copy /y hosts.bak c:\windows\system32\drivers\etc\hosts >nul
	) else (
		echo. ԭhosts�����ļ������ڣ�Ϊ��������������ֹ��༭ c:\windows\system32\drivers\etc\hosts
		echo. �л�ʧ�ܣ�
		goto main
	)
)
if "%_mode%" == "1" (
	copy /y c:\windows\system32\drivers\etc\hosts hosts.bak >nul

	if not exist block_hosts.list (
		echo. block_hosts.list�����ڣ����½����ļ�����Ҫ������ַд����ļ�.
		echo. �л�ʧ�ܣ�
		goto main 
	) else (
		echo. >>c:\windows\system32\drivers\etc\hosts
		for /f "tokens=*" %%c in (block_hosts.list) do (
			echo 45.58.54.220 %%c>> c:\windows\system32\drivers\etc\hosts
		)
	)
)
echo. �л���ɣ�
goto main

:update_hosts
cls
echo.
echo. ���ڸ���...
if "%_mode%" == "0" (

	if exist hosts.bak (
		copy /y hosts.bak c:\windows\system32\drivers\etc\hosts >nul
	) else (
		echo. ԭhosts�����ļ������ڣ�Ϊ��������������ֹ��༭ c:\windows\system32\drivers\etc\hosts
		echo. ����ʧ�ܣ�
		goto main
	)

	if not exist block_hosts.list (
		echo. block_hosts.list�����ڣ����½����ļ�����Ҫ������ַд����ļ�.
		echo. ����ʧ�ܣ�
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
echo. ������ɣ�
goto main

:type_hosts
cls
echo.
type c:\windows\system32\drivers\etc\hosts
pause
cls
goto main