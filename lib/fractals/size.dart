import 'package:fractal/lib.dart';
import 'package:position_fractal/controllers/sizes.dart';
import 'package:signed_fractal/models/event.dart';
import 'offset.dart';

class SizeFractal extends EventFractal {
  static final controller = SizesCtrl(
    extend: EventFractal.controller,
    make: (d) => switch (d) {
      MP() => SizeFractal.fromMap(d),
      Object() || null => throw ('wrong event type')
    },
  );

  @override
  SizesCtrl get ctrl => controller;
  final SizeF value;

  SizeFractal({
    super.id,
    required this.value,
    super.hash,
    super.pubkey,
    super.createdAt,
    super.syncAt,
    super.sig,
    super.to,
  }) {}

  @override
  get hashData => [
        ...super.hashData,
        value.width.toInt(),
        value.height.toInt(),
      ];

  SizeFractal.fromMap(MP d)
      : value = SizeF(
          d['w'] + .0,
          d['h'] + .0,
        ),
        super.fromMap(d);

  MP get _map => {
        'w': value.width,
        'h': value.height,
      };

  @override
  MP toMap() => {
        ...super.toMap(),
        ..._map,
      };
}
