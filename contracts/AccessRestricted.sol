import "./abstractClasses/AccessRestrictable.sol";

contract AccessRestricted is AccessRestrictable{

	function addAccess(address _newAccessor) restricted() {
    accessList[_newAccessor] = true;
    accessListChanged(_newAccessor, accessChanges.Added);
  }

  function removeAccess(address _currentAccessor) restricted() {
    accessList[_newAccessor] = false;
    accessListChanged(_newAccessor, accessChanges.Removed);
  }

}
