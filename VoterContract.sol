// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//This contract is meant to tract a voter location and whether they have voter and checks for what they voter for

contract VoterContract {
    struct Voter{
        string name;
        uint Id;
        string location;
        string presidenticalCandidate;
        string memberOfParliament;
        bool hasVoted;
    }
    //step 1: We are going to use mapping to track a voter to a voter

    mapping(string => bool) public hasVoted;
    mapping(uint256 => string) public voterToPresidentialCandidate;

    //Step 2: Create an array to track voters

    Voter[] public listOfVoters; 

//How do I make sure only the voter can voter
    function createVoter(string memory _name, uint _Id, string memory _location, string memory _presidentialCandidate, string memory _memberOfParliament, bool _hasVoted) public  returns(string memory,uint, string memory, string memory, string memory, bool){
        //What I am missing  how do I create a voter object in all the methods and do I need to pass in all the parameter
        //Voter voter = new Voter();
        listOfVoters.push(Voter(_name,_Id,_location,_presidentialCandidate,_memberOfParliament,_hasVoted));



    }
        //What I am missing how I read the voter object from the block chain and dont I need to return something
    function getVoter(uint _Id)public view returns(string memory) {
        return voterToPresidentialCandidate[_Id];
    }
//making it internal so that no external contract can access it
    function vote(string memory _presidentialCandidate, string memory _memberOfParliament) private  returns(string memory, string memory){
        //presidenticalCandidate = _presidentialCandidate;
        //memberOfParliament = _memberOfParliament;


    }
}
