 Bacteria[] zombie = new Bacteria[3];//declare bacteria variables here
 ArrayList<Bullet> bullets = new ArrayList<Bullet>();
 Human person = new Human();
 boolean[] direction = new boolean[4];
 int Width = 1000;
 int Height = 1000;
 void setup()   
 {
   size(1000,1000);
   person.pos.x=Width/2;
   person.pos.y=Height/2;
   for(int i=zombie.length-1;i>=0;i--){
     zombie[i] = new Bacteria();
   }
 }   
 
 void draw(){
   background(255);
   person.move();
   for(int i=bullets.size()-1;i>=0;i--){
     if(bullets.get(i).isOutOfBounds()){
       bullets.remove(i);
     } else{
       bullets.get(i).fire();
     }
   }
   for(int i=zombie.length-1;i>=0;i--){
     if(zombie[i].hp<=0){
       zombie[i].show();
     } else{
       zombie[i].move();
     }
   }
   for(int i=bullets.size()-1;i>=0;i--){
     boolean hit = false;
     Bullet b = bullets.get(i);
     for(int j=zombie.length-1;j>=0;j--){
       Bacteria z = zombie[j];
       if(bulletHit(b,z)){
         zombie[j].hp-=1;
       }
     }
     if(hit){
       bullets.remove(i);
     }
   }
 } 
 boolean bulletHit(Bullet b, Bacteria z){
   
 }

 class Bacteria{     
   PVector pos,target;
   float speed = 16;
   int hp = 5;
   int radius = 50;
   Bacteria(){
     pos=new PVector((int)(Math.random()*2)*Width,(int)(Math.random()*2)*Height);
   }
   void move() {
     target = new PVector(person.pos.x,person.pos.y);
     PVector step = new PVector(pos.x, pos.y);
     if(pos.x<target.x){
       step.x+=(int)(Math.random()*(2*speed))-speed*0.75;
     } else if(pos.x>target.x){
       step.x-=(int)(Math.random()*(2*speed))-speed*0.75;
     } else{
       step.x-=(int)(Math.random()*(2*speed))-speed;
     }
     if(pos.y<target.y){
       step.y+=(int)(Math.random()*(2*speed))-speed*0.75;
     }else if(pos.y>target.y){
       step.y-=(int)(Math.random()*(2*speed))-speed*0.75;
     } else{
       step.y-=(int)(Math.random()*(2*speed))-speed;
     }
     pos.x = step.x;
     pos.y = step.y;
     show();
   }
   void show(){
     if(hp<=10){
       fill(115, 216, 60);
     }
     pos.x = constrain(pos.x,radius,Width-radius);
     pos.y = constrain(pos.y,radius,Height-radius);
     ellipse(pos.x,pos.y,radius*2,radius*2);
   }
   boolean isDead(){
     return hp<=0;
   }
 }

 class Bullet{
   PVector pos,vel;
   PVector dimensions = new PVector(10,5);
   float angle;
   float speed=16.0;
   Bullet(){
     pos=new PVector(person.pos.x,person.pos.y);
     angle = atan2(mouseY-pos.y,mouseX-pos.x);
     vel = new PVector(cos(angle),sin(angle));
     vel.mult(speed);
   }
   void fire(){
     pos.add(vel);
     show();
   }
   void show(){
     pushMatrix();
     translate(pos.x,pos.y);
     rotate(angle);
     fill(255,255,0);
     rect(0,0,dimensions.x,dimensions.y);
     popMatrix();
   }
   boolean isOutOfBounds(){
     return pos.x<0||pos.y<0||pos.x>Width||pos.y>Height;
   }
 }
 
 class Human{
   PVector vel = new PVector(0,0);
   PVector pos;
   float acceleration = 0.5;
   float friction = 0.98;
   int maxSpeed = 15;
   Human(){
     pos = new PVector(0,0);
   }
   void move(){
     if(direction[0]) vel.y-=acceleration;
     if(direction[1]) vel.x-=acceleration;
     if(direction[2]) vel.y+=acceleration;
     if(direction[3]) vel.x+=acceleration;
     vel.limit(maxSpeed);
     vel.mult(friction);
     pos.add(vel);
     person.show();
   }
   void show(){
     fill(0);
     person.pos.x = constrain(person.pos.x,10,Width-10);
     person.pos.y = constrain(person.pos.y,10,Height-10);
     ellipse(pos.x,pos.y,20,20);
   }
 }
 
 void mousePressed(){
   bullets.add(new Bullet());
 }
 
 void keyPressed(){
   if(key=='w') direction[0]=true;
   if(key=='a') direction[1]=true;
   if(key=='s') direction[2]=true;
   if(key=='d') direction[3]=true;
 }
 
 void keyReleased(){
   if(key=='w') direction[0]=false;
   if(key=='a') direction[1]=false;
   if(key=='s') direction[2]=false;
   if(key=='d') direction[3]=false;
 }
 
