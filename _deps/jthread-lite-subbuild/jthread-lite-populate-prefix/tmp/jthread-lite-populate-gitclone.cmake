# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

if(EXISTS "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitclone-lastrun.txt" AND EXISTS "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitinfo.txt" AND
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitclone-lastrun.txt" IS_NEWER_THAN "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitinfo.txt")
  message(STATUS
    "Avoiding repeated git clone, stamp file is up to date: "
    "'C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitclone-lastrun.txt'"
  )
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-src"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: 'C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "C:/Users/Chris/AppData/Local/Atlassian/SourceTree/git_local/bin/git.exe" 
            clone --config "advice.detachedHead=false" "https://github.com/martinmoene/jthread-lite.git" "jthread-lite-src"
    WORKING_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps"
    RESULT_VARIABLE error_code
  )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once: ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/martinmoene/jthread-lite.git'")
endif()

execute_process(
  COMMAND "C:/Users/Chris/AppData/Local/Atlassian/SourceTree/git_local/bin/git.exe" 
          checkout "5332bbd46dcba5f028a844795cc0931e9f2ffdf4" --
  WORKING_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-src"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '5332bbd46dcba5f028a844795cc0931e9f2ffdf4'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "C:/Users/Chris/AppData/Local/Atlassian/SourceTree/git_local/bin/git.exe" 
            submodule update --recursive --init 
    WORKING_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-src"
    RESULT_VARIABLE error_code
  )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitinfo.txt" "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: 'C:/Users/Chris/Desktop/CactuarLSB/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/jthread-lite-populate-gitclone-lastrun.txt'")
endif()
