class Spread{
  ArrayList<Predator> pred; 
  ArrayList<Prey> prey;
  
  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;
  int oldage;
  int hunger;
  
  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y,int oldAge,int hungerthreshold){
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
  }
  
  public void tick(){
    predmap = new ArrayList<Predator>[predmap[0].length][predmap.length];
    preymap = new ArrayList<Pret>[preymap[0].length][preymap.length];
    
    
   int oldAge = 25;
   int hungerthreshold = 25;

  if(x.getAge > oldAge || x.getHunger > hungerthreshold){
    pred.remove(i);
    
  }

      if(i.getAge > oldAge){
    prey.remove(i);
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
