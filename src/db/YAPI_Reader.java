package db;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class YAPI_Reader {

	private static HashMap<String, String> tag;
	public static final List<String> DEFAULT_ATTRIBUTES;

	static {
		tag = new HashMap<String, String>();
		tag.put("Annualized Gain", "g3");
		tag.put("Ask", "a0");
		tag.put("Ask Size", "a5");
		tag.put("Average Daily Volume", "a2");
		tag.put("Bid", "b0");
		tag.put("Bid Size", "b6");
		tag.put("Book Value Per Share", "b4");
		tag.put("Change", "c1");
		tag.put("Change In Percent", "c0");
		tag.put("Change From Fifty-day Moving Average", "m7");
		tag.put("Change From Two Hundred-day Moving Average", "m5");
		tag.put("Change From Year High", "k4");
		tag.put("Change From Year Low", "j5");
		tag.put("Change In Percent", "p2");
		tag.put("Day High", "h0");
		tag.put("Day Low", "g0");
		tag.put("Day Range", "m0");
		tag.put("Day Value Change", "w1");
		tag.put("Dividend Pay Date", "r1");
		tag.put("Trailing Annual Dividend Yield", "d0");
		tag.put("Trailing Annual Dividend Yield In Percent", "y0");
		tag.put("Diluted EPS", "e0");
		tag.put("EBITDA", "j4");
		tag.put("EPS Estimate Current Year", "e7");
		tag.put("EPS Estimate Next Quarter", "e9");
		tag.put("EPS Estimate Next Year", "e8");
		tag.put("Ex Dividend Date", "q0");
		tag.put("Fifty-day Moving Average", "m3");
		tag.put("Shares Float", "f6");
		tag.put("High Limit", "l2");
		tag.put("Holdings Gain", "g4");
		tag.put("Holdings Gain Percent", "g1");
		tag.put("Holdings Value", "v1");
		tag.put("Last Trade Date", "d1");
		tag.put("Last Trade Price Only", "l1");
		tag.put("Last Trade Size", "k3");
		tag.put("Last Trade Time", "t1");
		tag.put("Last Trade With Time", "l0");
		tag.put("Low Limit", "l3");
		tag.put("Market Capitalization", "j1");
		tag.put("Name", "n0");
		tag.put("One-yr Target Price", "t8");
		tag.put("Open", "o0");
		tag.put("PEG Ratio", "r5");
		tag.put("PE Ratio", "r0");
		tag.put("Percent Change From Fifty-day Moving Average", "m8");
		tag.put("Percent Change From Two-Hundred-day Moving Average", "m6");
		tag.put("Change In Percent From Year High", "k5");
		tag.put("Percent Change From Year Low", "j6");
		tag.put("Previous Close", "p0");
		tag.put("Price", "l1");
		tag.put("Price Book", "p6");
		tag.put("Price EPS Estimate Current Year", "r6");
		tag.put("Price EPS Estimate Next Year", "r7");
		tag.put("Price Sales", "p5");
		tag.put("Revenue", "s6");
		tag.put("Shares Owned", "s1");
		tag.put("Shares Outstanding", "j2");
		tag.put("Short Ratio", "s7");
		tag.put("Stock Exchange", "x0");
		tag.put("Ticker", "s0");
		tag.put("Two Hundred-day Moving Average", "m4");
		tag.put("Volume", "v0");
		tag.put("Year High", "k0");
		tag.put("Year Low", "j0");
		tag.put("Year Range", "w0");
		
		DEFAULT_ATTRIBUTES = new ArrayList<String>();
		DEFAULT_ATTRIBUTES.add("Ticker");
		DEFAULT_ATTRIBUTES.add("Name");
		DEFAULT_ATTRIBUTES.add("Last Trade Price Only");
		DEFAULT_ATTRIBUTES.add("Change In Percent");
		DEFAULT_ATTRIBUTES.add("PE Ratio");
		DEFAULT_ATTRIBUTES.add("Market Capitalization");
		DEFAULT_ATTRIBUTES.add("Diluted EPS");
		DEFAULT_ATTRIBUTES.add("PEG Ratio");
		DEFAULT_ATTRIBUTES.add("Revenue");		
	}


	public static void main(String args[]) {
		try {
			System.out.println("Getting prices...");
			List<String> tickers = new ArrayList<String>();
			tickers.add("GOOG");
			tickers.add("YHOO");
			tickers.add("AAPL");
			List<BigDecimal> prices = getPrices(tickers);
			for (int i = 0; i < prices.size(); i++) {
				System.out.println(prices.get(i));
			}
			System.out.println();

			System.out.println("Getting stock quotes with default attributes...");
			List<String> quotes = getStockQuotes(tickers);
			for (int i = 0; i < quotes.size(); i++) {
				System.out.println(quotes.get(i));
			}
			System.out.println();

			List<String> attributes = new ArrayList<String>();
			attributes.add("Name");
			attributes.add("Ticker");
			attributes.add("Bid");
			attributes.add("Price");
			System.out.println("Getting stock quotes with custom attributes...");
			quotes = getStockQuotes(tickers, attributes);
			for (int i = 0; i < quotes.size(); i++) {
				System.out.println(quotes.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static List<BigDecimal> getPrices(List<String> tickers) throws Exception {
		StringBuilder url = new StringBuilder("http://download.finance.yahoo.com/d/quotes.csv?s=");
		for (int i = 0; i < tickers.size() - 1; i++) {
			url.append(tickers.get(i));
			url.append(",");
		}
		url.append(tickers.get(tickers.size() - 1));
		url.append("&f=l1&e=.csv");
		
		URL stock = new URL(url.toString());
		BufferedReader in = new BufferedReader(new InputStreamReader(stock.openStream()));
		List<BigDecimal> prices = new ArrayList<BigDecimal>();
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			prices.add(new BigDecimal(inputLine));
		}

		in.close();
		return prices;
	}

	public static BigDecimal getPrice(String ticker) throws Exception {
		StringBuilder url = new StringBuilder("http://download.finance.yahoo.com/d/quotes.csv?s=");
		url.append(ticker);
		url.append("&f=l1&e=.csv");
		
		URL stock = new URL(url.toString());
		BufferedReader in = new BufferedReader(new InputStreamReader(stock.openStream()));
		return new BigDecimal(in.readLine());
	}

	public static List<String> getStockQuotes(List<String> tickers, List<String> attributes) throws Exception {
		StringBuilder url = new StringBuilder("http://download.finance.yahoo.com/d/quotes.csv?s=");
		for (int i = 0; i < tickers.size() - 1; i++) {
			url.append(tickers.get(i));
			url.append(",");
		}
		url.append(tickers.get(tickers.size() - 1));
		
		StringBuilder header = new StringBuilder();
		StringBuilder tags = new StringBuilder();
		for (int i = 0; i < attributes.size(); i++) {
			tags.append(tag.get(attributes.get(i)));
			header.append(attributes.get(i) + ",");
		}
		
		url.append("&f=");
		url.append(tags.toString());
		url.append("&e=.csv");
		
		URL stock = new URL(url.toString());
		BufferedReader in = new BufferedReader(new InputStreamReader(stock.openStream()));
		List<String> quotes = new ArrayList<String>();
		quotes.add(header.substring(0, header.length()-1));

	
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			quotes.add(inputLine);
		}
		in.close();
		return quotes;
	}

	public static List<String> getStockQuotes(List<String> tickers) throws Exception {
		return getStockQuotes(tickers, DEFAULT_ATTRIBUTES);
	}
}
