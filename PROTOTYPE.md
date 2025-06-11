
# Technical Details:


A description of your technical design. This should include: 
   
How you will be using the topics covered in class in the project.

Population spread simulation

A population simulation designed to model spatial population spread over time. While population spread over the continuous domain requires complex pde's, simulating it allows us to discretize space and time. This spread will be done through diffusion matrices, similar to the kernels which we explored in our recent image processing lab.

     
# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.

### UML
![SimulationUML](https://github.com/user-attachments/assets/08389b7a-fe8a-410b-9bf2-95f25230918f)
The classes fit together as follows:
in simulation an instance of Spread is called, and instance of Sliders, and ChildApplet, and finally, and many instances of prey and pred are called. Prey and Pred are both extensions of Animal.

### Key Algorithms
# ChildApplet:
 popGraph() uses the data in an arraylist to construct points in a beginshape() to create points connected by lines which creates the graph.

# Simulation:
 CreateMap calls dropRock and dropWater to add texture to the map. Places the rocks first then the water at random points, so that the water is unimpeded.
 GenerateAnimals, litters the map with an initial amount of animals.
 validSpawn is important because it finds the closest non water(valid) spot for the animal to move to or spawn to. It just checks in the cardinal directions not radially.
 genSF creates a slope field to water by using toupledTerrainWater, looping through it and finding the closest water. Then  it applys a weight to the vector from x and y to the closest water.
 Display shows every predator and prey by looping over pred and preymap.

# Spread
updateSimulation()
# Sliders
 

# Intended pacing:

How you are breaking down the project and who is responsible for which parts.
We will both work on the first part and have it done for Monday the 26th. This will include The "Simulation" tab and the Spread class.
Afterwards we will complete the diffusion class by that Wednesday (28th) where Naoki does the Diffuse class while Ansel does the Directed movement. The goal is to finish the project by Friday 30th (or Monday the 2nd) in that time Ansel will do the Encounter class and Naoki will finish random movement.


OLD IMAGE UML:

![image](https://github.com/user-attachments/assets/4c3eaa3f-4bc6-4551-894d-dd6eb74bf814)

