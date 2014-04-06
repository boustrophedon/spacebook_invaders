part of spacebook;

class BackgroundRenderSystem extends VoidEntitySystem {

  Screen screen;
  CanvasRenderingContext2D context;

  BackgroundRenderSystem(this.screen);

  void initialize() {
    context = screen.canvas.context2D;
  }

  void processSystem() {
    context.save();
    try {
      context.fillStyle = "black";

      context.beginPath();
      context.rect(0, 0, screen.width, screen.height);
      context.closePath();

      context.fill();
    } finally {
      context.restore();
    }
  }
}


class RenderSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Sprite> spriteMapper;
  ComponentMapper<Rotation> rotationMapper;

  Screen screen;
  CanvasRenderingContext2D context;

  RenderSystem(this.screen) : super(Aspect.getAspectForAllOf([Position, Sprite, Rotation]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    rotationMapper = new ComponentMapper<Rotation>(Rotation, world);
    context = screen.canvas.context2D;
  }
  
  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    Sprite sprite = spriteMapper.get(entity);
    Rotation rotation = rotationMapper.get(entity);
    num xpos = pos.x-sprite.img.width/2;
    num ypos = pos.y-sprite.img.height/2;

    CanvasElement cv = new CanvasElement();
    cv.width = sprite.img.width;
    cv.height = sprite.img.height;
    CanvasRenderingContext2D cxt = cv.getContext('2d');
    cxt.rotate(rotation.theta * (math.PI/180));
    cxt.translate(cv.width/2, cv.height/2);
    cxt.drawImage(sprite.img, 0, 0);

    //print("rotation = ${rotation.theta}");

    context.drawImage(cv, xpos, ypos);
  }
}

