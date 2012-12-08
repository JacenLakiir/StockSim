package db;

import java.math.BigDecimal;

public class LeaderBoard {
	private String Username;
	private String Portfolio_Name;
	private BigDecimal Mkt_Value;
	
	public LeaderBoard(String Username, String name, BigDecimal mktvalue){
		this.Mkt_Value=mktvalue;
		this.Username=Username;
		this.Mkt_Value=mktvalue;
	}
	
	public String getUsername(){
		return Username;
	}
	public String getPortfolioName(){
		return Portfolio_Name;
	}
	public BigDecimal getMktValue(){
		return Mkt_Value;
	}

}
