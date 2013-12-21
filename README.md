# Ctags Pack

Based on a ctags setup described in this blog post: http://blog.jenkster.com/2013/12/my-emacs-tags-setup.html

This pack looks for a .git directory somewhere above any file you open and then
uses the ctags command to create a `TAGS` file there. It also auto-regenerates
anytime you save a file. The idea is that you shouldn't have to manage the
TAGS file yourself. Obviously it's very git-centric, and is not incredibly
configurable right now (patches welcome).

This allows you to use these key bindings to navigate to definitions of symbols
in many programming languages:

* Go to definition: M-.
* Go back: M-*

## Installation

1. Install Exuberant Ctags if it isn't already (not tested with other tag generators).
  * On Mac OS X with Homebrew: `brew install ctags`
1. `cd ~/.live-packs`
1. `git clone https://github.com/cap10morgan/ctags-pack.git`
1. `cd ctags-pack`
1. `git submodule update --init --recursive`
1. Add `~/.live-packs/ctags-pack` to your `(live-add-packs ...)` form in `~/.emacs-live.el`
1. (Re-)start Emacs

You may want to add TAGS to a global gitignore file. Otherwise you'll be adding
it to every project's .gitignore file.

## Contributing

GitHub pull requests on topic branches that leave the version number alone are
preferred.
