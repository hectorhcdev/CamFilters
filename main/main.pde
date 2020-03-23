import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.imgproc.Imgproc;
import java.lang.*;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;
Capture cam;
CVImage prin,img,auximg,pimg;
CascadeClassifier face,leye,reye;
PImage casco;
String faceFile, leyeFile,reyeFile;
boolean [] filter;
void setup() {
    size(1280, 480);
  //Cámara
  cam = new Capture(this, width/2 , height);
  cam.start(); 
  casco= loadImage("casco.png");
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  prin= new CVImage(cam.width,cam.height);
  auximg=new CVImage(cam.width, cam.height);
  pimg= new CVImage(cam.width,cam.height);
  filter= new boolean [3];
  filter[0]=true;
  
  //Detectores
  faceFile = "haarcascade_frontalface_default.xml";
  leyeFile = "haarcascade_mcs_lefteye.xml";
  reyeFile = "haarcascade_mcs_righteye.xml";
  face = new CascadeClassifier(dataPath(faceFile));
  leye = new CascadeClassifier(dataPath(leyeFile));
  reye = new CascadeClassifier(dataPath(reyeFile));
}

void draw() { 
  prin.copy(cam, 0, 0, cam.width, cam.height,0, 0, prin.width, prin.height);  
  prin.copyTo();
  
  if(filter[0]){
    dibujo();
  }else if(filter[1]){
    
    mascara();
  }
  //mascara();
  image(prin,0,0);
    color(0,0,255);
    stroke(3);
    textSize(20);
    text("Cámara sin filtros",10,30);
    textSize(14);
    text("Filtro dibujo: 1",10,height-70);
    text("Filtro máscara: 2",10,height-40);
    
}

void dibujo(){
   if (cam.available()) {
    background(0);
      cam.read();
      img.copy(cam, 0, 0, cam.width, cam.height,0, 0, img.width, img.height);
    
      img.copyTo();
      Mat gris = img.getGrey();
      Mat mask= new Mat();
      int ddepth = CvType.CV_16S;
      Mat grad_x = new Mat();
      Mat grad_y = new Mat();
      Mat abs_grad_x = new Mat();
      Mat abs_grad_y = new Mat();
      Mat colors= img.getBGR();
      Mat pgris = img.getGrey();
      Mat mask2 = new Mat();

      Imgproc.Canny(pgris,pgris,25,70,3);

      Imgproc.cvtColor(pgris,mask2,8);

      Imgproc.Sobel(gris, grad_x, ddepth, 1, 0);
      Core.convertScaleAbs(grad_x, abs_grad_x);

      Imgproc.Sobel(gris, grad_y, ddepth, 0, 1);
      Core.convertScaleAbs(grad_y, abs_grad_y);

      Core.addWeighted(abs_grad_x, 0.8, abs_grad_y, 0.8, 0, gris);

      Imgproc.cvtColor(gris,mask,8);

      Core.subtract(colors,mask,mask);
      Core.subtract(mask,mask2,mask);
      auximg.copyTo(mask);
    
      
      image(auximg,width/2,0);
      
      pimg.copy(img, 0, 0, img.width, img.height, 
      0, 0, img.width, img.height);
      pimg.copyTo();
      gris.release();
      color(0,0,255);
      stroke(3);
      textSize(20);
      text("Cámara con filtro:dibujo",(width/2) + 10,30);
   }
}

void mascara(){
    if (cam.available()) {
    background(0);
    cam.read();
    
    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    
    //Imagen de grises
    Mat gris = img.getGrey();
    
    //Imagen de entrada
    image(img,width/2,0);
    
    //Detección y pintado de contenedores
    FaceDetect(gris);
    
    gris.release();
    stroke(3);
    textSize(20);
    text("Cámara con filtro:máscara",(width/2) + 10,30);
  }
}

void FaceDetect(Mat grey)
{
  Mat auxroi;
  casco= loadImage("casco.png");
  //Detección de rostros
  MatOfRect faces = new MatOfRect();
  face.detectMultiScale(grey, faces, 1.15, 3, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(60, 60), new Size(200, 200));
  Rect [] facesArr = faces.toArray();
  
   //Dibuja contenedores
  noFill();
  stroke(255,0,0);
  strokeWeight(4);
  int i=0;
  for (Rect r : facesArr) {    
    casco.resize(r.width*2+40, r.height*2+40);
    image(casco,r.x+width/2-r.width/2-20, r.y-r.height/2-20);
    i++;
    text("GAKLGAS"+i,r.x,r.y);
   }
  faces.release();
}

void keyPressed(){
  if(key=='1'){
    //println("eooo");
    for(int i =0; i< filter.length;i++){
      filter[i]=false;
    }
    filter[0]=true;
  }
  
  if(key=='2'){
    for(int i =0; i< filter.length;i++){
      filter[i]=false;
    }
    filter[1]=true;
  }
  
  
}
