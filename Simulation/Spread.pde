class Spread{
  ArrayList<Predator> pred; 
  ArrayList<Prey> prey;
  
  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;
  
  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr, int x, int y){
    pred = predator;
    prey = pr;
    
    predmap = new ArrayList<Predator>[x][y];
    preymap = new ArrayList<Prey>[x][y];
  }
  
  public void tick(){
    predmap = new ArrayList<Predator>[predmap[0].length][predmap.length];
    preymap = new ArrayList<Pret>[preymap[0].length][preymap.length];
    
    
   int oldAge = 25;
   int hungerthreshold = 25;
  for(int i=0;i<pred.size();i++){
    if(x.getAge > oldAge || x.getHunger > hungerthreshold){
    pred.remove(i);
  }
  else{
    (predmap[i.getX()][i.getY()]).add(i);
  }
  }
  
  

  
  for(int i=0;i<prey.size();i++){
    if(i.getAge > oldAge){
    prey.remove(i);
  }
  else{
    (preymap[i.getX()][i.getY()]).add(i);
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
