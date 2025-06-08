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
  public void setX(int X){
    x = X;
  }
  public void setY(int Y){
    y = Y;
  }
  public int getAge(){
    return age;
  }
  public void addAge(){
    age ++;
  }
  public void move(int[] v, float moveRate){
    x += v[1] * moveRate;
    y += v[0] * moveRate;
  }
  public void display(PImage img, int x, int y){
    image(img, x, y, 13, 13);
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
    Spread.predmap[y_][x_].add(this);
  }
  Predator(int x_, int y_, int hunger_, int age_){
    super(x_, y_, age_);
    hunger = hunger_;
    Spread.predmap[y_][x_].add(this);
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
  void die(){
    Spread.predmap[getY()][getX()].remove(this);
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
    Spread.preymap[y_][x_].add(this);
  }
  void die(){
    Spread.preymap[getY()][getX()].remove(this);
  }
}
