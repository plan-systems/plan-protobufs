# plan-protobuf

This repo contains PLAN's protobuf-based data structures and gRPC messages.  The .proto file found in this repo is used to auto-generate serialization and gRPC source code used in other PLAN projects.  

Specifcally, this repo generates:
 * C# code for PLAN's Unity-based client
 * Go code for pnode, PLAN's go-based p2p server node. 



### Build Flow

1. Set up **Gprc.Tools** (and C# plugin):
    1. Download the latest nuget package:
    
         https://www.nuget.org/packages/Grpc.Tools/
      
    2. Unzip the nuget pkg zip file using unzip. 
    
        `unzip grpc.tools.1.14.1.nupkg -d $GOPATH/src/github.com/plan-tools/plan-protobuf/Grpc.Tools`
        
        (macOS's default unarchiver doesn't restore `.nupkg` filenames properly)
                
    3. Add execute permissions:
         ```
         chmod +x plan-protobuf/Grpc.Tools/tools/macosx_64/*
         chmod +x plan-protobuf/Grpc.Tools/tools/linux_x64/*
         ```
       
2. Ensure your `$PATH` contains Go's `bin` directory, e.g. `PATH="${GOPATH}/bin:${PATH}"`

3. Install **gogo protobufs** 

     `go get github.com/gogo/protobuf/protoc-gen-gofast`

      https://github.com/gogo/protobuf/
     
4. Install **grpc**

     `go get google.golang.org/grpc`

5. Execute `./build-protobufs.sh` (this compiles each `.proto` file)  

6. The output `.go` files will already be properly placed in `go-plan`, but you must move:

    `*.cs`   ->   `plan-tools/unity-client/PLAN-Unity/Assets/src/Protobufs+gRPC`

7. Pick up your lambo


More **gRPC** info and docs:
   * https://grpc.io/docs/quickstart/csharp.html
   * https://grpc.io/docs/tutorials/basic/csharp.html
   * https://grpc.io/docs/tutorials/basic/go.html


## About PLAN

PLAN is a free, open source, all-in-one visual communication and organizational tool for real-world communities and individuals.  

http://plan.tools/


## Acknolwedgements

Special thanks to Google for making the protobuf toolchain FOSS.  Community-oriented software matters.


## License

[GPL-v3](https://www.gnu.org/licenses/gpl-3.0.en.htmlm)
