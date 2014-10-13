import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;

import org.json.JSONException;
import org.json.JSONObject;

import edu.cmu.lti.oaqa.watson.QAApiQuerier;

public class NaviTestClass {
	static final String credentialPropPath = "../../navi/credential.properties";
	static boolean renewCache = true;
	//static Console console = System.console();
	static BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
	
	public static void main(String[] args) throws IOException{
		QAApiQuerier querier = new QAApiQuerier(credentialPropPath);
		while(true){
			System.out.println("Ask me anything:");
			String question = reader.readLine();
			JSONObject jsonOutput = querier.fetch(question, renewCache);
			System.out.println("Here's the best answer I found:");
			try{
				System.out.println(jsonOutput.getJSONObject("question").getJSONArray("answers").getJSONObject(1).getString("text"));
			}catch(JSONException e){
				System.out.println(jsonOutput);
			}
		}
	}

}
