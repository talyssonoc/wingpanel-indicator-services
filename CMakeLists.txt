cmake_minimum_required (VERSION 2.6)
cmake_policy (VERSION 2.6)

set (INDICATOR_TITLE "Services indicator")
set (INDICATOR_DESCRIPTION "Manages init scripts")
project (com.github.talyssonoc.wingpanel-indicator-services)

# Configuration
include (GNUInstallDirs)
set (DATADIR "${CMAKE_INSTALL_FULL_LIBDIR}/wingpanel/")
set (PKGDATADIR "${DATADIR}")
set (GETTEXT_PACKAGE "${CMAKE_PROJECT_NAME}")
set (EXEC_NAME "${CMAKE_PROJECT_NAME}")
set (RELEASE_NAME "A services management indicator.")
set (VERSION "0.1")

# Configure file
configure_file (${CMAKE_SOURCE_DIR}/Constants.vala.cmake ${CMAKE_BINARY_DIR}/src/Constants.vala)
add_definitions (-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

# Comment this out to enable C compiler warnings
add_definitions (-w)

# Traslation stuff
# add_subdirectory (po)
add_subdirectory (schemas)
add_subdirectory (src)

# Uninstall target
configure_file(
  "${CMAKE_SOURCE_DIR}/cmake/Uninstall.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake"
  IMMEDIATE @ONLY)

add_custom_target(uninstall
  COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake)
