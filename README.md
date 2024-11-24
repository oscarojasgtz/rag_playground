# RAG Playground Environment
Welcome to the RAG Playground Environment! This guide will help you quickly set up and explore the components of your environment. **Let's dive in! 🚀**

## Prerequisites
Before we get started, make sure you have the following ready:
- [ ] Install Docker if it's not already installed, and ensure it's running.

---

## Initializing the Environment
Follow these steps to set up your Docker environment:
1) **Stop and clean up any existing containers**:
   ```bash  
   docker-compose down --remove-orphans
   ```
   This ensures no residual containers interfere with your setup.<br><br>

2) **Build the Docker images**:
   ```bash
   docker-compose build
   ```
   This step creates the necessary images as defined in your `docker-compose.yml`.<br><br>
3) **Start the containers**:
   ```bash
   docker-compose up -d
   ```
   This pulls missing images, starts all services, and sets up the volumes and network.<br><br>

To ensure all the containers are up, run:
```bash
docker ps
```
You should see something similar to this:
```
CONTAINER ID   IMAGE                          COMMAND                  CREATED             STATUS                    PORTS                              NAMES
134440357fe0   jupyter/base-notebook:latest   "tini -g -- sh -c 'p…"   About an hour ago   Up 18 minutes (healthy)   0.0.0.0:8888->8888/tcp             jupyter
cf81f5fa4fba   langfuse/langfuse:latest       "dumb-init -- ./web/…"   About an hour ago   Up About an hour          0.0.0.0:3000->3000/tcp             langfuse
b59b28bfd5af   ollama/ollama:latest           "/bin/ollama serve"      About an hour ago   Up About an hour          0.0.0.0:11434->11434/tcp           ollama
a940cd2ffcc3   postgres:12.22                 "docker-entrypoint.s…"   About an hour ago   Up About an hour          5432/tcp                           postgres
f19ef6d65ae7   qdrant/qdrant:v1.12.4          "./entrypoint.sh"        About an hour ago   Up About an hour          0.0.0.0:6333->6333/tcp, 6334/tcp   qdrant
```

---

## Accessing Services
Here's how to access and configure the key services:

### Jupyter Notebook
1) **Retrieve the Jupyter access token**:
   ```bash
   docker-compose logs jupyter | grep "http://127.0.0.1:8888/lab?token="
   ```
   Copy the URL with the token from the logs.<br><br>
2) **Open Jupyter**: Paste the URL into your browser to start using Jupyter Lab.

### Langfuse
1) **Access the Langfuse UI**: Open [http://localhost:3000](http://localhost:3000) in your browser.
2) **Create your account**: Follow the prompts to set up an account.
3) **Set up an organization**:  
   - Click **+ New Organization**.  
   - Enter a name and click **Create**.
4) **Create a project**:  
   - Navigate to the **Setup** page.  
   - Create a new project.
5) **Generate an API Key**:  
   - Go to **Project Settings** > **API Keys**.  
   - Click **+ Create a new API Key**.  
   - Copy the key details in OpenAI format and paste them into your `.env` file.
6) **Restart the containers**:  
   After updating the `.env` file with the Langfuse API key, restart the Jupyter container for the changes to take effect:  
   ```bash
   docker-compose down && docker-compose up -d
    ```

### Ollama
1) **Access the Ollama container**:
   ```bash
   docker exec -it ollama sh
   ```
2) **Download a model**: Run the following command to download a model (for example, llama3.2)
   ```bash
   ollama pull llama3.2
   ```
   Replace llama3.2 with the model name you want, if necessary.

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
5) List the env variables in the container:
   ```bash
   docker exec <service_name> printenv
   ```

## Happy experimenting! 😊
