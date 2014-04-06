import 'package:dartemis/dartemis.dart';

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

class Color extends Component {
  num r, g, b;
  Color(this.r, this.g, this.b);
}

class Sprite extends Component {
  ImageElement sprite;
  Sprite(this.sprite);
}
