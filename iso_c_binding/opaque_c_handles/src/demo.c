#include <stdlib.h>

typedef struct {
  int id;
  float score;
} EngineT;

EngineT *create_engine(int id) {
  EngineT *engine = malloc(sizeof *engine);

  if (!engine) {
    return NULL;
  }

  engine->id = id;
  engine->score = 99.5f;

  return engine;
}

float get_score(EngineT *engine) { return engine->score; }

void destroy_engine(EngineT *engine) {
  if (engine) {
    free(engine);
  }
}
