import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Array "mo:base/Array";


actor LoanPlatform {
  type Loan = {
    id: Nat;  // Storing the id of loan 
    borrower: Principal; // Identity of borrower
    lender: Principal; // Identity if lender
    amount: Nat; // Amount to be tranfered or lended
    interestRate: Nat;  // Stored as percentage (e.g., 5% is stored as 5).
    collateral: Nat; // Assests to be secured for loan
    status: Text;  // Status of loan example "Pending," "Active," "Completed," etc.
  };

  var loans : [Loan] = [];

  public shared({caller}) func createLoan(borrower: Principal, amount: Nat, interestRate: Nat, collateral: Nat) : async Loan {
    // Handels the case where amount is less than 0
    if(amount <= 0){
      let invalidLoan1 : Loan = { id = 0; borrower = caller; lender = caller; amount = 0; interestRate = 0; collateral = 0; status = "Can Not Process Loan Because Of Invalid Amount" };
      return invalidLoan1;
    };
    // Handels the case where intrest rate is less than 0
    if(interestRate <= 0){
      let invalidLoan2 : Loan = { id = 0; borrower = caller; lender = caller; amount = 0; interestRate = 0; collateral = 0; status = "Can Not Process Loan Because Of Invalid Intrest Rate" };
      return invalidLoan2;
    };
    // Handels the case where collateral amount is less than 0
    if(collateral <= 0){
      let invalidLoan3 : Loan = { id = 0; borrower = caller; lender = caller; amount = 0; interestRate = 0; collateral = 0; status = "Can Not Process Loan Because Of Invalid Collateral Amount" };
      return invalidLoan3;
    };
    //let loansLength = Array.size(loans);
    let newLoan : Loan = {
      id = loans.size();
      borrower = borrower;
      lender = caller;
      amount = amount;
      interestRate = interestRate;
      collateral = collateral;
      status = "Pending";
    };
    loans := Array.append(loans, [newLoan]);

    newLoan
  };

  public shared({caller}) func fundLoan(loanId: Nat) : async Text {
    if (loanId >= loans.size()) {
      // Handle the error gracefully
      return "Invalid loan ID.";
    };

    let loan = loans[loanId];
    if(caller == loan.borrower){
      return "Lender cannot fund their own loan."
    };
    if(loan.status != "Pending"){
      return "Loan is not pending funding.";
    };


    let updatedLoan : Loan = {
    id = loan.id;
    borrower = loan.borrower;
    lender = loan.lender;
    amount = loan.amount;
    interestRate = loan.interestRate;
    collateral = loan.collateral;
    status = "Processed";  // Update the status to "Processed"
    };
    //loans[] := ""

    "Loan funded successfully."
  }
};