import java.util.*;
static int cols, rows;
int[][] map;
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

void createMap(){
  int size, x, y;
  for(int i = 0; i <= 25; i ++)
  {
    size = int(random(1, 7));
    x = int(random(0, cols + 1));
    y = int(random(0, rows + 1));
    dropRock(size, x, y);
  }
  for(int i = 0; i < 5; i ++)
  {
    size = round(random(10, 51));
    x = round(random(size, cols + 1 - size));
    y = round(random(size, rows + 1 - size));
    dropWater(x, y, size);
  }
}

void dropRock(int size, int x, int y){
  for(int i = 0; i < size; i ++)
  {
    x = constrain(int(random(-int(pow(1.5, size))- 1, int(pow(1.5, size)) + 1)), -x, cols - x - 1);
    y = constrain(int(random(-int(pow(1.5, size))- 1, int(pow(1.5, size)) + 1)), -y, rows - y - 1);
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
      }
      k--;
  }
}

void generateTerrain(int rectW, int rectH){
  createMap();
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

void setup(){
  cols = 500;
  rows = 500;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  map = new int[rows][cols];
  generateTerrain(rectW, rectH);
}

void draw() {
}
