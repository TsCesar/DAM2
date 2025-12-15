**Autor/a:** Cesar

```
```bash
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HolaMundo {
    string public mensaje;

    constructor() {
        mensaje = "Hola, Ethereum privado";
    }

    function  actualizarMensaje(string memory nuevoMensaje) public  {
        mensaje = nuevoMensaje;
    }

}
```
```
