# PLAN

```
         P urposeful
         L ogistics
         A rchitecture
P  L  A  N etwork
```

[PLAN](http://plan-systems.org) is a free, multi-purpose collaboration and logistics planning tool for organizations and communities. To better understand PLAN and the role of `plan-protobufs`, see the [Design & Engineering Docs](https://github.com/plan-systems/design-docs).


## About

PLAN uses [Protocol Buffers](https://developers.google.com/protocol-buffers/) and [gRPC](https://grpc.io/) messages and services.  This repo hosts the script `build-protobufs.sh` that invokes `protoc` (the protobuf compiler) on each of PLAN's `.proto` files.  The script auto-generates serialization and gRPC source code used in other PLAN projects.   

Specifically, this process generates:
 * C# code for PLAN's Unity-based client, `plan-systems/plan-unity`
 * Go code for PLAN's go-based p2p server node, `plan-systems/go-plan`



### Build Flow

1. Set up **Gprc.Tools** (and C# plugin):
    1. Download the latest nuget package:
    
         https://www.nuget.org/packages/Grpc.Tools/
      
    2. Unzip the nuget pkg zip file using unzip. 
    
        `unzip grpc.tools.1.15.0.nupkg -d $GOPATH/src/github.com/plan-systems/plan-protobuf/Grpc.Tools`
        
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

6. The script also moves the output `.go` files to `go-plan`, but you must also move:

    `*.cs`   ->   `plan-systems/plan-unity/Assets/src/Protobufs+gRPC/`

7. Pick up your new lambo


Getting started with **gRPC**:
   * https://grpc.io/docs/quickstart/csharp.html
   * https://grpc.io/docs/tutorials/basic/csharp.html
   * https://grpc.io/docs/tutorials/basic/go.html


## Project Log


|    Date     | Status                                                          |
|:-----------:|-----------------------------------------------------------------|
| 01 Sep 2018 | Now processing 4 proto files                                    |
| 04 Aug 2018 | Now a separate repo/project                                     |


## Links

|                           |                                                          |
|--------------------------:|----------------------------------------------------------|
|                 Team Lead | [Drew O'Meara](mailto:drew2019@plan-systems.org)         |
| Design & Engineering Docs | https://github.com/plan-systems/design-docs              |
|              PLAN Website | http://plan-systems.org                                  |
|                   License | [GPL-v3](https://www.gnu.org/licenses/gpl-3.0.en.htmlm)  |
