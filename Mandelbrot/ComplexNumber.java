public class ComplexNumber {
  private double real, imagine;
  ComplexNumber(){
    real = 0;
    imagine = 0;
  }
  ComplexNumber(double real1, double imagine1){
    real = real1;
    imagine = imagine1;
  }
  ComplexNumber(ComplexNumber num){
    this(num.getReal(), num.getImagine());
  }
  public static ComplexNumber newInstance(ComplexNumber num) {
  return new ComplexNumber(num.getReal(), num.getImagine());
  }
  public ComplexNumber add(ComplexNumber num){
  ComplexNumber num1 = new ComplexNumber(real+num.getReal(),imagine +num.getImagine());
  return num1;  
  }
  public ComplexNumber subtract(ComplexNumber num) {
    ComplexNumber num1 = new ComplexNumber(real-num.getReal(),imagine -num.getImagine());
    return num1;  
  }
  public ComplexNumber multiply(ComplexNumber num){
    ComplexNumber num1 = new ComplexNumber(num.getReal()*real-imagine*num.getImagine(), real*num.getImagine() + num.getReal()*imagine);
    return num1;
  }
  public ComplexNumber divide(ComplexNumber num) throws ArithmeticException{
    if(num.getReal() == 0 && num.getImagine() == 0){ throw new ArithmeticException("No division by zero");}
    ComplexNumber num1 = this.multiply(num.conjugate());
    return num1;  
  }
  public ComplexNumber pow(int pow){
    ComplexNumber here = this;
    for (int i = 0; i < pow-1; i++){
      here = this.multiply(here);
    }
    return here;
  }
  public double getReal(){return real;}
  public double getImagine(){return imagine;}
  public void setReal(double real1){real = real1;}
  public void setImagine(double imagine1){imagine = imagine1;}
  public void setVale(double real1 , double imagine1){real = real1; imagine = imagine1;}
  private ComplexNumber conjugate(){
  ComplexNumber num = new ComplexNumber(real,imagine *-1);
  return num;
  }
  
  public double magnitude(){
    return Math.sqrt(Math.pow(real,2)+Math.pow(imagine,2));
  }
  public String toString(){return (real+", "+imagine+"i");}
  public int compareTo(ComplexNumber num){
    if(real == num.getReal() && imagine == num.getImagine()){
    return 0;}
    else if (this.magnitude() < num.magnitude()) {
    return -1;
    }
    else
    {return 1;}
  }
  
}