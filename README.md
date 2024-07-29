For self hosted github actions runners, there's a couple of things that I find missing, though there are caveats:

* GIT is not installed - currently it's suggested we create our own image (which is why this started)
* I occasionally see setup-java / maven tasks taking a long time for downloading - so I'm just going to install java and maven in the image and use those for now.

Hence the build of these Docker file images for various jdk/maven versions as things evolve.
