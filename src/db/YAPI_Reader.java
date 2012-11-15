package db;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

public class YAPI_Reader {
	
	HashMap<String,String> tag = new HashMap<String,String>();
	
	public String DEFAULT_ATTRIBUTES="s0n0l1p2r0j1e0r5s6";
	
	public static void main(String args[]){
		YAPI_Reader y = new YAPI_Reader();
		try {
			ArrayList<String> tickers = new ArrayList();
			tickers.add("GOOG");
			tickers.add("YHOO");
			tickers.add("AAPL");
			ArrayList<BigDecimal> prices = y.getPrice(tickers);
			for(int i=0;i<prices.size();i++) System.out.println(prices.get(i));
			
			
			ArrayList<String> quotes = y.getStockQuotes(tickers);
			for(int i=0;i<quotes.size();i++) System.out.println(quotes.get(i));
			
			ArrayList<String> attributes=new ArrayList<String>();
			attributes.add("Name");
			attributes.add("Ticker");
			attributes.add("Bid");
			attributes.add("Price");
			quotes = y.getStockQuotes(tickers,attributes);
			for(int i=0;i<quotes.size();i++) System.out.println(quotes.get(i));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public YAPI_Reader(){
		 tag.put("Annualized Gain","g3");
		 tag.put("Ask","a0");
		 tag.put("Ask Size","a5");
		 tag.put("Average Daily Volume","a2");
		 tag.put("Bid","b0");
		 tag.put("Bid Size","b6");
		 tag.put("Book Value Per Share","b4");
		 tag.put("Change","c1");
		 tag.put("Change In Percent","c0");
		 tag.put("Change From Fifty-day Moving Average","m7");
		 tag.put("Change From Two Hundred-day Moving Average","m5");
		 tag.put("Change From Year High","k4");
		 tag.put("Change From Year Low","j5");
		 tag.put("Change In Percent","p2");
		 tag.put("Day High","h0");
		 tag.put("Day Low","g0");
		 tag.put("Day Range","m0");
		 tag.put("Day Value Change","w1");
		 tag.put("Dividend Pay Date","r1");
		 tag.put("Trailing Annual Dividend Yield","d0");
		 tag.put("Trailing Annual Dividend Yield In Percent","y0");
		 tag.put("Diluted EPS","e0");
		 tag.put("EBITDA","j4");
		 tag.put("EPS Estimate Current Year","e7");
		 tag.put("EPS Estimate Next Quarter","e9");
		 tag.put("EPS Estimate Next Year","e8");
		 tag.put("Ex Dividend Date","q0");
		 tag.put("Fifty-day Moving Average","m3");
		 tag.put("Shares Float","f6");
		 tag.put("High Limit","l2");
		 tag.put("Holdings Gain","g4");
		 tag.put("Holdings Gain Percent","g1");
		 tag.put("Holdings Value","v1");
		 tag.put("Last Trade Date","d1");
		 tag.put("Last Trade Price Only","l1");
		 tag.put("Last Trade Size","k3");
		 tag.put("Last Trade Time","t1");
		 tag.put("Last Trade With Time","l0");
		 tag.put("Low Limit","l3");
		 tag.put("Market Capitalization","j1");
		 tag.put("Name","n0");
		 tag.put("One-yr Target Price","t8");
		 tag.put("Open","o0");
		 tag.put("PEG Ratio","r5");
		 tag.put("PE Ratio","r0");
		 tag.put("Percent Change From Fifty-day Moving Average","m8");
		 tag.put("Percent Change From Two-Hundred-day Moving Average","m6");
		 tag.put("Change In Percent From Year High","k5");
		 tag.put("Percent Change From Year Low","j6");
		 tag.put("Previous Close","p0");
		 tag.put("Price","l1");
		 tag.put("Price Book","p6");
		 tag.put("Price EPS Estimate Current Year","r6");
		 tag.put("Price EPS Estimate Next Year","r7");
		 tag.put("Price Sales","p5");
		 tag.put("Revenue","s6");
		 tag.put("Shares Owned","s1");
		 tag.put("Shares Outstanding","j2");
		 tag.put("Short Ratio","s7");
		 tag.put("Stock Exchange","x0");
		 tag.put("Ticker","s0");
		 tag.put("Two Hundred-day Moving Average","m4");
		 tag.put("Volume","v0");
		 tag.put("Year High","k0");
		 tag.put("Year Low","j0");
		 tag.put("Year Range","w0");
	}
	
	 public ArrayList<BigDecimal> getPrice(ArrayList<String> tickers) throws Exception{
		 	String url = "http://download.finance.yahoo.com/d/quotes.csv?s=";
		 	for(int i=0;i<tickers.size()-1;i++){
		 		url+=(tickers.get(i)+",");
		 	}
		 	url += tickers.get(tickers.size()-1)+"&f=l1&e=.csv";
	    	URL stock = new URL(url);
	        BufferedReader in = new BufferedReader(
	        new InputStreamReader(stock.openStream()));
	        ArrayList<BigDecimal> prices = new ArrayList<BigDecimal>();
	        
	        String inputLine;
	        while ((inputLine = in.readLine()) != null){
	        	prices.add(new BigDecimal(inputLine));
	        }
	 
	        in.close();
	        return prices;
	        
	    }

	 
	 public ArrayList<String> getStockQuotes(ArrayList<String> tickers, String attributes) throws Exception{
		 String url = "http://download.finance.yahoo.com/d/quotes.csv?s=";
		 	for(int i=0;i<tickers.size()-1;i++){
		 		url+=(tickers.get(i)+",");
		 	}
		 	url += tickers.get(tickers.size()-1)+"&f="+attributes+"&e=.csv";
	    	URL stock = new URL(url);
	        BufferedReader in = new BufferedReader(
	        new InputStreamReader(stock.openStream()));
	        ArrayList<String> quotes = new ArrayList<String>();
	        //String header = "Ticker,Name,Price,% Change,P/E,Market Cap,Diluted EPS,PEG Ratio,Revenue";
	        //quotes.add(header);
	        
	        String inputLine;
	        while ((inputLine = in.readLine()) != null){
	        	quotes.add(inputLine);
	        }
	 
	        in.close();
	        return quotes;
	 }
	 
	 public ArrayList<String> getStockQuotes(ArrayList<String> tickers) throws Exception{
		 return getStockQuotes(tickers, DEFAULT_ATTRIBUTES);
	 }
	 
	 public ArrayList<String> getStockQuotes(ArrayList<String> tickers, ArrayList<String> attributes) throws Exception{
		 String tags="";
		 for(int i=0;i<attributes.size();i++){
			 tags+=tag.get(attributes.get(i));
		 }
		 return getStockQuotes(tickers, tags);
	 }
}
