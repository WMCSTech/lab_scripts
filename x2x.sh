#!/bin/bash

read -p "Are you on Computer A or B? (Look at the top center of your computer) " AB
if [[ "$AB" == a ]] || [[ "$AB" == A ]]; then
  xhost
  echo "All set, waiting for Computer B to connect."
elif [[ "$AB" == b ]] || [[ "$AB" == B ]]; then
  read -p "Enter the user currently logged into Computer A: " USERNAME
  read -p "Enter the computer name of Computer A: " COMPUTER
  echo ""
  echo "When prompted, have the user on Computer A type in their password."; sleep +2
  echo ""
  echo "Drag mouse to the far right to control Computer A and remember to change Computer B's display to HDMI."; sleep +2
  echo ""
  echo "Enjoy paired programming! Having issues? Contact Dustin in Olin 126 (palmerdl@whitman.edu)."; sleep +5
  echo ""
  echo ""
  ssh -X USERNAME@COMPUTER x2x -to :0 -east
else
  echo "Please restart the program and type in either A or B."
fi
