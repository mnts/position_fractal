import 'package:frac/frac.dart';
import 'package:fractal/lib.dart';
import 'package:fractal/types/file.dart';
import 'package:fractal_base/extensions/fractal.dart';
import 'package:signed_fractal/controllers/events.dart';
import 'package:signed_fractal/models/event.dart';
import '../fractals/index.dart';

class OffsetProp<T extends OffsetF> extends CoordProp<T> {
  @override
  get ctrl => PositionFractal.controller;

  double get x => value.x;
  double get y => value.y;

  double get dx => value.x;
  double get dy => value.y;

  @override
  String get name => _name;
  static final _name = 'position';
  OffsetProp(
    super.parent, {
    super.value = OffsetF.zero,
  });
}

class SizeProp<T extends SizeF> extends CoordProp<T> {
  @override
  get ctrl => SizeFractal.controller;

  double get width => value.width;
  double get height => value.height;

  @override
  String get name => _name;
  static final _name = 'size';
  SizeProp(super.parent) : super(value: SizeF.zero);
}

abstract class CoordProp<T extends OffsetBaseF> extends Fr<T> {
  late dynamic _value;
  @override
  T get value => _value;
  @override
  set value(v) {
    _value = v;
    parent.notifyListeners();
  }

  EventsCtrl get ctrl;

  EventFractal parent;
  late EventFractal stored;
  CoordProp(this.parent, {required OffsetBaseF value}) {
    _value = value;
  }

  /*
  init() {
    ctrl.listen((coord) {
      if (coord.idEvent == parent.id) {
        value = (coord as dynamic).value;
      }
    });
  }
  */

  String get name => 'coord';

  final _timed = TimedF();
  //late final positions = db.select(DB.main.positions).watch();
  move(OffsetBaseF offset) {
    value = offset;
    if (offset case OffsetF offset) {
      if (offset.x == 0 && offset.y == 0) return;
    }
    parent.move();
    _timed.hold(() {
      if (parent.dontStore) return;
      stored = offset.store(parent);
    });

    /*
    PositionsCompanion.insert(
      title: '',
      x: x,
      y: y,
      content: '',
    );
    */
  }
}
