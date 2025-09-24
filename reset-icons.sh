#!/bin/bash

# Old n Busted dlp2022.3.28
#sudo dconf write /org/gnome/shell/favorite-apps "['ubiquity.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'google-chrome.desktop', 'spyder3.desktop', 'maple17.desktop', 'matlab.desktop', 'processing.desktop', 'brackets.desktop', 'eclipse-photon.desktop', 'texworks.desktop', 'texmaker.desktop', 'virtualbox.desktop', 'netbeans-8.2.desktop', 'codeblocks.desktop', 'android-studio.desktop', 'wolfram-mathematica.desktop', 'SceneBuilder.desktop', 'jetbrains-idea-ce.desktop', 'Elegit.desktop', 'libreoffice-writer.desktop', 'org.gnome.Software.desktop', 'yelp.desktop']"

# New hotness dlp2022.3.28
dconf write /org/gnome/shell/favorite-apps "['ubiquity.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'Zoom.desktop', 'google-chrome.desktop', 'spyder3.desktop', 'maple17.desktop', 'matlab.desktop', 'processing.desktop', 'brackets.desktop', 'atom.desktop', 'code.desktop', 'eclipse-photon.desktop', 'texworks.desktop', 'texmaker.desktop', 'virtualbox.desktop', 'codeblocks.desktop', 'android-studio.desktop', 'wolfram-mathematica.desktop', 'SceneBuilder.desktop', 'jetbrains-idea-ce.desktop', 'libreoffice-writer.desktop', 'org.gnome.Software.desktop', 'yelp.desktop']"

cd /usr/local/bin/ && logoff
