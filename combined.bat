@echo off

:: Define the directory where you want to save the output file
set "output_directory=%cd%"
set "output_file=%output_directory%\images_filepaths.txt"
set "user_info_file=%output_directory%\user_info.txt"

:: Define the directory where you want to copy images
set "copy_to_directory=%output_directory%\copied_images"

:: Define the path to the text file containing directories to search
set "paths_file=%output_directory%\paths.txt"

:: Create the output directory if it doesn't exist
if not exist "%output_directory%" mkdir "%output_directory%"

:: Create the copy to directory if it doesn't exist
if not exist "%copy_to_directory%" mkdir "%copy_to_directory%"

:: Clear the output file if it exists
if exist "%output_file%" del "%output_file%"

:: Clear the user info file if it exists
if exist "%user_info_file%" del "%user_info_file%"

:: Gather user info and write to user_info.txt
echo Gathering user information...
echo Hostname: %COMPUTERNAME% >> "%user_info_file%"
echo Username: %USERNAME% >> "%user_info_file%"

:: Check if paths file exists
if not exist "%paths_file%" (
    echo Paths file not found: %paths_file%
    pause
    goto :eof
)

:: Display the contents of paths.txt
echo Displaying paths from where images will be extracted:
type "%paths_file%"

:: Prompt the user to continue
set /P continue="Do you want to continue? (y/n): "
if /I not "%continue%"=="y" (
    echo Script terminated by user.
    pause
    goto :eof
)

:: Read the paths file and process each path
echo Reading paths from %paths_file%
for /F "usebackq delims=" %%P in ("%paths_file%") do (
    echo Processing path: %%P
    if exist "%%P" (
        echo Path found: %%P
        echo Searching for image files in %%P
        pushd "%%P"
        for /R %%A in (*.jpg *.jpeg *.png *.gif *.bmp *.tif *.tiff) do (
            echo Found file: "%%A"
            echo "%%A" >> "%output_file%"
            xcopy "%%A" "%copy_to_directory%" /Y > nul
        )
        popd
    ) else (
        echo Path not found: %%P
    )
)

echo Script completed.
pause
