contract Pingable{

	uint public last_ping;
	event logPing(address indexed _from, uint _now);

	function ping();
}
