library spacebook;

import 'package:dartemis/dartemis.dart';

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

class CollisionSystem extends EntityProcessingSystem {
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
    Acceleration acc = accelerationMapper.get(entity);
    pos.y += vel.y;
    vel.x += acc.x;
    vel.y += acc.y;
  }
}

