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
  dropRock();
  dropWater();
}

void dropRock(int size, int x, int y){
  for(int i = 0; i < size; i ++)
  {
    map[x + int(random(-int(pow(1.5, size)), int(pow(1.5, size))))][y + int(random(-int(pow(1.5, size)), int(pow(1.5, size))))] = 1;
  }
}

void dropWater(int size, int x, int y){
  color temp  = terrain[int(random(0, terrain.length))];
  int radius = int(random(2, 8));
  float deltaTheta = HALF_PI/radius
  for(float theta = 0; theta < HALF_PI; theta += deltaTheta)
  {
    for(int k = 1; k <= (r - tan(theta) * col); k ++)
    {
      map[x][y + k] = WATER;
    }
    //have C go over teh + and minus and just flip amplitude of r + k to be r - k
  }
  //REPEAT OVER ALL C and FLIP
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
           fill(water);
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
  generateTerrain(rectW, rectH);
}

void draw() {
}
