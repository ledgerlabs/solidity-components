import "Owned.sol"

contract SelfOwned is Owned{

  function SelfOwned() {
    owner = address(this);
  }

}
