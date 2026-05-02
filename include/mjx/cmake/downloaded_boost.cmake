include(FetchContent)
set(FETCHCONTENT_BASE_DIR ${MJX_EXTERNAL_DIR})
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON)

# Use the official source archive instead of cloning the giant super-repo with
# submodules. For header-only usage this is much faster and more reliable.
fetchcontent_declare(
  boost
  URL https://github.com/boostorg/boost/archive/refs/tags/boost-1.71.0.tar.gz
)

fetchcontent_getproperties(boost)
if(NOT boost_POPULATED)
  fetchcontent_populate(boost)
endif()

set(Boost_INCLUDE_DIRS ${boost_SOURCE_DIR})
