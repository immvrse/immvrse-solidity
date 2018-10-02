pragma solidity ^0.4.0;

contract payrollsrs{

address[] employees =[" "," ", " "];	//put account numbers here
uint totalreceived =0;				//counter of total ethers invested in this account
mapping(address => uint) withdrawnAmounts;	 //a dictionary which enables us to check if the requester has already withdrawn or not

function payrollsrs() payable{
updateTotalReceived();
}

function() payable{
updateTotalReceived(); 				//people can pay in this account
}

function updateTotalReceived() internal{	
totalreceived += msg.value;			//updates the values of invested ethers
}

modifier canWithdraw(){  			//called a function modifier
						//to check if the person requesting the money is actually an employee who can withdraw the money

bool contains=false;				//boolean because we need "yes" or "no"
for(uint i=0;i < employees.length; i++)
{
	if (employees[i]== msg.sender){		// msg.sender is the address of the person requesting
		contains = true;
		}
}
require(contains);
_;
}	
	
function withdraw() canWithdraw {		//"canWithdraw" enables the function to be called so that it could check the requesting person's address

	uint amountAllocated= totalreceived/employees.length; 		//declaring the amount allocated for the requester to withdraw 
	uint amountWithdrawn= withdrawnAmounts[msg.sender];		//check if the "address" has already withdrawn using mapping
	uint amount= amountAllocated- amountWithdrawn;			//update how much they have withdrawn
	withdrawnAmounts[msg.sender] = amountWithdrawn +amount;		//update how much they have withdrawn
	
	if (amount>0){							//if money allocated has not withdrawn
		msg.sender.transfer(amount);
	}


}
}
