part of spacebook;

class MovementSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Acceleration> accelerationMapper;

  MovementSystem() : super(Aspect.getAspectForAllOf([Position, Velocity, Acceleration]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    accelerationMapper = new ComponentMapper<Acceleration>(Acceleration, world);
  }

  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    Velocity vel = velocityMapper.get(entity);
    Acceleration acc = accelerationMapper.get(entity);
    pos.x += vel.x;
    pos.y += vel.y;
    vel.x += acc.x;
    vel.y += acc.y;
  }
}

