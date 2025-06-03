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
  public void addAge(){
    age ++;
  }
  public void display(PImage img, int x, int y){
    image(img, x, y, 10, 10);
  }
}  

class Predator extends Animal{
  int hunger;
  Predator(){
    super(int(random(0, Simulation.cols + 1)), int(random(0, Simulation.rows + 1)));
    hunger = int(random(0,0));////////UPDATE THIS WITH PROPER BOUNDS/////////
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
  void addHunger(int add){
    hunger += add;
  }
  int getHunger(){
    return hunger;
  }
}

class Prey extends Animal{
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
