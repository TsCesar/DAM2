```bash
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Strings.sol";

contract votaciones {
    uint public  contador_A = 0;
    uint public  contador_B = 0;
    using Strings for uint256;

    mapping (address => bool) public votacion;

    function compararCadenas(string memory a, string memory b) public pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function votar(string memory _opcion) public {
        require(!votacion[msg.sender], "Ya ha votado");
        require(compararCadenas(_opcion, "A") || compararCadenas(_opcion, "B"),"La opcion debe ser A o B");
        votacion[msg.sender] = true;

        if (compararCadenas(_opcion, "A")) {
            contador_A++;
        } else if (compararCadenas(_opcion, "B")) {
            contador_B++;
        }
    }

    function resultado() public  view returns (string memory, string memory) {
        string memory votosA = string(abi.encodePacked("Votos A: ", contador_A.toString()));
        string memory votosB = string(abi.encodePacked("Votos B: ", contador_B.toString()));

        return (votosA, votosB);
    }


}
```