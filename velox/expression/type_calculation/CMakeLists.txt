# Copyright (c) Facebook, Inc. and its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

bison_target(
  TypeCalculationParser TypeCalculation.yy
  ${CMAKE_CURRENT_BINARY_DIR}/TypeCalculation.yy.cc
  DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/TypeCalculation.yy.h)

flex_target(
  TypeCalculationScanner TypeCalculation.ll
  ${CMAKE_CURRENT_BINARY_DIR}/Scanner.cpp COMPILE_FLAGS "-Cf --prefix=veloxtc")

add_flex_bison_dependency(TypeCalculationScanner TypeCalculationParser)

find_package(flex)

include_directories(${PROJECT_BINARY_DIR})
find_package(FLEX 2.5.13 REQUIRED)
if(FLEX_FOUND)
  message(STATUS "xxxx----: ${FLEX_INCLUDE_DIR}")
  message(STATUS "xxxx----s: ${FLEX_INCLUDE_DIRS}")
else(FLEX_FOUND)
  message(STATUS "cannot found flex")
endif(FLEX_FOUND)

include_directories(${FLEX_INCLUDE_DIRS})
message(STATUS "xxxx: ${FLEX_INCLUDE_DIRS}")
add_library(velox_type_calculation ${BISON_TypeCalculationParser_OUTPUTS}
                                   ${FLEX_TypeCalculationScanner_OUTPUTS})
target_link_libraries(velox_type_calculation velox_common_base)
