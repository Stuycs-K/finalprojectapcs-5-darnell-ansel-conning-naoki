import java.util.*;
static int cols, rows;
int[][] map;
ArrayList<int[]> toupledTerrainWaater;
ArrayList<int[]> toupledTerrainRock;
PVector[][] slopeField;
int getCols() {
  return cols;
}
int getRows() {
  return rows;
}

color GRASS = color(0, 255, 0);
color ROCK = color(125);
color WATER = color(0, 0, 255);
//ADD SAND WHERE PREY MOVES SLOWER? ADD WHATEVER YOU WANT;
color[] terrain = {GRASS, ROCK, WATER};
PImage preyImg, predImg;
ArrayList<Prey> prey = new ArrayList<>();
ArrayList<Predator> predators= new ArrayList<>();


void setup(){
  preyImg = loadImage("prey.png");
  predImg = loadImage("pred.png");
  cols = 500;
  rows = 500;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  map = new int[rows][cols];
  createMap(15, 10);
  generateTerrain(rectW, rectH);
  generateAnimals(200);
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
      toupledTerrainRock.add(new int[] {constrain(y + k, 0, rows - 1), constrain(x - i, 0, cols - 1)});
    }
  }
}

void dropWater(int x, int y, int radius){
  float deltaTheta = HALF_PI/(radius-1);
  int k = radius-1;
  fill(0);
  rect(x,y,100,100);
  for(float theta = deltaTheta; theta < HALF_PI; theta += deltaTheta)
  {
      for(int j = 0; j < (sin(theta) * k); j ++)
      {
        map[y-j][x-k + (radius / 2)] = 2;
        map[y+j][x+k - (radius / 2)] = 2;
        toupledTerrainWater.add(new int[] {y - j, x-k + (radius / 2)});
        toupledTerrainWater.add(new int[] {y + j, x+k + (radius / 2)});
      }
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
      x = int(random(0, cols));
      y = int(random(0, rows));
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

int[] validSpawn(int x, int y) {
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

void draw() {
  for(Prey p : prey)
  {p.display(preyImg, p.getX() * width/cols , p.getY() * height/rows);}
  for(Predator p : predators)
  {p.display(predImg, p.getX() * width/cols , p.getY() * height/rows);}
}
