set(protobuf_MODULE_COMPATIBLE TRUE)

include(FetchContent)
set(FETCHCONTENT_BASE_DIR ${MJX_EXTERNAL_DIR})
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON)

fetchcontent_declare(
  grpc
  GIT_REPOSITORY https://github.com/grpc/grpc.git
  GIT_TAG v1.49.1
  GIT_PROGRESS TRUE
  GIT_SHALLOW TRUE
)
set(gRPC_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(gRPC_INSTALL OFF CACHE BOOL "" FORCE)
set(gRPC_BUILD_CSHARP_EXT OFF CACHE BOOL "" FORCE)
set(gRPC_BUILD_CODEGEN ON CACHE BOOL "" FORCE)
fetchcontent_makeavailable(grpc)

set(_PROTOBUF_LIBPROTOBUF libprotobuf)
set(_REFLECTION grpc++_reflection)
set(_GRPC_GRPCPP grpc++)

if(DEFINED _gRPC_PROTOBUF_PROTOC)
  set(_PROTOBUF_PROTOC ${_gRPC_PROTOBUF_PROTOC})
elseif(TARGET protobuf::protoc)
  set(_PROTOBUF_PROTOC $<TARGET_FILE:protobuf::protoc>)
elseif(TARGET protoc)
  set(_PROTOBUF_PROTOC $<TARGET_FILE:protoc>)
else()
  find_program(_PROTOBUF_PROTOC protoc)
endif()

if(DEFINED _gRPC_CPP_PLUGIN_EXECUTABLE)
  set(_GRPC_CPP_PLUGIN_EXECUTABLE ${_gRPC_CPP_PLUGIN_EXECUTABLE})
elseif(TARGET grpc_cpp_plugin)
  set(_GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:grpc_cpp_plugin>)
elseif(TARGET grpc::grpc_cpp_plugin)
  set(_GRPC_CPP_PLUGIN_EXECUTABLE $<TARGET_FILE:grpc::grpc_cpp_plugin>)
else()
  find_program(_GRPC_CPP_PLUGIN_EXECUTABLE grpc_cpp_plugin)
endif()

if(NOT _PROTOBUF_PROTOC OR NOT _GRPC_CPP_PLUGIN_EXECUTABLE)
  message(FATAL_ERROR "Could not resolve protoc/grpc_cpp_plugin for downloaded grpc build")
endif()
