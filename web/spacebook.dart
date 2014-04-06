library spacebook;

import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:dartemis/dartemis.dart';

World world;
Screen screen;

void main() {
  CanvasElement canvas = querySelector("#area");
  screen = new Screen(canvas);
  world = new World();
  scheduleMicrotask(screen.start);
}

Element notes = querySelector("#fps");
num fpsAverage;

/// Display the animation's FPS in a div.
void showFps(num fps) {
  if (fpsAverage == null) fpsAverage = fps;
  fpsAverage = fps * 0.05 + fpsAverage * 0.95;
  notes.text = "${fpsAverage.round()} fps";
}

class Screen {
  CanvasElement canvas;
  num width;
  num height;

  num renderTime;

  Screen(this.canvas);

  void start() {
    Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
    requestRedraw();
  }

  void draw(num _) {
    num time = new DateTime.now().millisecondsSinceEpoch;
    if (renderTime != null) showFps(1000 / (time - renderTime));
    renderTime = time;

    var context = canvas.context2D;
    drawBackground(context);
    requestRedraw();
  }

  void drawBackground(CanvasRenderingContext2D context) {
    context.clearRect(0, 0, width, height);
  }

  void drawWorld(CanvasRenderingContext2D context) {
    // do something with context
  }

  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }
}

