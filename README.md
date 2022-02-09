# Nocode

## Execute Ruby code through YAML

**Warning**: This library is currently experimental.

---

This is a proof of concept showing how a YAML interface could be draped over arbitrary Ruby code.  The YAML contains a series of steps with each step mapping to a specific Ruby class.  The Ruby classes just have one responsibility: to implement #perform.
