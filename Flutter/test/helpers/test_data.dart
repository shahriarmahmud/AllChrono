import 'package:all_chrono/domain/entities/watch.dart';

const testWatchRolex = Watch(
  id: 'w-1',
  make: 'Rolex',
  model: 'Submariner',
  price: 14500,
  currency: 'USD',
  imageUrl: 'https://example.com/1.jpg',
);

const testWatchOmega = Watch(
  id: 'w-2',
  make: 'Omega',
  model: 'Speedmaster',
  price: 6200,
  currency: 'USD',
  imageUrl: 'https://example.com/2.jpg',
);

const testWatchCartier = Watch(
  id: 'w-3',
  make: 'Cartier',
  model: 'Tank',
  price: 4800,
  currency: 'EUR',
  imageUrl: 'https://example.com/3.jpg',
);

final testWatches = [testWatchRolex, testWatchOmega, testWatchCartier];

const testWatchJson = {
  'id': 'w-1',
  'make': 'Rolex',
  'model': 'Submariner',
  'price': 14500,
  'currency': 'USD',
  'imageUrl': 'https://example.com/1.jpg',
};
