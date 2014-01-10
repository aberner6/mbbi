
void setup(){
size (640,360);
smooth();
drawlines();

}

void draw(){
}

void drawlines(){
for (int i = 0; i< width/10; i++){
line(i*10, height/8, i*10+width/30, height/7);

line(i*10, height/6, i*10+width/30, height/7);

stroke(0);
strokeWeight(1);
}
}

