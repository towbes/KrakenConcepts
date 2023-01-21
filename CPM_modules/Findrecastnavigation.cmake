include("C:/Users/Chris/Desktop/CactuarLSB/server/cmake/CPM_0.34.0.cmake")
CPMAddPackage(NAME;recastnavigation;GITHUB_REPOSITORY;recastnavigation/recastnavigation;GIT_TAG;67c36bda750f36b2b4152db57a23170ed7a0683c;OPTIONS;RECASTNAVIGATION_DEMO OFF;RECASTNAVIGATION_TESTS OFF;RECASTNAVIGATION_EXAMPLES OFF)
set(recastnavigation_FOUND TRUE)