import java.util.*;

static PApplet sketch;

static int WIDTH, HEIGHT;

ChildApplet child;


static int cols, rows;
static int[][] map;
static ArrayList<int[]> toupledTerrainWater;
static PVector[][] slopeField;
static int PREDC;
static int PREYC;

import controlP5.*;
ControlP5 cp5;


Sliders controls;
static boolean isPaused = false;











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
static PImage preyImg, predImg;

Spread spread;


public void setup(){
  
  sketch = this;
  //instantiation of spread class
  cols = 500;
  rows = 500;


  //create simulation
  size(1000, 800);
  controls = new Sliders();
  WIDTH = width;
  HEIGHT = height;
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;


  map = new int[rows][cols];
  slopeField = new PVector[rows][cols];
  
  /* FOR MULTIPLE WATER SOURCES
  for(PVector[] rows : slopeField)
  {
    for(int c = 0; c < rows.length; c ++)
    {
      rows[c] = new PVector(0, 0);
    }
  }
  */
  
  new Spread(300,60,40,0.5, map);
  toupledTerrainWater = new ArrayList<int[]>();
  createMap(15, 10);

  generateTerrain(rectW, rectH);
preyImg = loadImage("prey.png");
  predImg = loadImage("pred.png");
  generateAnimals(400);
  display();
  
  Prey p = new Prey(0,0,0);
  Predator z = new Predator(0,0,0);

  child = new ChildApplet(p.preyCount(), z.predCount());
  p.die();
  z.die();
  genSF();

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
  int preyCount = round(num * 7/10);
  int predCount = num - preyCount;
  int age, x, y, k;
  for(int i = 0; i < preyCount; i += k)
  {
    for(k = 0; k < int(random(1,11)); k ++)
    {

      
      age = int(random(0, 26));
      x = int(random(0, cols));
      y = int(random(0, rows));
      if(map[y][x] != 0)
      {
        int[] temp = validSpawn(x, y);
        x = temp[0];
        y = temp[1];
      }
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
  return validSpawn((int)m.x,(int)m.y);
}
static int[] validSpawn(int x, int y) {
  //bounds
  x = constrain(x,0,cols-1);
  y = constrain(y,0,rows-1);
  //base
  if(map[y][x] != 2)
  {return new int[] {x, y};}
  //CHECKS VALID POINTS
  for(int k = 1; k < Math.max(cols, rows); k++) {
        if(x - k >= 0 && map[y][x - k] != 2) {
            return new int[]{x - k, y};
        }
        if(y + k < rows && map[y + k][x] != 2){
            return new int[]{x, y + k};
        }
        if(y - k >= 0 && map[y - k][x] != 2) {
            return new int[]{x, y - k};
        }
        if(x + k < cols && map[y][x + k] != 2) {
            return new int[]{x + k, y};
        }
    }
    //WILL NOT EVER RUN JUST TO COMPILE
    return new int[]{0,0};
}
  



  /*
   static void genSF2(){
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
  */
  static void genSF(){
    float alpha = 0.00000776152278537;
        //current number is from using denomenator = 800^2 + 500^2 and minimum impact = 0.001
    //can be generalized like
    //.00000517434852358 using same denominator but impact = 0.01
    //gotten using alpha = -(ln(minimum impact) / (cols^2 + rows^2))
    for (int y = 0; y < slopeField.length; y++) {
        for (int x = 0; x < slopeField[0].length; x++) {
            
            //Find Water
            float min = Integer.MAX_VALUE;
            int nearX = -1;
            int nearY= -1;
            
            for (int[] water : toupledTerrainWater) {
                int wy = water[0];
                int wx = water[1];
                float dist = (wx-x)*(wx-x) + (wy-y)*(wy-y);
                
                if (dist < min) {
                    min = dist;
                    nearX = wx;
                    nearY = wy;
                }
            }
            if (x != nearX || y != nearY) {
                PVector direction = new PVector(nearX - x, nearY - y);
                float weight = exp(-alpha * min);
                direction.normalize();
                direction.mult(weight);
                slopeField[y][x] = direction;
            }else{
              slopeField[y][x] = new PVector(0,0);
            }
        }
    }
}
  
  
  
void display() {
  for (int i = 0; i < rows; i++) {
    for (int k = 0; k < cols; k++) {
      // Display predators
      for (Predator pr : Spread.predmap[i][k]) {
        if (pr != null && predImg != null) {
          pr.display(predImg, pr.getX() * width/cols, pr.getY() * height/rows);
        }
      }
      // Display prey
      for (Prey py : Spread.preymap[i][k]) {
        if (py != null && preyImg != null) {
          py.display(preyImg, py.getX() * width/cols, py.getY() * height/rows);
        }
      }
    }
  }
}
  


void Counter() {
    
    int boxW = 200;
    int boxH = 100;
    int boxX = width - boxW;
    int boxY = 0;

    fill(255, 255, 255); 
    rect(boxX, boxY, boxW, boxH);
    fill(0);
    text("Population Count", boxX + 10, boxY + 20);
    fill(0, 200, 0); 
    textSize(12);
    text("Prey: " + PREYC, boxX + 10, boxY + 40);
    fill(200, 0, 0); 
    text("Predators: " + PREDC, boxX + 10, boxY + 55);
    fill(0);
    text("Total: " + (PREYC + PREDC), boxX + 10, boxY + 70);
}


void draw(){
  if (isPaused) {
    background(255);
    int rectW = width / cols;
    int rectH = height / rows;
    generateTerrain(rectW, rectH);
    
      
    Spread.tickA();
  

    

    display();

    
    Counter();
  }
}

  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
