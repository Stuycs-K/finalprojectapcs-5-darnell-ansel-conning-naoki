class Spread{
}

class Diffuse{
}

class Encounter{
  float chance = 0.70;
  int hungerChange = 5;
  boolean encounter(Predator pred, Prey pr){
    if (random(0, 1) < chance)
    {
      pred.addHunger(hungerChange);
      pr.die();
      return true;
    }
    return false;
  }
}
