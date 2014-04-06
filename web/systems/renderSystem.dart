library spacebook;

import 'package:dartemis/dartemis.dart';

class BackgroundRenderSystem extends VoidEntitySystem {
  CanvasRenderingContext2D context;

  BackgroundRenderSystem(this.screen);

  void initialize() {
    context = screen.context2D;
  }

  void processSystem() {
    context.save();
    try {
      context.fillStyle = "black";

      context.beginPath();
      context.rect(0, 0, MAXWIDTH, MAXHEIGHT + HUDHEIGHT);
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

  RenderSystem(this.screen);

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    colorMapper = new ComponentMapper<Color>(Color, world);
    context = screen.context2D;
  }
  
  void processEntity(Entity entity) {
    Color color = colorMapper.get(entity);
    context.setFillColorRgb(color.r, color.g, color.b);

    Position pos = positionMapper.getComponent(entity);
    num xpos = pos.x-20; // 40x40 rectangles. XXX FIX ME WITH SPRITES OR SOMETHING
    num ypos = pos.y-20;

    context.fillRect(xpos, ypos, xpos+40, ypos+40);

  }
}
