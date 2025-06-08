import java.util.*;
static int cols, rows;
static int[][] map;
static ArrayList<int[]> toupledTerrainWater;
static PVector[][] slopeField;
public int getCols() {
  return cols;
}
public int getRows() {
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


public void setup(){
  preyImg = loadImage("prey.png");
  predImg = loadImage("pred.png");
  cols = 500;
  rows = 500;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  println(cols);
  print(rows);
  map = new int[rows][cols];
  slopeField = new PVector[rows][cols];
  for(PVector[] rows : slopeField)
  {
    for(int c = 0; c < rows.length; c ++)
    {
      rows[c] = new PVector(0, 0);
    }
  }
  toupledTerrainWater = new ArrayList<int[]>();
  createMap(15, 10);
  //generateTerrain(rectW, rectH);
  //generateAnimals(200);
  int startTime = millis();
  genSF();
  int elapsedTime = millis() - startTime;
  //print(Arrays.deepToString(slopeField));
  print(elapsedTime);
  print(Arrays.deepToString(slopeField));
  /*for(Prey p : prey)
  {p.display(preyImg, p.getX() * width/cols , p.getY() * height/rows);}
  for(Predator p : predators)
  {p.display(predImg, p.getX() * width/cols , p.getY() * height/rows);}*/
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
void draw() {
  //tick();
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
