class Spread{
}

class Diffuse{
}

class Encounter{
  float chance = 0.70;
  int hungerChange = 5;
  boolean encounter(Pedator pred, Prey pr){
    if(random(0, 1) < chance)
    {
      pred.addHunger(hungerChange);
    }
  }
}
