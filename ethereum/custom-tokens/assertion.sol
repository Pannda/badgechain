contract owned {
	
	address public owner;
	
	function owned() {
		owner = msg.sender;
	}
	
	modifier onlyOwner {
		
		if  (msg.sender != owner) throw;
		_
		
	}
	
	function transferOwnership(address newOwner) onlyOwner {
		
		owner = newOwner;
		
	}
	
}

contract tokenRecipient {
	
	function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData );
	
}

contract assertion {
	
	/* Public variables of the token */
	string public standard = 'Open Badges Assertion Token';
	string public jsonLDContext = 'https://w3id.org/openbadges/v1';
	string public jsonLDType = 'Assertion';
	string public name;
	string public symbol;
	uint8 public decimals;
	uint256 public totalSupply;
	
	/* This creates an array with all balances */
	mapping (address => uint256) public balanceOf;
	
	/* This generates a public event on the blockchain that will notify clients */
	event Transfer(address indexed from,  address indexed to, uint256 value);
	
	/* Initializes contract with initial supply tokens to the creator of the contract */
	function assertion(
		uint256 initialSupply,
		string tokenName,
		uint8 decimalUnits,
		string tokenSymbol
	)  {
		
		balanceOf[msg.sender] = initialSupply;
		totalSupply =  initialSupply;
		name = tokenName;
		symbol = tokenSymbol;
		decimals = decimalUnits;
		
	}
	
	function transfer(address _to, uint256 _value) {
		
		if (balanceOf[msg.sender] < _value) throw;
		if (balanceOf[_to] + _value < balanceOf[_to]) throw;
		
	}
	
	function () {
		throw;
	}
	
	
}
