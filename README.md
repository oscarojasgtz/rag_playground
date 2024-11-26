
# RAG Playground Environment
Welcome to the RAG Playground Environment! This guide will help you quickly set up and explore the components of your environment. **Let's dive in! 🚀**

## Prerequisites
Before we get started, make sure you have the following ready:
- [ ] Install Docker if it's not already installed, and ensure it's running.

---

## Initializing the Environment
Follow these steps to set up your Docker environment using the `bootstrap.sh` script:

1) **Run the bootstrap script**:
   ```bash
   sh bootstrap.sh
   ```
   The script will automatically set up and initialize the environment.

> [!WARNING]
> **Important Notes During the Bootstrap Process**:
>    - **Langfuse Setup**:<br>
>      The bootstrap will wait for you to:
>        1. Create an account on the Langfuse UI at [http://localhost:3000](http://localhost:3000).
>        2. Set up an organization and project.
>        3. Generate and copy the API keys to your `.env` file.
>        4. Press **Enter** to allow the bootstrap process to continue.<br><br>
>    - **Ollama Model Download**:<br>
>    When prompted, provide the name of the Ollama model you want to download (e.g., `llama3.2`).<br> Refer to [Ollama Models](https://ollama.ai/models) for a list of available models.<br><br>
>    - **Jupyter Notebook Access**:<br>
>    The bootstrap will display the initial Jupyter URL, including the access token, for you to start coding.

> [!TIP]
> **Confirm Services Are Running**: 
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

---

## You're All Set! 🎉
Now that your environment is up and running, feel free to explore its capabilities!

### Services URL
* [Jupyter](http://localhost:8888)
* [Langfuse](http://localhost:3000)
* [Qdrant](http://localhost:6333/dashboard)
* [Ollama](http://localhost:11434)

### Common Commands
Here are some handy commands for managing your setup:
1) Stop all containers:
   ```bash
   docker-compose down
   ```
2) Restart the environment:
   ```bash
   docker-compose up -d
   ```
3) View logs for a specific service:
   ```bash
   docker-compose logs <service_name>
   ```
4) Restart a specific service:
   ```bash
   docker-compose restart <service_name>
   ```
5) List the environment variables in a container:
   ```bash
   docker exec <service_name> printenv
   ```

## Happy experimenting! 😊
