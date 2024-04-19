import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public static int num_rows = 50;
public static int num_cols = 100;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(1000, 500);
  frameRate(6);
  noStroke();
  // make the manager
  Interactive.make(this);

  //your code to initialize buttons goes here
  buttons = new Life[num_rows][num_cols];
  
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      buttons[i][j] = new Life(i, j); 
    }
  }
  //your code to initialize buffer goes here
  buffer = new boolean[num_rows][num_cols];
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      buffer[i][j] = buttons[i][j].getLife(); 
    }
  }
}

public void draw() {
  background(0);
  if (running == false) { //pause the program
    return;
  }

  //store current state of buttons into a buffer
  copyFromButtonsToBuffer();

  //use nested loops to 
       //  First draw the buttons here
       //  Then setup the new state of the buffer based on rules
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      if ((countNeighbors(i, j) == 2 && buttons[i][j].getLife()) || countNeighbors(i, j) == 3) {
        buffer[i][j] = true;
      } else { 
        buffer[i][j] = false;
      }
      buttons[i][j].draw();
    }
  }
  
  //store new state of buffer into buttons
  copyFromBufferToButtons();
}

public void keyPressed() {
  running = !running;
}

public void mousePressed() {
  int colOver = mouseX / (1000/num_cols);
  int rowOver = mouseY / (500/num_rows);
  buttons[rowOver][colOver].mousePressed();
}
public void copyFromBufferToButtons() {
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      buttons[i][j].setLife(buffer[i][j]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      buffer[i][j] = buttons[i][j].getLife();
    }
  }
}

public boolean isValid(int r, int c) {
  if (r >= num_rows || r < 0 || c >= num_cols || c < 0) {
    return false;
  }
  return true;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (isValid(row + i, col + j) && buttons[row + i][col + j].getLife()) {
        neighbors += 1;
      }
    }
  }
  if (buttons[row][col].getLife()) {
    neighbors -= 1;
  }
  return neighbors;
}



