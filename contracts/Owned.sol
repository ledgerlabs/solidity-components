import "./abstractClasses/Ownable.sol"

contract Owned is Ownable{

  function Owned() {
    owner = msg.sender;
  }

	function changeOwner(address _newOwner) onlyOwner() {
    ownerChanged(owner, _newOwner);
    owner = _newOwner;
  }
}
