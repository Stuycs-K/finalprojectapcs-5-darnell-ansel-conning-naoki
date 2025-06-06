
class Spread {
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
  int[][]Matrix;

  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y, int oldAge, int hungerthreshold, int growthCoeff, int[][] map, int[][] Matrix) {
    pred = predator;
    prey = pr;
    X = x;
    Y = y;
    oldage = oldAge;
    hunger = hungerthreshold;
    growthC = growthCoeff;
  }
//////////////////
  void tick() {
    for (int m=0; m<pred.size(); m++) {
      //loop through predator list
      Predator x = pred.get(m);
      //increment age
      x.addAge();
      //death
      if (x.getAge() > oldage || x.getHunger() > hunger) {
        pred.remove(m);
      }
      //growth
    }
    for (int n=0; n<prey.size(); n++) {
      //loop through prey list
      Prey x = prey.get(n);
      //increment age
      x.addAge();
      //death
      if (x.getAge() > oldage) {
        prey.remove(n);
      }
      //growth
      int baby = pred.size() * growthC;
      for (int a=0; a<baby; a++) {
        new Prey(prey.get(int(random(0, prey.size()))).getX(), prey.get(int(random(0, prey.size()))).getY(), 0);
      }
    }
    //run diffuse
    //diffuse();
    
    //setup for encounters
    predmap = new ArrayList<Predator>[x][y];
    preymap = new ArrayList<Prey>[x][y];
    for (int i=0; i<pred.size(); i++) {
      (predmap[i.getX()][i.getY()]).add(i);
    }
    for (int i=0; i<prey.size(); i++) {
      (preymap[i.getX()][i.getY()]).add(i);
    }

    //run encounter
    encounter();
  }
  
  
  //Trying agent based tick()
 void aTick(ArrayList<ArrayList<ArrayList<Predator>>> predMap, ArrayList<ArrayList<ArrayList<Prey>>> preyMap){
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

  void genSF(){
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
    public void diffuse(int[][] Matrix, int[][]map ) {
    }
    
    public ArrayList<Predator> getPred() {
      return pred;
    }
    public ArrayList<Prey> getPrey() {
      return prey;
    }

    public ArrayList<Predator>[][] getPredmap() {
      return predmap;
    }
    public ArrayList<Pre>[][] getPreymap() {
      return preymap;
    }

}

class Growth {
}
