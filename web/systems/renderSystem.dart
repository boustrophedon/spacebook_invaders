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

  Screen screen;
  CanvasRenderingContext2D context;

  RenderSystem(this.screen) : super(Aspect.getAspectForAllOf([Position, Sprite]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    context = screen.canvas.context2D;
  }
  
  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    Sprite sprite = spriteMapper.get(entity);
    num xpos = pos.x-20;
    num ypos = pos.y-20;

    context.drawImage(sprite.img, xpos, ypos);

  }
}
