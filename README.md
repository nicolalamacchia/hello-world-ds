# Hello World DS

A "hello world" homebrew application for the Nindendo DS console family.

## Disclaimer

This is the very first homebrew I write and I just started learning about
Nintendo DS programming.

## Development and Testing

I developed this on an Arch Linux derivative distro,
[Manjaro](https://manjaro.org/) (which I love and I've been using happily for a
very long time), using the [devkitPro ARM suite](https://devkitpro.org), which
comes with the [libnds](https://libnds.devkitpro.org/) library.

For more details on how to build this project, refer to the [build](##build)
section.

This homebrew is written in C, but you can use C++,
[Free Pascal](https://krachik.developpez.com/tutoriels/pascal/fpc4nds-setup/),
[D](https://github.com/TheGag96/3ds-hello-dlang) and I bet also some other
languages, to develop for the Nintendo DS.

I tested the `.nds` output file using
[DeSmuME](https://sourceforge.net/projects/desmume/) and a Nintendo DS Lite with
a R4iSDHC Gold Pro 2020 flashcart. Unfortunately this flashcart has a
"time bomb", which makes it soft brick after ~1 year, but it's basically the
only one available on the market right now. The "time bomb" is easily fixable
though, by using [YSMenu](https://wiki.gbatemp.net/wiki/YSMenu) - or other
kernels - instead of the proprietary suggested kernel. (The purpose of the
"time bomb", of course, would be to force you to buy a new flashcart every year
or so.)

## Resources and Credits

The `Makefile` I used is a stripped-down version of the `Makefile` from the
[Jaeden Amero's Manual source code](https://github.com/Patater/manual).

If you want to learn more about DS game programming, I suggest you read
[Jaeden's manual](https://patater.com/files/projects/manual/manual.html). It's
a bit old (as the time of writing the lastest revision - 6.1x - is dated 2008),
but on the other hand the system has not evolved much (if at all) from that
time. While the toolchain and the [libnds](https://github.com/devkitPro/libnds)
library are still maintained, they should still be compatible with that manual.

## Why the Nintendo DS

There's a vast homebrew community around this console family. Though resources
are a bit scarce, especially if you want to learn programming for this handheld
console. Nonetheless, once you get started I think it's a great platform to get
introduced to game deveolpment. At least at a higher level than programming in
assembly for an old 6502-based machine (which is still a lot of fun!).

Aside from that, you can easily find used Nintendo DSs for very low prices and
often in quite good conditions.

## Build

* Install the basic development tools for your system (i.e.: `make`, etc.);
* [Install the devkitPro devkitARM toolchain](https://devkitpro.org/wiki/Getting_Started);
* run `make` in the root of this repository.

## Run

Use your favorite emulator or compatible console to run the file
`hello-world-ds.nds` (if you didn't change the `Makefile`, that's the output
ROM name).

## To do

* Add a CI pipeline using the
[devkitARM Docker image](https://hub.docker.com/r/devkitpro/devkitarm).
