pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

struct Bet {
  // Bet ID
  uint256 betId;
  // Match ID
  uint256 matchId;
  // Bettor address
  address bettor;
  // Bet amount
  uint256 amount;
  // Bet date in timestamp
  uint256 date;
  // Address of the participant which the bet is put on
  address side;
  // Indicates if the payout is performed (always false for losing or unresulted bets)
  bool paidOut;
  // Indicates if the bet is valid (non-null)
  bool isValid;
}

struct Match {
  // Match ID
  uint256 matchId;
  // Addresses of the participants of the match
  address[] participants;
  // Winner address (Multiple winners or draw?)
  address winner;
  // Payment token to be used for bets and prizes
  address paymentToken;
  // Indicates if the bet is valid (non-null)
  bool isValid;
}
