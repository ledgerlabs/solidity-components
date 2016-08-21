import "./abstractClasses/Delegatable.sol";

contract Delegated is Delegatable {
	mapping (address => bool) public delegates;

	function addDelegate (address _newDelegate) onlyOwner {
		delegates[_newDelegate] = true;
		accessListChanged(_newDelegate, delegateChanges.Added);
	}

	function removeDelegate (address _delegateToRemove) onlyOwner {
		delegates[_delegateToRemove] = false;
		accessListChanged(_delegateToRemove, delegateChanges.Removed);
	}

	function changeOwner onlyOwnerOrDelegate {
		ownerChanged(owner, _newOwner);
		owner = _newOwner;
	}
}
