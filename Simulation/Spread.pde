
static class Spread {
  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;
  int oldage;
  int hunger;
  int growthC;
  int X;
  int Y;
  int[][]Map;
  int[][][]Matrix;
  
  Spread(ArrayList<Predator>[][] Predmap,ArrayList<Prey>[][] Preymap, int x, int y, int oldAge, int hungerthreshold, int growthCoeff, int[][] map) {
    predmap = Predmap;
    preymap = Preymap;
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
       for(int c=0;c<predmap[a][b].size();c++){
           Predator x = pred.get(c);
           //increment age
           x.addAge();
           //Death
           if (x.getAge() > oldage || x.getHunger() > hunger) {
              x.die();
           }
           //Growth
           int baby = pred.size() * growthC;
           for(int a=0; a<baby; a++) {
              new Prey(a, b, 0);
           }
           //Diffuse
           Diffuse(x);
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
    PVector move = SlopeField[x.getY()][x.getX()];
    //random move
    int ranX = (int) (Math.random() * 7);
    int ranY = (int) (Math.random() * 7);
    PVector random = new PVector(ranX,ranY);
    //add together
    move.add(random);
    //current position of animal added to movement
    int x = move.x + x.getX();
    int y = move.y + x.getY();
    //check valid
    int[][] cord = validSpawn();
    //change position of animal
    animal.setX(cord[0]);
    animal.setY(cord[1]);
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
}
