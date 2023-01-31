class Backpack implements Comparable<Backpack> {

  Item[] items;
  boolean[] genes;

  int maxWeight;
  int weight;
  int value; 
  double fitness;

  public Backpack(Item[] items, int maxWeight) {
    this.items = items;
    this.maxWeight = maxWeight;

    // Create a boolean array of genes that represents the configuration of items in the backpack
    this.genes = new boolean[items.length];

    // Randomly fill the backpack with items
    for (int i = 0; i < genes.length; i++) {
      this.genes[i] = random(1) < 0.5;
    }

    // Initialize the value variable
    this.value = 0;

    // Calculate the weight and value of the backpack based on its genes
    calculateWeightValue();
  }

  public Backpack(Item[] items, int maxWeight, boolean[] genes) {
    this.items = items;
    this.maxWeight = maxWeight;
    this.genes = genes.clone();
     calculateWeightValue();
    }

  public void calculateWeightValue() {
    this.weight = 0;
    this.value = 0;
    for (int i = 0; i < genes.length; i++) {
      if (genes[i]) {
        this.weight += items[i].weight;
        this.value += items[i].value;
      }
    }
  }

  public void calculateFitness() {
    // If the backpack is over the maximum weight, its fitness is 0
    if (this.weight > maxWeight) {
      this.fitness = 0;
    } else {
      this.fitness = (double) this.value;
      
      //this.fitness = (double) this.value / this.weight;
    }
  }

  public void mutate() {
    // Randomly select a gene and flip its value
    int index = (int) random(genes.length);
    genes[index] = !genes[index];
    // Recalculate the weight and value of the backpack
    calculateWeightValue();
  }

  public void printContents() {
    println(" ---- Backpack ---- ");
    println("Backpack weight = "+this.weight);
    println("Backpack value = "+this.value);
    println("Backpack fitness = "+this.fitness);    
    // Print the contents of the backpack
    /**
    for (int i = 0; i < genes.length; i++) {
      if (genes[i]) {
        println("Item " + (i+1) + ": " + items[i].weight + "kg, " + items[i].value + " dollars");
      }
    }
    **/    
  }

  public Backpack clone() {
     Backpack clone = new Backpack(items, maxWeight, genes);     
     return clone;
  }

  @Override public int compareTo(Backpack a)
  {
      int retval1 = Double.compare(this.fitness, a.fitness);      

      retval1 = retval1 * -1;
      return retval1;     
  }
}
