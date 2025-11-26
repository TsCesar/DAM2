**Autor/a:** IvanCH

```java
```bash
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Scanner;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

public class P1 {

	public static void main(String[] args) {
		try {
			   SAXParserFactory parserFactory = SAXParserFactory.newInstance();
			   SAXParser parser = parserFactory.newSAXParser();
			   XMLReader procesadorXML = parser.getXMLReader();

			   Gestor gestor = new Gestor();
			   procesadorXML.setContentHandler(gestor);
			 
			   InputSource fileXML = new InputSource("C:/Users/ivan/Desktop/mainWindow.xml");
			   procesadorXML.parse(fileXML); // Aquí ocurre toda la lectura.
			   /**/
			   
			/*		   
			   InputSource fileXML = new InputSource("C:/Users/ivan/Desktop/mainWindow.xml");

			   DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			   DocumentBuilder builder = factory.newDocumentBuilder();

			// Creación - Partiendo de un fichero
			   Document doc = builder.parse(fileXML);
			   
			   NodeList raiz=doc.getElementsByTagName("TableRow");
			   System.out.println("fila "+raiz.getLength()+":");
			   Node table=raiz.item(1);
			   Element alg=(Element) table;
			   System.out.println("fila "+alg.getLocalName()+":");
			   for (int i = 0; i < raiz.getLength(); i++) {
				   
					

			   }*/
			boolean es=true;
			while(es){
			String menu="1. Mostrar elementos de fila.\r\n"
					+ "2. A~nadir Radio Button.\r\n"
					+ "3. Contar n´umero de TextViews.";
			System.out.println(menu);
			Scanner teclado= new Scanner(System.in);
			int key= Integer.parseInt(teclado.nextLine()) ;
			switch (key) {
			case 1 -> mostrar(gestor, teclado);
			case 3 -> gestor.contTextView();
			case 4 -> es=false;
			/*
			default -> System.out.println("pusiste algo mal");
			throw new IllegalArgumentException("Unexpected value: " + key);*/
			}
			} 
			
			

			
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	private static void mostrar(Gestor gestor, Scanner teclado) {
		System.out.println("fila ??");
		int numf= Integer.parseInt(teclado.nextLine());
		gestor.getId(numf);
	}

}
```
```
