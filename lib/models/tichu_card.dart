import 'enums.dart';

class TichuCard {
  final Suit suit;
  final Rank rank;

  const TichuCard(this.suit, this.rank);

  factory TichuCard.fromString(String str) {
    late Suit s;
    late Rank r;
    switch (str.substring(0, 1)) {
      case 's':
        s = Suit.special;
        break;
      case 'r':
        s = Suit.red;
        break;
      case 'g':
        s = Suit.green;
        break;
      case 'b':
        s = Suit.blue;
        break;
      case 'k':
        s = Suit.black;
        break;
    }
    switch (str.substring(1, 2)) {
      case 'M':
        r = Rank.mahjong;
        break;
      case 'D':
        r = Rank.dragon;
        break;
      case 'P':
        r = Rank.phoenix;
        break;
      case 'G':
        r = Rank.dog;
        break;
      case '2':
        r = Rank.two;
        break;
      case '3':
        r = Rank.three;
        break;
      case '4':
        r = Rank.four;
        break;
      case '5':
        r = Rank.five;
        break;
      case '6':
        r = Rank.six;
        break;
      case '7':
        r = Rank.seven;
        break;
      case '8':
        r = Rank.eight;
        break;
      case '9':
        r = Rank.nine;
        break;
      case 'X':
        r = Rank.ten;
        break;
      case 'J':
        r = Rank.jack;
        break;
      case 'Q':
        r = Rank.queen;
        break;
      case 'K':
        r = Rank.king;
        break;
      case 'A':
        r = Rank.ace;
        break;
    }
    return TichuCard(s, r);
  }

  String get str {
    late String s;
    late String r;
    switch (suit) {
      case Suit.special:
        s = 's';
        break;
      case Suit.red:
        s = 'r';
        break;
      case Suit.green:
        s = 'g';
        break;
      case Suit.blue:
        s = 'b';
        break;
      case Suit.black:
        s = 'k';
        break;
    }
    switch (rank) {
      case Rank.mahjong:
        r = 'M';
        break;
      case Rank.dragon:
        r = 'D';
        break;
      case Rank.phoenix:
        r = 'P';
        break;
      case Rank.dog:
        r = 'G';
        break;
      case Rank.two:
        r = '2';
        break;
      case Rank.three:
        r = '3';
        break;
      case Rank.four:
        r = '4';
        break;
      case Rank.five:
        r = '5';
        break;
      case Rank.six:
        r = '6';
        break;
      case Rank.seven:
        r = '7';
        break;
      case Rank.eight:
        r = '8';
        break;
      case Rank.nine:
        r = '9';
        break;
      case Rank.ten:
        r = 'X';
        break;
      case Rank.jack:
        r = 'J';
        break;
      case Rank.queen:
        r = 'Q';
        break;
      case Rank.king:
        r = 'K';
        break;
      case Rank.ace:
        r = 'A';
        break;
    }
    return '$s$r';
  }
}
