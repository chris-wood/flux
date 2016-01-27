# Overview

TODO: rationale 

## (1) flux DSL to specify flows

- specify constants for keys, certificates, etc. (key chains, names of keys, etc.)
- command to send interest (and specify return content size)
- general control flow commands (loops, conditions)


key k1 = RSA("root", 1024, nil)
key k2 = RSA("child", 1024, k1)

// TODO

flow name(link l) {
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

// Grammar

a  ::= x | n | - a | a opa a
b  ::= true | false | not b | b opb b | a opr a
opa ::= + | - | * | /
opb ::= and | or
opr ::= > | <
S  ::= x := a | skip | S1; S2 | ( S ) | if b then S1 else S2 | while b do S

## (2) flux compiles to instrumented ccnx-pktgen files
TODO

each flow has an outgoing queue
each flow has a program counter
each flow requires a link to operate
flows may call one another

## (3) instrumented ccnx-pktgen files are executed by fwdharness -> fwdrig
TODO
