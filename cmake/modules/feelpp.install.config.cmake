
if ( EXISTS ${CMAKE_CURRENT_BINARY_DIR}/cmake/modules/Feel++Config.cmake )

  set(FEELPP_DONT_SETUP_CMAKE 1)
  include(${CMAKE_CURRENT_BINARY_DIR}/cmake/modules/Feel++Config.cmake)
  unset(FEELPP_DONT_SETUP_CMAKE)

  string(REPLACE ${FEELPP_BINARY_BUILD_DIR}/feel/ ${FEELPP_INSTALL_DIR}/lib/  FEELPP_LIBRARY  "${FEELPP_LIBRARY}" )
  
  set(DIRS_TO_MODIFY)
  if ( FEELPP_HAS_GFLAGS )
    list(APPEND DIRS_TO_MODIFY ${FEELPP_BINARY_BUILD_DIR}/contrib/gflags/ )
  endif()
  if ( FEELPP_HAS_GLOG )
    list(APPEND DIRS_TO_MODIFY ${FEELPP_BINARY_BUILD_DIR}/contrib/glog/ )
  endif()
  if ( FEELPP_HAS_GINAC )
    list(APPEND DIRS_TO_MODIFY ${FEELPP_BINARY_BUILD_DIR}/contrib/ginac/ginac/ )
  endif()
  if ( FEELPP_HAS_METIS )
     list(APPEND DIRS_TO_MODIFY ${FEELPP_BINARY_BUILD_DIR}/contrib/metis/libmetis/ )
  endif()
  if ( FEELPP_HAS_NLOPT )
    list(APPEND DIRS_TO_MODIFY ${FEELPP_BINARY_BUILD_DIR}/contrib/nlopt/ )
  endif()

  foreach( DIR_TO_MODIFY ${DIRS_TO_MODIFY} )
    string(REPLACE ${DIR_TO_MODIFY} ${FEELPP_INSTALL_DIR}/lib/  FEELPP_LIBRARIES  "${FEELPP_LIBRARIES}" )
  endforeach()

  set(FEELPP_LIBRARIES_WITH_SPACE)
  foreach( THELIB ${FEELPP_LIBRARIES} )
    list(APPEND FEELPP_LIBRARIES_WITH_SPACE " ${THELIB} ")
  endforeach()
  set(FEELPP_LIBRARIES_TEXT "set(FEELPP_LIBRARY ${FEELPP_LIBRARY} )\nset(FEELPP_LIBRARIES ${FEELPP_LIBRARIES_WITH_SPACE})" )
  file( WRITE ${FEELPP_INSTALL_DIR}/share/feel/cmake/modules/feelpp.libraries.config.cmake
    ${FEELPP_LIBRARIES_TEXT} )

  set(FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE)
  foreach( THEINC ${FEELPP_DEPS_INCLUDE_DIR} )
    string( FIND ${THEINC} ${FEELPP_BINARY_BUILD_DIR} FINDINCBIN )
    string( FIND ${THEINC} ${FEELPP_SOURCE_BUILD_DIR} FINDINCSOURCE )
    if( ( "${FINDINCBIN}" STREQUAL "-1") AND ( ( "${FINDINCSOURCE}" STREQUAL "-1") ))
      list(APPEND FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE " ${THEINC} ")
    endif()
  endforeach()
  list(APPEND FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE  " ${FEELPP_INSTALL_DIR}/include/feel/ ")
  list(APPEND FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE  " ${FEELPP_INSTALL_DIR}/include/feel/unsupported/ ")
  if ( FEELPP_HAS_GINAC )
    list(APPEND FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE  " ${FEELPP_INSTALL_DIR}/include/feel/ginac/ ")
  endif()
  set(FEELPP_INCLUDE_DIR_TEXT "set(FEELPP_INCLUDE_DIR ${FEELPP_INSTALL_DIR}/include/)\nset(FEELPP_DEPS_INCLUDE_DIR ${FEELPP_DEPS_INCLUDE_DIR_WITH_SPACE})")
  string(REPLACE ";" "" FEELPP_INCLUDE_DIR_TEXT ${FEELPP_INCLUDE_DIR_TEXT} )
  file( WRITE ${FEELPP_INSTALL_DIR}/share/feel/cmake/modules/feelpp.include.config.cmake
    ${FEELPP_INCLUDE_DIR_TEXT} )

endif()
