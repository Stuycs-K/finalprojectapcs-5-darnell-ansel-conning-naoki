class Animal{
  int x,y,age;
  Animal(int x_, int y_){
    x = x_;
    y = y_;
  }
  Animal(int x_, int y_, int age_){
    x = x_;
    y = y_;
    age = age_;
  }
  public int getX(){
     return x;
  }
  public int getY(){
    return y;
  }
  public int getAge(){
    return age;
  }
}

class Predator extends Animal{
  int hunger;
  ArrayList<Predator> predators;
  Predator(){
<<<<<<< HEAD
    super(int(random(0, cols + 1), int(random(0, rows + 1))));
    hunger = random(0,0);////////UPDATE THIS WITH PROPER BOUNDS/////////
=======
    super(int(random(0, Simulation.cols + 1)), int(random(0, Simulation.rows + 1)));
    hunger = int(random(0,0));////////UPDATE THIS WITH PROPER BOUNDS/////////
>>>>>>> AnselBranch
    predators.add(this);
  }
  Predator(int x_, int y_, int hunger_){
    super(x_, y_);
    hunger = hunger_;
    predators.add(this);
  }
  Predator(int x_, int y_, int hunger_, int age_){
    super(x_, y_, age_);
    hunger = hunger_;
    predators.add(this);
  }
  void setHunger(int change){
    hunger = change;
  }
<<<<<<< HEAD
  void addHunger(int add)
  {
=======
  void addHunger(int add){
>>>>>>> AnselBranch
    hunger += add;
  }
}
  
class Prey extends Animal{
  ArrayList<Prey> prey;
  Prey(){
    //////very basic completely random spawn/////
    super(int(random(0, Simulation.cols + 1)), int(random(0, Simulation.rows + 1)));
    prey.add(this);  
  }
  Prey(int x_, int y_, int age_){
    super(x_,y_,age_);
    prey.add(this);
  }
  void die(){
    prey.remove(this);
  }
}
