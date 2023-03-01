import de.bezier.guido.*;
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5  ;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
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
  for(int i = 0; i < NUM_ROWS; i++){
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
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}
public boolean isValid(int r, int c)
{
  if(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS)
   return true;
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here
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
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
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
    //your code here
  }
  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if( clicked && mines.contains(this) ) 
      fill(255,0,0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
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
