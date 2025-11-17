**Autor/a:** Cesar

```python
```bash
criterio_f_g_h_ejercicio1:
import time
import random
import threading

def inicio():
    print('¡Todos listos! ¡Pitido de inicio de la carrera!')

Barrera = threading.Barrier(4, action=inicio)

def calentamiento(num_atleta):
    print(f'Atleta {num_atleta} comenzando su calentamiento.')
    tiempo_calentamiento = random.uniform(1, 3)
    time.sleep(tiempo_calentamiento)
    print(f'Atleta {num_atleta} ha terminado su calentamiento en {tiempo_calentamiento:.2f}s.')
    Barrera.wait()

if __name__ == "__main__":
    print('César Méndez Castro')

    hilos = []
    for i in range(1, 5):
        hilo = threading.Thread(target=calentamiento, args=(i,))
        hilos.append(hilo)
        hilo.start()
    
    for hilo in hilos:
        hilo.join()

criterio_f_g_h_ejercicio2:
import time
import random
import threading

evento_clase = threading.Event()

def estudiantes(nombre):
    tiempo = random.uniform(1, 3)
    time.sleep(tiempo)
    print(f'El estudiante {nombre} llegó al aula {tiempo:.2f}s.')
    evento_clase.wait()
    print(f'El estudiante {nombre} comienza a atender la clase.')

def profesor():
    time.sleep(7)
    print('Profesor: ¡Buenos días a todos! La clase va a comenzar.')
    evento_clase.set()

if __name__ == "__main__":
    estudiantes = ['Ana', 'Luis', 'Carlos']
    hilos_estudiantes = []

    for nombre in estudiantes:
        hilo = threading.Thread(target=estudiantes, args=(nombre,))
        hilos_estudiantes.append(hilo)
        hilo.start()
    
    hilo_profesor = threading.Thread(target=profesor)
    hilo_profesor.start()

    for hilo in hilos_estudiantes:
        hilo.join()

    print('OK')
```
```
