class Screen {
  CanvasElement canvas; /* canvas.context2D as CanvasRenderingContext2D */
  num width, height;

  Screen(CanvasElement aCanvas) {
    canvas = aCanvas;
    Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
  }

  void clear() {
    canvas.context2D.clearRect(0, 0, width, height);
  }
}

