import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import de.l3s.boilerpipe.BoilerpipeExtractor;
import de.l3s.boilerpipe.extractors.CommonExtractors;
import de.l3s.boilerpipe.sax.HTMLHighlighter;


public class scrapeLinks {

	public static void main(String[] args)
	{
				System.out.println("anything?");
				//add bing results pages to this array
				//for example, the first link displayed is the results page for "macbook air reviews"
				String[] bing = {"http://www.bing.com/search?q=macbook%20air%20reviews&qs=n&form=QBRE&pq=macbook%20air%20reviews&sc=8-14&sp=-1&sk=&cvid=c6a7ce52f92a426b9d5d61c118e75a10",
						"http://www.bing.com/search?q=macbook+air+reviews&qs=n&pq=macbook+air+reviews&sc=8-14&sp=-1&sk=&cvid=c6a7ce52f92a426b9d5d61c118e75a10&first=7&FORM=PERE",
						"http://www.bing.com/search?q=surface%20pro%20reviews&qs=n&form=QBRE&pq=surface%20pro%20reviews&sc=8-19&sp=-1&sk=&cvid=5f1861f7e7e749dd88d16570ac2f6422",
						"http://www.bing.com/search?q=surface+pro+reviews&qs=n&pq=surface+pro+reviews&sc=8-19&sp=-1&sk=&cvid=5f1861f7e7e749dd88d16570ac2f6422&first=7&FORM=PERE",
						"http://www.bing.com/search?q=chromebook%20reviews&qs=n&form=QBRE&pq=chromebook%20reviews&sc=8-17&sp=-1&sk=&cvid=dfbeb9275eeb48549b17a6961b9c8f36",
						"http://www.bing.com/search?q=chromebook+reviews&qs=n&pq=chromebook+reviews&sc=8-17&sp=-1&sk=&cvid=dfbeb9275eeb48549b17a6961b9c8f36&first=8&FORM=PERE"
				};
				ArrayList<String> al = new ArrayList<String>();
				for(String s : bing)
					addLinks(s, al);
				InputStream is = null;
				URL url = null;
				for(String s : al)
				{
					boilerpipe(s);
				}
	}
	
	public static void boilerpipe(String link)
	{
		try
		{			
			URL url = new URL(link);
			// choose from a set of useful BoilerpipeExtractors...
			final BoilerpipeExtractor extractor = CommonExtractors.ARTICLE_EXTRACTOR;
			// choose the operation mode (i.e., highlighting or extraction)
		        final HTMLHighlighter hh = HTMLHighlighter.newExtractingInstance();
			
			PrintWriter out = new PrintWriter("corpus/laptops/" + reformat(link) + ".html", "UTF-8");
			String ret = "";
			ret += "<base href=\"" + url + "\" >";
			ret += "<meta http-equiv=\"Content-Type\" content=\"text-html; charset=utf-8\" />";
			ret += hh.process(url, extractor);
			out.println(ret);
			out.close();
			
		} catch (Throwable t)
		{
			t.printStackTrace();
		}
	}
	
	public static String reformat(String s)
	{
		String ret  = "";
		for(String c : s.split("/"))
		{
			ret += c + " ";
		}
		return ret;
	}
	
	public static void addLinks(String url, ArrayList<String> al)
	{
		try {
			Document doc = Jsoup.connect(url).post();
			Elements links = doc.select("a[href]"); 
			for (Element i : links) {
				if (i.attr("href").toLowerCase()
						.contains("macbook-air") || i.attr("href").toLowerCase()
						.contains("surface-") || i.attr("href").toLowerCase()
						.contains("chromebook-")) {
					
					if (!i.attr("href")
							.contains(url) && !i.attr("href").contains("msn.com")) {
						al.add(i.attr("href"));
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
