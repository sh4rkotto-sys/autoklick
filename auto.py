import time
import threading
from pynput.mouse import Button, Controller as MouseController
from pynput.keyboard import Listener as KeyboardListener

# ==========================================================
# CONFIGURAZIONE RAPIDA (Modifica qui la velocità)
# ==========================================================
VELOCITA_CPS = 10  # <--- Cambia questo numero (es. 40, 20, 10) per i click al secondo!
# ==========================================================

mouse = MouseController()
click_active = False
CLICK_DELAY = 1.0 / VELOCITA_CPS

def clicker():
    """Thread dedicato al click ad altissima velocità"""
    while True:
        if click_active:
            mouse.click(Button.left)
            time.sleep(CLICK_DELAY)
        else:
            time.sleep(0.05)  # Risparmio risorsa CPU quando in pausa

def on_press(key):
    """Rileva la pressione del tasto M per attivare/disattivare (ON/OFF)"""
    global click_active
    try:
        if hasattr(key, 'char') and key.char and key.char.lower() == 'm':
            click_active = not click_active
            stato = f"ATTIVATO ({VELOCITA_CPS} CPS)" if click_active else "DISATTIVATO"
            print(f"[AutoClicker] -> {stato}")
    except AttributeError:
        pass

# Avvio del thread di click
t = threading.Thread(target=clicker, daemon=True)
t.start()

print("==========================================")
print(f"     AUTO CLICKER TURBO {VELOCITA_CPS} CPS (PYTHON)   ")
print("==========================================")
print("Premi [ M ] -> ATTIVA (ON) / DISATTIVA (OFF)")
print("Premi [ CTRL + C ] per chiudere il terminale")
print("==========================================\n")

# Resta in ascolto globale del tasto M
with KeyboardListener(on_press=on_press) as listener:
    listener.join()