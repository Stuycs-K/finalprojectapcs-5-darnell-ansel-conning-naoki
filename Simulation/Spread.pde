class Spread{
  ArrayList<Predator> pred; 
  ArrayList<Prey> prey;
  
  ArrayList<Predator>[][] predmap;
  ArrayList<Prey>[][] preymap;  
  
  Spread(ArrayList<Predator> predator, ArrayList<Prey> pr){
    pred = predator;
    prey = pr;
   for(Predator x: pred){
    xy = (predmap[x.getX()][x.getY()]).add(x);
  }
  for(Prey x: prey){
  (predmap[x.getX()][x.getY()]).add(x);
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
