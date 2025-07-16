=== My Dot Files (and related)

I'm slowly getting on board with the idea of portable configuration across
devices now that I've stared to customize my environment more than I used
to.

This repository primarily contains stuff that belongs in $HOME/.config, but
for applications that don't follow this convention (macOS apps in
particular), I've added support for stowing files elsewhere.

The requirements directory contains platform-specific file that either
aren't configuration files themselves or can not be used by simply placing
them somewhere on the filesystem. For each platform requiring special cases,
I will include a install.sh script. For example, for macOS I can run the
following after cloning/updating the repo:

```
bash requirements/macOS/install.sh
```

This will first ensure that Oh-my-zsh and Homebrew are installed and will
then install dependencies for my configuration using `brew install` or
`git clone` before stowing my dotfiles and performing and additional
setup, such as modifying my Terminal.app window settings, which involves
adding a new dictionary to its defaults.

*** Use this at your own risk!! I've only written it for me, and it serves
my purposes using assumptions specific to my use cases. Take a look at what
the scripts do before running them (or consider not running them at all)!
It is entirely possible this will obliterate something you consider
important. ***

