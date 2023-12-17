# Bin

A few scripts I've made to make life easier.

## `del`

Safeley "delete" files by moving them to the trash. No more dangerous `rm -rf`-ing!

## `docs`

A versatile `man` alias that lets me specify a flag to open the manual page for a program in the macOS Preview app as a PDF, open a shortened version on https://ss64.com/osx, or just open it like normal.

## `gitignore`

Create a .gitignore from a template. I don't use this one much anymore, but you can just do `gitignore node` or whatever to pull a .gitignore template for Node.js from https://www.toptal.com/developers/gitignore/api. Comes with caching too, for no reason lol.

## `ts`

Formats a Unix timestamp to a readable format.

```
$ ts 1672549200
January 01, 2023 00:00:00
```

## Git subcommands

If you run `git <xyz>` and there is a `git-<xyz>` script in $PATH, Git will run that script. For example, the `git-open` script below means I can run `git open` like any other Git command.

### `git-open`

Open the `origin` URL of the current repository in the browser.

### `git-qtag`

Quickly create a tag for the most recent commit. I use this often when publishing a new version of something - I'll make a commit like `v0.1.0`, and I can just run `git qtag` to create a tag called `v0.1.0` for that commit. Very helpful since I use GitHub Actions release workflows that run on tags like that.

### `git-tag-rm`

Delete a tag locally and remotely.

### `git-branch-rm`

Delete a branch, locally and remotely. Tries to avoid deleting important branches (prevents you from deleting `master`/`main`).
