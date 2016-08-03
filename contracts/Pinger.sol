import "Pingable.sol";

contract Pinger is Pingable {

	function Pinger() {
		owner = msg.sender;
	}

	function ping () {
		last_ping = now;
		Ping(msg.sender, last_ping);
	}

	modifier onlyOwner {
		if (msg.sender == owner) _
		else throw;
	}
}