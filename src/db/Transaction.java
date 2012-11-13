package db;

import java.math.BigDecimal;

public class Transaction {
	public String PID;
	public String ticker;
	public int num_shares;
	public BigDecimal price;
	public String type;
	public java.sql.Timestamp time;
	
    public Transaction() {
    }
    
    public Transaction(String PID, String ticker, int num_shares, BigDecimal price, String type, java.sql.Timestamp timestamp) {
        this.PID = PID;
        this.ticker=ticker;
        this.num_shares=num_shares;
        this.price=price;
        this.type=type;
        this.time=timestamp;
    }
  /*  public String toString() {
        String string = "";
        string += "Name: " + name + "\n";
        string += "Address: " + address + "\n";
        string += "Beer(s) liked: ";
        for (int i=0; i<beersLiked.size(); i++) {
            if (i > 0) string += ", ";
            string += beersLiked.get(i);
        }
        string += "\n";
        string += "Bar(s) frequented: ";
        for (int i=0; i<barsFrequented.size(); i++) {
            if (i > 0) string += ", ";
            string += barsFrequented.get(i);
            string += " (" + timesFrequented.get(i) + " time(s) a week)";
        }
        string += "\n";
        return string;
    }*/
    
  

}
