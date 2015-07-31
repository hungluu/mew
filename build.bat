@echo off
SET modulelist=functions
SET release=release\mew
:: Detect if module directory exists
if not exist %modulelist% goto nodir
type nul > %release%
for /f %%a in (tib-list) do (
	if not exist %modulelist%\%%a (
		echo MODULE %%a NOT FOUND
		goto fail
	)

	echo COPYING MODULE %%a TO RELEASE FILE
	:: Copy module file to final release
	type %modulelist%\%%a >> %release%
	:: Add end of line
	echo. >> %release%
)
goto success
:success
echo SUCCESS
goto end
:fail
goto end
:nodir
echo NO MODULE DIRECTORY FOUND.
goto end
:end
pause
exit