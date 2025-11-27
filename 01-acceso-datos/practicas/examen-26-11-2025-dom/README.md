**Autor/a:** Cesar

```java
```bash
package datos;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class Examen {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        try {
            File fichero = new File("mainWindow.xml");

            // Construir el DOM a partir del fichero XML
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(fichero);
            document.getDocumentElement().normalize();

            // Obtener el TableLayout
            NodeList listaTableLayout = document.getElementsByTagName("TableLayout");
            if (listaTableLayout.getLength() == 0) {
                System.out.println("No se ha encontrado ningún TableLayout en el XML.");
                sc.close();
                return;
            }

            Element tableLayout = (Element) listaTableLayout.item(0);

            // Obtener las filas (TableRow) que cuelgan del TableLayout
            NodeList filas = tableLayout.getElementsByTagName("TableRow");

            // 1) Listado inicial de filas con número de elementos en cada fila
            for (int i = 0; i < filas.getLength(); i++) {
                Node nodoFila = filas.item(i);
                if (nodoFila.getNodeType() == Node.ELEMENT_NODE) {
                    Element fila = (Element) nodoFila;
                    int numElementos = contarHijosElemento(fila);
                    System.out.println("fila " + (i + 1) + ": " + numElementos);
                }
            }

            int opcion;
            do {
                System.out.println("\nElige una de las opciones: ");
                System.out.println("1. Mostrar elementos de fila.");
                System.out.println("2. Añadir Radio Button.");
                System.out.println("3. Contar número de TextViews.");
                System.out.println("0. Salir.");
                System.out.print("Opción: ");

                try {
                    opcion = Integer.parseInt(sc.nextLine());
                } catch (NumberFormatException e) {
                    opcion = -1;
                }

                switch (opcion) {
                    case 1:
                        // Mostrar IDs de los elementos de una fila
                        System.out.print("Introduce un número de fila (1-" + filas.getLength() + "): ");
                        int numFila = Integer.parseInt(sc.nextLine());

                        if (numFila < 1 || numFila > filas.getLength()) {
                            System.out.println("Número de fila no válido.");
                        } else {
                            Element fila = (Element) filas.item(numFila - 1);
                            mostrarIdsFila(fila);
                        }
                        break;

                    case 2:
                        // Añadir RadioButton al primer RadioGroup
                        System.out.print("Introduce el id del nuevo RadioButton (ej: @+id/radioNuevo): ");
                        String nuevoId = sc.nextLine();
                        System.out.print("Introduce el texto del nuevo RadioButton: ");
                        String nuevoTexto = sc.nextLine();

                        boolean anadido = anadirRadioButton(document, nuevoId, nuevoTexto);
                        if (anadido) {
                            // Guardar cambios en el XML
                            guardarDocumento(document, fichero);
                            System.out.println("RadioButton añadido correctamente al primer RadioGroup.");
                        } else {
                            System.out.println("No se ha encontrado ningún RadioGroup en el XML.");
                        }
                        break;

                    case 3:
                        // Contar número total de TextViews de la interfaz
                        NodeList textViews = document.getElementsByTagName("TextView");
                        int totalTextViews = textViews.getLength();
                        System.out.println("Número total de TextViews: " + totalTextViews);
                        break;

                    case 0:
                        System.out.println("Saliendo del programa...");
                        break;

                    default:
                        System.out.println("Opción no válida. Introduce 0, 1, 2 o 3.");
                }

            } while (opcion != 0);

        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        } finally {
            sc.close();
        }
    }

    /**
     * Cuenta cuántos hijos de tipo ELEMENT_NODE tiene una fila (TableRow).
     */
    private static int contarHijosElemento(Element fila) {
        NodeList hijos = fila.getChildNodes();
        int contador = 0;
        for (int i = 0; i < hijos.getLength(); i++) {
            Node hijo = hijos.item(i);
            if (hijo.getNodeType() == Node.ELEMENT_NODE) {
                contador++;
            }
        }
        return contador;
    }

    /**
     * Muestra por pantalla los IDs (android:id) de los elementos hijos directos
     * de una fila (TableRow).
     */
    private static void mostrarIdsFila(Element fila) {
        NodeList hijos = fila.getChildNodes();
        System.out.println("Elementos de la fila (IDs):");
        for (int i = 0; i < hijos.getLength(); i++) {
            Node hijo = hijos.item(i);
            if (hijo.getNodeType() == Node.ELEMENT_NODE) {
                Element elem = (Element) hijo;
                String id = elem.getAttribute("android:id");
                if (id != null && !id.isEmpty()) {
                    System.out.println(id);
                } else {
                    System.out.println("(sin id) tag: " + elem.getTagName());
                }
            }
        }
    }

    /**
     * Añade un RadioButton al primer RadioGroup encontrado en el documento.
     */
    private static boolean anadirRadioButton(Document document, String id, String texto) {
        NodeList radioGroups = document.getElementsByTagName("RadioGroup");
        if (radioGroups.getLength() == 0) {
            return false;
        }

        Element radioGroup = (Element) radioGroups.item(0);

        Element nuevoRadioButton = document.createElement("RadioButton");
        nuevoRadioButton.setAttribute("android:id", id);
        nuevoRadioButton.setAttribute("android:layout_width", "wrap_content");
        nuevoRadioButton.setAttribute("android:layout_height", "wrap_content");
        nuevoRadioButton.setAttribute("android:checked", "false");
        nuevoRadioButton.setAttribute("android:text", texto);

        radioGroup.appendChild(nuevoRadioButton);
        return true;
    }

    /**
     * Guarda el DOM en el fichero XML indicado.
     */
    private static void guardarDocumento(Document document, File fichero)
            throws TransformerException {

        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");

        DOMSource source = new DOMSource(document);
        StreamResult result = new StreamResult(fichero);

        transformer.transform(source, result);
    }
}
```
```
