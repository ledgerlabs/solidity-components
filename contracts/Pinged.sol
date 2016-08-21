import "./abstractClasses/Pingable.sol";

contract Pinged is Pingable {

	function ping() {
		last_ping = now;
		logPing(msg.sender, last_ping);
	}
}
