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
    attributes: <Attr>[
      Attr(
        name: 'w',
        format: FormatF.integer,
        isImmutable: true,
      ),
      Attr(
        name: 'h',
        format: FormatF.integer,
        isImmutable: true,
      ),
    ],
  );

  @override
  SizesCtrl get ctrl => controller;
  final SizeF value;

  @override
  bool get deleteOlder => true;

  SizeFractal({
    super.id,
    required this.value,
    super.hash,
    super.pubkey,
    super.createdAt,
    super.syncAt,
    super.sig,
    super.to,
  });

  SizeFractal.fromMap(MP d)
      : value = SizeF(
          (d['w'] ?? 0) + .0,
          (d['h'] ?? 0) + .0,
        ),
        super.fromMap(d);

  MP get _map => {
        'w': value.width.toInt(),
        'h': value.height.toInt(),
      };

  @override
  Object? operator [](String key) => switch (key) {
        'w' => value.width.toInt(),
        'h' => value.height.toInt(),
        _ => super[key],
      };
}
