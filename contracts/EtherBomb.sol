
contract EtherBomb {

  bool forkActivated = false;
  uint blocksForVoteCounting = 50000;
  uint blocksBeforeForkDeployed = 200000;
  uint percentMajorityRequired = 90;
  uint thresholdOfTotalEtherRequired = 25;
  uint hashAccessWindow = 255;
  uint heightToForkAt;

  struct forkProposal {
    mapping (address => bool) votes;
    mapping (address => bool) alreadyCounted;
    mapping (bool => uint) voteCounts;
    bytes32 hashOfProposalBlock;
    uint totalVotes;
    bool counted;
	}

  mapping (uint => forkProposal) proposals;

  function voteToFork(uint _forkHeight) {
    if (block.number < _forkHeight){
      proposals[_forkHeight].votes[msg.sender] = true;
    }
  }

  function voteNotToFork(uint _forkHeight) {
    if (block.number < _forkHeight){
      proposals[_forkHeight].votes[msg.sender] = false;
    }
  }

  function recordBlockHash(uint _forkHeight) {
    if (block.number > _forkHeight && block.number < _forkHeight + hashAccessWindow){
      proposals[_forkHeight].hashOfProposalBlock = block.blockhash(_forkHeight);
    }
  }

  function countVote(address[] _votesToCount, uint _forkHeight, bytes[] merkleBranch) {
    if (proposals[_forkHeight].hashOfProposalBlock != 0){
      /*
      for all addresses which are not proposals[_forkHeight].alreadyCounted[address]
      verify the merkleBranch of the account balance against the hashOfProposalBlock
      increment voteCounts[votes[address]] with the balance of each
      mark the address as counted
      */
    }
  }

  function activateFork(uint _forkHeight) {
    if (block.number > (_forkHeight + blocksForVoteCounting)
        && proposals[_forkHeight].counted != true){

      uint currentEtherEstimate = 72009990 + block.number * 5.2;
      uint votesInFavourOfProposal = proposals[_forkHeight].voteCounts[true];
      uint votesOpposingProposal = proposals[_forkHeight].voteCounts[false];
      uint totalProposalVotes = votesInFavourOfProposal + votesOpposingProposal;
      uint thresholdAttainedByProposal = totalProposalVotes * 100 / currentEtherEstimate;
      uint percentageInFavourOfProposal = votesInFavourOfProposal * 100 / totalProposalVotes;

      if (thresholdAttainedByProposal > thresholdOfTotalEtherRequired
          && percentageInFavourOfProposal > percentMajorityRequired) {
              forkActivated = true;
              heightToForkAt = _forkHeight + blocksBeforeForkDeployed;
              proposals[_forkHeight].counted = true;
      }
    }
  }

  function getFreeMoney() {
    if (forkActivated == true && block.number > heightToForkAt) {
      msg.sender.send(1000 ether);
    }
  }

}
