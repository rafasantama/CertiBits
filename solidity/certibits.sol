pragma solidity 0.8.0;

contract CertiBits{  // defino que mi contrato se va a llamar Inbox
    uint public totalCertiBits;   // variable donde se almacena la información
    address owner;
    mapping (string => address[]) public hash2addressList;
    mapping (address => mapping(string => bool)) address2hashstate;
    constructor () {  // este es el metodo constructor donde     inicializo el contrato con un mensaje
        owner = msg.sender;
    }
    
    uint IDu;
    
    function isOwner() view private returns(bool) {
        return msg.sender == owner;    
    }
    
    modifier onlyOwner {
        require(isOwner(), "Only owner can do that!");
        _;
    }
    
    struct usuario {
        uint IDusuario;
        string nombre;
        string nit;
        string email;
        address owner;
    }
    usuario[] public usuarios;
    mapping (address => uint) public pubkey2IDu;
    mapping (address => bool) public address2state;
    mapping (address => uint) public saldo;
    function nuevo_usuario(string memory _nombre, string memory _nit, string memory _email, address _owner) public onlyOwner{
        usuarios.push(usuario(IDu,_nombre,_nit,_email,_owner));
        pubkey2IDu[_owner]=IDu;
        IDu+=1;
        address2state[_owner]=true;
    }
    function Certify(string memory _hash) public { // esta función permite reemplazar el mensaje almacenada en la variable message
        require(address2state[msg.sender],"Address not subscribed to the contract");
        require(!address2hashstate[msg.sender][_hash],"Address already signed these hash");
        require(saldo[msg.sender]>=1,"no balance");
        saldo[msg.sender]-=1;
        address2hashstate[msg.sender][_hash]=true;
        hash2addressList[_hash].push(msg.sender);
        totalCertiBits++;
    }
    function recargar(address _pk_usuario, uint _valor) public onlyOwner{
        require(_valor>0,"recharge value must be positive");
        saldo[_pk_usuario]+=_valor;
    }
}