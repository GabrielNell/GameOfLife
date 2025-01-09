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



class Cell {
  private boolean alive, toDie, toRevive;
  private int x, y;
  Cell(int x_, int y_, boolean alive_) {
    x = x_;
    y = y_;
    alive = alive_;
  }

  public void show() {
    if (alive) {
      fill(sin(0.05*time) * (100 - x * 100 / boardWidth) + 150, sin(0.05*time+1) * (100 - y * 100 / boardHeight) + 155, sin(0.05*time + 2) * (100 - y * 100 / boardHeight) + 155);
    } else {
      fill(0);
    }
    rect(x * cellWidth, y * cellWidth, cellWidth, cellWidth);
  }
  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }
  
  public void calculateLife() {
    if (numNeighbors() == 3 && !alive) {
      toDie = false;
      toRevive = true;
    } else if (alive && (numNeighbors() == 2 || numNeighbors() == 3)) {
      toDie = false;
      toRevive = false;
    } else {
      toDie = true;
      toRevive = false;
    }
  }

  void reevaluateLife() {
    if (toDie) {
      alive = false;
    }
    if (toRevive) {
      alive = true;
    }
  }
  
  int numNeighbors() {
    int numNeighbors_ = 0;
    for (Cell[] col : board) {
      for (Cell cell : col) {
        if (((cell.getX() == x + 1 || cell.getX() == x - 1 || cell.getX() == x) && (cell.getY() == y + 1 || cell.getY() == y - 1 || cell.getY() == y)) && cell.alive) {
          numNeighbors_ += 1;
        }
      }
    }
    if (alive) {
      numNeighbors_ -= 1;
    }
    return numNeighbors_;
  }
}
