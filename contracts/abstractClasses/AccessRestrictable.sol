contract AccessRestrictable {

  mapping (address => bool) public accessList;
  enum accessChanges { Added, Removed}
	event accessListChanged(
        address indexed _changedAddress,
        accessChanges indexed _change
        );

	function addAccess(address _newAccessor);
  function removeAccess(address _currentAccessor);

  modifier restricted {
		if (accessList[msg.sender] == true) {
			_
		} else {
			throw;
		}
	}
}
