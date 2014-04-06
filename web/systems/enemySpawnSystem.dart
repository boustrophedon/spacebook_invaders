part of spacebook;

class EnemySpawnSystem extends VoidEntitySystem {
  ImageElement zuck_image;

  TagManager tagManager;

  EnemySpawnSystem(this.zuck_image);

  void initialize() {
    Entity enemy = world.createEntity();
    enemy.addComponent(new Species('enemy'));
    enemy.addComponent(new Position(200, 200));
    enemy.addComponent(new Velocity(0,0));
    enemy.addComponent(new Acceleration(0,0));
    enemy.addComponent(new Intensity(1, 1, 0));
    enemy.addComponent(new Sprite(zuck_image));
    enemy.addComponent(new Health(25));
    enemy.addComponent(new Rotation(0));
    enemy.addToWorld();

    tagManager.register(enemy, TAG_ZUCKER);

  }

  void processSystem() {
  }
}

