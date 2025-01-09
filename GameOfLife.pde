int boardWidth, boardHeight;
int cellWidth = 10;
boolean computeGenerations = true;
int time = 0;
Cell[][] board; 
void setup() {
  background(80);
  frameRate(100);
  noStroke();
  size(1400, 700);

  boardWidth = (int)(width / cellWidth);
  boardHeight = (int)(height / cellWidth);
  board = new Cell[boardHeight][boardWidth];
  //for (int i = 0; i < boardHeight; i++) {
  //  board[i] = new Cell[boardWidth];
  //}
  for (int i = 0; i < boardHeight; i++) {
    //System.out.println(i);
    for (int j = 0; j < boardWidth; j++) {
      if (Math.random() > 0.5) {
        board[i][j] = new Cell(j, i, false);
      } else {
        board[i][j] = new Cell(j, i, true);
      }
    }
  }
}


void draw() {
  background(80);
  for (Cell [] row : board) {
    for (Cell cell : row) {
      cell.show();
      if (computeGenerations) {
        cell.calculateLife();
      }
    }
  }
  
  for (Cell [] row: board) {
    for (Cell cell : row) {
      cell.reevaluateLife();
    }
  }
  time += 1;
}

void mouseClicked() {
  for (Cell [] row: board) {
    for (Cell cell : row) {
      if (Math.random() > 0.8) {
        cell.alive = true;
        cell.toDie = false;
      } else {
        cell.alive = false;
        cell.toDie = true;
      }
      cell.show();
    }
  }
  
}

void keyPressed() {
  if (keyCode == 32) {
    computeGenerations = !computeGenerations;
  }
  
}
