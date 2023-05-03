// ignore_for_file: constant_identifier_names

enum PlayerNr {
  one,
  two,
  three,
  four;

  String get str => this == PlayerNr.one
      ? 'player1'
      : this == PlayerNr.two
          ? 'player2'
          : this == PlayerNr.three
              ? 'player3'
              : this == PlayerNr.four
                  ? 'player4'
                  : '';
}

enum TablePos {
  thisPlayer,
  teamMate,
  OppRight,
  OppLeft,
}

enum BannerState {
  empty,
  neutral,
  turn,
  pass,
  dragon,
}

enum Suit { red, green, blue, black, special }

enum Rank {
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king,
  ace,
  mahjong,
  dragon,
  phoenix,
  dog,
}

// enum Card {
//   mahjong,
//   dragon,
//   phoenix,
//   dog,
//   red_2,
//   red_3,
//   red_4,
//   red_5,
//   red_6,
//   red_7,
//   red_8,
//   red_9,
//   red_10,
//   red_jack,
//   red_queen,
//   red_king,
//   red_ace,
//   green_2,
//   green_3,
//   green_4,
//   green_5,
//   green_6,
//   green_7,
//   green_8,
//   green_9,
//   green_10,
//   green_jack,
//   green_queen,
//   green_king,
//   green_ace,
//   blue_2,
//   blue_3,
//   blue_4,
//   blue_5,
//   blue_6,
//   blue_7,
//   blue_8,
//   blue_9,
//   blue_10,
//   blue_jack,
//   blue_queen,
//   blue_king,
//   blue_ace,
//   black_2,
//   black_3,
//   black_4,
//   black_5,
//   black_6,
//   black_7,
//   black_8,
//   black_9,
//   black_10,
//   black_jack,
//   black_queen,
//   black_king,
//   black_ace,
// }
