part of spacebook;

class MovementSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Acceleration> accelerationMapper;
  ComponentMapper<Species> speciesMapper;

  Screen screen;

  MovementSystem(this.screen) : super(Aspect.getAspectForAllOf([Position, Velocity, Acceleration]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    accelerationMapper = new ComponentMapper<Acceleration>(Acceleration, world);
    speciesMapper = new ComponentMapper<Species>(Species, world);
  }

  void processEntity(Entity entity) {
    Position pos = positionMapper.get(entity);
    Velocity vel = velocityMapper.get(entity);
    Acceleration acc = accelerationMapper.get(entity);

    Species spec = speciesMapper.get(entity);
    if (spec.name == 'laser') {
      if (pos.y <= -20) {
        entity.deleteFromWorld();
      }
    }

    num dt = world.delta/1000;
    pos.x += vel.x*dt;
    pos.y += vel.y*dt;
    vel.x += acc.x*dt;
    vel.y += acc.y*dt;
  }
}

