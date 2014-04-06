part of spacebook;

class InputSystem extends IntervalEntitySystem {
  static const int UP = 38; //arrow up
  static const int DOWN = 40; // arrow down
  static const int LEFT = 37; // arrow left
  static const int RIGHT = 39; // arrow right

  bool moveUp = false;
  bool moveDown = false;
  bool moveLeft = false;
  bool moveRight = false;
  bool shoot = false;

  ComponentMapper<Velocity> velocityMapper;
  TagManager tagManager;

  CanvasElement canvas;

  InputSystem(Screen screen) : super(20, Aspect.getAspectForAllOf([Velocity])) {
    canvas = screen.canvas;
  }

  void initialize() {
    window.onKeyDown.listen(handleKeyDown);
    window.onKeyUp.listen(handleKeyUp);
    canvas.onMouseDown.listen(handleMouseDown);
    canvas.onMouseUp.listen(handleMouseUp);
  }

  void processEntities(Iterable<Entity> entities) {
    Entity player = tagManager.getEntity(TAG_PLAYER);
    Velocity velocity = velocityMapper.get(player);

    num moveSpeed = 20;

    if (moveUp) {
      velocity.y = -moveSpeed*world.delta;
    } else if (moveDown) {
      velocity.y = moveSpeed*world.delta;
    }
      else {
      velocity.y = 0;
    }
    if (moveLeft) {
      velocity.x = -moveSpeed*world.delta;
    } else if(moveRight) {
      velocity.x = moveSpeed*world.delta;
    } else {
      velocity.x = 0;
    }
  }

  void handleKeyDown(KeyboardEvent e) {
    int keyCode = e.keyCode;
    if (keyCode == UP) {
      moveUp = true;
    } else if (keyCode == DOWN) {
      moveDown = true;
    } else if (keyCode == LEFT) {
      moveLeft = true;
    } else if (keyCode == RIGHT) {
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

