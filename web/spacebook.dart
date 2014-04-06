library spacebook;

import 'dart:async';
import 'dart:html';
import 'dart:math';

// import 'package:dartemis/dartemis.dart';
import "package:dartemis/dartemis_mirrors.dart";

@MirrorsUsed(targets: const [InputSystem, MovementSystem, BackgroundRenderSystem])

import "dart:mirrors";


part 'screen.dart';
part 'components.dart';
part 'systems/inputSystem.dart';
part 'systems/enemySpawnSystem.dart';
part 'systems/collisionSystem.dart';
part 'systems/movementSystem.dart';
part 'systems/playerLaserSystem.dart';
part 'systems/renderSystem.dart';

const String TAG_PLAYER = "player";

void main() {
  CanvasElement canvas = querySelector("#area");
  Spacebook spacebook = new Spacebook(canvas);
  Future.wait(spacebook.load_images()).then((e) => spacebook.start());
}

class Spacebook {
  Screen screen;
  World world;
  num lastTime;

  String player_facebook;
  ImageElement player_image;
  ImageElement zuck_image;

  Spacebook(CanvasElement canvas) {
    screen = new Screen(canvas);
    world = new World();
    lastTime = 0;
    
    player_facebook = 'hcstern'; // obviously fix this.
  }

  load_images() {
    player_image = new ImageElement(src: 'http://graph.facebook.com/$player_facebook/picture');
    zuck_image = new ImageElement(src: 'assets/spacebook_invaders/zuck.jpg');
    return [player_image.onLoad.first, zuck_image.onLoad.first]; 
  }
  void start() {
    Entity player = world.createEntity();
    player.addComponent(new Species('player'));
    player.addComponent(new Position(screen.width~/2, screen.height~/2));
    player.addComponent(new Velocity(0, 0));
    player.addComponent(new Acceleration(0, 0));
    player.addComponent(new PlayerLaser(5, false, 0)); 
    player.addComponent(new Sprite(player_image));
    player.addToWorld();
    TagManager tagManager = new TagManager();
    tagManager.register(player, TAG_PLAYER);
    world.addManager(tagManager);

    world.addSystem(new InputSystem(screen));
    world.addSystem(new EnemySpawnSystem(zuck_image));
    world.addSystem(new PlayerLaserSystem());
    world.addSystem(new MovementSystem());
    world.addSystem(new CollisionSystem(screen));
    world.addSystem(new BackgroundRenderSystem(screen));
    world.addSystem(new RenderSystem(screen));

    world.initialize();
    gameLoop(0);
  }

  void gameLoop(num time) {
    world.delta = (time - lastTime);
    lastTime = time;
    world.process();

    requestRedraw();
  }

  void requestRedraw() {
    window.requestAnimationFrame(gameLoop);
  }
}

