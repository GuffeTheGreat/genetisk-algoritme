import java.util.Arrays;

Item items;
Backpack[] population;
Backpack[] matingPool;

int maxWeight = 5000;
int value = 0;

// Define the number of items and the maximum weight of the backpack
int numItems = 24;
int populationSize = 100;
int matingpoolSize = 10;
int generation = 0;

// screen size
int xsize = 1024;
int ysize = 1024;

void setup() {
  background(0);
  fullScreen();
  stroke(255);
  frameRate(1);


  // TODO: Create item from assignment..-
  // Create an array to store the items and their properties
  Item[] items = new Item[numItems];
  int i = 0;
    items[i++] = new Item( 90, 150);
    items[i++] = new Item( 130, 35);
    items[i++] = new Item( 1530, 200);
    items[i++] = new Item( 500, 160);
    items[i++] = new Item( 150, 60);
    items[i++] = new Item( 680, 45);
    items[i++] = new Item( 270, 60);
    items[i++] = new Item( 390, 40);
    items[i++] = new Item( 230, 30);
    items[i++] = new Item( 520, 10);
    items[i++] = new Item( 110, 70);
    items[i++] = new Item( 320, 30);
    items[i++] = new Item( 240, 15);
    items[i++] = new Item( 480, 10);
    items[i++] = new Item( 730, 40);
    items[i++] = new Item( 420, 70);
    items[i++] = new Item( 430, 75);
    items[i++] = new Item( 220, 80);
    items[i++] = new Item( 70, 20);
    items[i++] = new Item( 180, 12);
    items[i++] = new Item( 40, 50);
    items[i++] = new Item( 300, 10);
    items[i++] = new Item( 900, 1);
    items[i++] = new Item( 2000, 150);


  // Create an array to store the population of backpack configurations
  population = new Backpack[populationSize];
  for (i = 0; i < population.length; i++) {
    Backpack backpack = new Backpack(items, maxWeight);
    population[i] = backpack;
  }
  
  // create empty matingpool
  matingPool = new Backpack[matingpoolSize];
  
}
// Main loop
void draw() {

  println("----oOo-----");  
  println("Generation:"+ generation);
  
  // Evaluate the fitness of each backpack in the population
  for (int i = 0; i < populationSize; i++) {
    population[i].calculateFitness();
  }

  /*println("population:");
  population[0].printContents();
  population[99].printContents();*/

  // Sort the population by fitness
  //population = Arrays.sort(population);
  Arrays.sort(population);
  
  println();
  println("sorted population:");
  population[0].printContents();
  population[1].printContents();
  population[2].printContents();
  population[99].printContents();
  
  // Print the best backpack's fitness and contents
  println("Best backpack's fitness: " + population[0].fitness);
  //population[0].printContents();

  // draw point
  float x = generation;
  float y = (float) (population[0].value / 5) ;
  stroke(255);
  point( x, y ); 
  
noSmooth();
textSize(128);
fill(0,0,0);
noStroke();
rect(0,0,600,130);
fill(255,0,0);
text("" + population[0].fitness, 40, 120); 



  // Select the top 10% of backpacks for mutation
  for (int i = 0; i < matingPool.length; i++) {
    matingPool[i] = population[i];
  }

  //println("mating pool:");
  //matingPool[0].printContents();
  //matingPool[1].printContents();
  //matingPool[2].printContents();
  //matingPool[9].printContents();

  // fill the population with elements from the mating pool
  for (int i = 0; i < population.length; i++) {
    int matingpoolIndex = i % matingpoolSize;
    Backpack backpack = matingPool[matingpoolIndex];   
    population[i] = backpack.clone(); 
  }

  //println("new population:");
  //population[0].printContents();
  //population[99].printContents();


  
  // Mutate
  for (int i = 0; i < population.length; i++) {
    population[i].mutate();
  }

   

  // increase generation 
  generation++;
}
