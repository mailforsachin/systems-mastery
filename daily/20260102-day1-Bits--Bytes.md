# Day 1: Bits & Bytes
## Date: 20260102

## Today's Question
How does data physically travel from my VPS to users?

## My Understanding
Data is made of streams of information in the form of signals or pulses, bits, bytes
It is not possible to stream data continously as it is transmitted over a shared medium of communication.
From the NIC card to the router, the distance covered is called a hop. 
A dataframe is sent with a packet to the hop where the hop receives it removes the packet, discards the dataframe and a new dataframe encapsulates the package.
Thus, data moves from the application layer down to the (PDNTSPA) <-- physical layer and back up to the receiver in the similar fashion.

## Commands I Ran
```bash
tracert
nslookup
```

## Related to My Production Setup
- myjournal.omchat.ovh
- Nginx / VPS

## Questions for AI Architect/ Explanations for Systems Architect
Data originates at the application layer and is progressively encapsulated as it moves down the network stack. At the sender’s NIC, the data becomes a Layer‑2 frame and is transmitted over the physical medium as electrical/optical/radio signals.

Each router along the path strips the Layer‑2 frame, examines the Layer‑3 packet, and forwards it by re‑encapsulating it into a new Layer‑2 frame appropriate for the next hop.

At the receiver, the process reverses: frames are decapsulated up the stack until the application receives the original data stream.

## Tomorrow's Focus
[What's next?]
