# PLAN Design & Engineering Docs

```
         P.rivacy
         L.ogistics
         A.ccessibility
P  L  A  N.etworks
```

[PLAN](http://plan-systems.org) is a software platform for communications, group collaboration, and spatial planning. PLAN leverages modern feats of engineering in distributed crypto systems, 3D graphics, and "trustless" protocols. 


## About

PLAN leverages [Protocol Buffers](https://developers.google.com/protocol-buffers/) and [gRPC](https://grpc.io/).  This repo houses PLAN's foundational data structures, allowing any consuming projects to be interoperable.  This repo also offers the utility script `build-proto.sh` which invokes the protobuf compiler `protoc` on a `.proto` file for a given target language.  Consuming projects invoke this script to more easily compile this projects proto files.


### Setup

1. Set up **Gprc.Tools** (and C# plugin):
    a. Download the [latest Grpc.Tools nuget package](https://www.nuget.org/packages/Grpc.Tools/)
      
    b. Unzip the `grpc.tools` nupkg file using unzip.  _Do not use macOS's default unarchiver since it does not restore `.nupkg` filenames properly. Instead:_
    
        `unzip grpc.tools.X.XX.0.nupkg -d plan-systems/plan-protobufs/Grpc.Tools`        
                
    c. Add execute permissions to for your platform:
        ```
        cd plan-systems/plan-protobufs/Grpc.Tools
        chmod +x tools/macosx_x64/*
        chmod +x tools/linux_x64/*
        chmod +x tools/windows_x64/*
        ```
       
2. Ensure your `$PATH` contains Go's `bin` directory, e.g. `PATH="${GOPATH}/bin:${PATH}"`

3. Install [gogo protobufs](https://github.com/gogo/protobuf/) and [gRPC](https://grpc.io/):

    ```
    go get -u github.com/gogo/protobuf/protoc-gen-gofast
    go get -u google.golang.org/grpc
    ```

4. Invoke `build-proto.sh` from consuming projects.

5. Pick up your new lambo.


Getting started with **gRPC**:
   * https://grpc.io/docs/quickstart/csharp.html
   * https://grpc.io/docs/tutorials/basic/csharp.html
   * https://grpc.io/docs/tutorials/basic/go.html


