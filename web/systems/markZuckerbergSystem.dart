part of spacebook;


class MarkZuckerbergSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Intensity> intensityMapper;
  ComponentMapper<Health> healthMapper;

  TagManager tagManager;

  MarkZuckerbergSystem() : super(Aspect.getAspectForAllOf([Position, Velocity, Intensity, Health]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    intensityMapper = new ComponentMapper<Intensity>(Intensity, world);
    healthMapper = new ComponentMapper<Health>(Health, world);
  }

  void processEntity(Entity entity) {

    Entity zuck = tagManager.getEntity(TAG_ZUCKER);
    Position pos = positionMapper.get(zuck);
    Intensity i = intensityMapper.get(zuck);
    Health health = healthMapper.get(zuck);

    num t = ((new DateTime.now().millisecondsSinceEpoch*i.i1 % (2*math.PI)) - (math.PI/2));
    pos.x += i.i2*math.cos(t);
    pos.y += i.i2*math.sin(t)*math.cos(t);

    if (health.health <= 0) {
      var random = new math.Random();
      for (num cc = 0; cc < 50; cc++) {
        print("$cc");
        Entity e = world.createEntity();
        e.addComponent(new Species('money'));
        e.addComponent(new Position(20+random.nextInt(300), 20));
        e.addComponent(new Velocity(0, 10));
        e.addComponent(new Acceleration(0,0));
        e.addComponent(new Rotation(random.nextInt(360)));
        e.addComponent(new Sprite(money_image));
        e.addToWorld();
      }
      print('end');
    }
  }
}

