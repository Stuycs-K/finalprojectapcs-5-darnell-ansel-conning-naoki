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
  public void setXY(int[] move){
    x = move[0];
    y = move[1];

    if(this instanceof Prey){

    this.display(preyImg, this.x * width/cols , this.y * height/rows);
    }
    if(this instanceof Predator){
    this.display(predImg, this.x * width/cols , this.y * height/rows);
    }
  }
  public void setX(int X){
    x = X;
    
    if(this instanceof Prey){
 
    this.display(preyImg, this.x * width/cols , this.y * height/rows);
    }
    if(this instanceof Predator){
    this.display(predImg, this.x * width/cols , this.y * height/rows);
    }
  }
  public void setY(int Y){
    y = Y;

        if(this instanceof Prey){

    this.display(preyImg, this.x * width/cols , this.y * height/rows);
    }
    if(this instanceof Predator){
    this.display(predImg, this.x * width/cols , this.y * height/rows);
    }
  }
  public int getAge(){
    return age;
  }
  public void addAge(){
    age ++;
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
    PREDC ++;
  }
  Predator(int x_, int y_, int hunger_, int age_){
    super(x_, y_, age_);
    hunger = hunger_;
    Spread.predmap[y_][x_].add(this);
    PREDC ++;
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
    PREDC --;
  }
  int predCount(){
    return PREDC;
  }
}

class Prey extends Animal{
  int preyCount;
  Prey(){
    //////very basic completely random spawn/////
    super(int(random(0, Simulation.cols + 1)), int(random(0, Simulation.rows + 1)));
    prey.add(this);
  }
  Prey(int x_, int y_, int age_){
    super(x_,y_,age_);
    Spread.preymap[y_][x_].add(this);
    PREYC ++;
  }
  void die(){
    Spread.preymap[getY()][getX()].remove(this);
    PREYC --;
  }
  int preyCount(){
    return PREYC;
  }
}
