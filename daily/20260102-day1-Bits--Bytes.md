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

## Questions for AI Architect
1.
2.

## Tomorrow's Focus
[What's next?]
