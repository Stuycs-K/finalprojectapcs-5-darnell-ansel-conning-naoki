int cols;
int rows;

int getCols(){
  return cols;
}
int getRows(){
  return rows
}

void setup(){
  cols = 33;
  rows = 17;
  size(1000, 800);
  int rectW = width / cols;
  int rectH = height / rows;
  cols = width / rectW;
  rows = height / rectH;
  for(int i = 0; i < cols; i++)
  {
    for(int j = 0; j < rows; j++)
    {
      rect(i * rectW, j * rectH, rectW, rectH);
    }
  }
 }
 
void draw(){
 }
