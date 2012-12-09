package db;

import java.math.BigDecimal;

public class LeaderBoard {
	private String username;
	private String Portfolio_Name;
	private BigDecimal marketValue;
	
	public LeaderBoard(String username, String portfolioName, BigDecimal marketValue){
		this.username = username;
		this.Portfolio_Name = portfolioName;
		this.marketValue = marketValue;
	}
	
	public String getUsername(){
		return username;
	}
	public String getPortfolioName(){
		return Portfolio_Name;
	}
	public BigDecimal getMarketValue(){
		return marketValue;
	}
}
