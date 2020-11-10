# C-CPP-Builder
A C/C++ Builder written in batch 

HOW TO USE:
There are two options/ways to build a c and/or c++ file 
  - the first one is Main which is a way of compiling a c/c++ code without using any external libraries
  - the second is External option, which will compile a c/c++ with external libraries
  
  this build script will automaticly choose between those options based on the arguments passed from the command-line.
  
  note: you don't have to pass the extension of the file when using this build script
  example: build main
  
  note: the default directory of the compiled c/c++ file is in ..\bin directory you can specify it manualy
  example: build main
  the main.exe file will compiled to the ..\bin directory.

To use the Main option you just have to pass the file name with no extension, and if you wanted to change the default executeable file path you can use the -f followed
by the directory of the executeable file will be placed.
pattern: build file_name
pattern: build file_name -f executeable_directory

example: build main
example: build main -f c:\dev


To use the External option you just need to pass the file name with extension, the include headers path written inside double quotes,the library path written inside
double quotes,the libraries to link to also written inside double quotes, and last one is optional which is the path where to executeable file will be placed.
pattern: build file_name "include_path" "library_path" "-llib1 -llib2 -land_so_on"
pattern: build file_name "include_path" "library_path" "-llib1 -llib2 -land_so_on" executeable_directory
example: build main "C:\SDL\include" "C:\SDL\lib" "-mingw32 -lSDL2main -lSDL2"
example: build main "C:\SDL\include" "C:\SDL\lib" "-mingw32 -lSDL2main -lSDL2" C:\dev
  
