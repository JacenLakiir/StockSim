package db;

import java.math.BigDecimal;

public class LeaderBoard {
	
	private String username;
	private String portfolioName;
	private BigDecimal marketValue;
	
	public LeaderBoard(String username, String portfolioName, BigDecimal marketValue){
		this.username = username;
		this.portfolioName = portfolioName;
		this.marketValue = marketValue;
	}
	
	public String getUsername(){
		return username;
	}
	public String getPortfolioName(){
		return portfolioName;
	}
	public BigDecimal getMarketValue(){
		return marketValue;
	}
}
