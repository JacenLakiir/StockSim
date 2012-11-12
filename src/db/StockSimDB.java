package db;
import java.sql.*;
import java.util.*;
import javax.sql.*;

import javax.naming.*;

public class StockSimDB {

	protected Connection con = null;
			
	    // Use lots of prepared statements for performance!
	    // Java enum provides a nice way of specifying a static collection
	    // of objects (in this case prepared statements:
	    protected enum PreparedStatementID {
			CreateNewUser("INSERT INTO USER VALUES(?,?,?)"),
			CreateNewPortfolio("INSERT INTO Portfolio VALUES(?, ?, ?, ?);"),
			PerformTransaction("INSERT INTO Transaction VALUES(?, ?, ?, ?, ?, ?)");
			
	        public final String sql;
	        PreparedStatementID(String sql) {
	            this.sql = sql;
	            return;
	        }
	    }
	    
	    protected EnumMap<PreparedStatementID, PreparedStatement> _preparedStatements =
	            new EnumMap<PreparedStatementID, PreparedStatement>(PreparedStatementID.class);
	    
	public StockSimDB() throws NamingException, SQLException{
		connect();
	}
	
	  public void connect() throws NamingException, SQLException {
	        // Is this a reconnection?  If so, disconnect first.
	        if (con != null) disconnect();
	        try {
	            // Use JNDI to look up a data source created by Tomcat:
	            Context context = new InitialContext();
	            Context envContext = (Context)context.lookup("java:/comp/env");
	            DataSource dataSource = (DataSource)envContext.lookup("jdbc/dbcourse");
	            con = dataSource.getConnection();

	            // Prepare statements:
	            for (PreparedStatementID i: PreparedStatementID.values()) {
	                PreparedStatement preparedStatement = con.prepareStatement(i.sql);
	                _preparedStatements.put(i, preparedStatement);
	            }
	        } catch (SQLException e) {
	            if (con != null) disconnect();
	            throw e;
	        }
	    }

	    public void disconnect() {
	        // Close all prepared statements:
	        for (PreparedStatementID i: _preparedStatements.keySet()) {
	            try { _preparedStatements.get(i).close(); } catch (SQLException ignore) {}
	        }
	        _preparedStatements.clear();
	        // Close the database connection:
	        try {con.close(); } catch (SQLException ignore) {}
	        con = null;
	        return;
	    }
	
	public static void main(String args[]){
		
	}
}
