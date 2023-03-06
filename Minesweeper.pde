import de.bezier.guido.*;
public final static int NUM_ROWS = 15;
public final static int NUM_COLS = 15;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(600, 600);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );  

  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int j = 0; j < NUM_ROWS; j++)
    for (int i = 0; i < NUM_COLS; i++)
      buttons[j][i] = new MSButton(j, i);

  setMines();
}
public void setMines()
{
  for (int i = 0; i < NUM_ROWS * 2; i++) {
    int randomR = (int)(Math.random()*NUM_ROWS);
    int randomC = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[randomR][randomC])) {
      mines.add(buttons[randomR][randomC]);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  for (int i = 0; i < buttons.length; i++)
    for (int j = 0; j < buttons[i].length; j++)
      if (!mines.contains(buttons[i][j]) && buttons[i][j].clicked == false)
        return false;
  return true;
}
public void displayLosingMessage()
{
  //your code here
  buttons[6][6].setLabel("Y");
  buttons[6][7].setLabel("O");
  buttons[6][8].setLabel("U");
  buttons[7][5].setLabel("L");
  buttons[7][6].setLabel("O");
  buttons[7][7].setLabel("S");
  buttons[7][8].setLabel("E");
  buttons[7][9].setLabel("!");
}
public void displayWinningMessage()
{
  //your code here
  buttons[6][6].setLabel("Y");
  buttons[6][7].setLabel("O");
  buttons[6][8].setLabel("U");
  buttons[7][6].setLabel("W");
  buttons[7][7].setLabel("I");
  buttons[7][8].setLabel("N");
  buttons[7][9].setLabel("!");
}
public boolean isValid(int r, int c)
{
  if (r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS)
    return true;
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int r = row - 1; r <= row + 1; r++)
    for (int c = col - 1; c <= col + 1; c++)
      if (isValid(r, c) && mines.contains(buttons[r][c]))
        numMines++;
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 600/NUM_COLS;
    height = 600/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT)
    {
      flagged = !flagged;
      if (flagged == false)
        clicked = false;
    } else if (mines.contains(this))
    {
      for (int i = 0; i < mines.size(); i++) {
        mines.get(i).clicked = true;
      }
      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0)
    {
      setLabel(countMines(myRow, myCol));
    } else
    {
      // left neighbor
      if (isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked == false) {
        buttons[myRow][myCol-1].mousePressed();
      }
      //down neighbor
      if (isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked == false) {
        buttons[myRow+1][myCol].mousePressed();
      }
      // up neighbor
      if (isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked == false) {
        buttons[myRow-1][myCol].mousePressed();
      }
      // right neighbor
      if (isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked == false) {
        buttons[myRow][myCol+1].mousePressed();
      }
      // upper left corner neighbor
      if (isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].clicked == false) {
        buttons[myRow-1][myCol-1].mousePressed();
      }
      // upper right corner neighbor
      if (isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].clicked == false) {
        buttons[myRow-1][myCol+1].mousePressed();
      }
      // lower left corner neighbor
      if (isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].clicked == false) {
        buttons[myRow+1][myCol-1].mousePressed();
      }
      // lower right corner neighbor
      if (isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].clicked == false) {
        buttons[myRow+1][myCol+1].mousePressed();
      }
    }
  }
  public void draw () 
  {    
    if (flagged){
      stroke(0);
      fill(188, 19, 254);
    }
    else if ( clicked && mines.contains(this) ){
      stroke(0);
      fill(255, 0, 0);
    }
    else if (clicked){
      stroke(255);
      fill( 0 );
    }
    else {
      stroke(0);
      fill(55, 198, 255);
    }
    
    rect(x, y, width, height);
    fill(255);
    textSize(width/2);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
