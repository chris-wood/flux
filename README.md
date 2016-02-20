# flux

## Overview

Flux is an imperative programing language that compiles to *executable 
packet flows.* The intent is to allow the network behavior of an application
to be programmatically encoded without dealing with the application-layer 
details. The ultimate goal is to enable better experimentation of CCN-based
applications, forwarders, and (forwarding, caching, etc.) strategies. 

## Development

Inspired by the following tutorial:

[http://www.stephendiehl.com/llvm/#chapter-2-parser-and-ast](http://www.stephendiehl.com/llvm/#chapter-2-parser-and-ast)

## Workflow

Flux compiles to instrumented ccnx-pktpusher files -- what are called programmable
packets. The details of these instrumented files can be found in the ccnx-pktpusher
project. 

## Language Sketches

### (1) flux DSL to specify flows

- specify constants for keys, certificates, etc. (key chains, names of keys, etc.)
- command to send interest (and specify return content size)
- general control flow commands (loops, conditions)


key k1 = RSA("root", 1024, nil)
key k2 = RSA("child", 1024, k1)

// TODO

flow flowOneName(link l) {
    while true {
        // send and receive explicit
        receive(l, "/name/of/interest", nil)
        asyncSend(l, "/name/of/interest", nil)

        // block send
        send(l, "/name/of/interest", nil)
        
        // delays
        uniformWait(0.05)
        expWait(0.05)
    }
}

link l1 = Link(/prefix/) 
flowOneName(l1)

delay = exp(100) // uniform(100) (other distributions here)
scheduleWithRepeat(flowOneName, l1, delay)
schedule(flowOneName, l1, delay)


