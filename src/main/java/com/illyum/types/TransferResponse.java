package com.illyum.types;

import java.math.BigDecimal;

public class TransferResponse {

	private BigDecimal previousSourceBalance;
	private BigDecimal newSourceBalance;
	private BigDecimal previousTargetBalance;
	private BigDecimal newTargetBalance;
	
	public BigDecimal getPreviousSourceBalance() {
		return previousSourceBalance;
	}
	
	public void setPreviousSourceBalance(BigDecimal sourcePreviousBalance) {
		this.previousSourceBalance = sourcePreviousBalance;
	}
	
	public BigDecimal getNewSourceBalance() {
		return newSourceBalance;
	}
	
	public void setNewSourceBalance(BigDecimal sourceNewBalance) {
		this.newSourceBalance = sourceNewBalance;
	}
	
	public BigDecimal getPreviousTargetBalance() {
		return previousTargetBalance;
	}
	
	public void setPreviousTargetBalance(BigDecimal targetPreviousBalance) {
		this.previousTargetBalance = targetPreviousBalance;
	}
	
	public BigDecimal getNewTargetBalance() {
		return newTargetBalance;
	}
	
	public void setNewTargetBalance(BigDecimal targetNewBalance) {
		this.newTargetBalance = targetNewBalance;
	}
	
	public TransferResponse() {
	}
	
	public TransferResponse(BigDecimal previousSourceBalance, BigDecimal newSourceBalance, BigDecimal previousTargetBalance, BigDecimal newTargetBalance) {
		setPreviousSourceBalance(previousSourceBalance);
		setNewSourceBalance(newSourceBalance);
		setPreviousTargetBalance(previousTargetBalance);
		setNewTargetBalance(newTargetBalance);
	}
	
}
