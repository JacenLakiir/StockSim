package production;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import db.YAPI_Reader;

public class ProductionDatasetGenerator {

	private static final int NUM_USERS = 100;
	private static final int MAX_PORTFOLIOS = 3;
	private static final List<String> SAMPLE_TICKERS;

	static {
		SAMPLE_TICKERS = new ArrayList<String>();
		SAMPLE_TICKERS.add("GOOG");
		SAMPLE_TICKERS.add("YHOO");
		SAMPLE_TICKERS.add("FB");
		SAMPLE_TICKERS.add("AAPL");
		SAMPLE_TICKERS.add("MSFT");
	}
	
	private File output = new File("productions/CREATE-PRODUCTION.sql");
	private Random rand = new Random(55);
	private BufferedWriter bw;
	
	public static void main(String args[]) {
		ProductionDatasetGenerator pdg = new ProductionDatasetGenerator();
		try {
			pdg.makeUsers(NUM_USERS);
		} catch (IOException e1) {
			System.out.println("Failed to make Users");
			e1.printStackTrace();
		}
		try {
			pdg.makePortfolios(MAX_PORTFOLIOS);
		} catch (Exception e) {
			System.out.println("Failed to make Portfolios");
			e.printStackTrace();
		}
		pdg.close();
		System.out.println("Done");
	}

	public ProductionDatasetGenerator() {
		FileWriter fw;
		try {
			fw = new FileWriter(output.getAbsoluteFile());
			bw = new BufferedWriter(fw);
			bw.write("\\c stocksim \n");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void makeUsers(int numUsers) throws IOException {
		for (int i = 0; i < numUsers; i++) {
			StringBuilder insertion = new StringBuilder("INSERT INTO Users VALUES('User");
			insertion.append(i);
			insertion.append("', 'password', 'User");
			insertion.append(i);
			insertion.append("@duke.edu');\n");
			bw.write(insertion.toString());
		}
	}

	public void makePortfolios(int maxPortfolios) throws Exception {
		Random randomTransactionSeed = new Random(30);
		int id = 0;
		for (int i = 0; i < NUM_USERS; i++) {
			int n = rand.nextInt(maxPortfolios + 1);
			for (int j = 0; j < n; j++) {
				StringBuilder insertion = new StringBuilder("INSERT INTO Portfolio VALUES('P");
				insertion.append(id);
				insertion.append("', 'Portfolio ");
				insertion.append(j);
				insertion.append("', 'User");
				insertion.append(i);
				insertion.append("', now(), 10000);\n");
				bw.write(insertion.toString());
				
				makeTransactions("P" + id, randomTransactionSeed);
				id++;
			}
		}
	}

	public void makeTransactions(String PID, Random seed)
			throws Exception {
		for (int i = 0; i < SAMPLE_TICKERS.size(); i++) {
			String ticker = SAMPLE_TICKERS.get(i);
			int numShares = seed.nextInt(20);
			BigDecimal price = YAPI_Reader.getPrice(ticker);
			
			StringBuilder insertion = new StringBuilder("INSERT INTO Transaction VALUES('");
			insertion.append(PID);
			insertion.append("', '");
			insertion.append(ticker);
			insertion.append("', ");
			insertion.append(numShares);
			insertion.append(", ");
			insertion.append(price);
			insertion.append(", 'Buy', now());\n");
			bw.write(insertion.toString());
		}
	}

	public void close() {
		try {
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}