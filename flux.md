# Overview

## (1) flux DSL to specify flows

- specify constants for keys, certificates, etc. (key chains, names of keys, etc.)
- command to send interest (and specify return content size)
- general control flow commands (loops, conditions)



key k1 = RSA("root", 1024, nil)
key k2 = RSA("child", 1024, k1)

// TODO

flow name() {
    while true {
        // send and receive explicit
        receive("/name/of/interest", nil)
        asyncSend("/name/of/interest", nil)

        // block send
        send("/name/of/interest", nil)
        
        // delays
        uniformWait(0.05)
        expWait(0.05)
    }
}


## (2) flux compiles to instrumented ccnx-pktgen files
TODO

## (3) instrumented ccnx-pktgen files are executed by fwdharness
TODO
