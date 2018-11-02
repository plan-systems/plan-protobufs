
#!/bin/sh




THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#
#
# See:
#    plan-tools/plan-protobuf/README.md 
#    http://plan.tools
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

# Generate language-specific source files for each .proto file
for i in "${PROTO_FILES[@]}"
do

    # Use find/replace magic to come up with the relative pathname for the .proto file
    proto_dir="${template/zzzPKGzzz/$i}"  
    proto_file="$i.proto"

    echo "Compiling: $proto_file"

    # also suggested: -I=$GOPATH/src/github.com/gogo/protobuf/protobuf
    $protoc -I=$proto_dir  -I="$GOPATH/src" --gofast_out=plugins=grpc:$proto_dir $proto_file

    $protoc -I=$proto_dir  -I="$GOPATH/src" --csharp_out "$csharp_out" --grpc_out "$csharp_out" --plugin=protoc-gen-grpc=$GRPC_DIR/grpc_csharp_plugin   $proto_file

done






