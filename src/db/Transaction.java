package db;

import java.math.BigDecimal;

public class Transaction {
	
	public String PID;
	public String ticker;
	public int num_shares;
	public BigDecimal price;
	public String type;
	public java.sql.Timestamp time;
	
    public Transaction() {}
    
    public Transaction(String PID, String ticker, int num_shares, BigDecimal price, String type, java.sql.Timestamp timestamp) {
        this.PID = PID;
        this.ticker=ticker;
        this.num_shares=num_shares;
        this.price=price;
        this.type=type;
        this.time=timestamp;
    }
}
