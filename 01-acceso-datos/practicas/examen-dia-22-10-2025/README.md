**Autor/a:** ** Cesar

```java
```bash
package ExamenDatos;

public class records { // total de 15 bytes
	
	private short marcado; // 2 bytes
	private String nombre; //2 + 3 caracteres 2 + 3 = 5 bytes
	private double puntuacion; //8 bytes
	
	public records (String nombre, double puntuacion, short marcado) {
		this.marcado = marcado;
		this.nombre = nombre;
		this.puntuacion = puntuacion;
	}

	public String getNombre() {
		return nombre;
	}
	
	//Getters y Setters
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public double getPuntuacion() {
		return puntuacion;
	}

	public void setPuntuacion(double puntuacion) {
		this.puntuacion = puntuacion;
	}

	public short getMarcado() {
		return marcado;
	}

	public void setMarcado(short marcado) {
		this.marcado = marcado;
	}
	

}


package ExamenDatos;
//Imports
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.Scanner;

public class examenDatos {
	public static void main(String[] args) {
		//Nombramiento del fichero
		File file = new File("sf.bin");
		
		//Creación de Scanner
		Scanner sc = new Scanner(System.in);
		
		//Declaracion de variables
		String nombre = "";
		double puntuacion = 0;
		int opcion = 0;
		short marcado = 0;
		int id = 1;
		
		//Creacion del objeto record
		records record = new records(nombre, puntuacion, marcado);
		
		while (opcion != 5) {
			System.out.println("---MENU---");
			System.out.println(" 1. Mostrar regístros.");
			System.out.println(" 2. Añadir regístro.");
			System.out.println(" 3. Modificar puntuación");
			System.out.println(" 4. Resaltar regístro.");
			System.out.println(" 5. Salir.");
			
			System.out.print("\nIntroduce la opcion: ");
			opcion = Integer.parseInt(sc.nextLine());
			
			if (opcion == 1) {
				try (RandomAccessFile raf = new RandomAccessFile("file", "rw")) {
					while (raf.getFilePointer() < raf.length()) {
						marcado = raf.readShort();
						nombre = raf.readUTF();
						puntuacion = raf.readDouble();
						
						if (marcado == 1) {
							System.out.println(id + nombre + "   " + puntuacion + " puntos " + "***");
						} else {
							System.out.println(id + nombre + "   " + puntuacion + " puntos");
						}
						id++;
					}
					raf.close();
				} catch (Exception e) {
					System.out.println("Error: " + e.getMessage());
				}
			}
			
			if (opcion == 2) {
				try (RandomAccessFile raf = new RandomAccessFile("file", "rw")) {
					if (raf.length() == 7) {
						System.out.println("no se puede añadir mas de 7 ficheros");
					} else {
						System.out.println("Introduce los datos para añadir el registro: ");
						System.out.print("Introduce el nombre: ");
						nombre = sc.nextLine();
						System.out.print("\nIntroudcue la puntuación: ");
						puntuacion = Double.parseDouble(sc.nextLine());
						
						long fin = raf.length();
						long prin = raf.getFilePointer();
						
						raf.seek(fin);
						raf.writeUTF(nombre);
						raf.writeDouble(puntuacion);
						
						System.out.println("Registro añadido");
						raf.close();
						
					}
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (opcion == 3) {
				try (RandomAccessFile raf = new RandomAccessFile("file", "rw")) {
					System.out.println("Introduce la posisción de quien quieres modificar la puntuación: ");
					id = Integer.parseInt(sc.nextLine());
					System.out.println("Introduce la nueva puntuación: ");
					puntuacion = Double.parseDouble(sc.nextLine());
					
					long pos = (id * 16);
					raf.seek(pos);
					raf.writeDouble(puntuacion);
					
					System.out.println("Puntuación modificada");
					raf.close();
					
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (opcion == 4) {
				try (RandomAccessFile raf = new RandomAccessFile("file", "rw")) {
					System.out.print("Introduce la posición de la puntuación que quieres marcar: ");
					id = Integer.parseInt(sc.nextLine());
					
					long pos = (id * 16);
					raf.seek(pos);
					raf.writeShort(marcado);
					
					System.out.println("Puntuación marcada");
					raf.close();
					
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if (opcion == 5) {
				System.out.println("Saliendo...");
				return;
			}
		}
	}
	
	public static String nombreFormalizado(String nombre) {
		if (nombre.length() < 3) {
			throw new IllegalArgumentException("El nombre tiene que tener 3 letras");
		} else if (nombre.length() > 3) {
			throw new IllegalArgumentException("El nombre tiene que tener 3 letras");
		} else {
			return nombre;
		}
	}
}
``````
