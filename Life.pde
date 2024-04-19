public class Life {
  private int myRow, myCol;
  private float x, y, wid, hgt;
  private boolean alive;

  public Life (int row, int col) {
    wid = 1000/num_cols;
    hgt = 500/num_rows;
    myRow = row;
    myCol = col; 
    x = myCol * wid;
    y = myRow * hgt;
    // alive = Math.random() < .5; // uncomment/comment to your heart's content
    alive = false;
    Interactive.add(this); // register it with the manager
  }

  // called by manager
  public void mousePressed() { //turn cell on and off with mouse press
    alive = !alive;
    setLife(alive);
  }
  
  public void draw() {    
    if (alive) {
      fill(255);
    } else {
      fill(0);
    }
    
    rect(x, y, width, height);
  }
  
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
