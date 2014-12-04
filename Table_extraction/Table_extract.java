import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.PropertyException;
import javax.xml.namespace.QName;

import org.jsoup.Jsoup;
import org.jsoup.helper.HttpConnection.Response;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class Table_extract {

	public static void main(String[] args) {
		HashMap<String, String> kvp = new HashMap<String, String>();
		String[] products= {"http://www.engadget.com/reviews/laptops/popular/", "http://www.engadget.com/reviews/cellphones/popular/", "http://www.engadget.com/reviews/tablets/", "http://www.engadget.com/reviews/os-platforms/popular/"};
		for(String prod : products)
			Table_extract.addProducts(prod, kvp);
		
		Product_table pt = new Product_table(kvp);
		JAXBContext jaxbContext;
		try {
			jaxbContext = JAXBContext.newInstance(Product_table.class);
			String XML_serialized_table = Table_extract.tableToXml(jaxbContext, pt);
			System.out.println(XML_serialized_table);
			//this table contains the XML-serialized version of the product table
			//keys represent product names, and the values are strings representing a newline-delimited
			//hash table, in which each key-value combination is delimited by a tab (\t)

		} catch (JAXBException e) {
			e.printStackTrace();
		}
		//Now the HashMap kvp, whose first keys are product names and second keys are product attributes, is populated from Engadget
		//In order to use with Python, must serialize to XML.
	}
	
	public static void addProducts(String str, HashMap<String, String> kvp)
	{
		for (Object link : getLinks(str)) {
			String url = (String) link;
			String name = extractName(url);
			for(String s : scrapeKV(url))
			{
				if(kvp.containsKey(name)) kvp.put(name, kvp.get(name) + "\n" + s);
				else kvp.put(name, s);
			}
		}
	}
	
	public static Object[] getLinks(String url) {
		ArrayList<String> al = new ArrayList<String>();
		try {
			Document doc = Jsoup.connect(url).post();
			Elements links = doc.select("a[href]"); 
			for (Element i : links) {
				if (i.attr("href")
						.contains("http://www.engadget.com/products/")) {
					if (!i.attr("href")
							.contains(url)) {
						al.add(i.attr("href") + "specs/");
					}
				}
			}
			return al.toArray();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			return al.toArray();
		}
	}

	public static ArrayList<String> scrapeKV(String url) {
		Response res;
		try {
			res = (Response) Jsoup.connect(url).execute();
			String html = res.body();
			Document doc2 = Jsoup.parseBodyFragment(html);
			Element body = doc2.body();
			body = body.select(".key-specs").get(0); 
			//replacing ".key-specs" with "#product-specs" increases the number of unique specs displayed
			//but also can increase the number of undesired specifications stored
			Elements lines = body.select("li");
			ArrayList<String> als = new ArrayList<String> ();
			for (Element line : lines) {
				als.add(line.getElementsByTag("label").text() + " " + line
						.getElementsByTag("span").text());
			}
			return als;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<String>();
		}
	}

	public static String extractName(String url) {
		String[] sp = url.split("/");
		String name = "";
		if (sp.length > 5) {
			for (int i = 4; i < (sp.length - 1); i++) {
				name += sp[i] + " ";
			}
			return name.substring(0, name.length() - 1);
		} else
			return "NONAME";
	}

	public static String tableToXml(JAXBContext jaxbContext, Product_table hm)
	{
		try {
			StringWriter sw = new StringWriter();
			Marshaller marshaller = jaxbContext.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			
			QName qName = new QName("", "hm");
	        JAXBElement<Product_table> root = new JAXBElement<Product_table>(qName, Product_table.class, hm);
			marshaller.marshal(root, sw);
			return sw.toString();
		} catch (PropertyException e) {
			e.printStackTrace();
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		return "NOXML";
	}
}