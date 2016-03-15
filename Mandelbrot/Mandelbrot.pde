/* Author: Nicholas Mullikin
 Project: Mandelbrot / Julia set generator
 Date: 2/19/16
 Features: First generates a mandelbrot set, then switches over to juila set.
 To switch back between mandelbrot and julia, hit the space bar and then click again to generate another set.
 */
String s;
int[][] colorArray = new int [600][30];
String currentJuliaset = "";
void setup() {
  size(800,600);
  background(255);
  colorMode(HSB);
  mandelbrot(-2, 2, -1.5, 1.5);
  //getPic();
}
void draw() {
  textSize(12);
  if (zoom == 0)
  {
    s = map(mouseX, 0, width, -2, 2) / (zoom+1) + ", " + map(mouseY, 0, height, -1.5, 1.5)/ (zoom+1)+"i";
    //text(map(mouseX, 0, width, -2, 2) / (zoom+1) + " " + map(mouseY, 0, height, -1.5, 1.5)/ (zoom+1),5 , 10);
  } else {
    s = map(mouseX, 0, width, (mousePosX-startHeight/(zoom)), ( mousePosX+startHeight/(zoom)))+ ", "+ map(mouseY, 0, height, (mousePosY-startWidth/(zoom)), (mousePosY+startWidth/(zoom)))+"i";
    //text ( map(mouseX, 0, width, (mousePosX-startHeight/(zoom)), ( mousePosX+startHeight/(zoom)))+ " "+ map(mouseY, 0, height, (mousePosY-startWidth/(zoom)), (mousePosY+startWidth/(zoom))),5,10);
  } 
  fill(255);

  //rect(0, 0, 500, 20);
  fill(0);
  setPic();
  text(s, 5, 10);

  if (number != 1){
  textSize(12);
  text(currentJuliaset, 5, 20);
  textSize(24);
  text("Julia Set", 350, 20);}
  else{
      textSize(24);
  text("Mandelbrot Set", 350, 20);
    
  }
}
int number = 1;
double zoom = 0;
double startHeight = 2/2;
double startWidth = 1.5/2;
double mousePosX, mousePosY;
void mouseClicked() {
  if (mouseButton == LEFT) {
    if (zoom == 0)
    {
      mousePosX = map(mouseX, 0, width, -2, 2) / (zoom+1);
      mousePosY = map(mouseY, 0, height, -1.5, 1.5)/ (zoom+1);
      zoom++;
    } else {
      //zoom--;

      mousePosX = map(mouseX, 0, width, (mousePosX-startHeight/(zoom)), ( mousePosX+startHeight/(zoom))) ;
      mousePosY = map(mouseY, 0, height, (mousePosY-startWidth/(zoom)), (mousePosY+startWidth/(zoom)));
      zoom*=1.2;
    }
  } else if (mouseButton == RIGHT) {
    if (zoom == 0)
    {

      mousePosX = map(mouseX, 0, width, -2, 2) / (zoom+1);
      mousePosY = map(mouseY, 0, height, -1.5, 1.5)/ (zoom+1);
      zoom++;
    } else {
      //zoom++;
      zoom*= 1/1.2;

      mousePosX = map(mouseX, 0, width, (mousePosX-startHeight/(zoom)), ( mousePosX+startHeight/(zoom))) ;
      mousePosY = map(mouseY, 0, height, (mousePosY-startWidth/(zoom)), (mousePosY+startWidth/(zoom)));
    }
  }
  zoom = (double)Math.round(zoom * 100000d) / 100000d;
  //println((mousePosX-startHeight/zoom)+ " "+(mousePosX+startHeight/zoom)+ " "+(mousePosY-startWidth/zoom)+ " "+ (mousePosY+startWidth/zoom));
  println((mousePosX-startHeight/zoom)+ " "+(mousePosX+startHeight/zoom)+ " "+(mousePosY-startWidth/zoom)+ " "+ (mousePosY+startWidth/zoom));

  println(zoom);
  mandelbrot(mousePosX-startHeight/zoom, mousePosX+startHeight/zoom, mousePosY-startWidth/zoom, mousePosY+startWidth/zoom );
}
/*
*Mandelbrot function
 * @params xmin the lowest width value generated
 * @params xmax the highest width value generated
 * @params ymin the lowest height value generated
 * @params ymax the highest height value generated
 * @returns
 */
void mandelbrot(double xmin, double xmax, double ymin, double ymax) {
  if (zoom == 1) {
    number = -1;
  }
  long timer =millis();
  double dx = (xmax - xmin) / (width);
  double dy = (ymax - ymin) / (height);
  double y = ymin;
  loadPixels();
  for (int j = 0; j < height; j++) {
    double x = xmin;
    for (int i = 0; i < width; i++) {
      int num;
      if (number== 1) {
        num =  man(new ComplexNumber(0, 0), new ComplexNumber(x, y), 0);
      } else {
        num =  man(new ComplexNumber(x, y), new ComplexNumber((xmax+xmin)/2, (ymax+ymin)/2) , 0);
        // if(num == 0){num = (int)(random(0,10));}
      }


      if (num == -1)
      {
        pixels[i+j*width] = color(0, 0, 0);
      } else {
        pixels[i+j*width] = color(num*10%255, 255, 255);
      }
      x += dx;
    }
    y += dy;
  }
  updatePixels();
  //println(millis()-timer);
  if (number != 1)
  {
    
    currentJuliaset = (xmax+xmin)/2 +", " + (ymax+ymin)/2+ "i ";
  }
  getPic();
}

/*
*@params z a ComplexNumber 
 *@params c a ComplexNumber 
 *@params iter the iteration 
 */

int man(ComplexNumber z, ComplexNumber c, int iter) {
  double zr = z.getReal();
  double zi = z.getImagine();
  double cr = c.getReal();
  double ci = c.getImagine();
  if ( (((zr*zr-zi*zi+cr)*(zr*zr-zi*zi+cr)+(2*(zr*zi)+ci)*(2*(zr*zi)+ci)))>= 4 ) {
    return iter;
  } else if (iter >=255) { 
    return -1;
  } else { 
    return man(new ComplexNumber(zr*zr-zi*zi+cr, 2*(zr*zi)+ci), new ComplexNumber(cr, ci), iter+1);
  }
}


void keyPressed() {
  if (key == ' ') {
    number*=-1;
    setPic();
  }
}
/*
Map Function that uses doubles instead of floats
 */
static public double map(double value, 
  double istart, 
  double istop, 
  double ostart, 
  double ostop) {
  return ostart + (ostop - ostart) * ((value - istart) / (istop - istart));
}
void getPic(){  
for (int i = 0; i < 600; i ++)
  {
    for (int j = 0; j < 30; j++)
    {
      colorArray[i][j] = get(i,j);
    }
  }
}

void setPic(){
for (int i = 0; i < 600; i ++)
  {
    for (int j = 0; j < 30; j++)
    {
      set(i,j,colorArray[i][j]);
    }
  }
}
  
  