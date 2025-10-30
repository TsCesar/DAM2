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
