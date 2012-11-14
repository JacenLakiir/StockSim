package db;

import java.math.BigDecimal;
import java.util.ArrayList;

public class Portfolio {
	public class Stock{

		  public final String ticker;
		  public int num_shares;
		  public BigDecimal avg_price_bought;
		 
		  
		  public Stock(String ticker, int num_shares, BigDecimal avg_price_bought) {
		    this.ticker = ticker;
		    this.num_shares = num_shares;
		    this.avg_price_bought=avg_price_bought;
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
		  
		  public void addShares(int num, BigDecimal price){
			  
			  double new_price = (avg_price_bought.doubleValue()*num_shares + price.doubleValue()*num)/(num+num_shares);
			  num_shares+=num;
			  BigDecimal dec_price = new BigDecimal(new_price);
			  dec_price.setScale(2, dec_price.ROUND_HALF_UP);
			  avg_price_bought = dec_price;
			  
		  }

		}
	public ArrayList<Stock> StockHoldings;
	public String name;
	public java.sql.Timestamp time_created;
	public BigDecimal cash;
	
	public Portfolio(){}
	
	public void set_name(String name){
		this.name = name;
	}
	
	public Portfolio(String name, java.sql.Timestamp time, BigDecimal cash){
		this.name=name;
		this.time_created=time;
		this.cash=cash;
		StockHoldings = new ArrayList<Stock>();
	}
	public void addStock(String ticker, int num_shares, BigDecimal avg_price_bought){
		Stock s = new Stock(ticker, num_shares,avg_price_bought);
		if(StockHoldings.contains(s)){
			StockHoldings.get(StockHoldings.indexOf(s)).addShares(num_shares, avg_price_bought);
		}
		else StockHoldings.add(s);
	}

}
