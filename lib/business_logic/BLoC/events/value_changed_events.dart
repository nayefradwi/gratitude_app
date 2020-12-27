abstract class ValueChangedEvents<T> {
  const ValueChangedEvents();
}

class InitValueEvent<T> extends ValueChangedEvents<T> {
  final T initialValue;

  const InitValueEvent(this.initialValue);
}

class NewValueEvent<T> extends ValueChangedEvents<T>{
  final T value;

  const NewValueEvent(this.value);

}
