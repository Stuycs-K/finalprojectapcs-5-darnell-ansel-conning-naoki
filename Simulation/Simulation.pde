import java.util.*;
ChildApplet child;

static int cols, rows;
static int[][] map;
static ArrayList<int[]> toupledTerrainWater;
static PVector[][] slopeField;

//TERRAIN COLOR
color GRASS = color(0, 255, 0);
color ROCK = color(125);
color WATER = color(0, 0, 255);

//ADD SAND WHERE PREY MOVES SLOWER? ADD WHATEVER YOU WANT;
color[] terrain = {GRASS, ROCK, WATER};

//Animal List
ArrayList<Prey> prey = new ArrayList<>();
ArrayList<Predator> predators= new ArrayList<>();

//Animal Images
PImage preyImg, predImg;

Spread spread;


public void setup(){
  //instantiation of spread class
  cols = 500;
  rows = 500;
  
  System.out.println("1");
  preyImg = loadImage("prey.png");
  predImg = loadImage("pred.png");
  System.out.println("2");
  //create simulation
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  println(cols);
  print(rows);
  System.out.println("3");
  new Spread(0,0,0,0,0, map);
  
  
  map = new int[rows][cols];
  slopeField = new PVector[rows][cols];
  for(PVector[] rows : slopeField)
  {
    for(int c = 0; c < rows.length; c ++)
    {
      rows[c] = new PVector(0, 0);
    }
  }
  System.out.println("4");
  toupledTerrainWater = new ArrayList<int[]>();
  createMap(15, 10);
  System.out.println("5");
  generateTerrain(rectW, rectH);
  
  generateAnimals(200);
  display();
  
  
  System.out.println("6");
  Prey p = new Prey(0,0,0);
  Predator z = new Predator(0,0,0);
  System.out.println("7");
  //child = new ChildApplet(p.preyCount(), z.predCount());
  p.die();
  z.die();
  genSF();
  System.out.println("8");

  System.out.println("9");
  draw();
}





void createMap(int rocks, int puddles){
  int size, x, y;
  for(int i = 0; i < rocks; i ++)
  {
    size = int(random(10, 71));
    x = int(random(0, cols + 1));
    y = int(random(0, rows + 1));
    dropRock(size, x, y);
  }
  for(int i = 0; i < puddles; i ++)
  {
    size = round(random(10, 51));
    x = round(random(size, cols + 1 - size));
    y = round(random(size, rows + 1 - size));
    dropWater(x, y, size);
  }
}

void dropRock(int size, int x, int y){
  int rockWidth = round(random(size/3, size));
  int rockHeight = round(random(size/3, size));
  for(int i = 0; i < rockWidth; i ++)
  {
    for(int k = 0; k < rockHeight; k ++)
    {
      map[constrain(y + k, 0, rows - 1)][constrain(x - i, 0, cols - 1)] = 1;
      //toupledTerrainRock.add(new int[] {constrain(y + k, 0, rows - 1), constrain(x - i, 0, cols - 1)});
    }
  }
}

void dropWater(int x, int y, int radius){
  toupledTerrainWater.add(new int[] {y, x+ (radius / 2)});
  toupledTerrainWater.add(new int[] {y, x+ (radius / 2)});
  float deltaTheta = HALF_PI/(radius-1);
  int k = radius-1;
  fill(0);
  rect(x,y,100,100);
  for(float theta = deltaTheta; theta < HALF_PI; theta += deltaTheta)
  {
      int j = 0;
      while( j < (sin(theta) * k))
      {
        map[y-j][x-k + (radius / 2)] = 2;
        map[y+j][x+k - (radius / 2)] = 2;
        j++;
      }
      //toupledTerrainWater.add(new int[] {y - j, x-k + (radius / 2)});
      //toupledTerrainWater.add(new int[] {y + j, x+k + (radius / 2)});
      k--;
  }
}

void generateTerrain(int rectW, int rectH){
  for (int i = 0; i < rows; i++)
  {
    for (int j = 0; j < cols; j++)
    {
      switch(map[i][j])
      {
        case 0:
          stroke(GRASS);
          fill(GRASS);
          break;
         case 1:
          stroke(ROCK);
          fill(ROCK);
          break;
         case 2:
           stroke(WATER);
           fill(WATER);
           break;
      }
      rect(j * rectW, i * rectH, rectW, rectH);
    }
  }
}

void generateAnimals(int num){
  int preyCount = round(random(round(num * 3/4), num + 1));
  int predCount = num - preyCount;
  int age, x, y, k;
  for(int i = 0; i < preyCount; i += k)
  {
    for(k = 0; k < int(random(1,11)); k ++)
    {
      System.out.println(rows + "y");
      System.out.println(cols + "x");
      
      age = int(random(0, 26));
      x = int(random(0, cols));
      y = int(random(0, rows));
      System.out.println(x + " 1+ " + y);
      if(map[y][x] != 0)
      {
        int[] temp = validSpawn(x, y);
        x = temp[0];
        y = temp[1];
      }
      System.out.println(x + " 2 + " + y);
      new Prey(x, y, age);
    }
  }
  for(int i = 0; i < predCount; i += k)
  {
    for(k = 0; k < int(random(1,11)); k ++)
    {
      age = int(random(0, 26));
      x = int(random(0, cols-1));
      y = int(random(0, rows-1));
      if(map[y][x] != 0)
      {
        int[] temp = validSpawn(x, y);
        x = temp[0];
        y = temp[1];
      }
      new Predator(x, y, age);
    }
  }
}

static int[] validSpawn(PVector m) {
  int x = int(m.x);////SO IT COMPILES
  int y = int(m.y);//// SO IT COMPILES
  
  if(map[y][x] == 0)
  {return new int[] {x, y};}
  int k = 1;
  while (true)
  {
    try{
       if(map[y + k][x] == 0)
          {return new int[]{x, y + k + 3};}
          
        else if(map[y - k][x] == 0)
           {return new int[]{x, y - k - 3};}
           
         else if(map[y][x + k] == 0)
           {return new int[]{x + k + 3, y};}
           
         else if(map[y][x - k] == 0)
           {return new int[]{x - k - 3, y};}
    }catch (ArrayIndexOutOfBoundsException e){};
   k++;
  }
}
static int[] validSpawn(int x, int y) {
  if(map[y][x] == 0)
  {return new int[] {x, y};}
  int k = 1;
  while (true)
  {
    try{
       if(map[y + k][x] == 0)
          {return new int[]{x, y + k + 3};}
          
        else if(map[y - k][x] == 0)
           {return new int[]{x, y - k - 3};}
           
         else if(map[y][x + k] == 0)
           {return new int[]{x + k + 3, y};}
           
         else if(map[y][x - k] == 0)
           {return new int[]{x - k - 3, y};}
    }catch (ArrayIndexOutOfBoundsException e){};
   k++;
  }
}




   static void genSF(){
    float alpha = 0.00000776152278537;
    //current number is from using denomenator = 800^2 + 500^2 and minimum impact = 0.001
    //can be generalized like
    //.00000517434852358 using same denominator but impact = 0.01
    //gotten using alpha = -(ln(minimum impact) / (cols^2 + rows^2))
    for (int[] water : toupledTerrainWater)
    {
      int wy = water[0];
      int wx = water[1];
 
      for (int y = 0; y < slopeField.length; y++)
      {
        for (int x = 0; x < slopeField[0].length; x++)
        {
          if (x != wx && y != wy)
          {
            PVector direction = new PVector(wx - x, wy - y);
            float distSquared = direction.magSq();
            float weight = exp(-alpha * distSquared);
            direction.normalize();
            direction.mult(weight);
            slopeField[y][x].add(direction);
          }
        }
      }
    }
  }
  
  void display(){
     for(int i=0;i<rows;i++){
     for(int k=0;k<cols;k++){
       for(Predator pr : Spread.predmap[i][k]){
         {pr.display(predImg, pr.getX() * width/cols , pr.getY() * height/rows);}
       }
       for(Prey py : Spread.preymap[i][k]){
         {py.display(preyImg, py.getX() * width/cols , py.getY() * height/rows);}
         
       }
     }
  }
  }
  
  
  
  void draw(){

    Spread.tickA();
       System.out.println("a");
       
       
       

    
    
     
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
