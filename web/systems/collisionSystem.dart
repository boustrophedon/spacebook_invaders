part of spacebook;

class CollisionSystem extends EntityProcessingSystem {
  ComponentMapper<Position> positionMapper;
  ComponentMapper<Velocity> velocityMapper;
  ComponentMapper<Acceleration> accelerationMapper;
  ComponentMapper<Species> speciesMapper;
  ComponentMapper<Intensity> intensityMapper;
  ComponentMapper<Health> healthMapper;
  ComponentMapper<Damage> damageMapper;

  TagManager tagManager;

  Screen screen;

  CollisionSystem(this.screen) : super(Aspect.getAspectForAllOf([Position, Velocity, Acceleration, Species]));

  void initialize() {
    positionMapper = new ComponentMapper<Position>(Position, world);
    velocityMapper = new ComponentMapper<Velocity>(Velocity, world);
    accelerationMapper = new ComponentMapper<Acceleration>(Acceleration, world);
    speciesMapper = new ComponentMapper<Species>(Species, world);
    intensityMapper = new ComponentMapper<Intensity>(Intensity, world);
    healthMapper = new ComponentMapper<Health>(Health, world);
    damageMapper = new ComponentMapper<Damage>(Damage, world);
  }

  void processEntities(Iterable<Entity> entities) {
    Entity zuck = tagManager.getEntity(TAG_ZUCKER);
    Position zpos = positionMapper.get(zuck);
    Health zhealth = healthMapper.get(zuck);
    Intensity i = intensityMapper.get(zuck);

    for (var entity in entities) { 
      Position pos = positionMapper.get(entity);
      Species spec = speciesMapper.get(entity);
      Damage dam = damageMapper.get(entity);
      if ((zpos.x < pos.x && zpos.y < pos.y) && (pos.x < zpos.x+153 && pos.y < zpos.y+153)) {
        if (spec.name == 'laser') {
          zhealth.health -= dam.damage;

          num t = ((new DateTime.now().millisecondsSinceEpoch*i.i1 % (2*math.PI)) - (math.PI/2));
          zpos.x += i.i2*math.cos(t);
          zpos.y += i.i2*math.sin(t)*math.cos(t);
 
          i.i1 += 5;
          i.i2 += 20;

          entity.deleteFromWorld();
        }
      }
    }

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

