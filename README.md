# GetAGrip
Survivor Challenge recreation using GUI, direct recreation of this: https://www.youtube.com/watch?v=C1PXC5-vqjg

This was my first time coding using GUI, so this was a super fun experience learning 
new elements.

The only script inside of this is MovingLineGame.lua which has multiple functions including:
- When the proximity prompt is enabled, set the game as active
- teleports player to top of the pole and freezes user position
- Uses tweening service to move green line back and forth
- Runs an event on the click of the gamebutton (green circle) to check if the greenline was inside of the whiteline
- Tracks missed attempts, once missed attempts is 3, sets active to false, ending the game and unfreezing the users position
- Speeds up the greenline slightly everytime the gamebutton is clicked

Demo - https://youtu.be/9UvvBpcwFzA
  



