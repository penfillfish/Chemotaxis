 Bacteria[] zombie = new Bacteria[3];//declare bacteria variables here
 Human person = new Human();
 boolean[] direction = new boolean[4];
 void setup()   
 {
   size(1000,1000);
   person.x=width/2;
   person.y=height/2;
   for(int i=zombie.length-1;i>=0;i--){
     zombie[i] = new Bacteria();
     zombie[i].show();
   }
 }   
 
 void draw(){
   background(255);
   update();
 } 
 
 void update(){
   if(direction[0]) person.y-=5;
   if(direction[1]) person.x-=5;
   if(direction[2]) person.y+=5;
   if(direction[3]) person.x+=5;
   person.show();
   for(int i=zombie.length-1;i>=0;i--){
     zombie[i].move();
     zombie[i].show();
   }
 }
 
 class Bacteria{     
   PVector pos,step,target;
   float speed = 3.0;
   Bacteria(){
     pos=new PVector((int)(Math.random()*2)*width,(int)(Math.random()*2)*height);
   }
   void move() {
     step = new PVector();
     target = new PVector(person.x,person.y);
     if(Math.random()>0.8){
       step = PVector.sub(target, pos);
     }else{
       
     }
     step.normalize();
     step.mult(speed);
     pos.add(step);
   }
   void show(){
     fill(115, 216, 60);
     ellipse(pos.x,pos.y,100,100);
   }
 }
 
 class Bullet{
   int x,y;
   Bullet(){
     
   }
   void draw(){
     
   }
   void show(){
     fill(255,255,0);
     rect(x,y,10,5);
   }
 }
 
 class Human{
   int x,y;
   Human(){
     x=0;
     y=0;
   }
   void show(){
     fill(0);
     ellipse(x,y,20,20);
   }
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
