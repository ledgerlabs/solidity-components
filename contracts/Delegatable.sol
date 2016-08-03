import "Ownable.sol";

contract Delegatable is Ownable {
	mapping (address => bool) public delegates;

	function addDelegate (address _addr) {
		delegates[_addr] = true;
	}

	function removeDelegate (address _addr) {
		delegates[_addr] = false;
	}

	function changeOwner()
	onlyDelegate (msg.sender);


	modifier onlyDelegate (address _addr) {
		if (msg.sender == owner || delegates[_addr]) _
		else throw;
	}
}

