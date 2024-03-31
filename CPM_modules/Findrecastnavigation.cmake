include("C:/Users/Chris/Desktop/CactuarLSB/server/cmake/CPM_0.34.0.cmake")
CPMAddPackage(NAME;recastnavigation;GITHUB_REPOSITORY;recastnavigation/recastnavigation;GIT_TAG;cd898904b72a300011fbb24d578620bafa08ef2c;OPTIONS;RECASTNAVIGATION_DEMO OFF;RECASTNAVIGATION_TESTS OFF;RECASTNAVIGATION_EXAMPLES OFF)
set(recastnavigation_FOUND TRUE)