// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract YourContract{
    address private main_person;
    //pair<uint,uint> public ngo;
    struct Ngo{
        uint id ;
        uint balance;
    }
    Ngo public ngo;

    struct donors {
         address dad;
         uint dbalance;
    }

    struct TOad {
         address toad;
         uint tobalance;
    }

    struct mangers{
        string name;
        address ad;
        string location;
    }

    mapping (address => bool) private Mcheck;
    mapping (uint => mangers) public Mdetails;
    mapping (address => donors)public Ddetails;
    mapping (address => bool) public DCheck;
    mapping (address => TOad)public TOaddetails;
    mapping (address => bool) public TOCheck;

    constructor(){
        main_person = msg.sender;
        Mcheck[main_person] = true;
        ngo.id = 1234;
        ngo.balance = 0;
    }
    modifier ManagerCheck(){
         require(Mcheck[msg.sender]==true , "you doesn't have access");
        _;
    }
    
    modifier MainCheck(){
        require(main_person == msg.sender , "your are not the main Person to add mangers");
        _;
    }

    function addDonors (uint balance ,address ad)public {
        Ddetails[ad].dad =ad;
        Ddetails[ad].dbalance = balance;
        DCheck[ad]=true;
    }

     function addToad (uint balance ,address ad) public ManagerCheck {
        TOaddetails[ad].toad =ad;
        TOaddetails[ad].tobalance = balance;
        TOCheck[ad]=true;

    }
    function addingManger(uint num ,string memory name , address ad , string memory location ) public MainCheck{
        Mcheck[ad] = true;
        Mdetails[num].name = name;
        Mdetails[num].location = location ;
        Mdetails[num]. ad = ad;

    }
    function Transaction(uint amount, address toad) public payable ManagerCheck{
        require(ngo .balance >= amount ,"no sufficient amount");
        require(TOCheck[toad] = true , "no reciever");
        ngo . balance = ngo .balance - amount;
        TOaddetails[toad].tobalance +=amount;
    }

    function Donation(uint amount)public {
        require(DCheck[msg.sender] = true ,"first register as donor");
        require(Ddetails[msg.sender].dbalance >=amount , "balance is not sufficient");
        Ddetails[msg.sender].dbalance -=amount;
        ngo.balance +=amount;
    }
}