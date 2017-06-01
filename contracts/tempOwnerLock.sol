pragma solidity ^0.4.0;

contract transferable {
    function changeOwner(address _newOwner);
}

contract nodeAssigner {
    function setOwner(bytes32 _node, address _newOwner);
}

contract tempOwnerLock {
    
    address public owner;
    uint public releaseTime;
    
    function tempOwnerLock(address _setInitialOwner){
        owner = _setInitialOwner;
    }
    
    function lockUntil(uint _releaseTime)
        onlyAfter(releaseTime)
        onlyBy(owner)
    {
        releaseTime = _releaseTime;
    }
    
    function release(address _ownedContract)
        onlyAfter(releaseTime)
    {
        transferable contractToRelease = transferable(_ownedContract);
        contractToRelease.changeOwner(owner);
    }
    
    function releaseNode(address _nodeRegistry, bytes32 _node)
        onlyAfter(releaseTime)
    {
        nodeAssigner nodeRegistry = nodeAssigner(_nodeRegistry);
        nodeRegistry.setOwner(_node, owner);
    }
    
    
    function changeOwner(address _newOwner)
        onlyBy(owner)
    {
        owner = _newOwner;
    }
    
    modifier onlyBy(address _account)
    {
        require(msg.sender == _account);
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }
    
    modifier onlyAfter(uint _time) {
        require(now >= _time);
        _;
    }
    
}

contract tempOwnerLockFactory {
    
    function newTempOwnerLock(address _initialOwner) returns(address newTempOwner) {
        tempOwnerLock newContract = new tempOwnerLock(_initialOwner);
        return address(newContract);
    }
}
