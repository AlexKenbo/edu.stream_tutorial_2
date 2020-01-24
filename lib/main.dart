import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  StreamController<double> controller = StreamController<double>(); 
  StreamSubscription<double> streamSubscription;
  
  @override
  Widget build(BuildContext context) {
    var random = Random();
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                child: Text('Subscribe'),
                color: Colors.yellow,
                onPressed: () async {
                  /*getDelayedRandomValue().listen((value){
                    print('value from manualStream: $value');
                  });
                   Если getDelayedRandomValue() это Future
                  var value1 = await getDelayedRandomValue();
                  var value2 = await getDelayedRandomValue();
                  */
                  if (streamSubscription != null) {
                    streamSubscription.resume();
                  } else {
                  Stream stream = controller.stream;
                  streamSubscription = stream.listen((value){
                    print('value from the controller $value');
                  });
                  }
                  
                },
              ),
              MaterialButton(
                child: Text('Emit value'),
                color: Colors.blue[200],
                onPressed: (){
                  !controller.isPaused ? controller.add(random.nextDouble()) : null;
                },
              ),
              MaterialButton(
                child: Text('Unsubscribe'),
                color: Colors.red[200],
                onPressed: (){
                  streamSubscription.pause();
                  
                },
              )
          ],),
        ),
      ),
    );
  }

  Stream<double> getDelayedRandomValue() async* {
    var random = Random();

    while(true){
      await Future.delayed(Duration(seconds: 1));
      yield random.nextDouble();
    }
  }
}
