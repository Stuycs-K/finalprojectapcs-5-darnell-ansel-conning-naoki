static class Spread {
  static ArrayList<Predator>[][] predmap;
  static ArrayList<Prey>[][] preymap;
  static int oldage, hunger,repHunger;
  static float growthC, huntRate;
  static int[][]Map;
  static float moveChance = 2;


  Spread(int oldAge, int hungerthreshold,int reproductionHunger, float growthCoeff, int[][] map) {
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


    oldage = oldAge;
    hunger = hungerthreshold;
    growthC = growthCoeff;
    Map = map;
    repHunger = reproductionHunger;
  }
  // TICK FUNCTION
  static public void tickA() {

    //ONE TICK OF TIME
    for (int a = 0; a < predmap.length; a++) {
      for (int b = 0; b < predmap[0].length; b++) {
        //DEATH
        death(b, a);
        //DIFFUSION
        movement(b, a);
      }
    }

    //ENCOUNTER
    for (int a= 0; a < predmap.length; a++) {
      for (int b = 0; b < predmap[0].length; b++) {
        encounter(b, a);
      }
    }

    //RUN GROWTH
    for (int a= 0; a < predmap.length; a++) {
      for (int b = 0; b < predmap[0].length; b++) {
        growth(b, a);
      }
    }
  }
////////////////////////////////////////////////////////////////////////////////

public static void growth(int x, int y,int L) {
    //growth for predator

    if (!predmap[y][x].isEmpty())
    {
      
      for (int a = predmap[y][x].size()-1; a>=0; a--)
      {
       int ageOf = predmap[y][x].get(a).getAge();
       if (ageOf < 150 && Math.random() < .001 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 250 && Math.random() < .003 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 400 && Math.random() < .01 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf <= 500 && Math.random() < .001 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
      }
    }
}
  static void growth(int x, int y) {
    float GrowthConstant = growthC;
    //growth for predator
    Simulation sim = new Simulation();
    if (!predmap[y][x].isEmpty())
    {
      for (int a = predmap[y][x].size()-1; a>=0; a--)
      {
       int ageOf = predmap[y][x].get(a).getAge();
       if (ageOf < 150 && Math.random() < .002 * GrowthConstant)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 250 && Math.random() < .003 * GrowthConstant)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 400 && Math.random() < .005 * GrowthConstant)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf <= 500 && Math.random() < .002 * GrowthConstant)
       {
         new Predator(x, y, 0, 0);

       }
      }
    }
    //growth for prey
    if (!preymap[y][x].isEmpty()) {


      for (int b = preymap[y][x].size()-1; b>=0; b--)
      {

       int ageOf = preymap[y][x].get(b).getAge();
       if (ageOf < 150 && Math.random() < .003 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf < 250 && Math.random() < .008 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf < 400 && Math.random() < .015 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf <= 500 && Math.random() < .003 * growthC)
       {

         new Prey(x, y, 0);
       }
      }
    }
  }
 


  static void death(int x, int y){
    //age +death for predator
    if (!predmap[y][x].isEmpty()) {
    for (int a = predmap[y][x].size()-1; a>=0; a--){
      Predator pred = predmap[y][x].get(a);
      pred.addAge();
      pred.addHunger(1);
      if (pred.getAge() > oldage || pred.getHunger() > hunger) {

           pred.die();
        }
    }
  }
  //age + death for prey
  if (!preymap[y][x].isEmpty()) {
    for (int b = preymap[y][x].size()-1; b>=0; b--){
      Prey prey = preymap[y][x].get(b);
      prey.addAge();
      if (prey.getAge() > oldage) {
           prey.die();
       }
    }
  }
  }
  
  
  
  static void movement(int x,int y){
    if (!predmap[y][x].isEmpty()) {
    for (int a = predmap[y][x].size()-1; a>=0; a--){
      Predator pred = predmap[y][x].get(a);
      diffuse(pred);
    }
    }
    if (!preymap[y][x].isEmpty()) {
    for (int b = preymap[y][x].size()-1; b>=0; b--){
      Prey prey = preymap[y][x].get(b);
      diffuse(prey);
    }
    }
    
  }


  


  static public void diffuse(Animal x) {
  if (Math.random() < moveChance) {
    int oldX = x.getX();
    int oldY = x.getY();

    PVector move = leastConcentration(x, oldX, oldY);
    //concentration based diffusion mult
    move.mult(1);
    
    //WATER ATTRACTION 
    PVector SF = slopeField[oldY][oldX].copy();
    SF.mult(0.3);
    move.add(SF);
    
    //Random movement mult
    float multR = 1.0;
    float xR = (float)(Math.random() * multR * 2 - multR);
    float xY = (float)(Math.random() * multR * 2 - multR);
    PVector randXY = new PVector(xR,xY);
    //move.add(randXY);
    
    //movement rate based on variables
    float rate = calcMR(x);
    move.mult(rate);
    
    move.add(new PVector(oldX, oldY));
    
    int[] newP = validSpawn(move);
    
    if (x instanceof Predator) {
      predmap[oldY][oldX].remove((Predator)x);
      predmap[newP[1]][newP[0]].add((Predator)x);
    } else if (x instanceof Prey) {
      preymap[oldY][oldX].remove((Prey)x);
      preymap[newP[1]][newP[0]].add((Prey)x);
    }
    x.setXY(newP);
  }
}

//lowest concentration direction
static PVector leastConcentration(Animal animal, int x, int y) {
  
  ArrayList<PVector> best = new ArrayList<PVector>();
  int lowest = Integer.MAX_VALUE;
  
  //all directions madde
  ArrayList<PVector> directions = new ArrayList<PVector>();
  for (int dx = -5; dx <= 5; dx++) {
    for (int dy = -5; dy <= 5; dy++) {
      if (dx == 0 && dy == 0) continue;
      directions.add(new PVector(dx, dy));
    }
  }
  
  
  // Check all directions
  for (PVector dir : directions) {
    int checkX = x + (int)dir.x;
    int checkY = y + (int)dir.y;
    
    if (checkX >= 0 && checkX < cols && checkY >= 0 && checkY < rows) {
      int count;
      
      if (animal instanceof Predator) {
        count = predmap[checkY][checkX].size() * 2;
        //Pred wants to move towards prey
        count -= preymap[checkY][checkX].size() * 3;
        
      } else {
        count = preymap[checkY][checkX].size() * 2;
        //Prey wants to move away from pred
        count += predmap[checkY][checkX].size() * 3;
      }

      if (count < lowest) {
        lowest = count;
        best = new ArrayList<PVector>();
        best.add(dir);
      } else if (count == lowest) {
        best.add(dir);
      }
    }
  }
  if (best.isEmpty()) {
    return new PVector(0, 0);
  }
  
  //random selection from best dir
  int random = (int)(Math.random() * best.size());
  return best.get(random);
}

  static public void encounter(int x, int y) {
    ArrayList<Predator> neighborPred = new ArrayList<>();
    ArrayList<Prey> neighborPrey = new ArrayList<>();
    //CREATES A LOCAL ARRAYLIST OF 3x3 grid around x,y, to allow for encounters between neighboring blocks.
    for (int a = -1; a <= 1; a++) {
      for (int b = -1; b <= 1; b++) {
        int cx = x + b;
        int cy = y + a;
        if(cx >= 0 && cx < cols && cy >= 0 && cy < rows) {
          neighborPred.addAll(predmap[cy][cx]);
          neighborPrey.addAll(preymap[cy][cx]);
        }
      }
    }
    //RUN ENCOUNTERS USING PROBABILITY FUNC
    for (Predator pred : neighborPred) {
      for (Prey prey : neighborPrey) {
        float probability = probability(pred, prey);
        if (Math.random() < probability) {
          pred.setHunger(0);

          prey.die();
          neighborPrey.remove(prey);

          //debug
          if(Math.random() > 0.6){
           new Predator(pred.getX(),pred.getY(),0,0);
          }
          
          
          //so it doesnt eat 2
          break;
        }
      }
    }
  }
  //PROBABIILITY OF PRED EATING PREY BASED ON VARS
  static float probability(Predator pred, Prey prey) {
    
    float base = huntRate;


    //Age
    float age = 1.0;
    Boolean predOY = (pred.getAge() > 350 || pred.getAge() < 50);
    Boolean preyOY = (prey.getAge() < 50 || prey.getAge() > 350 );
    //IF BOTH ARE OLD/Young, then factor is 1
    //IF Pred is nomral, prey is old, then factor is 1.5
    if(!predOY && preyOY){
      age = 1.5;
    }
    //IF PRED IS OLD/YOUNG AND PREY IS NORMAL, then factor is 0.66
    if(predOY && !preyOY){
      age = 0.66;
    }
    //ALL OTHER CASES ARE JUST 1.
    return base * age;
  }



  static float calcMR(Animal a) {
    int age = a.getAge();
    float k = 0;
    if (age < 50)
    {
      k= 1.5;
    } else if (age < 150)
    {
      k= 1.25;
    } else if (age < 250)
    {
      k= 1.15;
    } else if (age < 350)
    {
      k= 1.0;
    } else if (age < 400)
    {
      k= 0.85;
    } else if (age < 450)
    {
      k= 0.65;
    } else if (age <= 500)
    {
      k= 0.5;
    }
    return map[a.getY()][a.getX()] == 1 ? k * 0.7 : k;
  }
}
