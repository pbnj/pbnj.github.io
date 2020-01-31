# Auto-Toggle Between Dark & Light Modes in Alacritty & Vim

![black and white](https://images.unsplash.com/photo-1422207049116-cfaf69531072?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1920&q=80)

## Table of Contents

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Problem](#problem)
- [Solution](#solution)
  - [Alacritty](#alacritty)
    - [Considerations](#considerations)
  - [Vim](#vim)
    - [Considerations](#considerations-1)
- [Demo](#demo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Problem

Since macOS Catalina, I have always set the _General_ > _Appearance_ setting to
_Auto_ in order to automatically toggle between Dark and Light mode based on
time of day. During the day, the system is light and bright. Past sunset, the
system is dark and dim. I find this feature extremely useful for me as I tend to
prefer lighter themes during the day and darker themes at night or in dim
environments.

This auto-toggle functionality generally work really well with applications that
integrate with macOS, such as most, if not all, Apple applications (e.g. Notes,
Calendar, Safari, Terminal), many 3rd party applications (e.g. Slack, Outlook),
and even with some websites (e.g. Duck Duck Go, Twitter).

However, I had 2 problems with this:

1. Even though the macOS native Terminal application supports this auto-toggle
   feature, I don't use it for a number of reasons. Instead I use
   [alacritty](https://github.com/alacritty/alacritty).
1. I have to set the `colorscheme` and/or the `background` option in vim/neovim
   to the appropriate values manually each time the system theme changes.

## Solution

So, I decided to figure out a way to automate toggling Alacritty's theme and Vim
settings once and for all and I did what any 10x hacker would do!

![Google that shit](https://media.giphy.com/media/mWz4CusF1T1oez1lxR/giphy.gif)

If only there was a way I could query the system for the current theme!

Unfortunately, the first few searches didn't yield anything useful.

That is until I came across
[blog article](https://stefan.sofa-rockers.org/2018/10/23/macos-dark-mode-terminal-vim/)
and specifically this nugget (among many nuggets in the article):

```sh
$ defaults read -g AppleInterfaceStyle
Dark
```

![booya](https://media.giphy.com/media/3o7TKDzLLKjIOVbPbi/giphy.gif)

From here on out, it's simple commands to glue some functionality together
crudely:

### Alacritty

Fortunately, alacritty supports live-reloading, so as soon as `colors:` setting
has changed in `alacritty.yml` config file, the changes take effect immediately.

So, I cobbled up this bash hack in my `$HOME/.bash_profile`:

```sh
# THEME
if [ "$(uname)" == "Darwin" ]; then
        if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]; then
                sed -i.bak 's/colors: \*pencil_light/colors: \*pencil_dark/' $HOME/.config/alacritty/alacritty.yml
        else
                sed -i.bak 's/colors: \*pencil_dark/colors: \*pencil_light/' $HOME/.config/alacritty/alacritty.yml
        fi
fi
```

#### Considerations

- If you're using the default Terminal app, then you can achieve similar results
  by pre-configuring your Profiles with the proper colors/themes and toggle
  between Profiles using AppleScript, as detailed in the earlier blog article,
  which I consider it to be a much more elegant solution.
- This script only runs once at shell startup. I could put it in a function and
  wrap it in a `while` loop (e.g.
  `while true; do toggleAlacritty &; sleep 3; kill $!; done`), but the current
  setup is good enough for me.

### Vim

Initially, I also modified the `background` option in my vim config file
(`$HOME/.config/nvim/init.vim` ¯\\\_(ツ)\_/¯ ) via `sed`, which worked.

But, I thought the solution in the earlier blog article was better:

```vim
function SetBackgroundMode(...) abort
  if has('macunix')
    let s:mode = systemlist("defaults read -g AppleInterfaceStyle")[0]

    if s:mode ==? "dark"
      let s:new_bg = "dark"
    else
      let s:new_bg = "light"
    endif

    if &background !=? s:new_bg
      let &background = s:new_bg
    endif
  endif
endfunction
call SetBackgroundMode()
```

#### Considerations

- This function is called once at vim startup. I could
  `call timer_start(3000, "SetBackgroundMode", {"repeat": -1})` to make vim
  re-run the function every 3 seconds forever, but the current behavior is good
  enough for me.

## Demo

And now for the demo:

<!-- ![gif demo](../img/auto-toggle-theme.gif) -->

<video> <source src="/img/auto-toggle-themes.webm" type="video/webm"> </video>

## Conclusion

This is a bit of a hack, but works fine for my needs.

I am sure there are room for improvements, so if you have any suggestions, feel
free to drop a comment or raise an issue on GitHub.

- My [dotfiles](https://github.com/pbnj/dotfiles) repo.
- My [blog](https://github.com/pbnj/pbnj.github.io) repo.
