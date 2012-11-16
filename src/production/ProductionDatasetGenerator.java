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
	
	private File output = new File("samples/PRODUCTION-SAMPLE.sql");
	private Random rand = new Random(55);
	private BufferedWriter bw;
	
	public static void main(String args[]) {
		ProductionDatasetGenerator pdg = new ProductionDatasetGenerator();
		try {
			pdg.make_Users(NUM_USERS);
		} catch (IOException e1) {
			System.out.println("Failed to make Users");
			e1.printStackTrace();
		}
		try {
			pdg.make_Portfolios(MAX_PORTFOLIOS);
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

	public void make_Users(int num_users) throws IOException {
		for (int i = 0; i < num_users; i++) {
			bw.write("INSERT INTO Users VALUES('User" + i + "', 'password', 'User" + i + "@duke.edu');\n");
		}
	}

	public void make_Portfolios(int max_Portfolios) throws Exception {
		int id = 0;
		Random randomTransactionSeed = new Random(30);
		for (int i = 0; i < NUM_USERS; i++) {
			int n = rand.nextInt(max_Portfolios + 1);
			for (int j = 0; j < n; j++) {
				bw.write("INSERT INTO Portfolio VALUES('P" + id + "', 'Portfolio " + j + "', 'User" + i + "', now(), 10000);" + "\n");
				make_Transactions(SAMPLE_TICKERS, "P" + id, randomTransactionSeed);
				id++;
			}
		}
	}

	public void make_Transactions(List<String> tickers, String PID, Random seed)
			throws Exception {
		for (int i = 0; i < tickers.size(); i++) {
			String ticker = tickers.get(i);
			int num_shares = seed.nextInt(20);
			BigDecimal price = YAPI_Reader.getPrice(ticker);
			bw.write("INSERT INTO Transaction VALUES('" + PID + "', '" + ticker + "', " + num_shares + ", " + price + ", 'Buy', now());\n");
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