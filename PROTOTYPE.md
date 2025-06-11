
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

# Intended pacing:

How you are breaking down the project and who is responsible for which parts.
We will both work on the first part and have it done for Monday the 26th. This will include The "Simulation" tab and the Spread class.
Afterwards we will complete the diffusion class by that Wednesday (28th) where Naoki does the Diffuse class while Ansel does the Directed movement. The goal is to finish the project by Friday 30th (or Monday the 2nd) in that time Ansel will do the Encounter class and Naoki will finish random movement.


OLD IMAGE UML:

![image](https://github.com/user-attachments/assets/4c3eaa3f-4bc6-4551-894d-dd6eb74bf814)

