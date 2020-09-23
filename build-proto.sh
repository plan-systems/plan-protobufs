#!/bin/bash
#
# See:
#    http://github.com/plan-systems/plan-protobuf/README.md
#    http://plan-systems.org
#
#

if [[ $# -ne 3 ]]; then
    echo "Usage: ./build-proto.sh <pkg_name> <proto_compiler> <out_path>"
    echo "proto_compiler: go|gofast|csharp"
    exit
fi

PKG_NAME=$1
PROTO_VERB=$2
OUT_PATH=$3


# Dir of where this script resides -- should be alongside all the available proto fiiles
SELF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

OS=""
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "cygwin"* ]]; then
    OS="windows"
fi


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    BIN_DIR="$SELF_DIR/Grpc.Tools/tools/linux_x64"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    BIN_DIR="$SELF_DIR/Grpc.Tools/tools/macosx_x64"
elif [[ "$OS" == "windows" ]]; then
    BIN_DIR="$SELF_DIR/Grpc.Tools/tools/windows_x64"
else
    echo "Unknown PLAN build environment: $OSTYPE"
    exit
fi

protoc="$BIN_DIR/protoc"
protoc_vers=$($protoc --version)

if [[ 0 == 1 ]]; then
    echo
    echo
    echo "\$SELF_DIR=$SELF_DIR"
    echo "  \$protoc=$protoc"
    echo
    echo "Using: $protoc_vers"
    echo
fi


proto_include="$SELF_DIR/pkg"
proto_pathname="$proto_include/$PKG_NAME/$PKG_NAME.proto"
# proto_include="$INCLUDE_PATH"

# # If no leading slash, make pathname relative to parent of this script
# if [[ "${SRC_PROTO_PATHNAME:0:1}" == "/" ]]; then
#     proto_pathname="$SRC_PROTO_PATHNAME"
# else
#     proto_pathname="$SELF_DIR/$SRC_PROTO_PATHNAME"
# fi
# proto_include="$(dirname "$proto_pathname")"

#echo "include::::::::: $proto_include"
#echo "OUT ---> $OUT_PATH"
#echo "IN ---> $proto_pathname"

printf "$protoc_vers: %18s  --$PROTO_VERB-->  $proto_pathname\n" "$PKG_NAME"

csharp_exe="$BIN_DIR/grpc_csharp_plugin"

if [[ "$OS" == "windows" ]]; then
	csharp_exe=$(cygpath -w "$csharp_exe")
	proto_include=$(cygpath -w "$proto_include")
	proto_pathname=$(cygpath -w "$proto_pathname")
	OUT_PATH=$(cygpath -w "$OUT_PATH")
fi


if [[ "$PROTO_VERB" == "go" ]]; then
    $protoc -I="$proto_include"  \
            --go_out="$OUT_PATH" \
            "$proto_pathname"
fi

if [[ "$PROTO_VERB" == "gofast" ]]; then
    $protoc -I="$proto_include"                   \
            --gofast_out=plugins="grpc:$OUT_PATH" \
            "$proto_pathname"
fi

if [[ "$PROTO_VERB" == "csharp" ]]; then
    $protoc -I="$proto_include"      \
            --csharp_out "$OUT_PATH" \
            --grpc_out "$OUT_PATH"   \
            --plugin=protoc-gen-grpc="$csharp_exe" \
            "$proto_pathname"
fi
