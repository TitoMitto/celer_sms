import 'dart:async';


Timer setTimeout(handleTimeout, int milli){
  var timeout = new Duration(milliseconds: milli);
  return new Timer(timeout, handleTimeout);
}

Timer setInterval(handleTimeout, int milli){
  var timeout = new Duration(milliseconds: milli);
  return new Timer.periodic(timeout, (Timer t) => handleTimeout(t));
}