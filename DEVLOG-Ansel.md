# Dev Log:

This document must be updated daily every time you finish a work session.

## Ansel Darnell

### 2025-05-26 - initialized processing files, made branch, did Animals class + prey and pred.
Roughly an hour(based on time between commits). First I Wrote the Animals class. Then because Naoki wasn't home yet I initialized the rest of the processing files and pushed them to the main branch. Then I wrote the predator and prey classes but because they reference the bounds of the board I wrote a basic board creation for the setup class.

### 2025-05-27 - worked on all three files
I expanded simulation class so for the future terrain is easier to make. I made the encounter class, added die to prey and other bits to predator for convenience. Most importantly I fixed the classes so they can run. In all between class and home I worked for around 2hrs.

### 2025-05-28 - planning map gen
Spent most of my time at home planning how to get the terrain to generate. I have a roadmap for the building of the terrain. Primarily I thought about how to make the lakes look circular, which are approximated with tan(pi/(2 * radius)) and then incremented. in all I spent around 45 minutes planning and working.

### 2025-06-28 - devlog for prev days + what I did today
I forgot to update the devlog on the previous days and so to not lie but to still update what I did on those days here is a quick rundown:
over the weekend I looked through and fixed issues that arose because of a large merge conflicts that arose at the end of Fridays class. I also worked on dropWater() logic.
Yesterday I got dropWater() and displaying the prey and pred to work such that they aren't overlapping w/ rocks or water. And I tried to debug spread, but since I had no idea what it did I was stuck.
Today I worked on a new Tick() because Naoki is out sick and I am trying to make progress in his stead, I have encounter working and a proper 3d Arraylist setup that will be used to model the positions of the prey and predators.
