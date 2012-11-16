package db;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
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
		return Collections.unmodifiableList(stockHoldings);
	}
	
	public class Stock {

		private final String ticker;
		private int num_shares;
		private BigDecimal avg_price_bought;	
		  
		public Stock(String ticker, int num_shares, BigDecimal avg_price_bought) {
			this.ticker = ticker;
		    this.num_shares = num_shares;
		    this.avg_price_bought=avg_price_bought;
		}
		  
		//Not completely sure if implemented correctly, hopefully won't need to use it
		public void addShares(int num, BigDecimal price) {
			double new_price = (avg_price_bought.doubleValue()*num_shares + price.doubleValue()*num)/(num+num_shares);
			num_shares += num;
			BigDecimal dec_price = new BigDecimal(new_price);
			dec_price.setScale(2, BigDecimal.ROUND_HALF_UP);
			avg_price_bought = dec_price;
		}

		@Override
		public int hashCode() { return ticker.hashCode(); }

		@Override
		public boolean equals(Object o) {
			if (o == null) return false;
		    if (!(o instanceof Stock)) return false;
		    Stock s2 = (Stock) o;
		    return this.ticker.equals(s2.ticker);
		}
		
		public String getTicker() {
			return ticker;
		}
		
		public int getNumShares() {
			return num_shares;
		}
	}
}
