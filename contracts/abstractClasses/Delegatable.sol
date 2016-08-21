import "Ownable.sol";

contract Delegatable is Ownable{
	mapping (address => bool) public delegates;
  enum delegateChanges { Added, Removed}
  event delegateListChanged(
        address indexed _delegate,
        delegateChanges indexed _change
        );

	function addDelegate onlyOwner (address _addr);
	function removeDelegate onlyOwner (address _addr);
	function changeOwner() onlyOwnerOrDelegate ();

	modifier onlyDelegate () {
		if (delegates[msg.sender]) _
		else throw;
	}

  modifier onlyOwnerOrDelegate () {
    if (msg.sender == owner || delegates[msg.sender]) _
		else throw;
  }
}
