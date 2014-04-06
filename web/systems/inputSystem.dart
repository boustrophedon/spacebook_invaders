part of spacebook;

class InputSystem extends IntervalEntitySystem {
  static const int UP = 87;
  static const int DOWN = 83;
  static const int LEFT = 65;
  static const int RIGHT = 68;

  bool moveUp = false;
  bool moveDown = false;
  bool moveLeft = false;
  bool moveRight = false;
  bool shoot = false;

  ComponentMapper<Velocity> velocityMapper;
  TagManager tagManager;

  Screen screen;

  InputSystem(this.screen) : super(20, Aspect.getAspectForAllOf([Velocity]));

  void initialize() {
    window.onKeyDown.listen(handleKeyDown);
    window.onKeyUp.listen(handleKeyUp);
    canvas.onMouseDown.listen(handleMouseDown);
    canvas.onMouseUp.listen(handleMouseUp);
  }

  void processEntities(Iterable<Entity> entities) {
    Entity player = tagManager.getEntity(TAG_PLAYER);
    Velocity velocity = velocityMapper.get(player);

    if (moveUp) {
      velocity.y -= 0.1;
    } else if (moveDown) {
      velocity.y += 0.1;
    }
    if (moveLeft) {
      velocity.x -= 0.1;
    } else if(moveRight) {
      velocity.x += 0.1;
    }
  }

  void handleKeyDown(KeyboardEvent e) {
    int keyCode = e.keyCode;
    if (keyCode == UP) {
      moveUp = true;
      moveDown = false;
    } else if (keyCode == DOWN) {
      moveUp = false;
      moveDown = true;
    } else if (keyCode == LEFT) {
      moveLeft = true;
      moveRight = false;
    } else if (keyCode == RIGHT) {
      moveLeft = false;
      moveRight = true;
    }
  }

  void handleKeyUp(KeyboardEvent e) {
    int keyCode = e.keyCode;
    if (keyCode == UP) {
      moveUp = false;
    } else if (keyCode == DOWN) {
      moveDown = false;
    } else if (keyCode == LEFT) {
      moveLeft = false;
    } else if (keyCode == RIGHT) {
      moveRight = false;
    }
  }

  void handleMouseDown(MouseEvent e) {
    shoot = true;
  }

  void handleMouseUp(MouseEvent e) {
    shoot = false;
  }
}

