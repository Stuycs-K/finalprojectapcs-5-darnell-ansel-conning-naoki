static class Spread {
  static ArrayList<Predator>[][] predmap;
  static ArrayList<Prey>[][] preymap;
  static int oldage, hunger, growthC, X, Y;
  static int[][]Map;

  
  Spread(int x, int y, int oldAge, int hungerthreshold, int growthCoeff, int[][] map) {
    predmap = (ArrayList<Predator>[][]) new ArrayList[rows][cols]; //this has to be done because java doesnt 
    preymap = (ArrayList<Prey>[][]) new ArrayList[rows][cols]; // allow  predmap = new ArrayList<Predator>[rows][cols]
    for (int i = 0; i < rows; i++)
    {
      for (int j = 0; j < cols; j++)
      {
        predmap[i][j] = new ArrayList<Predator>(10);
        preymap[i][j] = new ArrayList<Prey>(10);
      }
    }    
    
    X = x;
    Y = y;
    oldage = oldAge;
    hunger = hungerthreshold;
    growthC = growthCoeff;
    Map = map;
  }
  

  static public void tickA(){
  for(int a=0;a<predmap.length;a++){
    for(int b=0;b<predmap[0].length;b++){
      System.out.println("");
      //predator
      if(!predmap[a][b].isEmpty()){
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
              //new Prey(a, b, 0);
           }
           //Diffuse

           diffuse(x);
           //Encounter
       }
      }
       
       //prey
       if(!preymap[a][b].isEmpty()){
       for(int c=preymap[a][b].size()-1;c>=0;c--){
           Prey x = preymap[a][b].get(c);
           //increment age
           x.addAge();
           //Death

           if (x.getAge() > oldage){/// || x.getHunger() > hunger) {

             x.die();
           }
           //Growth
           int baby = preymap[a][b].size() * growthC;
           for(int m=0; m<baby; m++) {
              //new Prey(a, b, 0);
           }
           //Diffuse
           diffuse(x);
           //Encounter
           /*
           if(min(preymap[a][b].size(), predmap[a][b].size()) <= preymap[a][b].size())
           {
             if(Math.random() < 0.7)
             {
               predmap[a][b].get(c).addHunger(1);/////////////////////////for compilation but needs a hunger constant
               preymap[a][b].get(c).die();
             }
           }
           */
       }
       
       }
    }
  }
  
}



static public void diffuse(Animal x){
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
    float rate = calcMR(x);
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

static public void groupEncounter(){
 //MUST FINISH THIS FUNCTION 
}

  
  static float calcMR(Animal a){
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
