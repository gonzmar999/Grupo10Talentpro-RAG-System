# 📄 README: Sistema RAG para la Selección de Candidatos (Talentpro)

Este proyecto implementa un Sistema de Recuperación Aumentada (RAG) para optimizar el proceso de selección de personal, permitiendo la ingesta, procesamiento y búsqueda semántica avanzada de currículums (CVs).

## 🎯 Objetivo del Proyecto

El objetivo principal es transformar los currículums de los postulantes en un formato estructurado y vectorizado, indexándolos en una base de datos vectorial para facilitar una **búsqueda interactiva de candidatos** mediante un **Chatbot Agente IA**.

El sistema debe:
* Recibir CVs a través de un **Formulario de entrada**.
* Clasificar a los postulantes en categorías predefinidas: **Informático**, **Venta** y **Administrativo**.
* Permitir a los reclutadores buscar candidatos utilizando consultas en lenguaje natural (ej. "programador con Python y 3 años de experiencia en B2B").
* Retornar el **Top 5 candidatos** que mejor cumplan con los criterios, ordenados por puntuación.

---

## ⚙️ Descripción del Flujo (Workflow)

El sistema se compone de dos flujos principales (Workflows) orquestados en **N8N**, los cuales interactúan con Qdrant como base de datos vectorial y Cloudflare para las capacidades de Inteligencia Artificial (LLM y Embeddings).

### 1. Workflow: Recepción de Curriculums.

Este flujo se encarga de la ingesta y el procesamiento de los CVs para su indexación:


| Paso | Componente | Función |
| :--- | :--- | :--- |
| **1. Entrada** | `Webhook` | Recibe el CV (archivo binario) y los metadatos del postulante (nombre, correo, cargo, modalidad, etc.). |
| **2. Validación** | `Validación-campos` | Verifica que todos los campos requeridos (ej. `documento_nombre`, `grupo_nombre`, datos personales) estén presentes y sean válidos. |
| **3. Duplicados** | `Qdrant: eliminar duplicado` | Utiliza el **correo electrónico** (`persona_correo`) para filtrar y eliminar chunks antiguos del candidato, asegurando que solo esté indexada la versión más reciente del CV. |
| **4. Preprocesamiento** | `Call '_PDF2Markdown'` | Llama a un sub-workflow para convertir el CV (PDF/DOCX) a texto limpio en formato Markdown. |
| **5. Chunking y LLM** | `Cloudflare: LLM qwen2.5-coder-32b-instruct` | Un LLM (Large Language Model) analiza el texto del CV y lo estructura en **chunks semánticos** (perfil, skills, educación, experiencia, certificaciones) y extrae una lista completa de `keywords` (tecnologías). |
| **6. Vectorización** | `Cloudflare: embedding` | Genera un **vector embedding** (1024 dimensiones, modelo `bge-large-en-v1.5`) para cada chunk de contenido. |
| **7. Indexación** | `Qdrant: insertar` | Inserta los chunks vectorizados junto con sus metadatos (`grupo_nombre`, `persona_correo`, `habilidades_tecnologia`, etc.) en la *Collection* `curriculums_rag` de Qdrant. |

**Diagrama del Workflow: Recepción de Curriculums**
![Imagen de WhatsApp 2025-12-11 a las 12 04 58_866732a7](https://github.com/user-attachments/assets/fbbc6cb3-f288-4739-914b-80e53a991a7a)


### 2. Workflow: Agente - Buscador de Candidatos

Este flujo aloja el agente de IA que interactúa con el usuario a través del Chatbot:

| Componente | Descripción |
| :--- | :--- |
| **AI Agent (Gemini)** | Es el cerebro de la búsqueda. Utiliza un modelo de lenguaje (Google Gemini) para interpretar la consulta del usuario, decidir qué **Tool** usar y formular la respuesta final. |
| **Tool: `candidatos.obtener_por_perfil_solicitado`** | La herramienta clave para la búsqueda semántica. [cite_start]Recibe la consulta del usuario (que debe incluir el *hashtag* del perfil, ej. `#informatica`), la analiza, la descompone en categorías de CV (skills, experiencia, etc.), realiza una búsqueda multi-sección en Qdrant y genera el **ranking final con el score** de los candidatos. |
| **Tools de Soporte** | `candidatos.buscar_correos_por_nombre` y `candidato.obtener_por_correo`. Permiten la búsqueda de un candidato por nombre o la consulta del perfil completo usando el correo. |

**Diagrama del Workflow: Agente - Buscador de Candidatos**
![Imagen de WhatsApp 2025-12-11 a las 12 03 30_d49f2a6f](https://github.com/user-attachments/assets/5d4b8d16-5091-4922-a3cb-76013af59208)

---

## 🛠️ Instrucciones de Ejecución

Para operar y probar el sistema, sigue los siguientes pasos:

### 1. Ingesta de Curriculums (CVs)

Los CVs deben ser enviados a través del formulario de recepción, que llama al **Webhook** del flujo `Recepcion de Curriculums`.

1.  **Acceder al Formulario:** Utiliza la interfaz web de la consultora: `talentproconsultora.vercel.app`.
2.  **Carga de Datos:** Adjunta el CV y rellena los campos de metadatos requeridos:
    * `documento_nombre`
    * `grupo_nombre` (Debe ser `#venta`, `#informatica` o `#administrativo`).
    * Datos personales y laborales del postulante.
3.  **Procesamiento:** El sistema ejecutará el flujo completo (validación, eliminación de duplicados, chunking, embedding) para indexar el CV en Qdrant.

### 2. Búsqueda de Candidatos (Chatbot Agent)

La búsqueda de candidatos se realiza a través de un chatbot integrado en la plataforma web.

1.  **Acceder al Chatbot:** Ingresa a la página web de la consultora: `talentproconsultora.vercel.app`.
2.  **Formular la Consulta:** La consulta debe ser clara y contener los requisitos del puesto (habilidades, experiencia, formación). El chatbot se conecta al **Webhook** del flujo `Agente - Buscador de Candidatos`[cite: 8].
3.  **Inclusión Obligatoria del Perfil:** Para que el Agente pueda usar la herramienta de búsqueda semántica, **CRÍTICAMENTE** la consulta debe contener uno de los hashtags de perfil definidos:
    * **`#venta`**
    * **`#informatica`**
    * **`#administrativo`**
    
    *Ejemplo de consulta:* "Necesito 5 candidatos con Python, experiencia en Django y título en ingeniería **#informatica**".
4.  **Análisis y Respuesta:** El Agente analiza la consulta, realiza la búsqueda, genera un *score* para los candidatos y presenta el **ranking Top 5**, incluyendo la lista de correos para futuras exclusiones.
