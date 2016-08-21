import "Ownable.sol";

contract Pingable is Ownable{

	uint public last_ping;
	event Ping(address indexed _from, uint _now);
	
	function ping();
}
