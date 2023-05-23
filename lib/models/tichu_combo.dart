import 'package:tichu_flutter/models/tichu_card.dart';

import 'enums.dart';

class TichuCombo {
  final Combo combo;
  final Rank rank;
  final List<TichuCard> cards;

  const TichuCombo(this.combo, this.rank, this.cards);

  factory TichuCombo.fromString(String str) {
    late Combo co;
    late Rank ra;
    final List<TichuCard> ca = [];
    switch (str.substring(0, 1)) {
      case 'S':
        co = Combo.single;
        break;
      case 'P':
        co = Combo.pair;
        break;
      case 'J':
        co = Combo.adjacentPair;
        break;
      case 'T':
        co = Combo.trio;
        break;
      case 'F':
        co = Combo.fullhouse;
        break;
      case 'R':
        co = Combo.street;
        break;
      case 'B':
        co = Combo.bomb;
        break;
      case 'A':
        co = Combo.streetBomb;
        break;
      case 'C':
        co = Combo.special;
        break;
    }
    switch (str.substring(1, 2)) {
      case 'M':
        ra = Rank.mahjong;
        break;
      case 'D':
        ra = Rank.dragon;
        break;
      case 'P':
        ra = Rank.phoenix;
        break;
      case 'G':
        ra = Rank.dog;
        break;
      case '2':
        ra = Rank.two;
        break;
      case '3':
        ra = Rank.three;
        break;
      case '4':
        ra = Rank.four;
        break;
      case '5':
        ra = Rank.five;
        break;
      case '6':
        ra = Rank.six;
        break;
      case '7':
        ra = Rank.seven;
        break;
      case '8':
        ra = Rank.eight;
        break;
      case '9':
        ra = Rank.nine;
        break;
      case 'X':
        ra = Rank.ten;
        break;
      case 'J':
        ra = Rank.jack;
        break;
      case 'Q':
        ra = Rank.queen;
        break;
      case 'K':
        ra = Rank.king;
        break;
      case 'A':
        ra = Rank.ace;
        break;
    }
    for (int i = 2; i < str.length; i += 2) {
      ca.add(TichuCard.fromString(str.substring(i, i + 2)));
    }
    return TichuCombo(co, ra, ca);
  }

  // factory TichuCombo.fromCards(List<TichuCard> cards) {
  //   late Combo co;
  //   late Rank ra;
  //   switch (cards.length) {
  //     case 1:
  //       if (cards[0].suit == Suit.special) {
  //         co = Combo.special;
  //       } else {
  //         co = Combo.single;
  //       }
  //       ra = cards[0].rank;
  //       break;
  //     case 2:
  //       co = Combo.pair;
  //       ra = cards[0].rank;
  //       break;
  //     case 3:
  //       co = Combo.trio;
  //       ra = cards[0].rank;
  //       break;
  //     case 5:
  //       var rankCount = <Rank, int>{};
  //       var suitCount = <Suit, int>{};
  //       cards.forEach((card) {
  //         if (!rankCount.containsKey(card.rank)) {
  //           rankCount[card.rank] = 1;
  //         } else {
  //           rankCount[card.rank] += 1;
  //         }
  //         if (!suitCount.containsKey(card.suit)) {
  //           suitCount[card.suit] = 1;
  //         } else {
  //           suitCount[card.suit] += 1;
  //         }
  //         if (rankCount.keys.length == 2) {
  //           co = Combo.fullhouse;
  //           if (rankCount[rankCount.keys.first] == 3) {
  //             ra = rankCount.keys.first;
  //           } else {
  //             ra = rankCount.keys.last;
  //           }
  //         } else if (rankCount.keys.length >= 5) {
  //           if (suitCount.keys.length > 1) {
  //             co = Combo.street;
  //             ra = rankCount.keys.map((e) => e.index).reduce(min);
  //           }
  //         }
  //       });
  //       break;
  //     default:
  //   }
  // }

  String get str {
    late String co;
    String ca = '';
    switch (combo) {
      case Combo.single:
        co = 'SI';
        break;
      case Combo.pair:
        co = 'PA';
        break;
      case Combo.adjacentPair:
        co = 'AP';
        break;
      case Combo.trio:
        co = 'TR';
        break;
      case Combo.fullhouse:
        co = 'FH';
        break;
      case Combo.street:
        co = 'ST';
        break;
      case Combo.bomb:
        co = 'BO';
        break;
      case Combo.streetBomb:
        co = 'SB';
        break;
      case Combo.special:
        co = 'SP';
        break;
    }
    for (TichuCard card in cards) {
      ca = ca + card.str;
    }
    return '$co$ca';
  }
}
