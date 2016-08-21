import "./abstractClasses/Ownable.sol"

contract Owned is Ownable{

  function Owned() {
    owner = address(this);
  }

	function changeOwner(address _newOwner) onlyOwner() {
    ownerChanged(owner, _newowner);
    owner = _newOwner;
  }
}
