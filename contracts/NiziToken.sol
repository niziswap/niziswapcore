// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/BEP20.sol";

contract NiziToken is BEP20 {

    constructor(string memory name_, string memory symbol_) BEP20(name_, symbol_) public {}

    struct mintPartner {
      uint256 mintUpperBound;
      uint256 alreadyMint;
    }

    mapping(address=>mintPartner) public partners;

    function addPartner(address _partner, uint256 _upperBound) public onlyOwner {
      partners[_partner] = mintPartner(_upperBound, 0);
    }

    function mint(address _to, uint256 _amount) public {
        mintPartner memory p = partners[_msgSender()];
        require(p.mintUpperBound >= p.alreadyMint + _amount, "not a partner or mint reach upper bound");
        partners[_msgSender()].alreadyMint += _amount;
        _mint(_to, _amount);
    }

    function burn(address _to , uint256 _amount) public onlyOwner {
        _burn(_to, _amount);
    }

    function burn(uint256 _amount) public {
      _burn(_msgSender(), _amount);
    }

}