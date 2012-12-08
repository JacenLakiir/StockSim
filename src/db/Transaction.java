package db;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaction {
	
	private String PID;
	private String ticker;
	private int num_shares;
	private BigDecimal price;
	private String type;
	private Timestamp time;
	
    public Transaction() {}
    
    public Transaction(String PID, String ticker, int num_shares, BigDecimal price, String type, Timestamp timestamp) {
        this.PID = PID;
        this.ticker=ticker;
        this.num_shares=num_shares;
        this.price=price;
        this.type=type;
        this.time=timestamp;
    }
    
    public String getPID() {
    	return PID;
    }
    
    public String getTicker() {
    	return ticker;
    }
    
    public int getNumShares() {
    	return num_shares;
    }
    
    public BigDecimal getPrice() {
    	return price;
    }
    
    public String getType() {
    	return type;
    }
    
    public Timestamp getTime() {
    	return time;
    }
}
