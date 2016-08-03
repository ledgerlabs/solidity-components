contract Ownable {

	address public owner;
	event ownerChanged();

  function Ownable() {
    owner = address(this);
  }

	function changeOwner(address _newOwner) onlyOwner() {
    owner = _newOwner;
  }

  modifier onlyOwner {
		if (msg.sender == owner) {
			_
		} else {
			throw;
		}
	}
}
