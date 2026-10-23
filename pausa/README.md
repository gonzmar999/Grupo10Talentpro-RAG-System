# Pausa (prototipo v0.4)

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

## Perfil y personalización

La primera vez, Pausa hace unas 15 preguntas breves (3 o 4 minutos): hace cuánto pasa, cuántos episodios de pérdida de control por semana, cómo son, cuánto malestar generan, si hay conductas compensatorias, qué comidas se saltean, horarios, emociones y situaciones de riesgo, tratamiento actual, persona de confianza, preferencia en crisis y razones para cambiar.

Con eso define un **nivel de acompañamiento** (liviano, diario o intensivo; no es un diagnóstico) y adapta la app:

- Saludo por nombre; emociones y situaciones propias primero al registrar.
- Plan diario que prioriza no saltear las comidas que la persona suele saltear.
- Franja de riesgo tomada de las respuestas hasta que haya datos propios.
- Orden del modo crisis según la preferencia; contacto y razones cargados desde el inicio.
- Avisos sobrios si hay conductas de purga o pensamientos de hacerse daño.
- **Lo que noto**: observaciones que comparan lo que la persona contó con sus datos (episodios por semana, comidas salteadas y antojo de la tarde, horario real de riesgo, uso de herramientas, respaldo).
- **Revisión cada 4 semanas** (4 preguntas) con comparación antes/ahora e historial en Más → Mi perfil.

Los datos se guardan en dos lugares del navegador (localStorage e IndexedDB) y se pide almacenamiento persistente, así no hay que volver a responder nada.

## Cuentas y sincronización (opcional)

Con una cuenta, los datos se guardan también en la nube: no se pierden al cambiar de celular y se ven desde cualquier dispositivo. La app sigue guardando todo primero en el dispositivo, así funciona sin conexión, y sincroniza cuando hay internet. Sin configurar nada, Pausa funciona igual con datos solo locales.

Se usa [Supabase](https://supabase.com) (tiene plan gratis). Se configura una sola vez:

1. Creá una cuenta en supabase.com y un proyecto nuevo. Elegí una región cercana (por ejemplo, São Paulo).
2. En el proyecto, abrí **SQL Editor → New query**, pegá todo el contenido de `supabase.sql` y tocá **Run**.
3. En **Authentication → URL Configuration**, poné la dirección de tu sitio en **Site URL** (por ejemplo `https://pausa.tudominio.com`) y agregala también en **Redirect URLs**. Así funcionan los links de confirmación y de «olvidé mi contraseña».
4. En **Project Settings → API**, copiá la **Project URL** y la clave **anon public**.
5. Abrí `config.js`, pegá esos dos valores y subilo a tu sitio junto con el resto de los archivos.

Opcional: en **Authentication → Providers → Email** podés desactivar «Confirm email» para que no haga falta confirmar el mail al crear la cuenta.

Qué hace la app con la cuenta:

- **Crear cuenta / Entrar** con mail y contraseña, y **Olvidé mi contraseña** con un link al mail.
- Sincroniza sola después de cada cambio, al volver a abrir la app y al recuperar la conexión. Si dos celulares cargan datos, se combinan sin perder registros.
- **Cerrar sesión** dejando los datos en el dispositivo, o borrándolos (para celulares compartidos).
- **Eliminar la cuenta** y sus datos de la nube.

Privacidad: cada cuenta solo puede leer y escribir su propia fila (reglas de `supabase.sql`). Quien administra el proyecto de Supabase tiene acceso técnico a la base de datos; si Pausa la van a usar otras personas, contáselo.

## Archivos

- `app.html`: la app entera (HTML + CSS + JS, sin dependencias).
- `index.html`: versión instalable, se genera con `./build.sh` a partir de `app.html`.
- `manifest.webmanifest`, `sw.js`, `icon.svg`: lo necesario para instalarla y usarla sin conexión.
- `config.js`: datos de conexión a Supabase (vacíos por defecto).
- `supabase.sql`: crea la tabla y las reglas de seguridad en Supabase.
- `pausa-web.zip`: los archivos listos para subir a un dominio (`index.html`, `config.js`, `manifest.webmanifest`, `sw.js`, `icon.svg`) más `supabase.sql`.

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
