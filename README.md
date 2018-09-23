# plan-protobuf

[PLAN](http://plan.tools) uses [protobuf](https://developers.google.com/protocol-buffers/)-based data structures and gRPC messages.  This repo hosts the script `build-protobufs.sh` that invokes `protoc` (the protobuf compiler) on PLAN's `.proto` files.  The script auto-generates serialization and gRPC source code used in other PLAN projects.   

Specifcally, this process generates:
 * C# code for PLAN's Unity-based client, `plan-tools/plan-unity`
 * Go code for PLAN's go-based p2p server node, `plan-tools/go-plan`



### Build Flow

1. Set up **Gprc.Tools** (and C# plugin):
    1. Download the latest nuget package:
    
         https://www.nuget.org/packages/Grpc.Tools/
      
    2. Unzip the nuget pkg zip file using unzip. 
    
        `unzip grpc.tools.1.15.0.nupkg -d $GOPATH/src/github.com/plan-tools/plan-protobuf/Grpc.Tools`
        
        (macOS's default unarchiver doesn't restore `.nupkg` filenames properly)
                
    3. Add execute permissions:
         ```
         chmod +x plan-protobuf/Grpc.Tools/tools/macosx_x64/*
         chmod +x plan-protobuf/Grpc.Tools/tools/linux_x64/*
         ```
       
2. Ensure your `$PATH` contains Go's `bin` directory, e.g. `PATH="${GOPATH}/bin:${PATH}"`

3. Install [gogo protobufs](https://github.com/gogo/protobuf/)

     `go get github.com/gogo/protobuf/protoc-gen-gofast`
     
4. Install [gRPC](https://grpc.io/)

     `go get google.golang.org/grpc`

5. Compile PLAN's `.proto` files

     `./build-protobufs.sh`

6. The script also moves the output `.go` files to `go-plan`, but you must move:

    `*.cs`   ->   `plan-tools/unity-client/PLAN-Unity/Assets/src/Protobufs+gRPC`

7. Pick up your new lambo


Getting started with **gRPC**:
   * https://grpc.io/docs/quickstart/csharp.html
   * https://grpc.io/docs/tutorials/basic/csharp.html
   * https://grpc.io/docs/tutorials/basic/go.html


## About PLAN

PLAN is a free, open source, all-in-one visual communication and organizational tool for communities and individuals.  

http://plan.tools/


## Acknolwedgements

Special thanks to Google for making the protobuf toolchain FOSS.  Unencumbered community-available software matters.


## License

[GPL-v3](https://www.gnu.org/licenses/gpl-3.0.en.htmlm)
