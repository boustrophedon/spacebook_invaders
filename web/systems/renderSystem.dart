library spacebook;

import 'package:dartemis/dartemis.dart';

class RenderSystem extends EntityProcessingSystem {
  ComponentMapper<Sprite> spriteMapper;

  CanvasRenderingContext2D context;

  CircleRenderingSystem(this.context);

  void initialize() {
    spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    screen = world.screen;
  }
  
  void processEntity(Entity entity) {
    // render things. render all the things!!!!
  }
}
