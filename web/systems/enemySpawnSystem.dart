part of spacebook;

class EnemySpawnSystem extends VoidEntitySystem {
  ImageElement zuck_image;

  EnemySpawnSystem(this.zuck_image);

  void initialize() {
    Entity enemy = world.createEntity();
    enemy.addComponent(new Species('enemy'));
    enemy.addComponent(new Position(200, 200));
    enemy.addComponent(new Velocity(0,0));
    enemy.addComponent(new Acceleration(0,0));
    //enemy.addComponent(new MobLaser());
    enemy.addComponent(new Sprite(zuck_image));
    enemy.addToWorld();
  }

  void processSystem() {
  }
}

