**Autor/a:** IvanCH

```java
```bash

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
