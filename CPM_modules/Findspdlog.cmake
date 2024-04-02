include("C:/Users/Chris/Desktop/CactuarLSB/server/cmake/CPM_0.34.0.cmake")
CPMAddPackage(NAME;spdlog;GITHUB_REPOSITORY;gabime/spdlog;GIT_TAG;v1.12.0;OPTIONS;SPDLOG_ENABLE_PCH ON;SPDLOG_FMT_EXTERNAL ON)
set(spdlog_FOUND TRUE)