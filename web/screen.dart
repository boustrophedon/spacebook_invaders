part of spacebook;

class Screen {
  CanvasElement canvas; /* canvas.context2D as CanvasRenderingContext2D */
  num width, height;

  Screen(CanvasElement aCanvas) {
    canvas = aCanvas;
    width = canvas.width;
    height = canvas.height;
  }

  void clear() {
    canvas.context2D.clearRect(0, 0, width, height);
  }
}

