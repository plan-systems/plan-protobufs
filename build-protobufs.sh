
#!/bin/sh




THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#
#
# See:
#    plan-systems/plan-protobuf/README.md 
#    http://plan-systems.org
#
#


GRPC_DIR="$THIS_DIR/Grpc.Tools/tools/macosx_x64"
protoc="$GRPC_DIR/protoc"

proto_file="pservice.proto"

echo
echo
echo "\$THIS_DIR=$THIS_DIR"
echo "\$GRPC_DIR=$GRPC_DIR"
echo "  \$protoc=$protoc"
echo
echo "Using:" `$protoc --version`
echo

# List of .proto file dirs to prcoess
declare -a PROTO_FILES=(    \
"plan"                      \
"ski"                       \
"pdi"                       \
"pservice"                  \
)

template="$THIS_DIR/../go-plan/zzzPKGzzz"

csharp_out="$THIS_DIR/unity-client/"
mkdir -p "$csharp_out"


PROTO_FILES=(                       \
    "plan/plan.proto"               \
    "ski/ski.proto"                 \
    "pdi/pdi.proto"                 \
    "pservice/pservice.proto"       \
)
NUM_FILES=$(( ${#PROTO_FILES[@]} ))


# Generate language-specific source files for each .proto file
for (( i=0; i<$NUM_FILES; i++ ));
do
    pathname="${template/zzzPKGzzz/${PROTO_FILES[$i]}}"
    proto_dir=$(dirname  ${pathname})
    proto_file=$(basename ${pathname})

    echo "Compiling: $proto_file"

    # also suggested: -I=$GOPATH/src/github.com/gogo/protobuf/protobuf
    $protoc -I=$proto_dir  -I="$GOPATH/src" --gofast_out=plugins=grpc:$proto_dir $proto_file

    $protoc -I=$proto_dir  -I="$GOPATH/src" --csharp_out "$csharp_out" --grpc_out "$csharp_out" --plugin=protoc-gen-grpc=$GRPC_DIR/grpc_csharp_plugin   $proto_file

done






