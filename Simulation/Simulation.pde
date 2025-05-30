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
  int size = int(random(1, 7));
  int x = int(random(0, cols + 1));
  int y = int(random(0, rows + 1));
  for(int i = 0; i < 5; i ++)
  {
    dropRock(size, x, y);
    x = int(random(0, cols + 1));
    y = int(random(0, rows + 1));
  }
  size = 5;//int(random(1, 10));
  int radius = int(random(1, size));
  x = int(random(radius, cols + 1 - radius));
  y = int(random(radius, rows + 1 - radius));
  for(int i = 0; i < 4; i ++)
  {
    dropWater(size, x, y, radius);
  }
}

void dropRock(int size, int x, int y){
  for(int i = 0; i < size; i ++)
  {
    map[x + constrain(int(random(-int(pow(1.5, size))- 1, int(pow(1.5, size)) + 1)), -x, cols - x - 1)][y + constrain(int(random(-int(pow(1.5, size))- 1, int(pow(1.5, size)) + 1)), -y, rows - y - 1)] = 1;
  }
}

void dropWater(int size, int x, int y, int radius){
  float deltaTheta = HALF_PI/radius;
  for(float theta = deltaTheta; theta < HALF_PI; theta += deltaTheta)
  {
    for(int k = 1; k < radius; k ++)
    {
      for(int j = 0; j < int(tan(theta)) * k; j ++)
      {
        map[x+k][y+j] = 2;
        map[x+k][y-j] = 2;
        map[x-k][y+j] = 2;
        map[x-k][y-j] = 2;
      }
    }
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
  cols = 50;
  rows = 50;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  map = new int[cols][rows];
  generateTerrain(rectW, rectH);
}

void draw() {
}
