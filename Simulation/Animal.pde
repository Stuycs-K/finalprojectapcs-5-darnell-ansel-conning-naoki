static class Animal{
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
  public void setXY(int[] move) {
    x = move[0];
    y = move[1];
  }
 public void setX(int X) {
    x = X;
  }
  public void setY(int Y) {
    y = Y;
  }
  public int getAge(){
    return age;
  }
  public void addAge(){
    age ++;
  }
}  

static class Predator extends Animal{
  int hunger;
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
  void display(PImage img, int x, int y) {
    if (img != null) {
      sketch.image(img, x, y, 13, 13);
    }
  }
}
  


static class Prey extends Animal{

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
   void display(PImage img, int x, int y) {
    if (img != null) {
      sketch.image(img, x+13/2, y+13/2, 13, 13);
    }
  }
}
