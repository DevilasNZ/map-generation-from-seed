//class for managing each tile of the world. stores the status of this tile and records which tiles surround it.

class WorldTile{
  private int tileType = 0;//{0=grass,1=water,2=rock/mountain}
  private int newTileType;
  private color[] tileColors = {color(10, 168, 52),color(8, 138, 219),color(145, 140, 138)};
  private int depth = 0;//use this to determine how far into a terrain a tile is
  private color[] tileColors1 = {color(10, 168, 52),color(61, 76, 191),color(79, 62, 59)};
  private color[] tileColors2 = {color(10, 168, 52),color(49, 62, 160),color(44, 45, 51)};
  private color[] tileColors3 = {color(10, 168, 52),color(5, 16, 86),color(21, 21, 22)};
  private color[] tileColors4 = {color(10, 168, 52),color(5, 16, 86),color(227, 227, 234)};
  
  private WorldTile[] neighbours;
  
  public WorldTile(){
    
  }
  
  public void setNeighbours(ArrayList<WorldTile> neighbours){
    WorldTile[] temp = new WorldTile[neighbours.size()];
    for(int i=0;i<temp.length;i++){
      temp[i] = neighbours.get(i);
    }
    this.neighbours = temp;
  }
  
  //if the tile is grass in the first cycle, this function will check for different tiles nearby, and change its type depending.
  public void getFirstNewTile(){
    newTileType = tileType;
    if(tileType == 0){
      for(int i=0;i<neighbours.length;i++){//go through all neighbouring tiles to see what they are
        if(neighbours[i].getType() != 0){
          newTileType = neighbours[i].getType();
          return;
        }
      }
    }
  }
  
  //this function is for cycles thereafter, which will find a tile to update to depending on all neighbouring tiles.
  public void getNewTile(){
    newTileType = tileType;
    if(tileType == 0){
      int[] tileTypeCount = new int[tileColors.length];
      for(int i=0;i<tileTypeCount.length;i++){tileTypeCount[i] = 0;}
      
      for(int i=0;i<neighbours.length;i++){//get the tile status of all other tiles
        if(neighbours[i].getType() != 0){
          tileTypeCount[neighbours[i].getType()] ++;
        }
      }
      
      //see which neighbouring tile is the most common, and take on that tile.
      int currentLargest = 0;
      for(int i=1;i<tileTypeCount.length;i++){
        if(tileTypeCount[i] > tileTypeCount[currentLargest]){
          currentLargest = i;
        }
      }
      
      if(tileTypeCount[currentLargest] >= 2){
        newTileType = currentLargest;
      }
    }
  }
  
  public void commitNewTile(){
    tileType = newTileType;
  }
  
  //Methods to modify the depth of the tile based on the tiles around.
  public void updateDepth(){
    int[] tileTypeCount = new int[tileColors.length];
    for(int i=0;i<tileTypeCount.length;i++){tileTypeCount[i] = 0;}
    
    for(int i=0;i<neighbours.length;i++){//get the tile status of all other tiles
      if(neighbours[i].getType() != 0){
        tileTypeCount[neighbours[i].getType()] ++;
      }
    }
    
    //see which neighbouring tile is the most common, and take on that tile.
    int currentLargest = 0;
    for(int i=1;i<tileTypeCount.length;i++){
      if(tileTypeCount[i] > tileTypeCount[currentLargest]){
        currentLargest = i;
      }
    }
    
    if(tileTypeCount[currentLargest] >= 6){
        depth =1;
    }
  }
  
  public void updateDepthFurther(){
    if(depth==1){
      int deepTileCount = 0;
      
      for(int i=0;i<neighbours.length;i++){
        if(neighbours[i].getDepth() > 0){
          deepTileCount ++;
        }
      }
      
      if(deepTileCount >= 7){
        depth = 2;
      }
    }
    else if(depth==2){
      int deepTileCount = 0;
      
      for(int i=0;i<neighbours.length;i++){
        if(neighbours[i].getDepth() > 1){
          deepTileCount ++;
        }
      }
      
      if(deepTileCount >= 7){
        depth = 3;
      }
    }
    else if(depth==3){
      int deepTileCount = 0;
      
      for(int i=0;i<neighbours.length;i++){
        if(neighbours[i].getDepth() > 2){
          deepTileCount ++;
        }
      }
      
      if(deepTileCount >= 7){
        depth = 4;
      }
    }
  }
  
  private int getDepth(){
    return depth;
  }
  public int getType(){return tileType;}
  public color getColour(){
    if(depth==0){
      return tileColors[tileType];
    }else if(depth==1){
      return tileColors1[tileType];
    }else if(depth==2){
      return tileColors2[tileType];
    }else if(depth==3){
      return tileColors3[tileType];
    }else if(depth==4){
      return tileColors4[tileType];
    }
    return color(255,255,255);
  }
  public int getPossibleTypes(){return tileColors.length;}//getting how many different types a tile can be
  
  public void setType(int type){tileType = type;}
}