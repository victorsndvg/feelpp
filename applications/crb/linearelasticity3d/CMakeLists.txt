
add_library( feelpp-applications-crb-linearelasticity3d SHARED linearelasticity3d.cpp )
target_link_libraries( feelpp-applications-crb-linearelasticity3d ${FEELPP_LIBRARY} ${FEELPP_LIBRARIES} )
INSTALL(TARGETS feelpp-applications-crb-linearelasticity3d DESTINATION lib/ COMPONENT Libs)

crb_add_model(linearelasticity3d LinearElasticity3d HDRS linearelasticity3d.hpp
  LINK_LIBRARIES feelpp-applications-crb-linearelasticity3d )

feelpp_add_testcase(linearelasticity3d PREFIX feelpp_crb CATEGORY CRB)
