//Generate a 2d map from a seed

/*This code should:
-not use random numbers (so that the same terrain may be generated again.
-use an alphanumeric seed (what does this determine?)
-create natural looking water and mountain by examining surrounding worldTiles

-Generation process:
-regulate the size of the seed to ensure it is the correct size for generation(mod 3). if it is too short, add a common seed.
-create "growth points" by using the seed. use the seed to determine the location and type of terrain
-get the points surrounding the growth points and generate the type of terrain dependant on the growth point (no random numbers)
-from there, process all of the remaining unprocessed points depending on their surrounding worldTiles.


-NOTES
-values can range from 0 - 35: "abcdefghijklmnopqrstuvwxyz0123456789"

TO Do:
-pick the growth points using the seed.
-identify these points as being growth points, so that the non growth points can then have their state determined from growth points.
-may be some difficulty having natural formations without random values.
-one solution may be to run through once, every tile with a different tile near them will take on that state, 
then go through a second time having conditions similar to conway's game of life, where tile status is determined by the status of all surrounding tiles.
for instance, for a tile to become water, it may need a minimum of 2 neighbouring water tiles.

*/

String seedString = "theseed";
char[] commonSeed = {'4', 'e', 'b', 'x', 's', 'w', 'r', 'c', 'b', 'x', 'c', 't', 'a', '9', 'o', 'v', 'x', '5', 'c', 'w', 'z', '7', 'v', 'a', '1', 's', 'k', 'y', '8', 'g', '6', 'e', 'l', '2', 'p', 'e', 'q', 'a', 'p', 'v', 's', '7', '8', 'm', 'b', 'i', 'x', 'j', 'e', 'p', 'z', 'r', '1', 's', '3', 'c', '5', '4', 'p', 'a', '5', '7', '3', 'p', 'o', '1', 'x', 'x', 'b', '8', 'i', 'g', '0', 'd', 'x', 'r', 'u', 'a', 'z', 'c', 'v', 'h', '1', 't', 'f', 'z', 'm', 'o', '4', 'z', '5', 't', 'q', 'u', 'x', 'z', 'c', 'm', 'i', 'n', '3', 'c', 'b', 'u', 'e', '2', 'o', 'k', 'c', 'o', 'n', 'b', '6', 'z', 'x', 'y', '8', 'd', 'm', 's', 'i', 'n', 'k', '4', '8', '7', '7', 'n', 'm', '6', 'k', 'a', 'v', 'l', 's', '4', '2', 'i', '0', 'v', 's', 'a', 'k', 'r', '7', 'f', 'r', 'l', 'f', '7', 't', 'k', '1', 'o', 'a', 'w', '6', '4', '7', 'w', 'm', 'i', 't', 'x', 'k', 'q', 'g', 'a', 's', 'm', 'q', 'f', 'e', 'v', '3', 's', 'f', 't', 'w', 'h', 's', 'm', 'b', '0', 'a', 'e', 'e', '1', 'v', 'a', '3', '9', 'a', 'o', 'n', 'k', 'o', 'k', 'g', 'v', 'z', '1', 'g', '0', 'l', '8', 'f', 'f', '4', 'e', '7', 'l', 'f', '9', 'e', 'v', 'd', 'y', 'n', 'b', 'y', '4', '2', 'a', 'b', 'f', 'd', '8', 'b', 'a', 'b', 'i', 'h', 's', 's', '9', '3', 'p', '0', 'l', 'c', 'p', 'l', '1', 'h', 'j', 'c', 'm', '1', 'f', 'w', 'p', '7', 'h', 'r', 'o', 'h', '1', 'a', '6', 'b', 'z', 'w', 'm', 'i', 'z', 'o', 'j', 'n', 'j', 'a', 'm', '5', 'p', 'g', '4', 's', 'k', 'n', 'd', '4', 'r', '5', 'd', 'i', '6', 't', 'n', '6', 'g', 'r', 'm', 'z', 'z', 'g', 'y', '9', '9', 'b', 'c', 'n', 'a', 'f', 'r', 'g', '4', 'r', 'i', '7', 'l', '6', 's', 'm', 's', '1', 's', 'm', '7', '9', 'l', 'l', 'c', 'l', 'r', 'x', '1', 'x', '4', 'l', '6', 'f', '5', '7', 'i', 'u', '5', 'd', '6', 't', 'v', '6', '3', 'i', 'n', '6', 'i', 'e', '8', 'y', '4', 'z', '2', '9', 'u', 'd', 'g', 'u', 'i', 'w', 'f', 'j', 'm', 'f', 'x', 'u', 'x', 'w', 'g', '1', 'k', 't', '4', 'h', 'z', 'u', 'o', 'f', '4', 'a', '5', '4', '4', 'h', 'j', '9', '7', '7', '1', 'f', 'v', '5', 'c', 'z', 'z', 'k', 'w', 'h', 'r', 'x', '9', 'v', '1', 'd', '4', '8', '1', 'a', 'i', 'f', '1', 'b', 'r', '3', 't', '9', 'o', 'h', 'z', '2', '1', 'x', '6', 'p', '0', 'h', 'r', 'l', 'n', '6', 'f', 'x', '0', '4', 'c', '3', '1', 'i', 'a', 'v', 'z', 'q', 'w', 'h', '1', 's', '1', '1', 'x', 'w', 'x', 'p', 'm', '5', '8', 'h', '7', 's', '2', 'u', '7', 'd', 'p', '3', '9', '5', 'r', '5', 'a', '7', '7', 'g', 't', 'a', '3', 'm', '7', 'q', 'v', 'd', '9', '6', 'u', 'n', '8', 'u', 'y', '5', '5', 'x', '5', 'm', 'c', 'n', '0', '3', 'p', 'g', 'm', 'z', '0', '8', '5', '4', 'j', '2', 'j', 'j', 'm', 't', 'a', 'o', 'e', 'o', 'i', 'r', 'b', 'r', 'v', '4', 'm', '5', 'j', '4', 'j', 'x', 'l', '3', '2', 'l', 'm', '4', 'c', '0', 'h', 'w', '2', 't', 'g', 'm', 'y', '2', '9', '6', '8', 's', 'r', '5', 'a', '2', 'i', 'l', 'g', 'c', 'j', 'v', 'a', 'j', '8', '1', '5', 's', '4', 'g', 'k', 'm', '3', '0', 'n', 'm', '3', 'm', 'z', 'v', '1', '3', '5', 'v', '0', '4', '8', '3', '2', 'n', '2', '6', 'f', 'r', 'u', 'y', 'i', 'n', '7', 'y', 'n', 'j', 'b', 'm', '1', 'q', '7', '2', 'j', 'c', 'q', '7', '6', 'y', '1', 'y', '6', 'r', 'v', '2', 'o', '4', '8', 'l', '5', '5', 'o', 'w', 'y', 'p', 'v', 'o', 'i', '5', 'h', 'f', '9', 'a', 'c', 'd', 'e', 'n', 'u', 's', 'a', 'h', 'z', 'v', 'k', 't', '1', 'z', '0', '2', 's', 'd', '4', 'o', 'v', 'f', 'y', '4', 'e', 'o', '8', '1', 'z', '6', 'o', 'w', 's', '8', 'w', 'h', 'r', '5', 'y', 'i', 'i', 'c', 'z', 'h', 's', '1', 'v', 'o', '5', 'f', 'j', 'u', '2', 'j', 'g', '0', 'd', 'o', 'n', 'k', '4', '7', 'l', 'n', '2', 'v', 'f', 't', '7', 'e', 'h', 't', '6', 'l', 'j', '4', '4', 'z', 'h', 'q', 'l', '3', 'r', 'e', 'e', '7', 'q', 'c', 'f', 'l', 'b', 'd', 'p', 'f', 'q', 'x', '7', 'w', 'g', 'o', 'c', 'q', 'f', '9', '3', 's', 'w', 'd', 'c', 'm', 'l', 'a', 'v', 'b', 'u', 's', 'y', 'm', 's', 'j', 'y', 'y', 'z', 'd', '8', 'e', 'r', 'r', 'p', 'q', '1', 'l', 'l', 'x', 'b', '8', 'g', 'u', 's', 'p', 'm', '9', 'k', '0', 'u', '2', 'y', '0', '3', 's', 'u', 'e', 'k', '7', '9', 'j', 'f', 'x', 'w', 'x', 'k', 'u', 'e', 'x', 'm', 'h', 'm', 'j', '1', 'q', 'k', '9', '9', 'u', 'k', 'm', 't', 'h', '1', '8', '6', '8', 'x', 'v', 't', '5', '3', 'r', 'w', 'g', '7', 'f', '7', '7', 'k', '1', 'z', 'y', '8', '9', 'l', '6', 'v', 'u', 'm', 'c', 'h', '6', 'l', 'b', 'g', 'e', 'e', 'c', 'w', 'z', 'p', 'x', 'o', '9', 'c', 'q', 'g', 'm', 'k', 'z', '4', 'x', 't', 'v', '9', '2', '8', 'e', 's', 'z', '5', 'n', '5', 't', 'i', 'g', 'h', '5', 'w', 'v', 'p', '0', '5', 'm', 't', 's', 'q', '9', '7', 'q', 'f', 'j', '6', 'h', 'a', 'n', 'q', 'f', 'j', 'q', 'c', 'y', 's', '2', '2', '3', '0', 'h', '5', 'r', 'm', 'j', 'm', 'p', '3', 'm', 'z', 'o', '7', '2', 'd', 'e', '6', '6', 's', 'p', 'g', 'c', '3', 'i', 'p', '3', 't', '7', 'o', 'd', 'd', 'c', 'z', 'n', 'l', '2', 'j', 'g', 'm', 'g', 'm', '0', 'e', 'u', 'z', '9', '2', 'o', 'd', 'k', '9', 'v', '7', '5', 'a', 'a', 'n', 'o', 'r', 'k', 'j', 'x', 'j', 'w', '6', '4', 'v', 'l', 'a', 'j', 'p', 'q', 'c', 'k', '7', 'd', 't', '3', '3', 'a', '4', '0', 'p', 'r', 'e', 'x', '7', 'q', 'f', '1', 'o', 'm', '9', 'o', 'f', 'u', 'e','n', 'n', '3', 'x', 'o', 'n', 'y', 'q', '6', 'v', '6', 'l', 'l', 'o', '5', '1', 'a', 'i', 'v', '2', '9', '9', 'i', 'r', 'x', 'f', '1', 'w', '0', 'm', 'o', 'j', 'i', 'p', 'w', 'm', 'r', 'k', 'i', '0', 'e', '2', 's', '9', 'c', 'y', 'p', 'o', 'j', '6', 'e', '3', 'n', 'x', '1', 'g', 'b', 'q', 'a', 'o', 't', '7', 't', '9', 'c', 'i', 'x', 't', 'd', '7', 'm', '0', '2', '9', 'c', 'g', 'y', 'a', '5', 'b', 'p', 'i', 'y', 'l', '4', 'o', 'o', 'n', 'l', 'n', '0', '7', '6', '0', 'm', '1', '0', 't', '0', 'd', 'y', 's', 'q', 'v', '9', '0', 'p', '0', 'z', 'd', '2', '0', 'w', '7', 'p', 'f', '2', 'n', 'y', 'j', 'x', 'l', 'e', '9', '0', 'l', 'o', '7', 'n', 'h', '8', '6', 'r', '2', '9', 'q', 'q', 's', 'd', 'e', 'v', 'l', '4', '6', 'q', 't', 'r', '6', 'a', 'r', 'u', 'q', 'v', 'v', 'x', 'm', 's', '1', 'b', 'i', '3', 'u', '4', 'k', 'p', 's', 'p', '4', 's', 'r', 'm', 'x', '5', 'h', '8', 'n', 'c', 'a', '9', 'x', 'o', 'r', 's', 'm', '3', 'm', '6', 'b', 'd', 'c', 't', '2', '7', 'b', 'o', 'd', 'y', 'k', '9', 'i', 'b', '5', 'h', 'c', 'x', 'a', 's', 'h', '5', '9', '5', '6', 'g', 't', '2', 'j', 'v', '7', 'd', 'a', 'f', 'd', 'r', 'e', '8', 't', 'e', 'k', 't', '8', '4', 'z', '1', 'z', 'a', 'p', '3', 'm', '2', '4', 'w', 'k', 'v', 't', 'p', 'b', 'e', '8', 'm', 's', 'l', 'v', '2', '2', 'j', 'l', '6', 'j', 't', '5', 'g', 'o', 'n', 'y', 'g', 'n', 'i', 'y', '5', 'j', 'p', '2', 'p', 'l', '8', 'a', 'v', 'p', 'h', 'l', 'b', 'r', '9', 'q', '1', 'i', 'y', 'i', '1', '2', 'e', 'q', '2', 'o', 'b', 'j', 'j', '5', 'w', 'h', 'r', 'k', 'r', 'w', 'z', 'r', 't', 'i', 'n', 'f', '8', 'p', '6', '4', 's', 'v', 'f', 'j', 's', 'f', '9', 'r', 'r', 'e', 'j', 'g', '5', 'g', 'r', 'o', 'f', 'h', 'k', 'b', '9', '1', '4', 'r', 'g', '5', 'w', 'e', 'u', 'a', 'g', 'c', 'i', '3', 'e', '9', '5', '6', 'y', 'g', 'i', 'c', 'l', '3', 'w', 't', 't', '7', 'g', 't', 'n', '9', 'x', 'x', 'u', 'm', 'n', 'e', 'n', '6', 'u', '1', '8', 'w', 'f', 'i', '2', 'n', 'g', 'u', 'q', 'x', 'm', '1', '1', 'm', 'j', '4', '2', 'l', 'o', '0', 'm', 'u', 'p', 'd', 'r', 'x', 'o', 'm', 'f', '0', 'u', '0', '3', '5', 'h', 't', 's', 'o', '5', 'r', 'e', 'f', 't', '3', 'q', 'd', 'g', 'c', 'g', '1', 't', '7', 'l', '8', 'z', 'k', '5', 'i', '0', '5', 'r', 'w', 'z', 'z', 't', 'w', 'z', 'a', '6', 'r', 'z', 'k', 'e', 's', 's', 'b', 'm', '7', 't', 'e', 'c', 'g', '9', 'p', 's', 'c', 'u', '2', '6', '0', 's', 'l', '1', 'w', 'm', '3', '5', 'c', 'e', 'u', 'b', 'd', 'a', 'm', 'b', '7', 'n', 'h', '2', '5', 'u', 'p', 'k', '0', 'y', 'z', 'a', 'z', 'n', 'h', 'v', 'h', 'j', 'b', 'm', 'h', 't', '3', 'u', 'l', '5', 'a', '2', 'b', '7', '5', 'f', '7', 'p', '4', 'x', 'k', '3', '0', 'e', '5', 'y', 'i', '8', '4', 'j', 'p', '0', '9', '4', '5', 'c', '8', '8', 's', 'g', 'n', 'b', 'd', 'w', 'w', 'n', '5', 'i', 'w', 'g', '0', 'c', '6', 'c', 'c', 'd', 'z', 'g', 'a', 'v', '9', 'i', 'd', 'j', 'z', 'i', 's', 'v', 'r', 'j', 'w', 'y', '3', 'q', 'd', 'd', 'l', 'y', 'b', '8', 'r', 'j', '8', 'i', '4', '8', 'm', 'y', 'u', 'v', 'j', 'f', 'w', 'a', '2', 'b', 'c', 'z', 'r', 'e', '5', 's', 'n', '7', 's', '0', '4', 'p', 'c', 'a', 'm', 'j', 'i', '6', '3', '6', 'v', '5', 'o', 'l', 'x', '3', '3', '6', '0', 'f', 'l', 't', '8', 'e', '2', 'i', 'o', 'p', 'g', 'v', 'd', 'q', '9', 'a', 'g', 'k', 'x', 'd', 'h', '4', '5', 'v', '4', 'b', 'p', 'x', 'y', 'd', '4', 'g', 'n', '5', '1', 'j', 'n', 'd', '1', 'o', 'd', '3', '9', 'u', 'q', 'c', '7', 'p', '3', '8', 'm', 'c', '1', 'q', '7', 'f', 'v', '2', 'k', 'd', 'e', 's', '8', '0', 'k', 'k', '5', '1', 'n', 'k', 'r', 'g', '0', 'x', 'c', 'v', 'k', 'l', '2', 'c', 'o', 'p', '4', 'g', 'r', '1', 'a', 'p', '1', '0', 'q', '3', '7', 'j', 'i', 'm', 'e', 'o', 'l', 'e', 'l', 'x', '1', 'i', '9', 's', 'i', 'l', 'o', 'w', 'g', 'p', 't', 'e', 's', '5', 'p', 'i', 'g', 'i', '5', 'e', 'n', 'h', '6', '6', 'f', 'q', 'o', 'j', 'x', 'o', 'c', 's', '7', 'f', 'f', '4', 'b', '0', 'h', 'f', '6', '6', 'i', 'd', 't', '6', 'q', '5', 'w', 'p', '3', 'w', 'c', 'o', 'h', 'z', 'd', 'x', '0', '0', 'p', 'j', 'j', 'k', '1', '5', '4', '1', 'f', 'y', 'u', 'b', 's', 'k', '9', 'r', 'h', 'w', 'o', '2', 'v', 's', 'y', 'b', 't', 'q', '5', 'a', 'c', 'h', 'i', '4', '1', '0', 't', 'a', 'j', 'p', 'm', 'n', 'c', 'e', 't', 'x', 't', 'u', 'z', 'o', '6', 'e', 'd', 'r', 'h', 'g', 'w', '7', 's', 't', 'g', 'n', 'i', 'h', 's', '2', '2', 'b', '0', '8', '7', 'z', 'b', 'a', 'n', 'm', 'r', '1', 'c', 'i', '2', 'm', 'n', '0', 'v', 'w', '1', 'd', 'p', 'x', 'x', 'e', '6', '1', 'h', '2', 's', 'o', 'z', '5', '4', 'a', 'a', 'r', 'p', 'k', 'j', 'f', 'o', 'p', 'm', 'b', '3', '7', '2', 'z', 'k', 'g', 't', 'c', 'c', 'l', '7', 'n', '2', 's', '5', 'z', 'd', 'e', 'y', 'l', '6', 'z', 'y', '9', 'e', 'f', 'u', 'v', 'g', '4', 't', '1', 'w', '5', '2', '5', 'l', 'b', 't', '0', '4', 'i', 'l', '7', 'l', 'b', '9', '1', 'p', 'p', '2', 's', 'j', '0', 'v', '7', 'x', '3', 'r', 'o', 'f', 'x', 'c', 'y', 'v', 'w', '7', 'l', 'o', 'v', '5', '5', 'g', 'c', '6', 'p', 'l', 'i', 'w', 'k', 'w', 'p', 't', 'i', '6', '8', '1', 'o', 'b', 'z', 'c', 'z', 'o', '8', 'e', 'h', 'j', '9', 'i', '1', '8', 'n', 'n', 'w', 'f', '2', '9'};

WorldTile[] worldTiles;
int worldTileSize = 10;
int worldTilingWidth;
int worldTilingHeight;
int growthPointCount;//determine the number of growth points based on the world size.
int growthPointRate = 20;//Determines how many growth points are spawned in the world. lower = more points.

void setup(){
  //Set up sizing
  size(1000,1000);
  worldTilingWidth = width/worldTileSize;
  worldTilingHeight = height/worldTileSize;
  worldTiles = new WorldTile[worldTilingWidth*worldTilingHeight];
  growthPointCount = (worldTilingWidth*worldTilingHeight)/growthPointRate;
  noStroke();
  
  //Initialize the worldTiles, find their neighbours.
  for(int i=0;i<worldTiles.length;i++){
    worldTiles[i] = new WorldTile();
  }
  //Add neighbours
  for(int x=0;x<worldTilingWidth;x++){
    for(int y=0;y<worldTilingHeight;y++){
      ArrayList neighbours = new ArrayList<WorldTile>();
      
      int topLeft = (x-1)+(y-1)*worldTilingWidth;
      int topCenter = x+(y-1)*worldTilingWidth;
      int topRight = (x+1)+(y-1)*worldTilingWidth;
      int left = (x-1)+y*worldTilingWidth;
      int right = (x+1)+y*worldTilingWidth;
      int bottomLeft = (x-1)+(y+1)*worldTilingWidth;
      int bottomCenter = x+(y+1)*worldTilingWidth;
      int bottomRight = (x+1)+(y+1)*worldTilingWidth;
      if((y-2) >= 0){//check the top row is in frame
        neighbours.add(worldTiles[topCenter]);//check topCenter
        if((x-2) >=0){
          neighbours.add(worldTiles[topLeft]);//check topLeft
          neighbours.add(worldTiles[left]);//also add left
        }
        if((x+2) <= worldTilingWidth){
          neighbours.add(worldTiles[topRight]);//check topRight
          neighbours.add(worldTiles[right]);//also add right
        }
      }
      if((y+2) <= worldTilingHeight){//check the bottom row is in frame
        neighbours.add(worldTiles[bottomCenter]);//check topCenter
        if((x-2) >=0){
          neighbours.add(worldTiles[bottomLeft]);//check topLeft
        }
        if((x+2) <= worldTilingWidth){
          neighbours.add(worldTiles[bottomRight]);//check topRight
        }
      }
      
      worldTiles[x+y*worldTilingWidth].setNeighbours(neighbours);
    }
  }
  
  //Modify the seed to be more workable. Seed must be of length growthPointCount * 3(determines x,y,type)
  int seedLength = seedString.length();
  if(seedLength < growthPointCount*3){//if the seed length is not long enough, add the common seed to the end of it
    //get the number of characters that need appending to the seed.
    int charCountToAdd = growthPointCount*3 - seedLength;
    for(int i=0;i<charCountToAdd;i++){//stretch the string to appropriate size
      seedString = seedString + commonSeed[i];
    }
  }else if(seedLength > growthPointCount*3){//if the seed is too long, cut it down.
    seedString = seedString.substring(0,growthPointCount*3);
  }
  println("Growth points:",growthPointCount);
  println("Seed:",seedString);
  //Assign the alphanumeric seed to a numeric one
  String[] seedStringArray = seedString.split("");
  int[] seed = new int[seedStringArray.length];
  for(int i=0;i<seedStringArray.length;i++){
    seed[i] = Character.getNumericValue(seedStringArray[i].charAt(0));
  }
  
  //From this generated seed, modify terrain tiles.
  for(int i=0;i<seedString.length()/3;i++){//iterate through each seed key
    //hash to get the x,y coordinates and the type of tile it will be
    int x =  seed[i*3]*seed[i*3+1] % worldTilingWidth;
    int y =  seed[i*3+1]*seed[i*3+2] % worldTilingHeight;
    int t = seed[i*3+2] % worldTiles[1].getPossibleTypes();
    
    worldTiles[x+y*worldTilingWidth].setType(t);
  }
  //Then, go through grass tiles and have them check for different tiles nearby.
  for(int i=0;i<worldTiles.length;i++){
    worldTiles[i].getFirstNewTile();
  }
  for(int i=0;i<worldTiles.length;i++){
    worldTiles[i].commitNewTile();
  }
  //go through all grass tiles again, this time make changes depending on the amount of nearby tiles.
  for(int n=0;n<3;n++){
    for(int i=0;i<worldTiles.length;i++){
      worldTiles[i].getNewTile();
    }
    for(int i=0;i<worldTiles.length;i++){
      worldTiles[i].commitNewTile();
    }
  }
  for(int i=0;i<worldTiles.length;i++){
    worldTiles[i].updateDepth();
  }
  for(int n=0;n<3;n++){
    for(int i=0;i<worldTiles.length;i++){
      worldTiles[i].updateDepthFurther();
    }
  }
  
  //Finally, draw the map from the seed.
  for(int x=0;x<worldTilingWidth;x++){
    for(int y=0;y<worldTilingHeight;y++){
      fill(worldTiles[x+y*worldTilingWidth].getColour());
      rect(x*worldTileSize,y*worldTileSize,worldTileSize,worldTileSize);
    }
  }
}