wEMBOSS docker
===================

This docker image is part of the eBioKit 2017 project.

This docker image extends and distributes the following software:

#### wEMBOSS

- Based on [wEMBOSS project](http://wemboss.sourceforge.net/).
- Based on [EMBOSS project](http://wemboss.sourceforge.net/).
- wEMBOSS was designed and implemented by Martin Sarachu and Marc Colet.
- Citation:
> wEMBOSS: a web interface for EMBOSS
Martín Sarachu and Marc Colet
Bioinformatics 2005 21(4):540-541

## Running the Container

The container is publicly available as `ebiokit/docker-wemboss`. The recommended method for launching the container is via docker-compose.

## Quickstart

This procedure starts wEMBOSS in a standard virtualised environment.

- Install [docker](https://docs.docker.com/engine/installation/) for your system if not previously done.
- `docker run -it -p 18090:18090 ebiokit/docker-wemboss`
- wEMBOSS will be available at [http://localhost:8095/](http://localhost:8095/)

### About the eBioKit project

The eBioKit is a system running multiple open source web services on an Apple Mac-mini where all databases are stored locally.
This reduces the need for a fast internet connection while giving the users an opportunity to incorporate their data sets in widely used web services.

The eBioKit is developed by the SLU Global Bioinformatics Centre (SGBC), an academic research and educational initiative aimed to build a long-term successful bioinformatics infrastructure facility that serves the Swedish University for Agricultural Sciences (SLU) and life science research communities worldwide.

Find more information at [http://ebiokit.eu](http://ebiokit.eu)  and at the [SGBC](http://sgbc.slu.se/) website.

**Contact** [ebiokit@gmail.com](ebiokit@gmail.com)

<p style="text-align:center">
<img height=100 src="https://avatars0.githubusercontent.com/u/24695838?v=3&s=200">
</p>
