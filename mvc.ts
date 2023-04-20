console.clear();

class CounterModel {
  public count = 0;
  public step = 1;

  public increment() {
    this.count += this.step;
  }

  public decrement() {
    this.count -= this.step;
  }
}

class CounterView {
  constructor(public model, public element) {}

  updateCount() {
    this.element.output.textContent = this.model.count;
  }
}

class Controller {
  on(eventName, elementName, callback) {
    this.view.element[elementName].addEventListener(eventName, callback);
  }

  off(eventName, elementName, callback) {
    this.view.element[elementName].removeEventListener(eventName, callback);
  }
}

class CounterController extends Controller {
  constructor(public model, public view) {}

  onIncrement = () => {
    this.model.increment();
    this.view.updateCount();
  };

  onDecrement = () => {
    this.model.decrement();
    this.view.updateCount();
  };

  mount() {
    this.on("click", "increment", this.onIncrement);
    this.on("click", "decrement", this.onDecrement);
  }

  unMount() {
    this.off("click", "increment", this.onIncrement);
    this.off("click", "decrement", this.onDecrement);
  }
}

const model = new CounterModel();

const view = new CounterView(model, {
  output: document.getElementById("output"),
  increment: document.getElementById("increment"),
  decrement: document.getElementById("decrement"),
});

const controller = new CounterController(model, view);
controller.mount();
