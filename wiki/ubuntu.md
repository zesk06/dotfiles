# ubuntu

## install Qtile

```
# install apt
sudo apt  install python-gobject
sudo apt  install python-dbus

# create venv
python -m venv ~/.virtualenvs/qtile
pip install xcffib
pip install --no-cache-dir cairocffi
pip install qtile 
# additionnal package for widgets
pip install psutil iwlib
```

```bash
# /usr/share/xsessions/qtile.desktop
[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=/home/zesk/.virtualenvs/qtile/bin/qtile
Type=Application
Keywords=wm;tiling
```

## install alacritty

- install packages in [[packages.list]]
- `git clone https://github.com/alacritty/alacritty.git`
- or `cargo install alacritty` 

## fonts

- download [nerd font](https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf)
- change in ~/.config/fontconfig/fonts.conf
```xml
  <family>SauceCodePro Nerd Font Mono</family> <!-- Your preferred monospace font -->
```
- then ``fc-cache --really-force``

## keyboard

Pour remapper TAB sur L_CTRL
voir [SO](https://asku buntu.com/questions/254424/how-can-i-change-what-keys-on-my-keyboard-do-how-can-i-create-custom-keyboard/300203#300203)

```bash
# dans /usr/share/X11/xkb/symbols/pc
# key <CAPS> {      [ Control_L             ]       };
key <CAPS> {        [ Control_L             ]       };
key <LCTL> {        [ Control_L             ]       };
```

et restart du server X
