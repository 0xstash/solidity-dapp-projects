pragma solidity ^0.8.9;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "./Types.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

contract Betting {
  // Owner(deployer) of the contract
  address owner;

  // Stores list of referees
  mapping(address => bool) referees;

  // Counter to assign a unique sequence ID to each bet created
  uint256 private nextBetId;

  // Counter to assign a unique sequence ID to each match created
  uint256 private nextMatchId;

  // Stores bets by bet ID
  mapping(uint256 => Bet) private betIdToBet;

  // Stores matches by match ID
  mapping(uint256 => Match) private matchIdToMatch;

  // Stores bet IDs by match ID
  mapping(uint256 => uint256[]) private matchIdToBetIdSet;

  // Stores bet IDs by user address
  mapping(address => uint256[]) private userToBetIdSet;

  // Number of votes for each participant in a match
  mapping(uint256 => mapping(address => uint256)) matchIdToParticipantToVoteCount;

  // Stores voters in a match
  mapping(uint256 => mapping(address => bool)) matchIdToVoters;

  // Match IDs to be reviewed by the owner or the referees
  mapping(uint256 => bool) matchIdsToReview;

  // Store total bet amount for a match
  mapping(uint256 => uint256) matchIdToBetAmount;

  // Event for putting a bet on a match
  event BetPut(address indexed sender, uint256 indexed matchId, uint256 indexed betId);

  // Event for creating a new match
  event MatchCreated(address indexed sender, uint256 indexed matchId, address[] participants, address paymentToken);

  constructor() {
    owner = msg.sender;
  }

  function betOnMatch(
    uint256 matchId,
    uint256 amount,
    address side
  ) external payable returns (uint256 betId) {
    Bet memory userBet = getUserBetForMatch(matchId);
    Match memory mt = matchIdToMatch[matchId];

    // Proper way to check if the value is null
    // require(bytes(mt).length == 0, "Invalid match ID");
    // require(bytes(userBet).length == 0, "User has already put a bet on this match");
    require(!userBet.isValid, "User has already put a bet on this match");
    require(mt.isValid, "Invalid match ID");

    // Amount should be greater than zero
    require(amount > 0, "Bet amount should be greater than zero");

    // The side to put the bet on should be a valid participant
    require(isUserParticipant(mt, side), "Bet side is not a participant in the match");

    // nextBetId cannot overflow 256 bits.
    unchecked {
      betId = ++nextBetId;
    }

    // Deposit the amount to the betting pool for the match
    IERC20Upgradeable(mt.paymentToken).safeTransferFrom(msg.sender, address(this), amount);

    // Store new bet
    betIdToBet[betId] = Bet(betId, matchId, msg.sender, amount, block.timestamp, side, false, true);
    matchIdToBetIdSet[matchId].push(betId);
    userToBetIdSet[msg.sender].push(betId);
    matchIdToBetAmount[matchId] += amount;

    // Emit bet event
    emit BetPut(msg.sender, matchId, betId);
  }

  function getBets(uint256 matchId) public view returns (Bet[] memory bets) {
    uint256[] memory betIds = matchIdToBetIdSet[matchId];
    uint256 pointer = 0;
    for (uint256 i = 0; i < betIds.length; i++) {
      uint256 betId = betIds[i];
      if (betId > 0) {
        Bet memory bet = betIdToBet[betId];
        bets[pointer++] = bet;
      }
    }
  }

  function getUserBets() public view returns (Bet[] memory bets) {
    uint256[] memory betIds = userToBetIdSet[msg.sender];
    uint256 pointer = 0;
    for (uint256 i = 0; i < betIds.length; i++) {
      uint256 betId = betIds[i];
      if (betId > 0) {
        Bet memory bet = betIdToBet[betId];
        bets[pointer++] = bet;
      }
    }
  }

  function getUserBetForMatch(uint256 matchId) public view returns (Bet memory bet) {
    Bet[] memory bets = getUserBets();
    for (uint256 i = 0; i < bets.length; i++) {
      Bet memory userBet = bets[i];
      if (userBet.matchId == matchId) {
        bet = userBet;
        break;
      }
    }
  }

  function getBet(uint256 betId) external view returns (Bet memory bet) {
    bet = betIdToBet[betId];
  }

  function getBetAmountForParticipant(uint256 matchId, address participant) external view returns (uint256 amount) {
    Bet[] memory bets = getBets(matchId);
    for (uint256 i = 0; i < bets.length; i++) {
      Bet memory bet = bets[i];
      if (bet.side == participant) {
        amount += bet.amount;
      }
    }
  }

  // Match Module

  function getMatch(uint256 matchId) public view returns (Match memory mt) {
    mt = matchIdToMatch[matchId];
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can take this action");
    _;
  }

  modifier onlyOwnerOrReferee() {
    string memory errorMsg = "Only owner of one of the referees can take this action";
    require(onlyOwner || referees[msg.sender] == true, errorMsg);
    _;
  }

  modifier onlyParticipant(uint256 matchId) {
    Match memory mt = getMatch(matchId);
    require(mt.isValid, "Invalid match ID");

    string memory errorMsg = "Only participants of the match can take this action";
    bool isParticipant = isUserParticipant(mt, msg.sender);
    require(isParticipant, errorMsg);
    _;
  }

  function isUserParticipant(Match memory mt, address user) private pure returns (bool isParticipant) {
    for (uint256 i = 0; i < mt.participants.length; i++) {
      address p = mt.participants[i];
      if (user == p) {
        isParticipant = true;
        break;
      }
    }
  }

  function addReferee(address referee) external onlyOwner {
    require(referees[referee] == false, "Given address is already a referee");
    referees[referee] = true;
  }

  function removeReferee(address referee) external onlyOwner {
    require(referees[referee] == true, "Given address is not a referee");
    referees[referee] = false;
  }

  function createMatch(address[] memory _participants, address _paymentToken) external returns (uint256 matchId) {
    require(_participants.length > 1, "There should be at least two participants");
    require(_paymentToken != address(0), "A valid payment token should be provided");

    // nextMatchId cannot overflow 256 bits.
    unchecked {
      matchId = ++nextMatchId;
    }

    // Store new match
    matchIdToMatch[matchId] = Match(matchId, _participants, address(0), _paymentToken, true);

    // Emit match creation event
    emit MatchCreated(msg.sender, matchId, _participants, _paymentToken);
  }

  function submitMatchResult(uint256 matchId, address winner) external onlyParticipant(matchId) returns (bool ended, bool needsReview) {
    // No need to check if match is valid because it's ensured in onlyParticipant modifier
    Match memory mt = matchIdToMatch[matchId];

    // Submitted winner should be one of the participants
    require(isUserParticipant(mt, winner), "Winner should be a participant in the given match");

    // Check if sender previously submitted a result or not
    // TODO: Do we want to give them the option to update their submission?
    require(matchIdToVoters[matchId][msg.sender] == true, "You already submitted a result for this match");

    // Mark sender as a voter
    matchIdToVoters[matchId][msg.sender] = true;

    // Increase the vote count of the winner
    matchIdToParticipantToVoteCount[matchId][winner]++;

    // Check the status of the match after the submission
    (bool _ended, bool _needsReview) = getMatchStatus(matchId);
    ended = _ended;
    needsReview = _needsReview;
    matchIdsToReview[matchId] = needsReview;

    // End the match if everyone submitted and no need for review
    if (ended && !needsReview) {
      _endMatch(matchId, winner);
    }
  }

  function getMatchStatus(uint256 matchId) public view returns (bool ended, bool needsReview) {
    Match memory mt = getMatch(matchId);
    require(mt.isValid, "Invalid match ID");

    uint256 totalVoteCount;
    uint256 participantCount = mt.participants.length;
    uint256 votedParticipantCount;

    for (uint256 i = 0; i < participantCount; i++) {
      address p = mt.participants[i];
      uint256 pVoteCount = matchIdToParticipantToVoteCount[matchId][p];
      totalVoteCount += pVoteCount;
      if (pVoteCount > 0) {
        votedParticipantCount++;
      }
      if (totalVoteCount == participantCount) {
        ended = true;
        break;
      }
    }

    needsReview = (votedParticipantCount > 1);
  }

  function _endMatch(uint256 matchId, address winner) private {
    Match memory mt = getMatch(matchId);
    require(mt.isValid, "Invalid match ID");

    // Check if the match is already resulted
    require(mt.winner == address(0), "Match has been already resulted");

    // Set the winner of the match and perform the payouts
    mt.winner = winner;
    performPayouts(mt);

    // Mark match as not needed to be reviewed
    matchIdsToReview[matchId] = false;
  }

  function endMatch(uint256 matchId, address winner) public onlyOwnerOrReferee {
    _endMatch(matchId, winner);
  }

  function performPayouts(uint256 matchId) private payable {
    Match memory mt = getMatch(matchId);
    require(mt.isValid, "Invalid match ID");
    require(mt.winner != address(0), "Match isn't ended yet");

    uint256 winningAmount = getBetAmountForParticipant(matchId, mt.winner);
    uint256 totalBetAmount = matchIdToBetAmount[matchId];

    Bet[] memory bets = getBets(matchId);

    for (uint256 i = 0; i < bets.length; i++) {
      Bet memory bet = bets[i];
      if (bet.side == mt.winner) {
        // Calculate the amount to be paid out
        uint256 amount = totalBetAmount * (bet.amount / winningAmount);

        // Transfer payout amount to the bettor
        IERC20Upgradeable(mt.paymentToken).safeTransferFrom(address(this), bet.bettor, amount);
      }
    }
  }
}
