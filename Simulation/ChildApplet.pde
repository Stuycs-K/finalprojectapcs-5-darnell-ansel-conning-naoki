public class ChildApplet extends PApplet {
  ArrayList<Integer> population_history_prey;
  ArrayList<Integer> population_history_pred;
  public ChildApplet(int preyH, int predH) {
    super();
    population_history_prey.add(preyH);
    population_history_pred.add(predH);
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
   public void settings() {
    size(400, 400);
    smooth();
  }
  public void setup() { 
    windowTitle("Data and Setup");
  }
  
  public void draw(){
    stroke(0);
    noFill();
    int x =15;
    int y = 15;
    int graphWidth = 200;
    int graphHeight = 200;
    rect(x, y, 200, 200); ///rect( x, y graph width, height)
    int minVal = Collections.min(population_history_prey);
    int maxVal = Collections.max(population_history_prey);
    stroke(0, 0, 255);
    noFill();
    beginShape();
    for (int i = 0; i < population_history_prey.size(); i++)
    {
      int val = population_history_prey.get(i);
      float px = x + map(i, 0, population_history_prey.size(), 0, graphWidth);
      float py = y + graphHeight - map(val, minVal, maxVal, 0, graphHeight);
      vertex(px, py);
    }
    endShape();
    minVal = Collections.min(population_history_pred);
    maxVal = Collections.max(population_history_pred);
    stroke(255, 0, 0);
    noFill();
    beginShape();
    for (int i = 0; i < population_history_prey.size(); i++)
    {
      int val = population_history_pred.get(i);
      float px = x + map(i, 0, population_history_pred.size(), 0, graphWidth);
      float py = y + graphHeight - map(val, minVal, maxVal, 0, graphHeight);
      vertex(px, py);
    }
    endShape();
  }

  public void updateData(int preyCount, int predCount)
  {
    population_history_prey.add(preyCount);
    population_history_pred.add(predCount);
    if(population_history_prey.size() > 200)
    {
      population_history_prey.remove(0);
      population_history_pred.remove(0);
    }
  }

}
