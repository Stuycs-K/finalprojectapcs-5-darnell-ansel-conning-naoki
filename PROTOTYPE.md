
# Technical Details:


Our project employs many technical aspects that have been taught in class. We use Agent-based simulation, similar to the TreeBurn sim. Additionally, we use PVectors for movement, advanced processing topics, class inheritance, static methods, encapsulation, Arrays, search algorithms, and more.

     
# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.

### UML
![SimulationUML](https://github.com/user-attachments/assets/08389b7a-fe8a-410b-9bf2-95f25230918f)
The classes fit together as follows:
in simulation an instance of Spread is called, and instance of Sliders, and ChildApplet, and finally, and many instances of prey and pred are called. Prey and Pred are both extensions of Animal.

### Key Algorithms
# ChildApplet:
 popGraph() uses the data in an arraylist to construct points in a beginshape() to create points connected by lines which creates the graph.
ratioGraph: graphs ratio between prey count and predator count, to analyze patterns.
# Simulation:
 CreateMap calls dropRock and dropWater to add texture to the map. Places the rocks first then the water at random points, so that the water is unimpeded.
 GenerateAnimals litters the map with an initial amount of animals.
 validSpawn is important because it finds the closest non water(valid) spot for the animal to move to or spawn to. It just checks in the cardinal directions not radially.
 genSF creates a slope field to water by using toupledTerrainWater, looping through it and finding the closest water. Then  it applys a weight to the vector from x and y to the closest water.
 Display shows every predator and prey by looping over pred and preymap.

# Spread
tick: Master function, which iterates through the predmap and preymap, calling growth, death, movement, and encounter functions.
Movement: calls diffuse function, adding 3 different types of diffusion processes into one PVector. Random Diffusion, Diffusion directed towards nearby water sources, and diffusion based on the concentration of predator and prey.
encounter: Handles encounters between predators and prey. For each location, it creates a 3x3 grid of all prey and predators using a radial search. It then iterates through these lists, pairing preds and prey, running a hunt sucess rate function, using ages of pred and prey and base rates to calculate the chance of a successful hunt.
Death: Ticks hunger and age of predators and prey. Will kill predators and prey after they reach a certain age or hunger.
growth: Calculates the chance of prey/ predator creating offspring based on age and a global growth parameter.

# Sliders
 setup/Draw: creates a window for real-time parameter adjustment of the simulation, and pause/start button.

# Intended pacing:

How you are breaking down the project and who is responsible for which parts.
We will both work on the first part and have it done for Monday the 26th. This will include The "Simulation" tab and the Spread class.
Afterwards we will complete the diffusion class by that Wednesday (28th) where Naoki does the Diffuse class while Ansel does the Directed movement. The goal is to finish the project by Friday 30th (or Monday the 2nd) in that time Ansel will do the Encounter class and Naoki will finish random movement.


OLD IMAGE UML:

![image](https://github.com/user-attachments/assets/4c3eaa3f-4bc6-4551-894d-dd6eb74bf814)

