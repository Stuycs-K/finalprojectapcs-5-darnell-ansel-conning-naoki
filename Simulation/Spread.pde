class Spread{
  ArrayList<Predator> pred; 
  ArrayList<Prey> prey;
  
  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;
  int oldage;
  int hunger;
  int growthC;
  
  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y,int oldAge,int hungerthreshold,int growthCoeff){
    //main arraylist of all objects
    pred = predator;
    prey = pr;
    
    //conversion to 2d array of arraylists for encounter dynamics
    predmap = new ArrayList<Predator>[x][y];
    preymap = new ArrayList<Prey>[x][y];
  for(int i=0;i<pred.size();i++){
    (predmap[i.getX()][i.getY()]).add(i);
  }
   for(int i=0;i<prey.size();i++){
    (preymap[i.getX()][i.getY()]).add(i);
  }
  
  // parameters
  oldage = oldAge;
  hunger = hungerthreshold;
  growthC = growthCoeff;
  }
  
  public void tick(){

  for(int i=0;i<predmap.length;i++){
    for(int x=0;x<predmap[0].length;x++){
      //loop through map array
      for(int m=0;m<predmap[i][x].size();m++){
        //loop through predator list at location
        Predator x = predmap[i][x];
        //increment age
        x.addAge();
        //death
         if(x.getAge > oldAge || x.getHunger > hungerthreshold){
          pred.remove(m);
        }
        //growth

      }
      for(int n=0;n<preymap[i][x].size();n++){
        //loop through prey list at location
          Prey x = preymap[i][x];
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
      
      for(int m=0;m<pred.size();m++){
        //loop through predator list at location
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
        //loop through prey list at location
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
  
  
}

class Diffuse{
}

class Encounter{
}

class Growth{
  
}
