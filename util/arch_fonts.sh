#!/bin/bash 

sudo pacman -S ttf-dejavu ttf-caladea ttf-carlito noto-fonts \
               ttf-opensans ttf-roboto ttf-ubuntu-font-family \
               tex-gyre-fonts ttf-liberation otf-overpass --needed

sudo sed -i "s/^#export FREETYPE_PROPERTIES.*/export FREETYPE_PROPERTIES=\"truetype:interpreter-version=40\"/" /etc/profile.d/freetype2.sh 

echo "<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
    <match target=\"font\">
        <edit mode=\"assign\" name=\"antialias\">
            <bool>true</bool>
        </edit>
        <edit mode=\"assign\" name=\"embeddedbitmap\">
            <bool>false</bool>
        </edit>
        <edit mode=\"assign\" name=\"hinting\">
            <bool>true</bool>
        </edit>
        <edit mode=\"assign\" name=\"hintstyle\">
            <const>hintslight</const>
        </edit>
        <edit mode=\"assign\" name=\"lcdfilter\">
            <const>lcddefault</const>
        </edit>
        <edit mode=\"assign\" name=\"rgba\">
            <const>rgb</const>
        </edit>
    </match>
    <match>
        <edit mode=\"prepend\" name=\"family\">
            <string>Noto Sans</string>
        </edit>
    </match>
    <match target=\"pattern\">
        <test qual=\"any\" name=\"family\">
            <string>serif</string>
        </test>
        <edit name=\"family\" mode=\"assign\" binding=\"same\">
            <string>Noto Serif</string>
        </edit>
    </match>
    <match target=\"pattern\">
        <test qual=\"any\" name=\"family\">
            <string>sans-serif</string>
        </test>
        <edit name=\"family\" mode=\"assign\" binding=\"same\">
            <string>Noto Sans</string>
        </edit>
    </match>
    <match target=\"pattern\">
        <test qual=\"any\" name=\"family\">
            <string>monospace</string>
        </test>
        <edit name=\"family\" mode=\"assign\" binding=\"same\">
            <string>Noto Mono</string>
        </edit>
    </match>
</fontconfig>" | sudo tee /etc/fonts/local.conf
