# Photograph

> Trivial tools to make a GitHub based photography portfolio.

## Installation

```sh
# pacman -S imagemagick
# apt install imagemagick
# brew install imagemagick coreutils
npm install -g valeriangalliat/photograph
```

## Usage

### Init

In a new directory, run the following to create the base template:

```sh
photograph init
```

It will generate the following structure:

```
.
├── index.md
└── photos
    ├── full
    ├── hd
    └── thumb
```

### Markdown

Edit `index.md` with Vim, and run the following to render the image
shortcuts:

```
:%!photograph md
```

For example, it renders the following:

```md
hd P0000001
ahd P0000002 /foo
athumb P0000003 /foo
```

Into:

```md
[![P0000001](/photos/hd/P0000001.jpg)](/photos/P0000001.md)
[![P0000002](/photos/hd/P0000002.jpg)](/foo)
[![P0000003](/photos/thumb/P0000003.jpg)](/foo)
```

### Missing

The base template references a number of nonexistent photos. The
following will print the list of missing photos:

```sh
photograph missing
```

You can add the missing photos into the `photos/full` directory.

### Build

Once the photos are present, you can build the other resolution variants
as well as the individual photo pages with Exif metadata:

```sh
photograph build
```

Your repository is now ready and you can commit and push it!
