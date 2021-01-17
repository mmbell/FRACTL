# User can tell us where to look

set ( LROSE_PREFIX $ENV{LROSE_INSTALL_DIR})

# If not, use the default location
if (NOT LROSE_PREFIX)
  set (LROSE_PREFIX "/usr/local/lrose")
endif ( NOT LROSE_PREFIX )

set ( LROSE_LIBRARIES kd tdrp Radx Ncxx toolsa netcdf hdf5_cpp hdf5 z bz2 )

find_program ( TDRP_EXECUTABLE tdrp_gen PATHS ${LROSE_BIN_DIR} /usr/local/bin )

# Add a custom generator for TDRP Params.cc and Params.hh files
# from their associated paramdef.<app> file
add_custom_command (
  OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/Params.hh ${CMAKE_CURRENT_SOURCE_DIR}/Params.cc
  DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/paramdef.${PROJECT_NAME}
  COMMAND cd ${CMAKE_CURRENT_SOURCE_DIR} && ${TDRP_EXECUTABLE}
            -c++
            -f paramdef.${PROJECT_NAME}
            -prog ${PROJECT_NAME}
            -add_ncar_copyright
  COMMENT "Generating/updating Params.hh and Params.cc for ${PROJECT_NAME}"
  )

message ( STATUS "lrose-config: CMAKE_INSTALL_PREFIX: " ${CMAKE_INSTALL_PREFIX} )
message ( STATUS "lrose-config: LROSE_INCLUDE_DIRS: " ${LROSE_INCLUDE_DIRS} )
message ( STATUS "lrose-config: LROSE_ROOT_DIR: " ${LROSE_ROOT_DIR} )
message ( STATUS "lrose-config: LROSE_BIN_DIR: " ${LROSE_BIN_DIR} )
message ( STATUS "lrose-config: LROSE_LIB_DIR: " ${LROSE_LIB_DIR} )
message ( STATUS "lrose-config: LROSE_DEFINITIONS: " ${LROSE_DEFINITIONS} )
message ( STATUS "lrose-config: LROSE_LIBRARIES: " ${LROSE_LIBRARIES} )
message ( STATUS "lrose-config: TDRP_EXECUTABLE: " ${TDRP_EXECUTABLE} )

