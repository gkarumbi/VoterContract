// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//This contract is meant to tract a voter location and whether they have voter and checks for what they voter for

contract VoterContract {
    struct Voter{
        string name;
        uint256 Id; //Changed this from uint to uint256
        string location;
        string presidentialCandidate;
        string memberOfParliament;
        bool hasVoted;
    }
    //step 1: We are going to use mapping to track a voter to a voter
//mapping to track whether a voter has voted, by ID

    mapping(uint256 => bool) public hasVoted; //changed for string to unint, my initial thought was to conduct searches by voter name 

//mapping to track the presidential candidate each voter has voted for

    mapping(uint256 => string) public voterToPresidentialCandidate;

    //Step 2: Create an array to track voters

    Voter[] public listOfVoters; 

/**
* @dev Adds a new voter to the list 
* @param _name The name of the voter.
* @param _Id The unique ID of the voter
* @param _location The location of the voter
*/

//How do I make sure only the voter can vote
    function createVoter(string memory _name, uint256 _Id, string memory _location) public {
        //What I am missing  how do I create a voter object in all the methods and do I need to pass in all the parameter
        //Voter voter = new Voter();
        require(!hasVoted[_Id], "Voter already exists");//Ensure voter already exists
        //create a voter object with defaul values for voting fields

        listOfVoters.push(Voter({
            name :_name,
            Id :_Id,
            location: _location,
            presidentialCandidate: "",
            memberOfParliament : "",
            hasVoted: false
    })
    );
    }
/**
* @dev Records a voter for a voter 
* @param _Id The unique ID of the voter
* @param _presidentialCandidate The presidential candidate the voter is voting for
* @param _memberOfParliament The member of parliament the voter is voting for
*/

//making it internal so that no external contract can access it
//changed the order of functions

    function vote( uint256 _Id, string memory _presidentialCandidate, string memory _memberOfParliament) internal {
       
       require(!hasVoted[_Id], "Voter has already voted");
       //Find the voter in a list and update their details

       for (uint256 i =0; i <listOfVoters.length; i++){
        if(listOfVoters[i].Id == _Id){
            listOfVoters[i].presidentialCandidate = _presidentialCandidate;
            listOfVoters[i].memberOfParliament = _memberOfParliament;
            listOfVoters[i].hasVoted = true;
            hasVoted[_Id] = true;

            voterToPresidentialCandidate[_Id] = _presidentialCandidate;
            break ;

        }
       }
        //presidenticalCandidate = _presidentialCandidate;
        //memberOfParliament = _memberOfParliament;


    }



        //What I am missing how I read the voter object from the block chain and dont I need to return something
    function getVoterByID(uint _Id)public view returns(string memory name, string memory location, string memory presidenticalCandidate, string memory memberOfParliament, bool hasVotedStatus) {

        //made note of the fact that we do  not need to return all the key values' from our struct, new object introduced hasVotedStatus
       // return voterToPresidentialCandidate[_Id];

       for (uint256 i =0; i<listOfVoters.length; i++) 
       {
        if(listOfVoters[i].Id == _Id){

            //what this method of creating a voter object
            Voter memory voter = listOfVoters[i];
            return (
                voter.name,
                voter.location, // and how come we are not returning the id
                voter.presidentialCandidate,
                voter.memberOfParliament,
                voter.hasVoted //why not has voted status
            );
        }
       }

       revert("Voter not found."); //Handle case where voter ID does not exist
    }


}
    
