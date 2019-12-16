

import 'package:event_bus/event_bus.dart';

class GlobalEventBus{
  EventBus eventBus;
  factory GlobalEventBus()=>_getInstance();

  static GlobalEventBus _instance;

  static GlobalEventBus get instance =>_getInstance();

  GlobalEventBus._internal(){
    eventBus = EventBus();
  }

  static GlobalEventBus _getInstance(){
    if(_instance==null){
      _instance = GlobalEventBus._internal();
    }
    return _instance;
  }


}