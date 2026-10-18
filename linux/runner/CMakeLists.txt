cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME}
  "main.cc"
  "my_application.cc"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

find_program(GLIB_COMPILE_RESOURCES glib-compile-resources)
if(NOT GLIB_COMPILE_RESOURCES)
  message(FATAL_ERROR "glib-compile-resources is required to build the application icon.")
endif()

set(APP_ICON_RESOURCE "${CMAKE_CURRENT_BINARY_DIR}/app_icon.gresource.c")
add_custom_command(
  OUTPUT "${APP_ICON_RESOURCE}"
  COMMAND "${GLIB_COMPILE_RESOURCES}"
    --target="${APP_ICON_RESOURCE}"
    --generate-source
    --sourcedir="${CMAKE_CURRENT_SOURCE_DIR}/resources"
    "${CMAKE_CURRENT_SOURCE_DIR}/resources/app_icon.gresource.xml"
  DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/resources/app_icon.gresource.xml"
    "${CMAKE_CURRENT_SOURCE_DIR}/resources/app_icon.png"
)
target_sources(${BINARY_NAME} PRIVATE "${APP_ICON_RESOURCE}")

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the application ID.
add_definitions(-DAPPLICATION_ID="${APPLICATION_ID}")

# Add dependency libraries. Add any application-specific dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE PkgConfig::GTK)

target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")
