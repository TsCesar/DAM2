```bash
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Increment {
    int256 private contador;

    function mostrarValor() public view returns (int256) {
        return contador;
    }

    function incrementar() public {
        contador += 1;
    }

    function incrementarValor(int256 _numero) public {
        require(_numero > 0, "El numero debe ser positivo");
        contador += _numero;
    }
}
```