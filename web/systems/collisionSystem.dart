part of spacebook;

class CollisionSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Acceleration> accelerationMapper;

  CollisionSystem() : super(Aspect.getAspectForAllOf([Position, Velocity, Acceleration]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    accelerationMapper = new ComponentMapper<Acceleration>(Acceleration, world);
  }

  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    Velocity vel = velocityMapper.get(entity);
    Acceleration acc = accelerationMapper.get(entity);
    if (pos.x > screen.width) {
      pos.x = screen.width;
    } else if (pos.x < 0) {
      pos.x = 0;
    }
    if (pos.y > screen.height) {
      pos.y = screen.height;
    } else if (pos.y < 0) {
      pos.y = 0;
    }
  }
}

