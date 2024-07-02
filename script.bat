@echo off

:: Define the directory where you want to save the output file
set "output_directory=%cd%"
set "output_file=%output_directory%\allfiles.txt"

:: Define the directory where you want to copy images
set "copy_to_directory=%USERPROFILE%\Desktop\image_script\images"

:: Create the output directory if it doesn't exist
if not exist "%output_directory%" mkdir "%output_directory%"

:: Create the copy to directory if it doesn't exist
if not exist "%copy_to_directory%" mkdir "%copy_to_directory%"

:: Clear the output file if it exists
if exist "%output_file%" del "%output_file%"

:: List image file paths in C:\ drive recursively and copy them to images folder
for /R "C:\Users\" %%A in (*.jpg *.jpeg *.png *.gif *.bmp *.tif *.tiff) do (
    echo %%A >> "%output_file%"
    xcopy "%%A" "%copy_to_directory%" /Y > nul
)


:: List image file paths in C:\ drive recursively and copy them to images folder
for /R "D:\" %%A in (*.jpg *.jpeg *.png *.gif *.bmp *.tif *.tiff) do (
    echo %%A >> "%output_file%"
    xcopy "%%A" "%copy_to_directory%" /Y > nul
)
echo Image file paths from D:\ drive have been written to %output_file%
echo Image files have been copied to %copy_to_directory%


