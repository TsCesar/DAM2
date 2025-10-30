**Autor/a:** Cesar

```python
```bash
import multiprocessing
import time

def hijo(cn):
    doblar_valor = 'El valor se doblo'
    cn.send(print(f'se ha doblado: {doblar_valor}'))

def doblar_valor(cn):
    cn.recieve(__name__)
    print(f"mensje: {cn}")
    time.sleep(1)
    cn.send(print('OK!'))

if __name__ == "__main__":
    cp, cn = multiprocessing.Pipe()
    p = multiprocessing.Process(target=hijo, args=(cn,))
    p.start()
    doblar_valor(cp)
    p.join()

```siguiente criterio
import multiprocessing
import time

def trabajdores(nom):
    print(f"Trabajador: {nom}, empezando a procesar")
    time.sleep(2.1)
    print(f"Trabajador: {nom}, finalizado con exito")

if __name__ == "__main__":
    lista = ('jesus.mod', 'jose.mod', 'carlos.mod', 'antonio.mod', 'mariano.mod')
    with multiprocessing.Pool(processes=3) as pool:
        resultas = pool.map(trabajdores, lista)

    print(f'Todas las tareas han finalizado {lista}')
