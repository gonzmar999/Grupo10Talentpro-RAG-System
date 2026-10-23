# Pausa (prototipo v0.2)

App personal para manejar antojos de dulce y la ansiedad asociada. Se basa en la guía «Antojos de dulce, ansiedad y control».
No cuenta calorías, no fija metas de peso, no propone dietas y nunca sugiere compensar después de un episodio.

## Qué incluye

| Módulo | Estado en el prototipo |
|---|---|
| 1. Registro rápido («Tengo un antojo» / «Comí dulce») | Completo |
| 2. SOS antojo (nombrar → urge surfing → respiración 4-6 → curiosidad → acción alternativa → medir) | Completo |
| 3. Ansiedad (respiración, grounding 5-4-3-2-1, registro TCC, STOP/TIPP, defusión ACT, urge surfing) con medición antes/después | Completo |
| 4. Check-in de mañana y de noche | Completo |
| 5. Detector de patrones (horas, emociones, situaciones, sueño/estrés, herramientas) | Completo (reglas simples) |
| 6. Plan diario (1 a 3 micro-acciones) y recordatorios | Plan completo; avisos dentro de la app, notificación si está abierta o en segundo plano |
| 7. Progreso semana a semana, sin rachas | Completo |
| 8. Biblioteca de técnicas y referentes | Completo |
| 9. Red de apoyo y aviso de consulta profesional | Completo |
| Respaldo JSON/CSV, importar, borrar | Completo |

Al abrirla por primera vez muestra 4 semanas de **datos de ejemplo**. El botón «Empezar con mis datos» los borra.

## Fase 2: para los momentos más difíciles

Pausa acompaña todos los días, entre sesión y sesión con el psicólogo. No lo reemplaza: le llega con información.

| Qué | Para qué |
|---|---|
| **Modo crisis** con dos caminos: «Lo resuelvo yo» (guía de 10 minutos, un paso por vez) y «Hablar con alguien» (llamar o WhatsApp con un mensaje ya escrito) | El momento del antojo muy fuerte, con o sin otra persona |
| **Comidas de hoy**: horarios regulares, avisos e ideas que sacian | Cortar el ciclo restricción → descontrol (TCC, Fairburn) |
| **Después de un episodio**: no compensar, próxima comida, frenar el «ya fue» | Que un episodio no se convierta en una noche entera |
| **Análisis en cadena** (DBT) | Encontrar dónde cortar la cadena la próxima vez |
| **Mi plan**: razones, señales tempranas, situaciones de riesgo, «si… entonces…» y entorno | Prevención de recaídas, como en cualquier adicción |
| **Red de apoyo**: hasta 3 contactos y un mensaje ya escrito | Bajar la vergüenza de pedir ayuda |
| **Entre sesiones**: fecha de la próxima sesión, notas y un resumen listo para copiar | Llegar a la sesión con lo importante |
| **Cuándo pedir más ayuda** y aviso desde 2 episodios en 7 días | No esperar a que empeore |
| **Comer para tener menos antojos** en la Biblioteca | Estructura, no dieta |

## Archivos

- `app.html`: la app entera (HTML + CSS + JS, sin dependencias).
- `index.html`: versión instalable, se genera con `./build.sh` a partir de `app.html`.
- `manifest.webmanifest`, `sw.js`, `icon.svg`: lo necesario para instalarla y usarla sin conexión.

## Probarla en la computadora (Windows)

1. Instalá Python desde python.org (marcá «Add to PATH»).
2. En la carpeta `pausa`, abrí una terminal y ejecutá: `python -m http.server 8000`
3. Abrí `http://localhost:8000` en Chrome o Edge.

## Instalarla en el celular

La forma más simple es publicarla gratis con GitHub Pages:

1. En GitHub: Settings → Pages → Source: «Deploy from a branch», elegí la rama y la carpeta raíz.
2. Abrí `https://<tu-usuario>.github.io/<repo>/pausa/` en el celular.
3. Android (Chrome): menú ⋮ → «Instalar app». iPhone (Safari): Compartir → «Agregar a inicio».

Los datos quedan solo en ese dispositivo. Exportá un respaldo desde Más → Respaldo de datos.

## Qué probar en los primeros días

- ¿El registro rápido lleva menos de 20 segundos?
- ¿El SOS completo te resulta corto o largo? ¿Qué paso salteás siempre?
- ¿El plan del día propone cosas que podés hacer de verdad?
- Después de una semana con datos reales: ¿las frases de Patrones coinciden con lo que sentís?

## Próximos pasos posibles

- Notificaciones con la app cerrada (requiere un servidor de push o la app empaquetada).
- Guardado en IndexedDB en lugar de localStorage.
- Resumen semanal redactado por IA, con permiso explícito.
