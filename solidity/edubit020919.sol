pragma solidity ^0.5.0;

/** @title Talk and Code * */

//Creación del contrato
contract EduBITS {    //Definimos el nombre del contrato
    uint Array_Element;     //Creamos una variable para almacenar la posición del ultimo dato subido a un listado
    uint public IDd;                //Creamos una variable para llevar la cuenta de cuantos asistentes se han regitrado
    uint public IDu;
    uint public IDc;
    address owner;

    constructor() public {
        owner = msg.sender;
    }
    
    function isOwner() view private returns(bool) {
        return msg.sender == owner;    
    }
    
    modifier onlyOwner {
        require(isOwner(), "Only owner can do that!");
        _;
    }

// Creamos una estrcutura donde definimos los datos que debemos almacenar de un asistente
    struct certificado {           //Definimos el nombre de la estructura
       uint IDdiploma;                  //Un identificador que corresponde a la posición del dato dentro del listado
       string curso;            //Nombre del asistente
       string fecha;             //Numero de cedula del asistente
       string estudiante;            //correo electronico del asistente
       uint cedula;            //definimos una variable para registrar la fecha de la asistencia
       string tipo_certificado;
       string modalidad;          
       address owner;           //clave publica de la persona que registro la asistencia
    }
    struct usuario {
        uint IDusuario;
        string nombre;
        string nit;
        string email;
        address owner;
    }
    struct curso {
        uint IDc;
        string nombre_curso;
    }
    
    // creamos un listado de asistentes con la estructura definida anteriormente
   certificado[] public  certificados;  
   usuario[] public usuarios; 
   curso[] public cursos;
    
    mapping (uint => address) public IDdToOwner;   //Creamos un mapeo que nos permite relacionar uno de los registros con la calve publica de la persona que realizo el registro
    mapping (string => uint) curso2IDc;
    mapping (string => bool) curso2estado;
    mapping (string => uint) institucion2IDu;
    mapping (uint => uint) public IDd2nota;
    mapping (uint =>string) public IDd2Link;
    mapping (uint =>string) public IDd2Lugar;
    mapping (address => uint) public pubkey2IDu;
    mapping (address => uint) public saldo;
    mapping (uint => string) public cedula2email;
    mapping (uint => uint) public IDd2cedula;
    mapping (uint => uint[]) public cedula2IDds;
    mapping (uint => uint) public cedula2totalIDds;
    mapping (uint =>uint[]) public IDc2cedulas;
    mapping (uint => uint) public IDc2totalcedulas;
    mapping (uint =>uint[]) public IDc2IDds;
    mapping (uint => uint) public IDc2totalIDds;
    mapping (uint =>uint[]) public IDu2IDds;
    mapping (uint => uint) public IDu2totalIDds;
    
 
    //definimos una función en la cual se ingresan los datos de un nuevo registro al listado de asistentes
    function nuevo_certificado(string memory _curso, string memory _fecha, string memory _estudiante, uint _cedula, string memory _tipo_certificado, string memory _modalidad, string memory _lugar,string memory _link,uint _nota, string memory _email) public { //la función es publica para permitir que cualquier persona pueda registrar la asistencia
        require(saldo[msg.sender]>=1);
        IDu2IDds[pubkey2IDu[msg.sender]].push(IDd);
        IDu2totalIDds[pubkey2IDu[msg.sender]]+=1;
        Array_Element  = (certificados.push(certificado(IDd,_curso,  _fecha,  _estudiante,  _cedula,  _tipo_certificado,  _modalidad, msg.sender))); // utilizamos la función push para tomar los datos de entrada de la función y agregarlos a nuestro listado
        IDd2nota[IDd]=_nota;
        IDd2Lugar[IDd]=_lugar;
        IDd2Link[IDd]=_link;
        cedula2IDds[_cedula].push(IDd);
        cedula2totalIDds[_cedula]+=1;
        if (curso2estado[_curso]==false){
            curso2estado[_curso]=true;
            cursos.push(curso(IDc,_curso));
            curso2IDc[_curso]=IDc;
            IDc+=1;
        }
        IDc2totalcedulas[curso2IDc[_curso]]+=1;
        IDc2totalIDds[curso2IDc[_curso]]+=1;
        IDc2cedulas[curso2IDc[_curso]].push(_cedula);
        IDc2IDds[curso2IDc[_curso]].push(IDd);
        cedula2email[_cedula]=_email;
        IDd2cedula[IDd]=_cedula;
        IDdToOwner[IDd] = msg.sender; // actualizamos el mapeo, relacionando el ID registrado con la clave publica que ejecuto la transaccion
        IDd = Array_Element; // Actulizamos la cuenta de los registros
        saldo[msg.sender]-=1;
    }
    
    function nuevo_usuario(string memory _nombre, string memory _nit, string memory _email, address _owner) public onlyOwner{
        usuarios.push(usuario(IDu,_nombre,_nit,_email,_owner));
        pubkey2IDu[_owner]=IDu;
        institucion2IDu[_nombre]=IDu;
        IDu+=1;
    }
    function recargar(address _pk_usuario, uint _valor) public onlyOwner{
        saldo[_pk_usuario]+=_valor;
    }
    function consultarIDc(string memory _curso) public view returns(uint _IDc){
        return (curso2IDc[_curso]);
    }
    function consultarIDu(string memory _institucion) public view returns(uint _IDu){
        return (institucion2IDu[_institucion]);
    }
}