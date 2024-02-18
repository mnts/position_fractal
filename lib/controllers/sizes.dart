import 'package:fractal_base/models/index.dart';
import 'package:signed_fractal/controllers/events.dart';
import '../fractals/size.dart';

class SizesCtrl<T extends SizeFractal> extends EventsCtrl<T> {
  SizesCtrl({
    super.name = 'size',
    required super.extend,
    required super.make,
    required super.attributes,
  });

  @override
  get fractalType => T;
}
