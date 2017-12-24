// need to declare now in solidity 4 and above
pragma solidity ^0.4.0;

contract ownedByAlan{
	
	string public brandName = "Alan";

	address public owner;

	// constructor funtion to set the owner to be the address of the sender of the contract
	function ownedByAlan() public {
		owner = msg.sender;
	}

	// used to modify a function and only allow the owner to execute wherever present
	modifier onlyOwner {
		// if the sender is not the owner, don't let them continue
		if(msg.sender != owner){
			// throw is deprecated, now revert();
			revert();
		// else, let them execute function
		}else{
			_;
		}
	}

	// needs to be after modifier to use..

	// allow the owner to kill the contract
	// you can't destory a contract but you can mute it, and make functionality no longer work
	function killTheContract() public onlyOwner {
		// once you tell the contract to commit suicide, any ether stored in the contract will be sent to the owner of the contract
		selfdestruct(owner);
	}
}

// inherits the functionality of the contract ownedByAlan
// once this contract is deployed, ownedByAlan contract is essentially deployed immediately after, 
// and this contract gets those properties afterwards
contract EthereumCourse is ownedByAlan{
	
	struct Student{
		string studentName;
		uint studentAge;
		bool active;
	}

	uint256 public fee;

	mapping(address=>Student) public myStudents;

	// need the payable keyword to make the function able to accept a registration fee
	function Register(string _typeYourName, uint _whatIsYourAge) public payable {
		if(msg.value == fee) {
			myStudents[msg.sender] = Student({
				studentName: _typeYourName,
				studentAge: _whatIsYourAge,
				active: true
			});
		} else {
			// throw is deprecated, now revert();
			revert();
		}
	}

	modifier onlyAfterTenMinutes{
		// now is a built in function to give the current timestamp
		// inserted the current timestamp at the time, lets you use minutes, if specified
		if(now < 1514028558 + 10 minutes){
			// throw is deprecated, now revert();
			revert();
		} else {
			// if now is true, allow user to register
			_;
		}
	}

	// only person who can set the registration fee is the owner, one who created the contract
	// onlyAfterTenMinutes is so that the owner can only interact with contract within 10 minutes, to give users
	// assurance that once a fee has been set, it will stay the same
	function setRegistrationFee(uint256 _fee) public onlyOwner onlyAfterTenMinutes {
		fee = _fee;
	}
}