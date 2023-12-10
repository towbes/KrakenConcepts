# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-build"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/tmp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/src/expected-lite-populate-stamp"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/src"
  "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/src/expected-lite-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/src/expected-lite-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Chris/Desktop/CactuarLSB/server/_deps/expected-lite-subbuild/expected-lite-populate-prefix/src/expected-lite-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
