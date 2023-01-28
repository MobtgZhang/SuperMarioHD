find_path(SFML_AUDIO_INCLUDE_DIR Audio.hpp
  HINTS
    ENV SFMLAUDIODIR
    ENV SFMLDIR
  PATH_SUFFIXES SFML
                # path suffixes to search inside ENV{SDLDIR}
                include/SFML include
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(VC_LIB_PATH_SUFFIX lib/x64)
else()
  set(VC_LIB_PATH_SUFFIX lib/x86)
endif()

find_library(SFML_AUDIO_LIBRARY
  NAMES sfml-audio
  HINTS
    ENV SFMLAUDIODIR
    ENV SFMLDIR
  PATH_SUFFIXES lib ${VC_LIB_PATH_SUFFIX}
)

if(SFMLDIR AND EXISTS "${SFMLDIR}/Config.hpp")
    file(STRINGS "${SFMLDIR}/Config.hpp" SFML_VERSION_MAJOR_LINE REGEX "^#define[ \t]+SFML_VERSION_MAJOR[ \t]+[0-9]+$")
    file(STRINGS "${SFMLDIR}/Config.hpp" SFML_VERSION_MINOR_LINE REGEX "^#define[ \t]+SFML_VERSION_MINOR[ \t]+[0-9]+$")
    file(STRINGS "${SFMLDIR}/Config.hpp" SFML_VERSION_PATCH_LINE REGEX "^#define[ \t]+SFML_VERSION_PATCH[ \t]+[0-9]+$")
    string(REGEX REPLACE "^#define[ \t]+SFML_VERSION_MAJOR[ \t]+([0-9]+)$" "\\1" SFML_VERSION_MAJOR "${SFML_VERSION_MAJOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SFML_VERSION_MINOR[ \t]+([0-9]+)$" "\\1" SFML_VERSION_MINOR "${SFML_VERSION_MINOR_LINE}")
    string(REGEX REPLACE "^#define[ \t]+SFML_VERSION_PATCH[ \t]+([0-9]+)$" "\\1" SFML_VERSION_PATCH "${SFML_VERSION_PATCH_LINE}")

    set(SFML_VERSION_STRING ${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR}.${SFML_VERSION_PATCH})
    unset(SFML_VERSION_MAJOR_LINE)
    unset(SFML_VERSION_MINOR_LINE)
    unset(SFML_VERSION_PATCH_LINE)
    unset(SFML_VERSION_MAJOR)
    unset(SFML_VERSION_MINOR)
    unset(SFML_VERSION_PATCH)
endif()

set(SFML_AUDIO_LIBRARIES ${SFML_AUDIO_LIBRARY})
set(SFML_AUDIO_INCLUDE_DIRS ${SFML_AUDIO_INCLUDE_DIR})
include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(sfml-audio
                                REQUIRED_VARS SFML_AUDIO_LIBRARIES SFML_AUDIO_INCLUDE_DIRS
                                VERSION_VAR SFML_VERSION_STRING)
mark_as_advanced(SFML_AUDIO_LIBRARY SFML_AUDIO_INCLUDE_DIR)