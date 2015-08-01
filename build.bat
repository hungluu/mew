@echo off
set modulelist=functions
set releasetemp=release\mew-temp
set release=release\mew
:: Detect if module directory exists
if not exist %modulelist% goto nodir
:: Load configs and head file
del /f /q %releasetemp%
del /f /q %release%
type nul>%releasetemp%
type nul>%release%
type %modulelist%\configs >> %releasetemp%
echo.>>%releasetemp%
type %modulelist%\head >> %releasetemp%
echo.>>%releasetemp%
:: Load modules
for /f %%m in (tib-list) do (
	if not exist %modulelist%\%%m (
		echo MODULE %%m NOT FOUND
		goto fail
	)

	echo COPYING MODULE %%m TO releasetemp FILE
		:: Copy module file to final releasetemp
		type %modulelist%\%%m>>%releasetemp%
		:: Add end of line
		echo.>>%releasetemp%
)
:: Load foot
type %modulelist%\foot>>%releasetemp%
goto success
:success
:: Auto closing on success
echo SUCCESSFULLY BUILT
goto end
:fail
del /f /q %releasetemp%
del /f /q %release%
pause
goto end
:nodir
echo NO MODULE DIRECTORY FOUND.
goto fail
:end
pause
exit