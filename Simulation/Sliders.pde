public class Sliders extends PApplet {
  int w = 300;
  int h = 500;
  
  //WATCHED TUTORIAL ON HOW TO MAKE
  
  //Slider
  float[] values;
  String[] labels;
  float[] mins;
  float[] maxs;
  boolean dragging[];
  
 Sliders() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  public void settings() {
    size(w, h);
  }
  
  public void setup() {
    surface.setTitle("Simulation Controls");
    int numSliders = 6;
    values = new float[numSliders];
    labels = new String[numSliders];
    mins = new float[numSliders];
    maxs = new float[numSliders];
    dragging = new boolean[numSliders];
    
    // Set up slider parameters
    labels[0] = "Max Age";
    mins[0] = 0; maxs[0] = 600; values[0] = 250;
    
    labels[1] = "Hunger Threshold";
    mins[1] = 0; maxs[1] = 200; values[1] = 60;
    
    labels[2] = "Reproduction Hunger";
    mins[2] = 0; maxs[2] = 150; values[2] = 35;
    
    labels[3] = "Growth Coefficient";
    mins[3] = 0.0; maxs[3] = 3.0; values[3] = 0.50;
    
    labels[4] = "Hunt Success Rate";
    mins[4] = 0.0; maxs[4] = 1.0; values[4] = 0.6;
    
    labels[5] = "Move Chance";
    mins[5] = 0.0; maxs[5] = 1.0; values[5] = 0.5;

  }
  
  public void draw() {
    background(40);
    
    fill(255);

    textSize(16);
    text("Simulation Parameters", w/2 - 80, 30);

    textSize(12);
    
    float sx = 20;
    float swidth = w - 40;
    float sheight = 20;
    float yp = 60;
    float space = 45;
    //draws boxes
    for (int i = 0; i < values.length; i++) {
      fill(255);
      text(labels[i] + ": " + values[i], sx, yp - 5);
      fill(80);
      rect(sx, yp, swidth, sheight);
      float hx = sx + ((values[i] - mins[i]) / (maxs[i] - mins[i])) * swidth;
     if(dragging[i]) {
     fill(255);
   }
      else{ 
      fill(180); 
    }
      rect(hx - 5, yp - 2, 10, sheight + 4);
      
      yp += space;
    }
    

    fill(60);

    rect(90, h - 40, 120, 30);
  
    fill(255);
    text("Start/Pause", 120, h - 21);
    updateSimulation();
  }
  
  void updateSimulation() {
    //updates sim params
    Spread.oldage = (int)values[0];
    Spread.hunger = (int)values[1];
    Spread.repHunger = (int)values[2];
    Spread.growthC = values[3];
    Spread.huntRate = values[4];
    Spread.moveChance = values[5];
  }
  
  public void mousePressed() {

    float sx = 20;
    float swidth = w - 40;
    float sheight = 20;
    float yp = 60;
    float space = 45;
    
    for (int i = 0; i < values.length; i++) {
      if (mouseX > sx && mouseX < sx + swidth &&
          mouseY > yp && mouseY < yp + sheight) {
        dragging[i] = true;
      }
      yp += space;
    }
    

    if (mouseY > h - 40 && mouseY < h-10) {
       if(mouseX > 90 && mouseX < 210) {
        Pause();
       }
    }
  }
  
  public void mouseReleased() {
    for (int i = 0; i < dragging.length; i++) {
      dragging[i] = false;
    }
  }
  
  public void mouseDragged() {
    float sx = 20;
    float swidth = w - 40;
    
    for (int i = 0; i < values.length; i++) {
      if (dragging[i]) {
        float ratio = (mouseX - sx) / swidth;
        ratio = constrain(ratio, 0, 1);
        values[i] = mins[i] + ratio * (maxs[i] - mins[i]);
      }
    }
  }

  
  void Pause() {
    isPaused = !isPaused;
  }
  

}
