project (eyeprotect)

cmake_minimum_required (VERSION 2.6)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

set (PKGDATADIR "${DATADIR}/eyeprotect")
set (EXEC_NAME "eyeprotect")
set (GETTEXT_PACKAGE "eyeprotect")
set (RELEASE_NAME "netra")
set (VERSION "0.1")
set (VERSION_INFO "Initial release")

find_package(PkgConfig)

pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite appindicator3-0.1)
add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)

include(ValaVersion)

ensure_vala_version("0.24" MINIMUM)

configure_file (${CMAKE_SOURCE_DIR}/src/config.vala.cmake ${CMAKE_SOURCE_DIR}/src/config.vala)
add_definitions (-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/eyeProtect.vala
    src/Settings.vala
    src/Indicator.vala
    src/config.vala
    src/Widgets/LLabel.vala
    src/Widgets/WaitWindow.vala

PACKAGES
    gtk+-3.0
    granite
    appindicator3-0.1
)

add_executable(${EXEC_NAME} ${VALA_C})

include (GSettings)
add_schema ("org.pantheon.iprotect.gschema.xml")

install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/iProtect.desktop DESTINATION ${DATADIR}/applications/)