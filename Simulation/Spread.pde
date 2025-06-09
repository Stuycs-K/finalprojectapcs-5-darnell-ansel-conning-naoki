static class Spread {
  static ArrayList<Predator>[][] predmap;
  static ArrayList<Prey>[][] preymap;
  int oldage;
  int hunger;
  int growthC;
  int X;
  int Y;
  int[][]Map;
  int[][][]Matrix;
  
  Spread(int x, int y, int oldAge, int hungerthreshold, int growthCoeff, int[][] map) {
    X = x;
    Y = y;
    oldage = oldAge;
    hunger = hungerthreshold;
    growthC = growthCoeff;
    Map = map;
  }
  
  
  static void initializeMaps(int cols, int rows){
   //MUST INITIALIZE PRED MAP AND PREY MAP 
  }

  public void tickA(){
  for(int a=0;a<predmap.length;a++){
    for(int b=0;b<predmap[0].length;b++){
      
      //predator
       for(int c=predmap[a][b].size()-1;c>=0;c--){
           Predator x = predmap[a][b].get(c);
           //increment age and hunger
           x.addHunger(1);
           x.addAge();
           //Death
           if (x.getAge() > oldage) {
             x.die();
           }
           
           //Growth
           int baby = predmap[a][b].size() * growthC;
           for(int m=0; m<baby; m++) {
              new Prey(a, b, 0);
           }
           //Diffuse
           diffuse(x);
           //Encounter
           groupEncounter();
       }
       
       //prey
       for(int c=preymap[a][b].size();c>=0;c--){
           Prey x = preymap[a][b].get(c);
           //increment age
           x.addAge();
           //Death
           if (x.getAge() > oldage) {
             x.die();
           }
           //Growth
           int baby = preymap[a][b].size() * growthC;
           for(int m=0; m<baby; m++) {
              new Prey(a, b, 0);
           }
           //Diffuse
           diffuse(x);
           //Encounter
           groupEncounter();
       }
       
       
    }
  }
  
}



public void diffuse(Animal x){
  //50% chance of movement
  int chance = (int) (Math.random() * 2);
  if(chance == 1){
    //SF move
    PVector move = slopeField[x.getY()][x.getX()].copy();
    //random move
    int ranX = (int) (Math.random() * 7);
    int ranY = (int) (Math.random() * 7);
    PVector random = new PVector(ranX,ranY);
    //add together
    move.add(random);
    //mult move rate
    int rate = calcMR(x);
    move.mult(rate);
    //current position of prey added to movement
    PVector current = new PVector(x.getX(),x.getY());
    move.add(current);

    //check if valid
    x.setXY(validSpawn(move));
    //change position of animal in map
    // HAVE TO FINISH THIS
    
  }
}

public void groupEncounter(){
 //MUST FINISH THIS FUNCTION 
}

  
  float calcMR(Animal a){
    int age = a.getAge();
    float k = 0;
    if (age < 50)
    {
      k= 1.5;
    }
    else if (age < 150)
    {
      k= 1.25;
    }
    else if (age < 250)
    {
       k= 1.15;
    }
    else if (age < 350)
    {
      k= 1.0;
    }
    else if (age < 400)
    {
        k= 0.85;
    }
    else if (age < 450)
    {
        k= 0.65;
    }
    else if (age <= 500)
    {
        k= 0.5;
    }
    return map[a.getY()][a.getX()] == 1 ? k * 0.7 : k; 
  }
}
