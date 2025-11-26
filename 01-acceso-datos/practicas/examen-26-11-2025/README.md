**Autor/a:** IvanCH

```java
```bash
package ex;

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


Gestor.java:
package ex;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class Gestor extends DefaultHandler {
	public boolean table=false;
	public boolean trow=false;
	public ArrayList<String> el=new ArrayList<String>();
	public int row=0;
	public int conrow=0;
	public int conttextv=0;
	public ArrayList<Integer> listrow=new ArrayList<Integer>();
	


	public Gestor() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public void startDocument() throws SAXException {
	}

	@Override
	public void endDocument() throws SAXException {
		
		
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
		//System.out.println(qName);
		if(qName.equals("TableLayout")) {
			table=true;
		}
		if(trow) {
			conrow++;
			//System.out.println(attributes.getValue(0));
			String s=attributes.getValue(0);
			el.add(s);
		}
		if(qName.equals("TableRow")) {
			row++;
			trow=true;
		}
		
		if(qName.equals("TextView")) {
			conttextv++;
		}
		super.startElement(uri, localName, qName, attributes);
	}

	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException {
		if(qName.equals("TableLayout")) {
			table=false;
		}
		if(qName.equals("TableRow")) {
			trow=false;
			System.out.println("fila "+row+":"+conrow);
			listrow.add(conrow);
			conrow=0;
		}
		super.endElement(uri, localName, qName);
	}

	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		// TODO Auto-generated method stub
		super.characters(ch, start, length);
	}
	
	public void getId(int fila) {
		int count=0;
		int fi=0;
		for (int i : listrow) {
			fi++;
			if(fi==fila) {
				for (int j = 0; j < i; j++) {
					System.out.println(el.get(j+count));
				}
			}
			count+=i;
		}
	}
	public void contTextView() {
		System.out.println(conttextv);
	}
	

}

```
```
