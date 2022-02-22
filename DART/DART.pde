final String []NUMS = {"6", "10", "15", "2", "17", "3", "19", "7", 
  "16", "8", "11", "14", "9", "12", "5",  "20", "1", "18", "4", "13"};
final float oBRDD = 451, oBULLD = 32, oBULLSEYED = 12.7,
              oOUTERR = 170, oINNERR = 107, oTDWIDTH = 8;
final int [] I_SCORES = {301, 501};

int INIT_SCORE, NUM_SETS, NUM_LEGS, SHOT_COUNTER, MENU_OPTION, NUM_PLAYERS, NAME_INDEX, GAME_MODE;
boolean CHECK_OUT, DOUBLING_IN, NORTHERN_BUST, TIE_BRAEK, MATCH_END, TOURNAMENT;

// INPUTS
int IN_NUM_S, IN_NUM_L, IN_IS_INDEX;
String IN_NAME1, IN_NAME2;
String []MODE_NAMES = {"Classic", "All vs all", "Round robin"};

int INTERFACE_NUM;
String []P_NAMES, IN_NAMES;
int []P_SCORE, PL_SCORE, PS_SCORE;
int P_NUM;

int cX, cY;
float brdD, bullD, bullseyeD, TDwidth, innerR, outerR;
float scaleF;

void setup()
{
  size(700, 900);
  surface.setResizable(true);
  
  // INPUTS
  IN_NUM_S = 1;
  IN_NUM_L = 4;
  IN_IS_INDEX = 0;
  IN_NAME1 = "Mateusz";
  IN_NAME2 = "Kinga";
  MENU_OPTION = 0;
  NUM_PLAYERS = 2;
  NAME_INDEX = 0;
  IN_NAMES = new String[0];
  
  // CENTER
  cX = width/2;
  cY = height/3;
  
  // BOARD DIAMETERS AND STUFF
  // display values
  brdD = 451;
  bullD = 32;
  bullseyeD = 12.7;
  outerR = 170;
  innerR = 107;
  TDwidth = 8;
  
  // scaling factor
  scaleF = 1;
 
  // init_vals 
  INTERFACE_NUM = 0;
  SHOT_COUNTER = 0;
  
  INIT_SCORE = I_SCORES[0];
  NUM_SETS = IN_NUM_S;
  NUM_LEGS = IN_NUM_L;
  
  CHECK_OUT = false;
  DOUBLING_IN = false;
  NORTHERN_BUST = false;
  TIE_BRAEK = false;
  MATCH_END = false;
  TOURNAMENT = false;

  // SCORES
  P_NAMES = new String[2];
  P_NAMES[0] = IN_NAME1;
  P_NAMES[1] = IN_NAME2;
  
  P_SCORE = new int[2];
  P_SCORE[0] = INIT_SCORE;
  P_SCORE[1] = INIT_SCORE;
  PL_SCORE = new int[2];
  PL_SCORE[0] = 0;
  PL_SCORE[1] = 0;
  PS_SCORE = new int[2];
  PS_SCORE[0] = 0;
  PS_SCORE[1] = 0;
  P_NUM = 0;
  
}

void draw()
{
  background(160);
  
  switch(INTERFACE_NUM)
  {
    case 0:
    //  ------------- MENU WINDOW ---------------
      showMenu();
      break;
      
    case 1:
    //  ------------- 2 PLAYER ---------------
      show2Pmenu();
      break;
      
    case 2:
    //  ------------- TOURNAMENT ---------------
      showTmenu();
      break;
      
    case 5:
      // ------------- GAME WINDOW ---------------
      drawBoard();
      drawInterface();
      gameCheck();
      break;
    
    default:
      break;
  }
}

void keyReleased()
{ 
  switch(INTERFACE_NUM)
  {
    case 0:
    //  ------------- MENU WINDOW ---------------
      if (key == CODED && keyCode == DOWN)
        MENU_OPTION = (MENU_OPTION + 1)%2;

      if (key == CODED && keyCode == UP)
      {
        MENU_OPTION--;
        if(MENU_OPTION < 0)
          MENU_OPTION = 1;
      }
      
      switch(MENU_OPTION)
      {
         case 0:
          if (key == ' ' || key == ENTER)
          {
            INTERFACE_NUM = 1;
            MENU_OPTION = 0;
          }
          break;
          case 1:
          if (key == CODED && keyCode == LEFT && NUM_PLAYERS > 2)
            NUM_PLAYERS--;
          if (key == CODED && keyCode == RIGHT)  
            NUM_PLAYERS++;
            
          if (key == ' ' || key == ENTER)
          {
            P_NAMES = new String[NUM_PLAYERS];
            IN_NAMES = new String[NUM_PLAYERS];
            P_SCORE = new int[NUM_PLAYERS];
            PL_SCORE = new int[NUM_PLAYERS];
            PS_SCORE = new int[NUM_PLAYERS];
            for (int i = 0; i < NUM_PLAYERS; i++)
            {
              IN_NAMES[i] = "";
              P_NAMES[i] = "";
              P_SCORE[i] = INIT_SCORE;
              PL_SCORE[i] = 0;
              PS_SCORE[i] = 0;
            }
                
            TOURNAMENT = true;
            INTERFACE_NUM = 2;
          }
          break;
        default:
          break;
      }
      break;
    case 1:
      // -------  2-PLAYER -------------
      if (key == CODED && keyCode == DOWN)
        MENU_OPTION = (MENU_OPTION + 1)%9;

      if (key == CODED && keyCode == UP)
      {
        MENU_OPTION--;
        if(MENU_OPTION < 0)
          MENU_OPTION = 8;
      }
      
      if (key == TAB)
      {
        INTERFACE_NUM = 0;
        resetAll();
      }
      
      switch(MENU_OPTION)
      {
        case 0: 
          if (key == CODED && (keyCode == LEFT || keyCode == RIGHT))
          {
            IN_IS_INDEX = (IN_IS_INDEX + 1)%2;
            INIT_SCORE = I_SCORES[IN_IS_INDEX];
          }
          break;
        case 1: 
          if (key == CODED && keyCode == LEFT && IN_NUM_S > 1)
          {
            IN_NUM_S--;
            NUM_SETS--;
          }
          else if(key == CODED && keyCode == RIGHT)
          {
            IN_NUM_S++;
            NUM_SETS++;
          }
          break;
        case 2: 
          if (key == CODED && keyCode == LEFT && IN_NUM_L > 1)
          {
            IN_NUM_L--;
            NUM_LEGS--;
          }
          else if(key == CODED &&  keyCode == RIGHT)
          {
            IN_NUM_L++;
            NUM_LEGS++;
          }
          break;
        case 3: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
           CHECK_OUT = !CHECK_OUT; 
          break;
        case 4: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
            DOUBLING_IN = !DOUBLING_IN; 
          break;
        case 5: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
            NORTHERN_BUST = !NORTHERN_BUST;
          break;
        case 6: 
         if (key == BACKSPACE)
         {
           if (IN_NAME1.length()>0) 
              IN_NAME1 = IN_NAME1.substring(0, IN_NAME1.length()-1);
         }
          else if (key != CODED)
            IN_NAME1 += key;
          break;
        case 7:
          if (key == BACKSPACE)
          {
           if (IN_NAME2.length()>0) 
              IN_NAME2 = IN_NAME2.substring(0, IN_NAME2.length()-1);
          }
          else if (key != CODED)
            IN_NAME2 += key;
          break;
         case 8:
          if (key == ' ' || key == ENTER)
          {
            INTERFACE_NUM = 5;
            P_NAMES[0] = IN_NAME1;
            P_NAMES[1] = IN_NAME2;
          }
        default:
          break;
      }
      break;
    case 2:
      // -------- TOURNAMENT ------------
      if (key == CODED && keyCode == DOWN)
        MENU_OPTION = (MENU_OPTION + 1)%9;

      if (key == CODED && keyCode == UP)
      {
        MENU_OPTION--;
        if(MENU_OPTION < 0)
          MENU_OPTION = 8;
      }
      
      if (key == TAB)
      {
        INTERFACE_NUM = 0;
        resetAll();
      }
        
      switch(MENU_OPTION)
      {
        case 0: 
          if (key == CODED && (keyCode == LEFT || keyCode == RIGHT))
          {
            IN_IS_INDEX = (IN_IS_INDEX + 1)%2;
            INIT_SCORE = I_SCORES[IN_IS_INDEX];
          }
          break;
        case 1: 
          if (key == CODED && keyCode == LEFT && IN_NUM_S > 1)
          {
            IN_NUM_S--;
            NUM_SETS--;
          }
          else if(key == CODED && keyCode == RIGHT)
          {
            IN_NUM_S++;
            NUM_SETS++;
          }
          break;
        case 2: 
          if (key == CODED && keyCode == LEFT && IN_NUM_L > 1)
          {
            IN_NUM_L--;
            NUM_LEGS--;
          }
          else if(key == CODED &&  keyCode == RIGHT)
          {
            IN_NUM_L++;
            NUM_LEGS++;
          }
          break;
        case 3: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
           CHECK_OUT = !CHECK_OUT; 
          break;
        case 4: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
            DOUBLING_IN = !DOUBLING_IN; 
          break;
        case 5: 
          if ((key == CODED && (keyCode == LEFT || keyCode == RIGHT)) || key == ' ')
            NORTHERN_BUST = !NORTHERN_BUST;
          break;
        case 6: 
          if (key == CODED && keyCode == RIGHT && GAME_MODE < 2)
            GAME_MODE++;

          if (key == CODED && keyCode == LEFT && GAME_MODE > 0)
            GAME_MODE--;
          break;
        case 7:
          if (key == CODED && keyCode == RIGHT && NAME_INDEX < NUM_PLAYERS - 1)
            NAME_INDEX++;

          if (key == CODED && keyCode == LEFT && NAME_INDEX > 0)
            NAME_INDEX--;
            
          if (key == BACKSPACE)
          {
           if (IN_NAMES[NAME_INDEX].length() > 0) 
              IN_NAMES[NAME_INDEX] = IN_NAMES[NAME_INDEX].substring(0, IN_NAMES[NAME_INDEX].length()-1);
          }
          else if (key != CODED)
            IN_NAMES[NAME_INDEX] += key;
          break;
         case 8:
          if (key == ' ' || key == ENTER)
          {
            INTERFACE_NUM = 5;
            for (int i = 0; i < NUM_PLAYERS; i++)
                P_NAMES[i] = IN_NAMES[i];
          }
        default:
          break;
      }
      break;

    case 3:
      break;
      
    case 5:
      // ------------- GAME WINDOW ---------------
      if (key == TAB)
      {
        INTERFACE_NUM = 0;
        resetAll();
      }
      
      if (key == 'R' || key == 'r')
        resetAll();
      
      if (key == 'U' || key == 'u')
        resetAll();
         
      break;
    
    default:
      break;
    
  }
  
}

void keyPressed()
{
  switch(INTERFACE_NUM)
  {
    case 0:
    //  ------------- MENU WINDOW ---------------
       break;
    case 5:
      // ------------- GAME WINDOW ---------------
      if (key == 'Q' || key == 'q')
      {
        scaleF -= 0.05;
        
        brdD = oBRDD * scaleF;
        bullD = oBULLD *scaleF;
        bullseyeD = oBULLSEYED * scaleF;
        outerR = oOUTERR * scaleF;
        innerR = oINNERR * scaleF;
        TDwidth = oTDWIDTH * scaleF; 
      }
      
      if (key == 'E' || key == 'e')
      {
        scaleF += 0.05;
        
        brdD = oBRDD * scaleF;
        bullD = oBULLD *scaleF;
        bullseyeD = oBULLSEYED * scaleF;
        outerR = oOUTERR * scaleF;
        innerR = oINNERR * scaleF;
        TDwidth = oTDWIDTH * scaleF;
      }
      
      if (key == 'W' || key == 'w')
         cY--;
      
      if (key == 'A' || key == 'a')
         cX--;
      
      if (key == 'S' || key == 's')
        cY++;
      
      if (key == 'D' || key == 'd')
        cX++;
      break;
    
    default:
      break;  
  }
}

void mouseReleased()
{
  if (INTERFACE_NUM == 5)
  if (!MATCH_END)
  {
      int X = mouseX;
      int Y = mouseY;
      int value = 0;
      
      float D = dist(cX, cY, X, Y);
      if (D < bullseyeD/2.0)
        value = 50;
      else if (D < bullD/2.0)
        value = 25;
      else if (D > outerR)
      {
        value = 0;
      } else
      {
        float phi = atan2((Y - cY),(X - cX)) + PI/20;
        
        if(phi < 0)
          phi += TWO_PI;
       
        int index = int(10*phi/PI);
        
        if(D > innerR - TDwidth && D < innerR)
          value = 3*int(NUMS[index]); 
        else if (D > outerR - TDwidth && D < outerR)
          value = 2*int(NUMS[index]); 
        else
          value = int(NUMS[index]); 
       }
      println(value);
      
      int new_score = P_SCORE[P_NUM] - value;
      
      if (new_score < 0)
      {
        P_NUM++;
        if (TOURNAMENT)
          P_NUM %= NUM_PLAYERS;
        else
          P_NUM %= 2;
          
        SHOT_COUNTER = 0;
      } else if(CHECK_OUT && new_score < 2)
      {
        P_NUM++;
        
        if (TOURNAMENT)
          P_NUM %= NUM_PLAYERS;
        else
          P_NUM %= 2;
          
        SHOT_COUNTER = 0;
      } else {
        SHOT_COUNTER++;
        P_SCORE[P_NUM] = new_score;
      }
      
      if (SHOT_COUNTER == 3) 
      {
        P_NUM++;
        
        if (TOURNAMENT)
          P_NUM %= NUM_PLAYERS; 
        else
          P_NUM %= 2;
          
        SHOT_COUNTER = 0;
      }
     
     gameCheck();
  } else 
  {
    if(!TOURNAMENT)
      resetAll();
    else
    {
      MATCH_END = false;
      
      
    }
  }
}

void gameCheck()
{
  int winner = -1;
  
  if (P_SCORE[0] == 0)
    winner = 0;
    
  if (P_SCORE[1] == 0)
    winner = 1;
  
  if (winner != -1)
  {
    PL_SCORE[winner]++;
    if(PL_SCORE[winner] >= NUM_LEGS && PL_SCORE[winner] != PL_SCORE[(winner + 1) % 2])
      PS_SCORE[winner]++;
      if(PS_SCORE[winner] >= NUM_SETS && PS_SCORE[winner] != PS_SCORE[(winner + 1) % 2])
        MATCH_END = true;
    
    P_SCORE[1] = INIT_SCORE;
    P_SCORE[0] = INIT_SCORE;
    SHOT_COUNTER = 0;
  }
}

void showMenu()
{
  pushStyle();
  
  int offY = height/18;
  int offCenter = height/12;
  
  textSize(abs(offY/2));
  textAlign(CENTER, CENTER);
  fill(0);
  text("DART APP", 0,offCenter,width,offY);
  text(" ------ *<-O->* ------", 0,offCenter+offY,width,offY);
  text(" ~ USE ARROWS TO CHANGE OPTIONS ~:", 0,offCenter+2*offY,width,offY);
  text("TWO PLAYERS ", 0,offCenter+3*offY,width,offY);
  text("TOURNAMENT " + NUM_PLAYERS + " PLAYERS", 0,offCenter+4*offY,width,offY);

  noFill();
  for (int i = 0; i < 2; i++)
  {
    if ( i == MENU_OPTION)
    {
      strokeWeight(3);
      stroke(255,0,0);
    } else
    {
      strokeWeight(1);
      stroke(0);
    }
      
    rect(0,offCenter+(i+3)*offY,width,offY);
  }
  
  popStyle();
}

void show2Pmenu()
{
  pushStyle();
  
  int offY = height/18;
  int offCenter = height/12;
  
  textSize(abs(offY/2));
  textAlign(CENTER, CENTER);
  fill(0);
  text("DART APP", 0,offCenter,width,offY);
  text(" ------ *<-O->* ------", 0,offCenter+offY,width,offY);
  text(" ~ USE ARROWS TO CHANGE OPTIONS ~:", 0,offCenter+2*offY,width,offY);
  text("POINTS: " + INIT_SCORE, 0,offCenter+3*offY,width,offY);
  text("SETS  : " + NUM_SETS, 0,offCenter+4*offY,width,offY);
  text("LEGS  : " + NUM_LEGS, 0,offCenter+5*offY,width,offY);
  text("Checking out : " + str(CHECK_OUT), 0,offCenter+6*offY,width,offY);
  text("Doubling in  : " + str(DOUBLING_IN), 0,offCenter+7*offY,width,offY);
  text("Northern bust: " + str(NORTHERN_BUST), 0,offCenter+8*offY,width,offY);
  text("Player 1 name: " + IN_NAME1, 0,offCenter+9*offY,width,offY);
  text("Player 2 name: " + IN_NAME2, 0,offCenter+10*offY,width,offY);
  text("   ~ START ~   ", 0,offCenter+11*offY,width,offY);
  
  noFill();
  for (int i = 0; i < 9; i++)
  {
    if ( i == MENU_OPTION)
    {
      strokeWeight(3);
      stroke(255,0,0);
    } else
    {
      strokeWeight(1);
      stroke(0);
    }
      
    rect(0,offCenter+(i+3)*offY,width,offY);
  }
  
  popStyle();
}

void showTmenu()
{
  pushStyle();
  
  int offY = height/18;
  int offCenter = height/12;
  
  textSize(abs(offY/2));
  textAlign(CENTER, CENTER);
  fill(0);
  text("DART APP", 0,offCenter,width,offY);
  text(" ------ *<-O->* ------", 0,offCenter+offY,width,offY);
  text(" ~ USE ARROWS TO CHANGE OPTIONS ~:", 0,offCenter+2*offY,width,offY);
  text("POINTS: " + INIT_SCORE, 0,offCenter+3*offY,width,offY);
  text("SETS  : " + NUM_SETS, 0,offCenter+4*offY,width,offY);
  text("LEGS  : " + NUM_LEGS, 0,offCenter+5*offY,width,offY);
  text("Checking out : " + str(CHECK_OUT), 0,offCenter+6*offY,width,offY);
  text("Doubling in  : " + str(DOUBLING_IN), 0,offCenter+7*offY,width,offY);
  text("Northern bust: " + str(NORTHERN_BUST), 0,offCenter+8*offY,width,offY);
  text("GAME MODE: " + MODE_NAMES[GAME_MODE], 0,offCenter+9*offY,width,offY);
  text(str(NAME_INDEX + 1) + " player name: " + IN_NAMES[NAME_INDEX], 0,offCenter+10*offY,width,offY);
  text("   ~ START ~   ", 0,offCenter+11*offY,width,offY);
  
  noFill();
  for (int i = 0; i < 9; i++)
  {
    if ( i == MENU_OPTION)
    {
      strokeWeight(3);
      stroke(255,0,0);
    } else
    {
      strokeWeight(1);
      stroke(0);
    }
      
    rect(0,offCenter+(i+3)*offY,width,offY);
  }
  
  popStyle();
}

void drawInterface()
{ 
  int wid = width/3, hei = height/4;
  int txtWid = wid/10, txtHei = hei/4;
  
   if(MATCH_END)
  {
    pushStyle();
    fill(0);
    rect(width/4, height/4,width/2,height/2); 
    int winner = (P_NUM + 1) % 2;
    
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    text(P_NAMES[winner] + " has won the game!!! \n    CONGRATULATIONS", width/4,height/4,width/2,height/2);
    popStyle();
  }
  
  pushStyle();
  pushMatrix();
  translate(width - wid, height - hei);
  
  fill(0);
  rect(0, 0, wid, hei);
  
  stroke(220);
  rect(0, 0, 5*txtWid, txtHei);
  rect(0, txtHei, 5*txtWid, txtHei);
  rect(0, 2*txtHei, 5*txtWid, txtHei);
  
  rect(5*txtWid, 0, 3*txtWid, txtHei);
  rect(5*txtWid, txtHei, 3*txtWid, txtHei);
  rect(5*txtWid, 2*txtHei, 3*txtWid, txtHei);
  
  rect(8*txtWid, 0, txtWid, txtHei);
  rect(8*txtWid, txtHei, txtWid, txtHei);
  rect(8*txtWid, 2*txtHei, txtWid, txtHei);
  
  rect(9*txtWid, 0, txtWid, txtHei);
  rect(9*txtWid, txtHei, txtWid, txtHei);
  rect(9*txtWid, 2*txtHei, txtWid, txtHei);
  
  fill(255);
  textSize(abs(txtHei/4));
  textAlign(CENTER, CENTER);
  
  text("Names: ", 0, 0, 5*txtWid, txtHei);
  text(P_NAMES[0], 0,  txtHei, 5*txtWid, txtHei);
  text(P_NAMES[1], 0, 2*txtHei, 5*txtWid, txtHei);
  
  text("Pts: ", 5*txtWid, 0, 3*txtWid, txtHei);
  text(str(P_SCORE[0]), 5*txtWid, txtHei, 3*txtWid, txtHei);
  text(str(P_SCORE[1]), 5*txtWid, 2*txtHei, 3*txtWid, txtHei);
  
  text("L:", 8*txtWid, 0, txtWid, txtHei);
  text(str(PL_SCORE[0]), 8*txtWid, txtHei, txtWid, txtHei);
  text(str(PL_SCORE[1]), 8*txtWid, 2*txtHei, txtWid, txtHei);
  
  text("S:", 9*txtWid, 0, txtWid, txtHei);
  text(str(PS_SCORE[0]), 9*txtWid, txtHei, txtWid, txtHei);
  text(str(PS_SCORE[1]), 9*txtWid, 2*txtHei, txtWid, txtHei);
 
  noFill();
  strokeWeight(3);
  stroke(255,0,0);
  translate(0, txtHei + P_NUM*txtHei);
  rect(0, 0, 5*txtWid, txtHei);
  rect(5*txtWid, 0, 3*txtWid, txtHei);
  rect(8*txtWid, 0, txtWid, txtHei); 
  rect(9*txtWid, 0, txtWid, txtHei);

  popMatrix();
  popStyle();
}

void drawBoard()
{
  pushMatrix();
  pushStyle();
  fill(0);
  stroke(0);
  strokeWeight(2);
  
  translate(cX, cY);
  ellipse(0, 0, brdD , brdD);
  fill(255);
  
  for(int i = 0; i < 20; i++)
  {
    pushMatrix();
    rotate(i*PI/10);
    
    if( i % 2 == 0)
      fill(255, 0, 0);
    else 
      fill(255);
      
    arc(0, 0, 2*outerR, 2*outerR, -PI/20, PI/20, PIE);
    
    if( i % 2 == 0)
      fill(255);
    else 
       fill(0, 0, 255);
       
    arc(0, 0, 2*outerR - 2*TDwidth, 2*outerR - 2*TDwidth, -PI/20, PI/20, PIE);
      
    if( i % 2 == 0)
      fill(255, 0, 0);
    else 
      fill(255);
      
    arc(0, 0, 2*innerR, 2*innerR, -PI/20, PI/20, PIE);
    
    if( i % 2 == 0)
      fill(255);
    else 
       fill(0, 0, 255);
       
    arc(0, 0, 2*innerR - 2*TDwidth, 2*innerR - 2*TDwidth, -PI/20, PI/20, PIE); 
    popMatrix();
    
    pushMatrix();
    pushStyle();
    fill(255);
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(3*TDwidth);
    text(NUMS[i], (outerR + 3*TDwidth)*cos(i*PI/10), (outerR + 3*TDwidth)*sin(i*PI/10), 4*TDwidth, 4*TDwidth);
    popStyle();
    popMatrix();
  }
  
  fill(0, 0, 255);
  ellipse(0,0,bullD, bullD);
  
  fill(255, 0, 0);
  ellipse(0,0,bullseyeD, bullseyeD);
 
  popStyle();
  popMatrix();
}

void resetAll()
{
  // INPUTS
  IN_NUM_S = 1;
  IN_NUM_L = 4;
  IN_IS_INDEX = 0;
  IN_NAME1 = "Mateusz";
  IN_NAME2 = "Kinga";
  MENU_OPTION = 0;
  NUM_PLAYERS = 2;
  NAME_INDEX = 0;
  IN_NAMES = new String[0];
  
  // CENTER
  cX = width/2;
  cY = height/3;
  
  // BOARD DIAMETERS AND STUFF
  // display values
  brdD = 451;
  bullD = 32;
  bullseyeD = 12.7;
  outerR = 170;
  innerR = 107;
  TDwidth = 8;
  
  // scaling factor
  scaleF = 1;
 
  // init_vals 
  INTERFACE_NUM = 0;
  SHOT_COUNTER = 0;
  
  INIT_SCORE = I_SCORES[0];
  NUM_SETS = IN_NUM_S;
  NUM_LEGS = IN_NUM_L;
  
  CHECK_OUT = false;
  DOUBLING_IN = false;
  NORTHERN_BUST = false;
  TIE_BRAEK = false;
  MATCH_END = false;
  TOURNAMENT = false;

  // SCORES
  P_NAMES = new String[2];
  P_NAMES[0] = IN_NAME1;
  P_NAMES[1] = IN_NAME2;
  
  P_SCORE = new int[2];
  P_SCORE[0] = INIT_SCORE;
  P_SCORE[1] = INIT_SCORE;
  PL_SCORE = new int[2];
  PL_SCORE[0] = 0;
  PL_SCORE[1] = 0;
  PS_SCORE = new int[2];
  PS_SCORE[0] = 0;
  PS_SCORE[1] = 0;
  P_NUM = 0;
}
