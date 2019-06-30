#!/bin/sh
#
#
# See:
#    plan-systems/plan-protobuf/README.md 
#    http://plan-systems.org
#
#


if [[ $# -ne 3 ]]; then
    echo "Usage: ./build-proto.sh <file.proto> <proto_compiler> <out_path>"
    echo "proto_compiler: go|gofast|csharp"
    exit
fi

PROTO_FILE=$1
PROTO_VERB=$2
OUT_PATH=$3


# Dir of where this script resides -- should be alongside all the available proto fiiles
SELF_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    BIN_DIR="$SELF_DIR/Grpc.Tools/tools/linux_x64"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    BIN_DIR="$SELF_DIR/Grpc.Tools/tools/macosx_x64"
else
    echo "Unknown environment"
    exit
fi

protoc="$BIN_DIR/protoc"
protoc_vers=`$protoc --version`

if [[ 0 == 1 ]]; then
    echo
    echo
    echo "\$SELF_DIR=$SELF_DIR"
    echo "  \$protoc=$protoc"
    echo
    echo "Using: $protoc_vers"
    echo
fi


proto_pathname="$SELF_DIR/proto/$PROTO_FILE"
proto_include=$(dirname  ${proto_pathname})

printf "$protoc_vers: %15s  --$PROTO_VERB-->  $proto_pathname\n" $PROTO_FILE

if [[ "$PROTO_VERB" == "go" ]]; then
    $protoc -I=$proto_include  -I="$GOPATH/src" --go_out=$OUT_PATH $proto_pathname
fi

if [[ "$PROTO_VERB" == "gofast" ]]; then
    $protoc -I=$proto_include  -I="$GOPATH/src" --gofast_out=plugins=grpc:$OUT_PATH $proto_pathname
fi

if [[ "$PROTO_VERB" == "csharp" ]]; then
    $protoc -I=$proto_include  -I="$GOPATH/src" --csharp_out "$OUT_PATH" --grpc_out "$OUT_PATH" --plugin=protoc-gen-grpc=$BIN_DIR/grpc_csharp_plugin $proto_pathname
fi


