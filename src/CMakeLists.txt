find_package (PkgConfig)

pkg_check_modules (DEPS REQUIRED
  gtk+-3.0
  wingpanel-2.0
  granite
)

add_definitions (${DEPS_CFLAGS})
link_directories (${DEPS_LIBRARY_DIRS})

find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.26.0" MINIMUM)

include (ValaPrecompile)
vala_precompile (VALA_C ${EXEC_NAME}
  Main.vala
  Common/Settings.vala
  Model/Service.vala
  Model/ServiceRepository.vala
  UI/Indicator.vala
  UI/Widgets/OverlayWidget.vala
  UI/Widgets/PopoverWidget.vala
  UI/Service/ServiceView.vala
  UI/Service/ServiceListView.vala
  UI/Preferences/PreferencesView.vala
  UI/Preferences/ServiceView.vala
  UI/Preferences/ServiceListView.vala
  ${CMAKE_CURRENT_BINARY_DIR}/Common/Constants.vala
PACKAGES
  gtk+-3.0
  wingpanel-2.0
  granite
OPTIONS
  --thread
  --target-glib=2.32
)

add_library (${EXEC_NAME} MODULE ${VALA_C})
target_link_libraries(${EXEC_NAME} ${DEPS_LIBRARIES})

# Installation
install (TARGETS ${EXEC_NAME} DESTINATION ${PKGDATADIR})

# install (FILES ${CMAKE_SOURCE_DIR}/data/${EXEC_NAME}.appdata.xml DESTINATION ${DATADIR}/metainfo/)
