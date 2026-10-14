const WIDTH = 1000;
const HEIGHT = 1000;

let person;
let zombies = [];
let bullets = [];
let direction = [false, false, false, false];
let score = 0;

function setup() {
  const canvas = createCanvas(WIDTH, HEIGHT);
  canvas.parent("simulation");

  person = new Human();

  for (let i = 0; i < 3; i++) {
    zombies.push(new Bacteria());
  }
}

function draw() {
  background(255);

  // Move the player
  if (direction[0]) person.pos.y -= 5;
  if (direction[1]) person.pos.x -= 5;
  if (direction[2]) person.pos.y += 5;
  if (direction[3]) person.pos.x += 5;

  person.pos.x = constrain(person.pos.x, 10, WIDTH - 10);
  person.pos.y = constrain(person.pos.y, 10, HEIGHT - 10);

  // Update bacteria
  for (const zombie of zombies) {
    if (zombie.hp > 0) {
      zombie.move();
    }
    zombie.show();
  }

  // Update bullets and check hits
  for (let i = bullets.length - 1; i >= 0; i--) {
    const bullet = bullets[i];
    bullet.move();

    let hit = false;

    for (const zombie of zombies) {
      if (zombie.hp > 0 &&
          dist(
            bullet.pos.x, bullet.pos.y,
            zombie.pos.x, zombie.pos.y
          ) < 50) {
        zombie.hp--;
        hit = true;

        if (zombie.hp <= 0) {
          score++;
        }
        break;
      }
    }

    if (
      hit ||
      bullet.pos.x < 0 || bullet.pos.x > WIDTH ||
      bullet.pos.y < 0 || bullet.pos.y > HEIGHT
    ) {
      bullets.splice(i, 1);
    } else {
      bullet.show();
    }
  }

  person.show();

  // Interface
  noStroke();
  fill(25);
  textSize(24);
  textAlign(LEFT, TOP);
  text("Bacteria eliminated: " + score, 20, 20);
  textSize(16);
  text("WASD: Move  |  Click: Shoot", 20, 52);
}

class Human {
  constructor() {
    this.pos = createVector(WIDTH / 2, HEIGHT / 2);
  }

  show() {
    noStroke();
    fill(0);
    circle(this.pos.x, this.pos.y, 20);
  }
}

class Bacteria {
  constructor() {
    this.hp = 5;
    this.pos = createVector(
      random() < 0.5 ? 0 : WIDTH,
      random() < 0.5 ? 0 : HEIGHT
    );
    this.speed = 1.5;
  }

  move() {
    const target = person.pos.copy();
    const step = p5.Vector.sub(target, this.pos);

    if (step.mag() > 0) {
      step.setMag(this.speed);
      this.pos.add(step);
    }
  }

  show() {
    noStroke();

    if (this.hp > 0) {
      fill(115, 216, 60);
    } else {
      fill(190);
    }

    circle(this.pos.x, this.pos.y, 100);

    if (this.hp > 0) {
      fill(30);
      textAlign(CENTER, CENTER);
      textSize(18);
      text(this.hp, this.pos.x, this.pos.y);
    }
  }
}

class Bullet {
  constructor() {
    this.pos = person.pos.copy();

    const target = createVector(mouseX, mouseY);
    this.vel = p5.Vector.sub(target, this.pos);

    if (this.vel.mag() > 0) {
      this.vel.setMag(16);
    }
  }

  move() {
    this.pos.add(this.vel);
  }

  show() {
    push();
    translate(this.pos.x, this.pos.y);
    rotate(this.vel.heading());
    noStroke();
    fill(255, 200, 0);
    rect(0, 0, 10, 5);
    pop();
  }
}

function mousePressed() {
  if (
    mouseX >= 0 && mouseX <= WIDTH &&
    mouseY >= 0 && mouseY <= HEIGHT
  ) {
    bullets.push(new Bullet());
  }
}

function keyPressed() {
  if (key === "w" || key === "W") direction[0] = true;
  if (key === "a" || key === "A") direction[1] = true;
  if (key === "s" || key === "S") direction[2] = true;
  if (key === "d" || key === "D") direction[3] = true;

  // Prevent arrow keys and space from scrolling the page
  if ([" ", "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(key)) {
    return false;
  }
}

function keyReleased() {
  if (key === "w" || key === "W") direction[0] = false;
  if (key === "a" || key === "A") direction[1] = false;
  if (key === "s" || key === "S") direction[2] = false;
  if (key === "d" || key === "D") direction[3] = false;
}
