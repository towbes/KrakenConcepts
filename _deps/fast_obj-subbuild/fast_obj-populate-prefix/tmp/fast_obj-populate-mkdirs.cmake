# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-build"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/tmp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/src/fast_obj-populate-stamp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/src/fast_obj-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/src/fast_obj-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/fast_obj-subbuild/fast_obj-populate-prefix/src/fast_obj-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
