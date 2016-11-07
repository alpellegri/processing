float h = 0.1; //<>//
float x;
float y;
float[] yv;
int step;

float y_eul;
float y_heun;
float y_rk4;
float[] yv_eul;
float[] yv_heun;
float[] yv_rk4;

float ee;
float eh;
float erk;

ODE_Vect ode_vect;
ODE ode;

void setup() {
  size(550,450);
  background(0);

  stroke(255);
  line(0, height/2, width, height/2);

  x = 0;
  y = 1;
  yv = new float[] {1,1};
  y_eul = y;
  y_heun = y;
  y_rk4 = y;
  yv_eul = yv.clone();
  yv_heun = yv.clone();
  yv_rk4 = yv.clone();
  step = 0;

  ode_vect = new ODE_Vect();
  ode = new ODE();
}

void draw() {

  noStroke();

  y_eul = ode.eul(x, y_eul, h);
  yv_eul = ode_vect.eul(x, yv_eul, h);
  y_heun = ode.heun(x, y_heun, h);
  yv_heun = ode_vect.heun(x, yv_heun, h);
  y_rk4 = ode.rk4(x, y_rk4, h);
  yv_rk4 = ode_vect.rk4(x, yv_rk4, h);

  x += h;

  // y′ = x + 2y
  // y = 0.25*exp(2*x) - 0.5*x - 0.25;
  // y = x*x/2;
  y = exp(x);
  yv[0] = y;
  yv[1] = y;

  ee = yv_eul[0]-y;
  eh = yv_heun[0]-y;
  erk = yv_rk4[0]-y;
  //print("x: " + x + " y: " + y + " e: " + ee + " h: " + eh + " rk: " + erk + "\n");

  stroke(255);
  point(step, height/2-ee);
  stroke(255,0,0); //<>//
  point(step, height/2-eh);
  stroke(0,255,0);
  point(step, height/2-erk);

  step++;
}