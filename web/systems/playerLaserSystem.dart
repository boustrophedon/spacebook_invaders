part of spacebook;

num LASER_TIMEOUT = 250;

class PlayerLaserSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<PlayerLaser> laserMapper;

  num laserSpeed = 250; // somehow the player is faster than the laser even though laserSpeed > moveSpeed

  Screen screen;
  ImageElement fb = new ImageElement(src: 'assets/spacebook_invaders/facebook.png');
  PlayerLaserSystem() : super(Aspect.getAspectForAllOf([Position, PlayerLaser]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    laserMapper = new ComponentMapper<PlayerLaser>(PlayerLaser, world);
  }

  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    PlayerLaser laser = laserMapper.get(entity);

    laser.timeout += world.delta;
    if (laser.firing && (laser.timeout - LASER_TIMEOUT >= 0)) {
      laser.timeout = 0;
      fireLaser(entity, pos, laser);
      laser.firing = false;
    }
  }

  void fireLaser(Entity player, Position pos, PlayerLaser laser) {
    Entity pew = world.createEntity();
    pew.addComponent(new Species('laser'));
    pew.addComponent(new Position(pos.x+16, pos.y+20));
    pew.addComponent(new Velocity(0, -laserSpeed));
    pew.addComponent(new Acceleration(0, 0));
    pew.addComponent(new Sprite(fb));
    pew.addComponent(new Damage(laser.damage));
    pew.addComponent(new Rotation(0));
    pew.addToWorld();
  }
}
