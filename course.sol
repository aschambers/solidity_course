contract ownedByAlan{
	
	string public brandName = "Alan";

	address public owner;

	// constructor funtion to set the owner to be the address of the sender of the contract
	function ownedByAlan(){
		owner = msg.sender;
	}

	// used to modify a function and only allow the owner to execute wherever present
	modifier onlyOwner {
		// if the sender is not the owner, don't let them continue
		if(msg.sender != owner){
			throw;
		// else, let them execute function
		}else{
			_
		}
	}

	// needs to be after modifier to use..

	// allow the owner to kill the contract
	// you can't destory a contract but you can mute it, and make functionality no longer work
	function killTheContract() onlyOwner {
		// once you tell the contract to commit suicide, any ether stored in the contract will be sent to the owner of the contract
		suicide(owner);
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

	function Register(string _typeYourName, uint _whatIsYourAge){
		if(msg.value == fee){
			myStudents[msg.sender] = Student({
				studentName: _typeYourName,
				studentAge: _whatIsYourAge,
				active: true
			});
		} else {
			throw;
		}
	}

	modifier onlyAfterTenMinutes{
		// now is a built in function to give the current timestamp
		// inserted the current timestamp at the time, lets you use minutes, if specified
		if(now < 1514028558 + 10 minutes){
			throw;
		} else {
			// if now is true, allow user to register
			_
		}
	}

	// only person who can set the registration fee is the owner, one who created the contract
	// onlyAfterTenMinutes is so that the owner can only interact with contract within 10 minutes, to give users
	// assurance that once a fee has been set, it will stay the same
	function setRegistrationFee(uint256 _fee) onlyOwner onlyAfterTenMinutes {
		fee = _fee;
	}
}