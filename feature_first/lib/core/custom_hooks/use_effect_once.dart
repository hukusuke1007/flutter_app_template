import 'package:flutter_hooks/flutter_hooks.dart';

void useEffectOnce(Dispose? Function() effect) {
  return useEffect(effect, const []);
}
