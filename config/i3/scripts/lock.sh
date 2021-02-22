
alpha='dd'
base03='#2E3440'
base02='#073642'
base01='#586e75'
base00='#D8DEE9'
base0='#839496'
base1='#93a1a1'
base2='#eee8d5'
base3='#fdf6e3'
yellow='#b58900'
orange='#cb4b16'
red='#BF616A'
magenta='#d33682'
violet='#6c71c4'
blue='#81A1C1'
green='#A3BE8B'

i3lock \
  --insidevercolor=$base02$alpha \
  --insidewrongcolor=$base03$alpha \
  --insidecolor=$base03$alpha \
  --ringvercolor=$green$alpha \
  --ringwrongcolor=$red$alpha \
  --ringvercolor=$green$alpha \
  --ringwrongcolor=$red$alpha \
  --ringcolor=$blue$alpha \
  --line-uses-ring \
  --keyhlcolor=$red$alpha \
  --bshlcolor=$orange$alpha \
  --separatorcolor=$base01$alpha \
  --verifcolor=$green \
  --wrongcolor=$red \
  --layoutcolor=$blue \
  --datecolor=$blue \
  --timecolor=$blue \
  --screen 1 \
  --blur 1 \
  --clock \
  --indicator \
  --timestr="%H:%M:%S" \
  --datestr="%a %b %e %Y" \
  --veriftext="Verifying..." \
  --wrongtext="U Can't Enter lul" \
  --noinput="No Input" \
  --locktext="Locking..." \
  --lockfailed="Lock Failed" \
  --time-font="Rubik" \
  --date-font="Rubik" \
  --layout-font="Rubik" \
  --verif-font="Rubik" \
  --wrong-font="Helvetica" \
  --radius=120 \
  --ring-width=12 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys \–
