if(NOT TARGET Cinder-OpenCV)
    # Define ${Cinder-Notifications_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(Cinder-OpenCV_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${Cinder-OpenCV_PROJECT_ROOT}/../.." ABSOLUTE)

    # Make a list of source files and define that to be ${SOURCE_LIST}.
    file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.h"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.hpp"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.H"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.cc"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.cpp"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.C"
            "${Cinder-OpenCV_SOURCE_PATH}/**/*.c")

    # Create the library!
    add_library(Cinder-OpenCV ${SOURCE_LIST})

    # Add include directories.
    # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
    # So you need to set `../../src/` to include.
    target_include_directories(Cinder-OpenCV PUBLIC "${Cinder-OpenCV_PROJECT_ROOT}/src" )
    target_include_directories(Cinder-OpenCV SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )


    # If your Cinder block has no source code but instead pre-build libraries,
    # you can specify all of them here (uncomment the below line and adjust to your needs).
    # Make sure to use the libraries for the right platform.
    target_link_libraries(Cinder-Notifications ${Cinder-OpenCV_PROJECT_ROOT}/lib/*.a)

    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(Cinder-OpenCV PRIVATE cinder)

endif()