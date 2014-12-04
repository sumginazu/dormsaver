import java.util.HashMap;

	public class Product_table {
		public HashMap<String, String> kvp;

		public Product_table()
		{
			kvp = new HashMap<String, String>();
		}
		
		public Product_table(HashMap<String, String> kvp)
		{
			this.kvp = kvp;
		}
	}