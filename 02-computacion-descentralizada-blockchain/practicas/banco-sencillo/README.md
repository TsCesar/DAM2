**Autor/a:** Cesar

```
```bash
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BancoSimple {
    //Mapping de saldo de cada dirección
    mapping (address => uint256) public saldos;

    //Constructor asigna saldo inicial al creador (Los valores del constructor al desplegar)
    constructor(uint256 saldoInicial){
        saldos[msg.sender] = saldoInicial;
    }

    //Depositar "dinero"
    function depositar(uint256 cantidad) public {
        saldos[msg.sender] += cantidad;
    }

    //Retirar "dinero"
    function retirar(uint256 cantidad) public {
        require(saldos[msg.sender] >= cantidad, "Saldo insuficiente");
        saldos[msg.sender] -= cantidad;
    }

    //Ver saldo
    function verSaldo() public view returns (uint256){
        return saldos[msg.sender];
    }


}
```
```
