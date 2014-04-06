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
  ComponentMapper<Color> colorMapper;

  Screen screen;
  CanvasRenderingContext2D context;

  RenderSystem(this.screen) : super(Aspect.getAspectForAllOf([Position, Sprite, Color]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    colorMapper = new ComponentMapper<Color>(Color, world);
    context = screen.canvas.context2D;
  }
  
  void processEntity(Entity entity) {
    Color color = colorMapper.get(entity);
    context.setFillColorRgb(color.r, color.g, color.b);

    Position pos = positionMapper.get(entity);
    num xpos = pos.x-20;
    num ypos = pos.y-20;

    context.fillRect(xpos, ypos, 40, 40);

  }
}
