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
public static void growth(int x, int y) {
    //growth for predator

    if (!predmap[y][x].isEmpty())
    {
      
      for (int a = predmap[y][x].size()-1; a>=0; a--)
      {
       int ageOf = predmap[y][x].get(a).getAge();
       if (ageOf < 150 && Math.random() < .005 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 250 && Math.random() < .05 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf < 400 && Math.random() < .01 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
       else if (ageOf <= 500 && Math.random() < .005 * growthC)
       {
         new Predator(x, y, 0, 0);
       }
      }
    }
    //growth for prey
    if (!preymap[y][x].isEmpty()) {

      for (int b = preymap[y][x].size()-1; b>=0; b--)
      {
        System.out.println(preymap[y][x].size());
       int ageOf = preymap[y][x].get(b).getAge();
       if (ageOf < 150 && Math.random() < .005 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf < 250 && Math.random() < .05 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf < 400 && Math.random() < .01 * growthC)
       {

         new Prey(x, y, 0);

       }
       else if (ageOf <= 500 && Math.random() < .005 * growthC)
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
      if (pred.getAge() > oldage) {
        System.out.println("kill pred");
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
    
    //50% chance of movement
    
    int chance = (int) (Math.random() * 5);
    if (chance == 1) {
      int oldX = x.getX();
      int oldY = x.getY();
      //SF move
      PVector move = slopeField[x.getY()][x.getX()].copy();
      //random move
      int ranX = (int) (Math.random() * 9)-4;
      int ranY = (int) (Math.random() * 9)-4;
      PVector random = new PVector(ranX, ranY);
      //add together
      move.add(random);
      //mult move rate
      float rate = calcMR(x);
      move.mult(rate);
      //current position of prey added to movement
      PVector current = new PVector(x.getX(), x.getY());
      move.add(current);
      //check if valid
      int[] newP = validSpawn(move);
      //change position of animal in map
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
          //debug
          System.out.println("encoutner");
          //so it doesnt eat 2
          break;
        }
      }
    }
  }
  //PROBABIILITY OF PRED EATING PREY BASED ON VARS
  static float probability(Predator pred, Prey prey) {
    
    float base = 0.5;

    //HUnger WILL FINISH LATER
    //float hungerExtra = pred.getHunger() / (float)hunger * 0.3;
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
