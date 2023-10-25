import { loan_backend } from "../../declarations/loan_backend";
import {Principal} from "@dfinity/principal";
// Create an instance of the LoanPlatform actor
//const loanPlatform = loan_backend.createActor();

// Handle loan creation form submission
document.getElementById("createLoanForm").addEventListener("submit", async function (event) {
  event.preventDefault();
  console.log("createLoanForm submitted");
  const borrower = document.getElementById("borrower").value;
  const amount = parseInt(document.getElementById("amount").value);
  const interestRate = parseFloat(document.getElementById("interestRate").value);
  const collateral = parseInt(document.getElementById("collateral").value);

  try {
    const response = await loan_backend.createLoan(Principal.fromText(borrower), amount, interestRate, collateral);
    const loanid = response.id;
    alert(`Loan created with ID: ${loanid}`);
    console.log(response);
  } catch (error) {
    // Handle errors
    console.error(error);
  }
});

// Handle loan funding form submission
document.getElementById("fundLoanForm").addEventListener("submit", async function (event) {
  event.preventDefault();
  const loanId = parseInt(document.getElementById("loanId").value);

  try {
    const response = await loan_backend.fundLoan(loanId);
    alert(response);
  } catch (error) {
    // Handle errors
    console.error("Invalid Loan Id");
  }
});
