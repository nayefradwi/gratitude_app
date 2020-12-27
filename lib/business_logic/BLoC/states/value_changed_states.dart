class ValueChangedStates<T> {
  const ValueChangedStates();

  factory ValueChangedStates.init(T initialValue) =>
      InitValueState(initialValue);

  factory ValueChangedStates.newValue(T value) => NewValueState(value);
}

class InitValueState<T> extends ValueChangedStates<T> {
  final T value;

  const InitValueState(this.value);
}

class NewValueState<T> extends ValueChangedStates<T> {
  final T value;

  const NewValueState(this.value);
}
