# RAG Playground Environment
Welcome to the RAG Playground Environment! This guide will help you quickly set up and explore the components of your environment. **Let's dive in! 🚀**

---

## Prerequisites

Before starting, ensure you have the following:

1. **Docker**: Install Docker from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
2. **Docker Compose**: Included with Docker Desktop. Verify installation with:
   ```bash
   docker-compose --version
   ```
3. **Git**: Install Git from [https://git-scm.com/](https://git-scm.com/).

---

## Getting Started️

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/oscarojasgtz/rag_playground.git
   cd rag_playground
   ```

2. **Set Environment Variables**:
   - Use the `.env_template` file to create your own.
   - Obtain your OpenAI API key from [OpenAI](https://platform.openai.com/).

3. **Bootstrap the Environment**:
   Run the bootstrap script to provision the environment:
   ```bash
   ./bootstrap.sh
   ```

   ### What Happens During Bootstrap:
   - Docker removes orphaned containers and builds the images.
   - Containers for **Ollama**, **Qdrant**, **Postgres**, and **LangFuse** start sequentially.
   - The Ollama model specified in `.env` is downloaded. If the model already exists, the download is skipped.
   - Prompts for LangFuse secret and public keys appear if they are not set in `.env`. Provide the keys when prompted.

> [!NOTE]
> You may encounter warnings like this during the first run:
>   ```
>   WARN[0000] The "LANGFUSE_SECRET_KEY" variable is not set. Defaulting to a blank string.
> WARN[0000] The "LANGFUSE_PUBLIC_KEY" variable is not set. Defaulting to a blank string.
>   ```
>   Don’t worry; these warnings indicate missing environment variables, which are handled during the bootstrap process. <br> <br>
>   **Langfuse Setup**:<br>
>   The bootstrap will wait for you to:<br>
>        1. Create an account on the Langfuse UI at [http://localhost:3000](http://localhost:3000).<br>
>        2. Set up an organization and project.<br>
>        3. Generate and copy the API keys

> [!TIP]
> **Confirm Services Are Running**<br>
> After the bootstrap completes, verify that all containers are running using: 
> ```bash
>   docker ps
>   ```
> You should see something like this
> ```
> CONTAINER ID   IMAGE                          COMMAND                  CREATED          STATUS                    PORTS                              NAMES
> e88c52ae61f0   jupyter/base-notebook:latest   "tini -g -- sh -c 'p…"   47 minutes ago   Up 47 minutes (healthy)   0.0.0.0:8888->8888/tcp             jupyter
> 2c69524d1c9c   ollama/ollama:latest           "/bin/ollama serve"      47 minutes ago   Up 47 minutes             0.0.0.0:11434->11434/tcp           ollama
> bffb987a6a68   qdrant/qdrant:v1.12.4          "./entrypoint.sh"        47 minutes ago   Up 47 minutes             0.0.0.0:6333->6333/tcp, 6334/tcp   qdrant
> 0dae0bada025   langfuse/langfuse:latest       "dumb-init -- ./web/…"   47 minutes ago   Up 47 minutes             0.0.0.0:3000->3000/tcp             langfuse
> 03d67516bb8f   postgres:12.22                 "docker-entrypoint.s…"   47 minutes ago   Up 47 minutes             5432/tcp                           postgres
> ```
 
> [!IMPORTANT]
> **Jupyter token** <br>
> At the end of the bootstrap, you will be provided with the Jupyter token, if not, you are always able to run:
> ```bash
> docker logs jupyter 2>&1 | grep 'http://127.0.0.1:8888/lab?token='
> ```

---

## Customizing Ollama Models

- Available models for Ollama can be found [here](https://ollama.ai/models).
- To change the model:
  1. Update the `OLLAMA_MODEL` variable in `.env`.
  2. Re-run the bootstrap script to download the new model.

---

## You're All Set! 🎉

Now that your environment is up and running, feel free to explore its capabilities!
Services URL

- [Jupyter](http://localhost:8888/)
- [Langfuse](http://localhost:3000/)
- [Qdrant](http://localhost:6333/dashboard)
- [Ollama](http://localhost:11434/)

## Docker Compose Tips 🐳

1. **Access a Container**:
     ```bash
     docker exec -it <container-name> bash
     ```
     Example:
     ```bash
     docker exec -it langfuse bash
     ```

2. **Run a Command in a Container**:
     ```bash
     docker-compose exec <service-name> <command>
     ```
     Example:
     ```bash
     docker-compose exec ollama printenv
     ```

3. **Stop All Containers**:
     ```bash
     docker-compose down
     ```

4. **Remove Orphaned Containers**:
     ```bash
     docker-compose down --remove-orphans
     ```

5. **Check Logs for a Service**:
     ```bash
     docker-compose logs <service-name>
     ```
   
6. **Restart a specific service**:
   ```bash
   docker-compose restart <service_name>
   ```
---

## Troubleshooting & Support 💡

- If you encounter issues, check the logs for specific services.
- Ensure the `.env` file is correctly configured.
- Refer to [Docker Docs](https://docs.docker.com/) for advanced troubleshooting.

---

Happy experimenting! 😊