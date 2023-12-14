# Recipe Website

A dirt simple website ran from an Apache Docker container. Recipes are written
in Markdown and transformed into HTML using [pandoc](https://pandoc.org/).

## Use

In order to build and run the recipe website, simply run `make` and then open up
a web browser to `localhost:8080`. See the Makefile for more details. Other
options are `make build` and `make run`, and `make clean` to shutdown the
running container and clean up Docker image files.

## Modify

Recipes are written in Markdown syntax and saved in the `site/recipes`
directory. See the `skel.md` file for a bare layout, or any example recipes. In
order to add an image to a recipe page, add a PNG or JPEG file with the same
name as your recipe file to the `site/images` directory.

## Requirements

This project relies on both GNU Make and Docker. See [Install Docker
Engine](https://docs.docker.com/engine/install/) for installing Docker on your
machine.
