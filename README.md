
# RAG Playground Environment
Welcome to the RAG Playground Environment! This guide will help you quickly set up and explore the components of your environment. **Let's dive in! 🚀**

## Prerequisites
Before we get started, make sure you have the following ready:
- [x] Install Docker if it's not already installed, and ensure it's running.

---

## Initializing the Environment
Follow these steps to set up your Docker environment using the `bootstrap.sh` script:

1) **Run the bootstrap script**:
   ```bash
   chmod +x bootstrap.sh
   ./bootstrap.sh
   ```
   This script will:
   - Start all necessary containers in the correct sequence.
   - Ensure dependencies are initialized and ready.
   - Ask for input (like the Ollama model name) where needed.

2) **Confirm services are running**:
   The script will verify each service is up and running. To double-check, you can run:
   ```bash
   docker ps
   ```
   You should see all containers listed as running.

---

## Accessing Services
Here's how to access and configure the key services:

### Jupyter Notebook
1) **Retrieve the Jupyter access token**:
   The bootstrap script will provide the Jupyter URL. You can also retrieve it manually by running:
   ```bash
   docker-compose logs jupyter | grep "http://127.0.0.1:8888/lab?token="
   ```
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

After updating the `.env` file, restart the environment for changes to take effect.

### Ollama
1) **Provide the model name during bootstrap**:
   The bootstrap script will prompt you to enter the Ollama model name (e.g., `llama3.2`) and automatically pull it.

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
