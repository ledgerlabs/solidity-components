/**
* This contract will call some arbitrary contract's methods
* if and only if the signer has signed off on the order to
**/

contract SignatureProxy {
    // Signer is the person whose transactions are being forwarded by this contract
    address signer;
    // Destination is the address of the contract that method calls are sent to
    address destination;
    // Nonce is to keep from having replay attacks
    uint nonce;
    
    // Ensures that the signer has signed the hash of the desired method call
     modifier onlySigner(
        // methodSignature is sha3("methodName(paramType,paraType...)")
        bytes32 methodSignature, 
        bytes32[] callData,
        uint _nonce,
        uint8 v, 
        bytes32 r, 
        bytes32 s
    ) {
        if (_nonce <= nonce) throw;
        nonce = _nonce;
        bytes32 hash = sha3(methodSignature, callData, _nonce);
        if (ecrecover(hash, v, r, s) != signer) throw;
        _
    }
    
    function SignatureProxy(address _signer, address _destination) {
        signer = _signer;
        destination = _destination;
        nonce = 0;
    }
    
    // Returns true upon success and false upon failure
    function forward(
        bytes32 methodSignature, 
        bytes32[] callData,
        uint8 v, 
        bytes32 r, 
        bytes32 s
    )
    onlySigner(methodSignautre, callData, v, r, s) returns (bool) {
        return destination.call(bytes4(hash), callData);
    }
}
