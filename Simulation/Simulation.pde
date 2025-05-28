static int cols, rows;

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

void generateTerrain(int rectW, int rectH){
  for (int i = 0; i < cols; i++)
  {
    print("j");
    for (int j = 0; j < rows; j++)
    {
      fill(terrain[int(random(0, terrain.length))]);
      rect(i * rectW, j * rectH, rectW, rectH);
      //have the things grow in patterns later, think tetris pieces
    }
  } 
}

void setup(){
   cols = 33;
   rows = 17;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  generateTerrain(rectW, rectH);
}

void draw() {
}
