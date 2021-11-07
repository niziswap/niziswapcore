//SPDX-License-Identifier: Unlicense

pragma solidity 0.6.12;

import "@pancakeswap/pancake-swap-lib/contracts/token/BEP20/BEP20.sol";

contract CMXToken is BEP20 {

  constructor(string memory name_, string memory symbol_, uint256 initialSupply) BEP20(name_, symbol_) public {
    _mint(msg.sender, initialSupply);
  }

  function burn(address _to , uint256 _amount) public onlyOwner {
    _burn(_to, _amount);
  }

  function burn(uint256 _amount) public {
    _burn(_msgSender(), _amount);
  }

}