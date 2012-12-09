package db;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class Portfolio {

	private String PID;
	private String name;
	private String username;
	private Timestamp timeCreated;
	private BigDecimal cash;
	
	private List<Stock> stockHoldings;

	public Portfolio(String PID) {
		this.PID = PID;
		stockHoldings = new ArrayList<Stock>();
	}
	
	public Portfolio(String name, String username, BigDecimal cash) {
		this.name = name;
		this.username = username;
		this.cash = cash;
		stockHoldings = new ArrayList<Stock>();
	}
	
	public Portfolio(String name, Timestamp timeCreated, BigDecimal cash) {
		this.name = name;
		this.timeCreated = timeCreated;
		this.cash = cash;
		stockHoldings = new ArrayList<Stock>();
	}
	
	public Portfolio(String PID, String name, String username, Timestamp timeCreated, BigDecimal cash) {
		this(name, username, cash);
		this.PID = PID;
		this.username = username;
		this.timeCreated = timeCreated;
	}
	
	public void addStock(String ticker, int num_shares, BigDecimal avg_price_bought) {
		Stock s = new Stock(ticker, num_shares, avg_price_bought);
		if (stockHoldings.contains(s)) {
			stockHoldings.get(stockHoldings.indexOf(s)).addShares(num_shares, avg_price_bought);
		}
		else stockHoldings.add(s);
	}
	
	public static class NameComparator implements Comparator<Portfolio> {
		@Override
		public int compare(Portfolio p1, Portfolio p2) {
			return p1.getName().compareTo(p2.getName());
		}
	}

	public String getPID() {
		return PID;
	}
	
	public String getName() {
		return name;
	}
	
	public String getUsername() {
		return username;
	}
	
	public Timestamp getTimeCreated() {
		return timeCreated;
	}
	
	public BigDecimal getCash() {
		return cash;
	}
	
	public List<Stock> getStockHoldings() {
		return stockHoldings;
	}
}
