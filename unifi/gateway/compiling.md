## Compiling for Secure Gateway

With Ubuntu, it is possible to cross compile C programs to run on Secure Gateway, which is running the MIPS-II architecture using the following package:

```
sudo apt-get install gcc-mips-linux-gnu
```

Then you can replace all `gcc` (or `cc`) invocations with `mips-linux-gnu-gcc`.
The final executable should probably be statically linked (using `-static`) in
order to not run into library incompatibilities.

During debugging of multicast, I successfully compiled and ran the following projects:

* https://github.com/pali/igmpproxy (The IGMP proxy which is preinstalled on USG)
* https://github.com/haibbo/improxy (An alternative implementation)
