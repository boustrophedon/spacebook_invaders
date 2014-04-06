part of spacebook;


class MarkZuckerbergSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Intensity> intensityMapper;

  TagManager tagManager;

  MarkZuckerbergSystem() : super(Aspect.getAspectForAllOf([Position, Velocity, Intensity]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    intensityMapper = new ComponentMapper<Intensity>(Intensity, world);
  }

  void processEntity(Entity entity) {

    Entity zuck = tagManager.getEntity(TAG_ZUCKER);
    Position pos = positionMapper.get(zuck);
    Intensity i = intensityMapper.get(zuck);

    num t = ((new DateTime.now().millisecondsSinceEpoch*i.i1 % (2*math.PI)) - (math.PI/2));
    pos.x += i.i2*math.cos(t);
    pos.y += i.i2*math.sin(t)*math.cos(t);

  }
}

