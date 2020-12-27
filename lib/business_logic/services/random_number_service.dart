import 'dart:math';

class RandomNumberService {
  RandomNumberService._();
  static RandomNumberService _service = RandomNumberService._();
  factory RandomNumberService.getInstance() => _service;
  Random _random = Random();
  int _lastGenerated = -1;
  int getRandomNumber(int excludedUpperLimit, {int includedLowerLimit: 0}) {
    int random;
    do {
      random = _random.nextInt(excludedUpperLimit) + includedLowerLimit;
    } while (random == _lastGenerated);
    _lastGenerated = random;
    return random;
  }
}
