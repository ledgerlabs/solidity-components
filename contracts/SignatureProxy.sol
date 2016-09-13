/**
* This contract will call some arbitrary contract's methods
* if and only if the signer has signed off on the request
**/

contract SignatureProxy {
    // Signer is the person whose transactions are being forwarded by this contract
    address signer;
    
    // Nonces are to prevent replay attacks
    mapping (bytes32 => uint) public hashNonces;

    function SignatureProxy(address _signer) {
        signer = _signer;
    }

    // Returns true upon success and false upon failure
    function forward(
        address _destination,
        // methodSignature is sha3("methodName(paramType,paraType...)")
        bytes32 _methodSignature,
        bytes32[] _callData,
        uint _nonce,
        bytes32 _hash,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    )
    onlyIfSigned(_hash, _v, _r, _s) returns (bool) {
      hash = sha3(_destination, _methodSignature, _callData, _nonce);
      if (_nonce != (hashNonces[hash]] + 1)
          || hash != _hash) throw;
      hashNonces[hash] += 1;
      return destination.call(bytes4(hash), callData);
    }

    // Ensures that the signer has signed the hash of the desired method call
    modifier onlyIfSigned(
       bytes32 _hash,
       uint8 v,
       bytes32 r,
       bytes32 s
   ) {
       if (ecrecover(_hash, v, r, s) != signer) throw;
       _
   }
}
