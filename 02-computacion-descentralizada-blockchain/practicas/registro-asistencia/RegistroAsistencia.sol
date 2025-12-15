```bash
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroAsistencia {

    int contador = 0;

    mapping (address => bool) public asistencia;

    event AsistenciaMarcada(address indexed asistente);

    function marcarAsistencia() public {
        require(!asistencia[msg.sender], "Ya has marcado asistencia");
        asistencia[msg.sender] = true;
        contador++;
        emit AsistenciaMarcada(msg.sender);
    }

    function verAsistencias(address asistente) public view returns (bool) {
        return asistencia[asistente];
    }

    function mostrarNumeroParticipantes() public view returns (int) {
        return contador;
    }
}
```