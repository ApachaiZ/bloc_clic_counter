import 'dart:async';

import 'package:meta/meta.dart';

part 'counter_event.dart';

class CounterBloc {
  //Declare and initialize the counter
  int _counter = 0;

  //Defining a StreamController for the state of the counter
  final _counterStateController = StreamController<int>();

  //Sink is entrypoint of the streamController: in
  StreamSink<int> get _inCounter => _counterStateController.sink;

  //Stream is the exit of the streamController: out
  Stream<int> get counter => _counterStateController.stream;

  //Defining a StreamController for the events of the counter
  final _counterEventController = StreamController<CounterEvent>();

  //Entrypoint of the StreamController : in
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  //Class constructor to listen on stream
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  //Logic to implement
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementCounterEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
