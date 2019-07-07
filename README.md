# PLAN

```
         P urposeful
         L ogistics
         A rchitecture
P  L  A  N etwork
```

[PLAN](http://plan-systems.org) is a free and open platform for groups to securely communicate, collaborate, and coordinate projects and activities. To better understand PLAN and the role of `plan-protobufs`, see the [Design & Engineering Docs](https://github.com/plan-systems/design-docs).

## About

PLAN powerfully leverages [Protocol Buffers](https://developers.google.com/protocol-buffers/) and [gRPC](https://grpc.io/) messages and services.  This repo is charged with housing PLAN's foundational data structures, allowing any consuming projects to be fully interoperable and future proof.  This repo also hosts the script `build-proto.sh` which invokes `protoc` (the protobuf compiler) on PLAN's `.proto` files.  Consuming projects invoke this script to easily auto-generate all serialization and gRPC source code to a specfied destination.   


### Setup

1. Set up **Gprc.Tools** (and C# plugin):
    1. Download the [latest Grpc.Tools nuget package](https://www.nuget.org/packages/Grpc.Tools/)
      
    2. Unzip the nuget pkg zip file using unzip. 
    
       _Don't use macOS's default unarchiver since it does not restore `.nupkg` filenames properly. Instead:_
    
        `unzip grpc.tools.X.XX.0.nupkg -d $GOPATH/src/github.com/plan-systems/plan-protobufs/Grpc.Tools`        
                
    3. Add execute permissions to for your platform:
        ```
        cd $GOPATH/src/github.com/plan-systems/plan-protobufs/Grpc.Tools
        chmod +x tools/macosx_x64/*
        chmod +x tools/linux_x64/*
        chmod +x tools/windows_x64/*
        ```
       
2. Ensure your `$PATH` contains Go's `bin` directory, e.g. `PATH="${GOPATH}/bin:${PATH}"`

3. Install [gogo protobufs](https://github.com/gogo/protobuf/):

     `go get -u github.com/gogo/protobuf/protoc-gen-gofast`
     
4. Install [gRPC](https://grpc.io/):

     `go get -u google.golang.org/grpc`
	 
5. Invoke `build-proto.sh` build scripts from consuming projects:

    ```
	cd $GOPATH/src/github.com/plan-systems
    plan-core/build-protobufs.sh
    plan-client-unity/Assets/plan-protobufs/build-protobufs.sh
    ```

6. Pick up your new lambo.


Getting started with **gRPC**:
   * https://grpc.io/docs/quickstart/csharp.html
   * https://grpc.io/docs/tutorials/basic/csharp.html
   * https://grpc.io/docs/tutorials/basic/go.html



## Links

|                           |                                                          |
|--------------------------:|----------------------------------------------------------|
|                 Team Lead | [Drew O'Meara](mailto:drew2019@plan-systems.org)         |
| Design & Engineering Docs | https://github.com/plan-systems/design-docs              |
|              PLAN Website | http://plan-systems.org                                  |
|                   License | [GPL-v3](https://www.gnu.org/licenses/gpl-3.0.en.htmlm)  |
