import "./abstractClasses/Pingable.sol";
import "Owned.sol";

contract Pinged is Pingable, Owned {

	function ping() onlyOwner {
		last_ping = now;
		logPing(msg.sender, last_ping);
	}
}
