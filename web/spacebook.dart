library spacebook;

import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:dartemis/dartemis.dart';

import 'screen.dart';
import 'systems/collisionSystem.dart';
import 'systems/movementSystem.dart';
import 'systems/renderSystem.dart';

World world;
Screen screen;

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
    Entity player = world.createEntity();
    player.addComponent(new Position(screen.width~/2, screen.height~/2));
    player.addComponent(new Velocity(0, 0));
    player.addComponent(new Acceleration(0, 5));
    player.addToWorld();

    world.addSystem(new MovementSystem());
    world.addSystem(new CollisionSystem());
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

