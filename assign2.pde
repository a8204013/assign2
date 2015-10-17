PImage bg1, bg2, enemy, fighter, hp, treasure, end1, end2, start1, start2;
int x,enemyX,enemyY,tx,ty,y,b1,b2,t,Blood;
final int GAME_START=1, GAME_RUN=2, GAME_LOSE=3;
int gameState;
float speed = 8;
boolean upPressed = false, downPressed = false, 
        leftPressed = false, rightPressed = false;

void setup () {
  size(640,480) ;  // must use this size.
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  Blood=200;
  //me
  x=580;y=250;
  //background2
  b2=-640;
  //treasure
  tx=floor(random(600));
  ty=floor(random(440));
  //START
  gameState = GAME_START;
  
}

void draw() {
  switch(gameState){
    case GAME_START:
    image(start2,0,0);
    if(mouseY > 380&&mouseY < 410&& mouseX < 450&& mouseX > 200){
      if(mousePressed){
        gameState = GAME_RUN;
      }else{
        image(start1,0,0);
      }
    }
    break;
    case GAME_RUN:
      //background
      b1=run(b1);
      b2=run(b2);
      image(bg1,b1,0);
      image(bg2,b2,0);
      //self
      if((x<=enemyX+55&x>=enemyX-45)&(y<=enemyY+55&y>=enemyY-45)){//Touch enemy
        Blood-=40;
        if(Blood<=0){
          gameState = GAME_LOSE;
        }
        enemyX=0;
        enemyY=floor(random(480));
      }
      if((x<=tx+50&x>=tx-45)&(y<=ty+45&y>=ty-50)){//Touch treasure
        if(Blood<200){
        Blood+=20;
        }
        tx=floor(random(600));
        ty=floor(random(440));
      }
      if (upPressed&y>5){//Control self
        y -= speed;
      }
      if (downPressed&y<430){
        y += speed;
      }
      if (leftPressed&x>0){
        x -= speed;
      }
      if (rightPressed&x<590){
        x += speed;
      }
      image(fighter,x,y);
      //enemy
      enemyX+=5;//enemy speed
      enemyX%=640;
      if(enemyX==0){
        enemyY=floor(random(480));
      }
      if(enemyY>y+5||enemyY<y-5){
        if(enemyY<y){
          if(y-enemyY>100){
            enemyY+=5;
          }
          else
          enemyY+=2;
        }
        else{
          if(enemyY-y>100){
            enemyY-=5;
          }
          else
          enemyY-=2;
        }
      }
      image(enemy,enemyX,enemyY);
      //treasure
      image(treasure,tx,ty);
      //hp
      fill(255,0,0);
      rect(30,30,Blood,20);//Blood
      image(hp,22,28);
    break;
    case GAME_LOSE:
       image(end2,0,0);
        if(mouseY > 310&&mouseY < 345&& mouseX < 430&& mouseX > 210){
          if(mousePressed){
            Blood=200;
            x=580;y=250;
            gameState = GAME_RUN;
          }else{
            image(end1,0,0);
          }
        }
    break;
  }
}

void keyPressed(){
 if(key == CODED){
   switch (keyCode){
     case UP:
     upPressed = true;
     break;
      case DOWN:
     downPressed = true;
     break;
      case LEFT:
     leftPressed = true;
     break;
      case RIGHT:
     rightPressed = true;
     break;
     
   }
 }
}

void keyReleased(){
 if(key == CODED){
   switch (keyCode){
     case UP:
     upPressed = false;
     break;
      case DOWN:
     downPressed = false;
     break;
      case LEFT:
     leftPressed = false;
     break;
      case RIGHT:
     rightPressed = false;
     break;
     
   }
 }
}

public static int run(int bgLct){//Background Location
  bgLct++;
  if(bgLct==640)
  {
  bgLct=-640;
  }
  return bgLct;
}
