public class ChildApplet extends PApplet {
  ArrayList<Integer> historyPrey;
  ArrayList<Integer> historyPred;
  ArrayList<Float> ratio;
 
  public ChildApplet(int preyH, int predH) {
    super();
    historyPrey = new ArrayList<Integer>();
    historyPred = new ArrayList<Integer>();
    ratio = new ArrayList<Float>();
   
    historyPrey.add(preyH);
    historyPred.add(predH);

    float iratio = 0.0;
    if (predH == 0) {
            iratio = 0.0;
        } else {
            iratio = (float) preyH / predH;
        }
    ratio.add(iratio);
   
    // Taken from Demo but it
    // Launches a new Processing sketch window using this PApplet instance.
    // runSketch takes a String[] (used to name the sketch, like command-line args)
    // and a PApplet object (this), which contains settings(), setup(), and draw().
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
 
  public void settings() {
    size(1200, 900);
  }

  public void draw() {
    if (`isPaused) {
    background(255);
    popGraph();
    ratioGraph();
    }
  }
 
  void popGraph() {
    stroke(100);

    //X and Y are graph offset from top of window
    int x = 50;
    int y = 50;
    int widthg = 800;
    int heightg = 300;
   
    fill(30);

    textSize(20);
    text("Population", x + widthg/2, y - 25);
   
    //border
    stroke(0);
    rect(x, y, widthg, heightg);
   
    int pmin = Collections.min(historyPrey);
    int pmax = Collections.max(historyPrey);
    int pdmin = Collections.min(historyPred);
    int pdmax = Collections.max(historyPred);
    int gmin = Math.min(pmin, pdmin);
    int gmax = Math.max(pmax, pdmax);
   

    int range = gmax - gmin;
    int padding = Math.max(1, range / 10);
    int dmin = Math.max(0, gmin - padding);
    int dmax = gmax + padding;
   
    //draw pop
    popGrid(x, y, widthg, heightg, dmin, dmax);
   
    //draw prey population(blue line)
    strokeWeight(5);
    stroke(80, 80, 255);

    noFill();
    beginShape();
    for (int i = 0; i < historyPrey.size(); i++) {
      int val = historyPrey.get(i);
      //Map is used to convert range from actual to graph
      float px = x + interpolate(i, 0, Math.max(1, historyPrey.size() - 1), 0, widthg);
      float py;
      // y is needed for vertical offset. THen when it is equal we set it to be midline, and when it isnt, we just subtract and use interpolate for proper scaling. 
      if (dmax == dmin) {
        py = y + heightg / 2;
      } else {
        py = y + heightg - interpolate(val, dmin, dmax, 0, heightg);
      }
      vertex(px, py);
    }
    endShape();
   
    // Draw predator population (red line)
    stroke(255, 0, 0);

    noFill();
    beginShape();
    for (int i = 0; i < historyPred.size(); i++) {
      int val = historyPred.get(i);
      //interpolate is used to convert range from actual to graph
      float px = x + interpolate(i, 0, Math.max(1, historyPred.size() - 1), 0, widthg);
     
      float py;
      //same as above
      if (dmax == dmin) {
        py = y + heightg / 2;
      } else {
        py = y + heightg - interpolate(val, dmin, dmax, 0, heightg);
      }
      vertex(px, py);
    }
    endShape();
    strokeWeight(1);
    // we do + 30 to shift legend off of the graph, but y can be the same
    // pass in gmax to display it
    popStats(x + widthg + 30, y);

    updateData();
  }
 
  //Draw the ratio graph (bottom half)
  void ratioGraph() {
    
    stroke(0);


    int x = 50;
    int y = 450;
    int widthg = 800;
    int heightg = 300;
   
    fill(30);
    textSize(18);
    text("Prey/Pred Ratio", x + widthg/2, y - 25);
   
    //border
    stroke(0);
    rect(x, y, widthg, heightg);
   

    float rmin = Collections.min(ratio);
    float rmax = Collections.max(ratio);
   
    float range = rmax - rmin;
    float padding = Math.max(0.1f, range / 10);
    float dmin = Math.max(0, rmin - padding);
    float dmax = rmax + padding;
   
    // Draw grid for ratio graph
    ratioGrid(x, y, widthg, heightg, dmin, dmax);
   
    // Draw ratio line (green/purple)
    strokeWeight(5);
    stroke(100, 150, 50);

    noFill();
    beginShape();
    for (int i = 0; i < ratio.size(); i++) {
      float Ratio = ratio.get(i);
      float px = x + interpolate(i, 0, Math.max(1, ratio.size() - 1), 0, widthg);
     
      float py;
      if (dmax == dmin) {
        py = y + heightg / 2;
      } else {
        py = y + heightg - interpolate(Ratio, dmin, dmax, 0, heightg);
      }
      vertex(px, py);
    }
    endShape();
   strokeWeight(1);

    ratioStat(x + widthg + 30, y);
  }
  //grid pop
  void popGrid(int x, int y, int width1, int height1, int min, int max) {
    stroke(255);

    int lines = 8;
    for (int i = 0; i <= lines; i++) {
      float Y = y + interpolate(i, 0, lines, height1, 0);
      line(x, Y, x + width1, Y);
      if (max != min) {
        int value = (int) interpolate(i, 0, lines, min, max);
        textSize(15);
        text(value, x - 30, Y);
      }
    }
    lines = 16;
    for (int i = 0; i <= lines; i++) {
      float lineX = x + interpolate(i,0, lines, 0, width1);
      line(lineX, y, lineX, y + height1);
    }
  }
  
  //grid ratio
  void ratioGrid(int x, int y, int width1, int height1, float min, float max) {

    stroke(255);
    int lines = 8;
    for (int i = 0; i <= lines; i++) {
      float Y = y + interpolate(i, 0, lines, height1, 0);
      line(x, Y, x + width1, Y);
      if (max != min) {
        float value = interpolate(i, 0, lines, min, max);
        textSize(15);
        text(value, x - 30, Y); 
      }
    }
    lines = 16;
    for (int i = 0; i <= lines; i++) {
      float X = x + interpolate(i, 0, lines, 0, width1);
      line(X, y, X, y + height1);
    }
  }
  
  //LINEAR INTERPOLATION USING FORMULA
  float interpolate(float val, float min1, float max1, float min2, float max2) {
  if (max1 == min1) {
    return min2;
  }
  return (((val - min1) * (max2 - min2)) / (max1 - min1)) + min2;
}

 
  //stats for pop
  void popStats(int x, int y) {
    fill(255);
    stroke(100);
    //minus x and y shift is arbitrary for visual appeal
    rect(x - 10, y - 10, 150, 120);
   

    stroke(0, 0, 255);

    line(x, y, x + 30, y);
    fill(0, 0, 255);

    textSize(12);
    text("Prey", x + 40, y);
   

    stroke(255, 0, 0);

    line(x, y + 20, x + 30, y + 20); // Placed below Prey legend 20 pts
    fill(255, 0, 0);
   
    fill(0);
    text("Predator", x + 40, y + 20);
    // Current values
      int currentPrey = historyPrey.get(historyPrey.size() - 1);
      int currentPred = historyPred.get(historyPred.size() - 1);
     //Display current prey and pred
      fill(60);
      textSize(10);
      text("Current:", x, y + 45);
      fill(0, 0, 255);
      text("Prey: " + currentPrey, x, y + 58);
      fill(255, 0, 0);
      text("Pred: " + currentPred, x, y + 71);
    noFill();
  }
 
  //stats for ratio
  void ratioStat(int x, int y) {
    fill(255);
    stroke(100);
    rect(x - 10, y - 10, 150, 140);
    stroke(100, 150, 50);
    line(x, y, x + 30, y);
    fill(100, 150, 50);
    fill(0);
    textSize(15);
    text("Prey/Pred", x + 40, y+5);
    text("Ratio", x + 40, y + 20);
    float current = ratio.get(ratio.size() - 1);
     
    fill(60);
    textSize(10);
    text("Current Ratio:", x, y + 50);
    fill(100, 150, 50);
    textSize(15);
    text(current, x, y + 63);
  }
 
  public void updateData() {
    historyPrey.add(PREYC);
    historyPred.add(PREDC);
   
    float newRatio = (float)PREYC / PREDC;
    ratio.add(newRatio);

    if (historyPrey.size() > 5000) {
      historyPrey.remove(0);
      historyPred.remove(0);
      ratio.remove(0);
    }
   }
  }
