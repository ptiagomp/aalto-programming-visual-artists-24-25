void setup() {
  int num1 = 10;  // First number
  int num2 = 3;   // Second number

  int sum = num1 + num2;
  int difference = num1 - num2;
  int product = num1 * num2;
  float quotient = (float) num1 / num2;  // Casting to float to get decimal division result
  int remainder = num1 % num2;

  println("The sum of " + num1 + " and " + num2 + " is: " + sum);
  println("The difference of " + num1 + " and " + num2 + " is: " + difference);
  println("The product of " + num1 + " and " + num2 + " is: " + product);
  println("The quotient of " + num1 + " divided by " + num2 + " is: " + nf(quotient,0,2));
  println("The remainder of " + num1 + " divided by " + num2 + " is: " + remainder);
}