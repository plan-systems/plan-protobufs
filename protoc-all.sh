
#!/bin/sh


THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#
#
# See plan-tools/plan-protobuf/README.md for info!
#
#


GRPC_DIR="$THIS_DIR/Grpc.Tools/tools/macosx_x64"
protoc="$GRPC_DIR/protoc"

proto_dir="$THIS_DIR/pservice"
proto_file="pservice.proto"

echo
echo
echo "\$THIS_DIR=$THIS_DIR"
echo "\$GRPC_DIR=$GRPC_DIR"
echo "  \$protoc=$protoc"
echo
echo "Using:" `$protoc --version`
echo "Compiling: $proto_file"
echo

#echo $protoc
#echo $proto_file


$protoc --proto_path=$proto_dir  --gofast_out=plugins=grpc:$proto_dir                                                                  $proto_file
#$protoc --proto_path=$proto_dir  --go_out=plugins=grpc:$proto_dir                                                                      $proto_file

$protoc --proto_path=$proto_dir  --csharp_out $proto_dir --grpc_out $proto_dir --plugin=protoc-gen-grpc=$GRPC_DIR/grpc_csharp_plugin   $proto_file
