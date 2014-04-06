part of spacebook;

class Species extends Component {
  String name;
  Species(this.name);
}

class Position extends Component {
  // this is the center of the object
  num x, y;
  Position(this.x, this.y);
}

class Velocity extends Component {
  num x, y;
  Velocity(this.x, this.y);
}

class Acceleration extends Component {
  num x, y;
  Acceleration(this.x, this.y);
}

class PlayerLaser extends Component {
  num damage;
  bool firing;
  num timeout;
  PlayerLaser(this.damage, this.firing, this.timeout);
}

class Damage extends Component {
  num damage;
  Damage(this.damage);
}

class Sprite extends Component {
  ImageElement img;
  Sprite(this.img);
}

class Intensity extends Component {
  num i1, i2, i3;
  Intensity(this.i1, this.i2, this.i3);
}

class Rotation extends Component {
  num theta;
  Rotation(this.theta);
}

