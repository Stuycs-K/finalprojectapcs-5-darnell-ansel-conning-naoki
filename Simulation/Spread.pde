/*
static class Spread {
  ArrayList<Predator> pred;
  ArrayList<Prey> prey;

  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;
  int oldage;
  int hunger;
  int growthC;
  int X;
  int Y;
  int[][]Map;
  int[][][]Matrix;
  



  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y, int oldAge, int hungerthreshold, int growthCoeff, int[][] map) {
    pred = predator;
    prey = pr;
    X = x;
    Y = y;
    oldage = oldAge;
    hunger = hungerthreshold;
    growthC = growthCoeff;
    Map = map;
  }
    public void createDiff(){
      //creates matrix for diffusion
      Matrix = new int[map.length][map[0].length][2];
      for(int i=0;i<Matrix.length;i++){
        for(int x=0;x<Matrix[0].length;x++){
          int[] close = findWater(x,i);
          //quadratic movement speed based on distance
          int f = -0.04 * ((close[2]-5)^2) + 1;
          
          //calculates movement amount broken into x and y
          float xmove = cos(direction) * f;
          float ymove = sin(direction) * f;
          //adds to movement matrix (ROUNDING NEEDS TO BE FIXED)
          Matrix[i][x][0] = (int) xmove;
          Matrix[i][x][1] = (int) ymove;
        }
      }
    
    }
    
    public void diffuse() {
      for(int i =0;i<pred.size();i++){
         Predator x = pred.get(i);
         //applies movement to pred
         x.setX(Matrix[x.getY()][x.getX()][0]);
         x.setY(Matrix[x.getY()][x.getX()][1]);
      }
      for(int i =0;i<prey.size();i++){
         Prey x = prey.get(i);
         //applies movement to prey
         x.setX(Matrix[x.getY()][x.getX()][0]);
         x.setY(Matrix[x.getY()][x.getX()][1]);
      }
  
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
              pred.remove(m);
           }
           //Growth
           int baby = pred.size() * growthC;
            for (int a=0; a<baby; a++) {
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

public void Diffuse(Animal x){

}

  //Trying agent based tick()
 void groupEncounter(){
   for(int a = 0; a < rows; a ++)
   {
     for(int b = 0; b < cols; b ++)
     {
       if(!preyMap.get(a).get(b).isEmpty() && !predMap.get(a).get(b).isEmpty())
       {
         for(int c = 0; c < min(predMap.get(a).get(b).size(), preyMap.get(a).get(b).size()); c++)//encounter is one to one so we pick smaller arraylist and pair off pred with prey
         {
            Encounter.encounter(predMap.get(a).get(b).get(c), preyMap.get(a).get(b).get(c));
         }
       }
     }
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
   static void genSF2(){
    float alpha = 0.00511685576221;
    //current number is from using denomenator = 2*(15^2) and minimum impact = 0.1
    //can be generalized from gaussian falloff of e^-(alpha*x^2)
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
  static class Encounter {
    static float chance = 0.70;
    static int hungerChange = 5;
    static void encounter(Predator pred, Prey pr) {
      if (Math.random() < chance)
      {
        pred.addHunger(hungerChange);
        pr.die();
      }
    }
}
*/
