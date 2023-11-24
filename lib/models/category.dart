enum Category { crypto, stock }

Category stringToCategory(String str) {
  switch (str) {
    case 'crypto':
      return Category.crypto;
    case 'stock':
      return Category.stock;
    default:
      throw ArgumentError('Invalid category string: $str');
  }
}
