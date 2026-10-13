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
   update();
 } 
 
 void update(){
   if(direction[0]) person.pos.y-=5;
   if(direction[1]) person.pos.x-=5;
   if(direction[2]) person.pos.y+=5;
   if(direction[3]) person.pos.x+=5;
   person.show();
   for(int i=zombie.length-1;i>=0;i--){
     if(zombie[i].hp<=0){
       zombie[i].show();
     } else{
       zombie[i].move();
     }
   }
   for(int i=bullets.size()-1;i>=0;i--){
     if(bullets.get(i).isOutOfBounds()){
       bullets.remove(i);
     } else{
       bullets.get(i).fire();
     }
   }
 }
 
 class Bacteria{     
   PVector pos,target;
   float speed = 16;
   int hp = 5;
   Bacteria(){
     pos=new PVector((int)(Math.random()*2)*Width,(int)(Math.random()*2)*Height);
   }
   void move() {
     target = new PVector(person.pos.x,person.pos.y);
     PVector step = pos.copy();
     if(pos.x<target.x){
       step.x+=(int)(Math.random()*(2*speed))-speed*0.75;
     } else if(pos.x>target.x){
       step.x-=(int)(Math.random()*(2*speed))-speed*0.75;
     }
     if(pos.y<target.y){
       step.y+=(int)(Math.random()*(2*speed))-speed*0.75;
     }else if(pos.y>target.y){
       step.y-=(int)(Math.random()*(2*speed))-speed*0.75;
     }
     pos.lerp(step,1.0);
     show();
   }
   void show(){
     if(hp<=10){
       fill(115, 216, 60);
     }
     ellipse(pos.x,pos.y,100,100);
   }
   boolean isDead(){
     return hp<=0;
   }
 }

 class Bullet{
   PVector pos,vel;
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
     rect(0,0,10,5);
     popMatrix();
   }
   boolean isOutOfBounds(){
     return pos.x<0||pos.y<0||pos.x>Width||pos.y>Height;
   }
 }
 
 class Human{
   PVector pos;
   Human(){
     pos = new PVector(0,0);
   }
   void show(){
     fill(0);
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
 
