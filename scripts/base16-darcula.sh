#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# scheme: "Darcula"
# author: "Matthias Brandt (github.com/PlusMinus0) based on Darcula theme by Konstantin Bulenkov (github.com/bulenkov/Darcula)"
# TODO:  Can't upstream until https://github.com/bulenkov/Darcula/issues/48 is resolved.
# Hmm. And here I've tweaked with some colors from https://github.com/vecheslav/darcula-solid
#
base00="2B2B2B"  # Default Background
base01="323232"  # Lighter Background (Used for status bars)
base02="214283"  # Selection Background
base03="808080"  # Comments, Invisibles, Line Highlighting
base04="D0D0D0"  # Dark Foreground (Used for status bars)
base05="D8D8D8"  # Default Foreground, Caret, Delimiters, Operators
base06="E8E8E8"  # Light Foreground (Not often used)
base07="F8F8F8"  # Light Background (Not often used)
base08="79ABFF"  # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
base09="9876AA"  # Integers, Boolean, Constants, XML Attributes, Markup Link Url
base0A="a9b7c6"  # Classes, Markup Bold, Search Text Background
base0B="A5C25C"  # Strings, Inherited Class, Markup Code, Diff Inserted
base0C="629755"  # Support, Regular Expressions, Escape Characters, Markup Quotes
base0D="FFC66D"  # Functions, Methods, Attribute IDs, Headings
base0E="CC7832"  # Keywords, Storage, Selector, Markup Italic, Diff Changed
base0F="D25252"  # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

# This color to base mapping is based on snazzy, not necc. Darcula.
color00=$base00 # Base 00 - Black
color01=$base08 # Base 08 - Red
color02=$base0B # Base 0B - Green
color03=$base0A # Base 0A - Yellow
color04=$base0D # Base 0D - Blue
color05=$base0E # Base 0E - Magenta
color06=$base0C # Base 0C - Cyan
color07=$base05 # Base 05 - White
color08=$base03 # Base 03 - Bright Black
color09=$base08 # Base 08 - Bright Red
color10=$base0B # Base 0B - Bright Green
color11=$base0A # Base 0A - Bright Yellow
color12=$base0D # Base 0D - Bright Blue
color13=$base0E # Base 0E - Bright Magenta
color14=$base0C # Base 0C - Bright Cyan
color15=$base07 # Base 07 - Bright White
color16=$base09 # Base 09
color17=$base0F # Base 0F
color18=$base01 # Base 01
color19=$base02 # Base 02
color20=$base04 # Base 04
color21=$base06 # Base 06
color_foreground=$base05 # Base 05
color_background=$base00 # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg e2e4e5 # foreground
  put_template_custom Ph 282a36 # background
  put_template_custom Pi e2e4e5 # bold color
  put_template_custom Pj 43454f # selection color
  put_template_custom Pk e2e4e5 # selected text color
  put_template_custom Pl e2e4e5 # cursor
  put_template_custom Pm 282a36 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
