contract Restrictable {

  mapping (address => bool) public accessList;
	event accessListChanged();

	function addAccess(address _newAccessor);
  function removeAccess(address _currentAccessor);

}
