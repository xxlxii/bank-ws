package com.illyum.types;

public class TransferRequest {

	//
	// Money must be never be handled in floats or doubles
	// For this demo sample, this handling is intentional
	// A future version will use an appropiate Money handler
	//
	
	private int sourceAccount;
	private int targetAccount;
	private double amount;

	public int getSourceAccount() {
		return sourceAccount;
	}

	public int getTargetAccount() {
		return targetAccount;
	}

	public double getAmount() {
		return amount;
	}
	
	public TransferRequest() {
	}
	
	public TransferRequest(int sourceAccount, int targetAccount, double amount){
		this.sourceAccount = sourceAccount;
		this.targetAccount = targetAccount;
		this.amount = amount;
	}
}
