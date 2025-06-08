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

  public void tickA(){
  for(int a=0;a<predmap.length;a++){
    for(int b=0;b<predmap[0].length;b++){
      
      //predator
       for(int c=0;c<predmap[a][b].size();c++){
           Predator x = predmap[a][b].get(c);
           //increment age
           x.addAge();
           //Death
           if (x.getAge() > oldage || x.getHunger() > hunger) {
             x.die();
           }
           //Growth
           int baby = predmap[a][b].size() * growthC;
           for(int m=0; m<baby; m++) {
              new Prey(a, b, 0);
           }
           //Diffuse
           diffusePred(x);
       }
       
       //prey
       for(int c=0;c<preymap[a][b].size();c++){
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
              new Prey(a, b, 0);
           }
           //Diffuse
           diffuse(x);
           //Encounter
           if(min(preymap[a][b].size(), predmap[a][b].size()) <= preymap[a][b].size())
           {
             if(Math.random() < 0.7)
             {
               predmap[a][b].get(c).addHunger(1);/////////////////////////for compilation but needs a hunger constant
               preymap[a][b].get(c).die();
             }
           }
       }
       
       
    }
  }
  
}



public void diffuse(Animal x){
  //50% chance of movement
  int chance = (int) (Math.random() * 2);
  if(chance == 1){
    //SF move
    PVector move = slopeField[x.getY()][x.getX()];
    //random move
    int ranX = (int) (Math.random() * 7);
    int ranY = (int) (Math.random() * 7);
    PVector random = new PVector(ranX,ranY);
    //add together
    move.add(random);
    //current position of prey added to movement
    PVector current = new PVector(x.getX(),x.getY());
    move.add(current);
    int rate = calcMR(x);
    move.mult(rate);
    //check if valid
    x.setXY(validSpawn(move));
    //change position of prey
  }
}




   static void genSF(){
    float alpha = 0.00000776152278537;
    //current number is from using denomenator = 800^2 + 500^2 and minimum impact = 0.001
    //can be generalized like
    //.00000517434852358 using same denominator but impact = 0.01
    //gotten using alpha = -(ln(minimum impact) / (cols^2 + rows^2))
    for (int[] water : toupledTerrainWater)
    {
      int wy = water[0];
      int wx = water[1];
 
      for (int y = 0; y < slopeField.length; y++)
      {
        for (int x = 0; x < slopeField[0].length; x++)
        {
          if (x != wx && y != wy)
          {
            PVector direction = new PVector(wx - x, wy - y);
            float distSquared = direction.magSq();
            float weight = exp(-alpha * distSquared);
            direction.normalize();
            direction.mult(weight);
            slopeField[y][x].add(direction);
          }
        }
      }
    }
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
