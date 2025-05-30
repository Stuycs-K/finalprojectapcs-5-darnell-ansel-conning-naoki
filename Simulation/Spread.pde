class Spread{
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

  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y,int oldAge,int hungerthreshold,int growthCoeff,int[][] map,int[][] Matrix){
    //main arraylist of all objects
    pred = predator;
    prey = pr;

    //conversion to 2d array of arraylists for encounter dynamics



  // parameters
  X = x;
  Y = y;
  oldage = oldAge;
  hunger = hungerthreshold;
  growthC = growthCoeff;
  }

  public void tick(){
      for(int m=0;m<pred.size();m++){
        //loop through predator list
        Predator x = pred.get(m);
        //increment age
        x.addAge();
        //death
         if(x.getAge > oldAge || x.getHunger > hungerthreshold){
          pred.remove(m);
        }
        //growth

      }
      for(int n=0;n<prey.size();n++){
        //loop through prey list
          Prey x = prey.get(n);
          //increment age
          x.addAge();
          //death
         if(x.getAge > oldAge){
          pred.remove(n);
        }
        //growth
        int baby = pred.size() * growthC;
        for(int a=0;a<baby;a++){
          new Prey(i,x,0);

        }
    }

    //run diffuse
    diffuse();


    //setup for encounters
    predmap = new ArrayList<Predator>[x][y];
    preymap = new ArrayList<Prey>[x][y];
  for(int i=0;i<pred.size();i++){
    (predmap[i.getX()][i.getY()]).add(i);
  }
   for(int i=0;i<prey.size();i++){
    (preymap[i.getX()][i.getY()]).add(i);
  }

  //run encounter
  encounter();




  }

  public void encounter(){
    class Growth{









class Encounter{
  float chance = 0.70;
  int hungerChange = 5;
  boolean encounter(Predator pred, Prey pr){
    if (random(0, 1) < chance)
    {
      pred.addHunger(hungerChange);
      pr.die();
      return true;
    }
    return false;
  }

class Encounter{
  float chance = 0.70;
  int hungerChange = 5;
  boolean encounter(Predator pred, Prey pr){
    if (random(0, 1) < chance)
    {
      pred.addHunger(hungerChange);
      pr.die();
      return true;
    }
    return false;
  }
      pred.addHunger(hungerChange);
      pr.die();
      return true;
    }
    return false;
  }
  }
  public void diffuse(int[][] Matrix, int[][]map ){

  }

  public ArrayList<Predator> getPred(){
    return pred;
  }
  public ArrayList<Prey> getPrey(){
     return prey;
  }

  public ArrayList<Predator>[][] getPredmap(){
     return predmap;
  }
    public ArrayList<Pre>[][] getPreymap(){
     return preymap;
  }





class Growth{

class Encounter{
  float chance = 0.70;
  int hungerChange = 5;
  boolean encounter(Predator pred, Prey pr){
    if (random(0, 1) < chance)
    {
      pred.addHunger(hungerChange);
      pr.die();
      return true;
    }
    return false;
  }
}


}
