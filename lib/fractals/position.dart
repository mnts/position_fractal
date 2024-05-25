import 'package:fractal/lib.dart';
import 'package:signed_fractal/models/event.dart';
import '../controllers/positions.dart';
import 'offset.dart';

class PositionFractal extends EventFractal {
  static final controller = PositionsCtrl(
    extend: EventFractal.controller,
    make: (d) => switch (d) {
      MP() => PositionFractal.fromMap(d),
      Object() || null => throw ('wrong event type')
    },
    attributes: <Attr>[
      Attr(
        name: 'x',
        format: 'DOUBLE',
        isImmutable: true,
      ),
      Attr(
        name: 'y',
        format: 'DOUBLE',
        isImmutable: true,
      ),
    ],
  );
  @override
  PositionsCtrl get ctrl => controller;
  final OffsetF value;

  PositionFractal({
    super.id,
    required this.value,
    super.hash,
    super.pubkey,
    super.createdAt,
    super.syncAt,
    super.sig,
    super.to,
  });

  PositionFractal.fromMap(MP d)
      : value = OffsetF(
          d['x'] + .0,
          d['y'] + .0,
        ),
        super.fromMap(d);

  MP get _map => {
        'x': value.x,
        'y': value.y,
      };

  @override
  MP toMap() => {
        ...super.toMap(),
        ..._map,
      };
}
