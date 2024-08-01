# CVBUILD

## About
A quick and easy way to streamline C.V. / résumé.

This repo contains everything needed to convert a .tex file into a PDF and package everything into ready-to-go website. It uses Make and Docker to build everything and bundles the resulting files into an NGINX Docker container.

Some samples are contained in `htdocs/resume`
## How to use
### Make & Docker
The cleanest way.
- Install Make
  - MacOS: Install via XCode CLI (`xcode-select --install`) or via homebrew (`brew install make`)
  - Linux:
    - Ubuntu / Debian: `apt install make`
    - Fedora / Red Hat: `dnf install make`
  - Windows: Install the [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/install)
- Install [Docker Desktop](https://docs.docker.com/desktop/)
- Clone or download this repo
- Copy a sample to your firstname_lastname.tex (e.g. john_doe.tex). The file name isn't technically important. This convention make it easier on those scrolling through hundreds of "resume 1.doc".
- run `make`

### Local LaTeX

[LaTeX installation guide](https://www.latex-project.org/get/)

You can then run `makepdf.sh htdocs/resume/myresume.tex` directly, avoiding the Makefile.

### VScode w/ LaTeX Extension
An exercise left to the reader.

[VScode](https://code.visualstudio.com/download)

[LaTeX Extension](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)