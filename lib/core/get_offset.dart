import 'dart:math' as math;
import 'dart:ui';

class GetOffset {
  static Offset getOffsetWithRadiusAndTheta({required double radius, required double theta}) {
    theta = theta - (math.pi / 2);
    return Offset(radius * math.cos(theta), radius * math.sin(theta));
  }
}
