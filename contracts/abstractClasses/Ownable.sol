contract Ownable {

	address public owner;
	event ownerChanged(
        address indexed _from,
        address indexed _to
    );

	function changeOwner(address _newOwner) onlyOwner();

  modifier onlyOwner {
		if (msg.sender == owner) {
			_;
		} else {
			throw;
		}
	}
}
