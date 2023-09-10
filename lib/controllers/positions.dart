import 'package:fractal_base/models/index.dart';
import 'package:signed_fractal/controllers/events.dart';
import '../fractals/position.dart';

class PositionsCtrl<T extends PositionFractal> extends EventsCtrl<T> {
  PositionsCtrl({
    super.name = 'position',
    required super.make,
    required super.extend,
    super.attributes = const <Attr>[
      Attr('x', double),
      Attr('y', double),
    ],
  });
}
