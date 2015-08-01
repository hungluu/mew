@echo off
set modulelist=functions
set release=release\mew
:: Detect if module directory exists
if not exist %modulelist% goto nodir
type nul > %release%
:: Load configs and head file
type %modulelist%\configs >> %release%
echo. >> %release%
type %modulelist%\head >> %release%
echo. >> %release%
:: Load modules
for /f %%a in (tib-list) do (
	if not exist %modulelist%\%%a (
		echo MODULE %%a NOT FOUND
		goto fail
	)

	(
		echo COPYING MODULE %%a TO RELEASE FILE
		:: Copy module file to final release
		type %modulelist%\%%a >> %release%
		:: Add end of line
		echo. >> %release%
	)
)
:: Load foot
type %modulelist%\foot >> %release%
goto success
:success
:: Auto closing on success
echo SUCCESSFULLY BUILT
goto end
:fail
type nul > %release%
pause
goto end
:nodir
echo NO MODULE DIRECTORY FOUND.
pause
goto end
:end
exit