import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/business_logic/BLoC/events/value_changed_events.dart';
import 'package:gratitude_app/business_logic/BLoC/states/value_changed_states.dart';

class ValueChangedBloc<T>
    extends Bloc<ValueChangedEvents<T>, ValueChangedStates<T>> {
  ValueChangedBloc(T value) : super(ValueChangedStates.init(value));

  void changeValue(T value) {
    this.add(NewValueEvent(value));
  }

  @override
  Stream<ValueChangedStates<T>> mapEventToState(
      ValueChangedEvents<T> event) async* {
    if (event is InitValueEvent<T>)
      yield ValueChangedStates.init(event.initialValue);
    else if (event is NewValueEvent<T>)
      yield ValueChangedStates.newValue(event.value);
  }

  void initValueToRefresh() {
    this.add(InitValueEvent(null));
  }
}
