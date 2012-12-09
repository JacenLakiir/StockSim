package db;

import java.math.BigDecimal;
import java.util.Comparator;

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
	
	public static class TickerComparator implements Comparator<Stock> {
		@Override
		public int compare(Stock s1, Stock s2) {
			return s1.getTicker().compareTo(s2.getTicker());
		}
	}
	
	public static class NumSharesComparator implements Comparator<Stock> {
		@Override
		public int compare(Stock s1, Stock s2) {
			if (s1.getNumShares() == s2.getNumShares()) {
				return 0;
			}
			return (s1.getNumShares() < s2.getNumShares()) ? -1 : 1;
		}
	}
	
	public String getTicker() {
		return ticker;
	}
	
	public int getNumShares() {
		return num_shares;
	}
	
	public BigDecimal getAvgPriceBought() {
		return avg_price_bought;
	}
}