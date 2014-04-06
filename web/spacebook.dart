library spacebook;

import 'dart:async';
import 'dart:html';
import 'dart:math';

// import 'package:dartemis/dartemis.dart';
import "package:dartemis/dartemis_mirrors.dart";

part 'screen.dart';
part 'components.dart';
part 'systems/inputSystem.dart';
part 'systems/collisionSystem.dart';
part 'systems/movementSystem.dart';
part 'systems/renderSystem.dart';

const String TAG_PLAYER = "player";

void main() {
  CanvasElement canvas = querySelector("#area");
  Spacebook spacebook = new Spacebook(canvas);
  spacebook.start();
}

class Spacebook {
  Screen screen;
  World world;
  num lastTime;

  Spacebook(CanvasElement canvas) {
    screen = new Screen(canvas);
    world = new World();
    lastTime = 0;
  }

  void start() {
    Entity player = world.createEntity();
    player.addComponent(new Position(screen.width~/2, screen.height~/2));
    player.addComponent(new Velocity(0, 1));
    player.addComponent(new Acceleration(0, 0));
    player.addComponent(new Color(255, 0, 0));
    player.addComponent(new Sprite());
    player.addToWorld();
    TagManager tagManager = new TagManager();
    tagManager.register(player, TAG_PLAYER);
    world.addManager(tagManager);

    world.addSystem(new InputSystem(screen));
    world.addSystem(new MovementSystem());
    world.addSystem(new CollisionSystem(screen));
    world.addSystem(new BackgroundRenderSystem(screen));
    world.addSystem(new RenderSystem(screen));

    world.initialize();
    gameLoop(0);
  }

  void gameLoop(num time) {
    world.delta = time - lastTime;
    lastTime = time;
    world.process();

    requestRedraw();
  }

  void requestRedraw() {
    window.requestAnimationFrame(gameLoop);
  }
}

