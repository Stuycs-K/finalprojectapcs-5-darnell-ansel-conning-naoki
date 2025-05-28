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
  boolean flag = true;
  int c = 0;
  int r= 0;
  color temp  = terrain[int(random(0, terrain.length))];
  while(flag)
  {
    if(temp == GRASS)
    {
      ///////////////////////MAKE THIS A FOR LOOP SINCE YOU USE CONSTRAIN IT LENDS ITSELF WELL///////////////////////
      map[constrain(c - 1, 0, map.length - 1)][constrain(r - 1, 0, map.length - 1)] = GRASS;
      map[constrain(c - 1, 0, map.length - 1)][constrain(r, 0, map.length - 1)] = GRASS;
      map[constrain(c - 1, 0, map.length - 1)][constrain(r + 1, 0, map.length - 1)] = GRASS;
      map[constrain(c, 0, map.length - 1)][constrain(r - 1, 0, map.length - 1)] = GRASS;
      map[constrain(c, 0, map.length - 1)][constrain(r, 0, map.length - 1)] = GRASS;
      map[constrain(c, 0, map.length - 1)][constrain(r + 1, 0, map.length - 1)] = GRASS;
      map[constrain(c + 1, 0, map.length - 1)][constrain(r - 1, 0, map.length - 1)] = GRASS;
      map[constrain(c + 1, 0, map.length - 1)][constrain(r, 0, map.length - 1)] = GRASS;
      map[constrain(c + 1, 0, map.length - 1)][constrain(r + 1, 0, map.length - 1)] = GRASS;
      ///////////////////////MAKE THIS A FOR LOOP SINCE YOU USE CONSTRAIN IT LENDS ITSELF WELL///////////////////////
    }
    else if(temp == WATER)
    {
      int radius = int(random(2, 8));
      if(c != constrain(c + radius, 0, map.length - 1))
      {
        radius = c - constrain(c + radius, 0, map.length - 1);
        c = c + radius;
      }
      if(c != constrain(c + radius, 0, map.length - 1))
      {
        radius = c - constrain(c + radius, 0, map.length - 1);
        c = c + radius;
      }
      for(constrain(c - radius, 0, map.length - 1);
      constrain(r - radius, 0, map.length - 1);
      for(dist = sin(PI)
    }
  }
}

void generateTerrain(int rectW, int rectH){
  createMap();
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      stroke(map[j][i]);
      fill(map[j][i]);
      rect(i * rectW, j * rectH, rectW, rectH);
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
