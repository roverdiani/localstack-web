# LocalStack Web - Makefile
# Comandos para facilitar o desenvolvimento e deployment

.PHONY: help install dev build preview lint format clean
.PHONY: docker-build docker-run docker-stop docker-logs docker-clean
.PHONY: localstack-start localstack-stop localstack-status localstack-logs localstack-reset
.PHONY: sample-data setup-dev setup-prod test health check-deps
.DEFAULT_GOAL := help

# Variáveis
DOCKER_IMAGE_NAME = localstack-web
DOCKER_CONTAINER_NAME = localstack-web-container
LOCALSTACK_ENDPOINT = http://localhost:4566
APP_PORT = 3000

# Cores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m # No Color

help: ## 📋 Mostra este menu de ajuda
	@echo "$(BLUE)LocalStack Web - Comandos Disponíveis$(NC)"
	@echo "=================================================="
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(YELLOW)Exemplos de uso:$(NC)"
	@echo "  make setup-dev     # Setup completo para desenvolvimento"
	@echo "  make dev           # Inicia aplicação em modo desenvolvimento"
	@echo "  make sample-data   # Cria dados de exemplo no LocalStack"
	@echo "  make docker-build  # Build da imagem Docker"

# ==================================================
# 📦 COMANDOS DE DESENVOLVIMENTO
# ==================================================

check-deps: ## 🔍 Verifica se todas as dependências estão instaladas
	@echo "$(BLUE)Verificando dependências...$(NC)"
	@command -v node >/dev/null 2>&1 || { echo "$(RED)❌ Node.js não está instalado$(NC)"; exit 1; }
	@command -v npm >/dev/null 2>&1 || { echo "$(RED)❌ npm não está instalado$(NC)"; exit 1; }
	@command -v docker >/dev/null 2>&1 || { echo "$(RED)❌ Docker não está instalado$(NC)"; exit 1; }
	@command -v docker-compose >/dev/null 2>&1 || { echo "$(RED)❌ Docker Compose não está instalado$(NC)"; exit 1; }
	@echo "$(GREEN)✅ Todas as dependências estão instaladas!$(NC)"

install: check-deps ## 📦 Instala as dependências do projeto
	@echo "$(BLUE)Instalando dependências...$(NC)"
	npm install
	@echo "$(GREEN)✅ Dependências instaladas com sucesso!$(NC)"

setup-dev: check-deps install localstack-start ## 🚀 Setup completo para desenvolvimento
	@echo "$(BLUE)Configurando ambiente de desenvolvimento...$(NC)"
	@echo "$(GREEN)✅ Setup completo! Use 'make dev' para iniciar a aplicação$(NC)"
	@echo "$(YELLOW)📋 Comandos úteis:$(NC)"
	@echo "  make dev           - Inicia aplicação"
	@echo "  make sample-data   - Cria dados de exemplo"
	@echo "  make health        - Verifica status dos serviços"

dev: ## 🔧 Inicia a aplicação em modo desenvolvimento
	@echo "$(BLUE)Iniciando aplicação em modo desenvolvimento...$(NC)"
	@echo "$(YELLOW)📱 Aplicação será aberta em: http://localhost:$(APP_PORT)$(NC)"
	npm run dev

build: ## 🏗️ Gera build de produção
	@echo "$(BLUE)Gerando build de produção...$(NC)"
	npm run build
	@echo "$(GREEN)✅ Build gerado em ./dist$(NC)"

preview: build ## 👀 Preview da build de produção
	@echo "$(BLUE)Iniciando preview da build...$(NC)"
	npm run preview

lint: ## 🔍 Executa linting do código
	@echo "$(BLUE)Executando linting...$(NC)"
	npm run lint

format: ## 🎨 Formata o código
	@echo "$(BLUE)Formatando código...$(NC)"
	npm run format
	@echo "$(GREEN)✅ Código formatado!$(NC)"

clean: ## 🧹 Limpa arquivos de build e cache
	@echo "$(BLUE)Limpando arquivos temporários...$(NC)"
	rm -rf dist/
	rm -rf node_modules/.cache/
	npm cache clean --force
	@echo "$(GREEN)✅ Limpeza concluída!$(NC)"

test: ## 🧪 Executa testes (placeholder)
	@echo "$(YELLOW)⚠️ Testes ainda não implementados$(NC)"

# ==================================================
# 🐳 COMANDOS DOCKER
# ==================================================

docker-build: ## 🐳 Build da imagem Docker
	@echo "$(BLUE)Construindo imagem Docker...$(NC)"
	docker build -t $(DOCKER_IMAGE_NAME) .
	@echo "$(GREEN)✅ Imagem $(DOCKER_IMAGE_NAME) criada!$(NC)"

docker-run: docker-build ## 🚀 Executa a aplicação em container Docker
	@echo "$(BLUE)Executando aplicação em container...$(NC)"
	docker run -d --name $(DOCKER_CONTAINER_NAME) -p $(APP_PORT):80 $(DOCKER_IMAGE_NAME)
	@echo "$(GREEN)✅ Container iniciado! Acesse: http://localhost:$(APP_PORT)$(NC)"

docker-stop: ## ⏹️ Para o container Docker
	@echo "$(BLUE)Parando container...$(NC)"
	-docker stop $(DOCKER_CONTAINER_NAME)
	-docker rm $(DOCKER_CONTAINER_NAME)
	@echo "$(GREEN)✅ Container parado!$(NC)"

docker-logs: ## 📋 Mostra logs do container Docker
	@echo "$(BLUE)Logs do container:$(NC)"
	docker logs -f $(DOCKER_CONTAINER_NAME)

docker-clean: docker-stop ## 🧹 Remove containers e imagens Docker
	@echo "$(BLUE)Limpando recursos Docker...$(NC)"
	-docker rmi $(DOCKER_IMAGE_NAME)
	-docker system prune -f
	@echo "$(GREEN)✅ Recursos Docker removidos!$(NC)"

# ==================================================
# 🔧 COMANDOS LOCALSTACK
# ==================================================

localstack-start: ## 🟢 Inicia o LocalStack
	@echo "$(BLUE)Iniciando LocalStack...$(NC)"
	docker-compose -f docker-compose.dev.yml up -d
	@echo "$(YELLOW)⏳ Aguardando LocalStack inicializar...$(NC)"
	@sleep 5
	@$(MAKE) localstack-status

localstack-stop: ## 🔴 Para o LocalStack
	@echo "$(BLUE)Parando LocalStack...$(NC)"
	docker-compose -f docker-compose.dev.yml down
	@echo "$(GREEN)✅ LocalStack parado!$(NC)"

localstack-status: ## 📊 Verifica status do LocalStack
	@echo "$(BLUE)Verificando status do LocalStack...$(NC)"
	@if curl -s $(LOCALSTACK_ENDPOINT)/_localstack/health >/dev/null 2>&1; then \
		echo "$(GREEN)✅ LocalStack está rodando em $(LOCALSTACK_ENDPOINT)$(NC)"; \
		curl -s $(LOCALSTACK_ENDPOINT)/_localstack/health | python3 -m json.tool 2>/dev/null || echo ""; \
	else \
		echo "$(RED)❌ LocalStack não está respondendo$(NC)"; \
		echo "$(YELLOW)💡 Use 'make localstack-start' para iniciar$(NC)"; \
	fi

localstack-logs: ## 📋 Mostra logs do LocalStack
	@echo "$(BLUE)Logs do LocalStack:$(NC)"
	docker-compose -f docker-compose.dev.yml logs -f

localstack-reset: ## 🔄 Reseta dados do LocalStack
	@echo "$(BLUE)Resetando dados do LocalStack...$(NC)"
	$(MAKE) localstack-stop
	rm -rf localstack-data/
	@echo "$(GREEN)✅ Dados resetados!$(NC)"
	@echo "$(YELLOW)💡 Use 'make localstack-start' para reiniciar$(NC)"

# ==================================================
# 📊 COMANDOS DE DADOS E TESTES
# ==================================================

sample-data: ## 🎯 Cria dados de exemplo no LocalStack
	@echo "$(BLUE)Criando dados de exemplo...$(NC)"
	@if curl -s $(LOCALSTACK_ENDPOINT)/_localstack/health >/dev/null 2>&1; then \
		chmod +x create-sample-data.sh && ./create-sample-data.sh; \
		echo "$(GREEN)✅ Dados de exemplo criados!$(NC)"; \
	else \
		echo "$(RED)❌ LocalStack não está rodando$(NC)"; \
		echo "$(YELLOW)💡 Use 'make localstack-start' primeiro$(NC)"; \
	fi

health: ## 🏥 Verifica saúde de todos os serviços
	@echo "$(BLUE)Verificando saúde dos serviços...$(NC)"
	@echo ""
	@echo "$(YELLOW)🔧 LocalStack:$(NC)"
	@$(MAKE) localstack-status
	@echo ""
	@echo "$(YELLOW)📱 Aplicação Web:$(NC)"
	@if curl -s http://localhost:$(APP_PORT) >/dev/null 2>&1; then \
		echo "$(GREEN)✅ Aplicação web está rodando em http://localhost:$(APP_PORT)$(NC)"; \
	else \
		echo "$(RED)❌ Aplicação web não está respondendo$(NC)"; \
		echo "$(YELLOW)💡 Use 'make dev' para iniciar$(NC)"; \
	fi

# ==================================================
# 🏗️ COMANDOS DE PRODUÇÃO
# ==================================================

setup-prod: ## 🏭 Setup para produção com Docker Compose
	@echo "$(BLUE)Configurando ambiente de produção...$(NC)"
	docker-compose up --build -d
	@echo "$(GREEN)✅ Ambiente de produção iniciado!$(NC)"
	@echo "$(YELLOW)📱 Acesse: http://localhost:$(APP_PORT)$(NC)"
	@echo "$(YELLOW)🔧 LocalStack: $(LOCALSTACK_ENDPOINT)$(NC)"

prod-stop: ## ⏹️ Para ambiente de produção
	@echo "$(BLUE)Parando ambiente de produção...$(NC)"
	docker-compose down
	@echo "$(GREEN)✅ Ambiente de produção parado!$(NC)"

prod-logs: ## 📋 Mostra logs do ambiente de produção
	@echo "$(BLUE)Logs do ambiente de produção:$(NC)"
	docker-compose logs -f

# ==================================================
# 🔧 COMANDOS UTILITÁRIOS
# ==================================================

urls: ## 🌐 Mostra URLs importantes
	@echo "$(BLUE)URLs importantes:$(NC)"
	@echo "$(GREEN)📱 Aplicação Web:$(NC)     http://localhost:$(APP_PORT)"
	@echo "$(GREEN)🔧 LocalStack:$(NC)        $(LOCALSTACK_ENDPOINT)"
	@echo "$(GREEN)🏥 Health Check:$(NC)      $(LOCALSTACK_ENDPOINT)/_localstack/health"
	@echo "$(GREEN)📊 LocalStack UI:$(NC)     https://app.localstack.cloud (se configurado)"

ports: ## 🔌 Mostra portas utilizadas
	@echo "$(BLUE)Portas utilizadas:$(NC)"
	@echo "$(GREEN)3000$(NC) - Aplicação Web Frontend"
	@echo "$(GREEN)4566$(NC) - LocalStack Gateway"
	@echo "$(GREEN)80$(NC)   - Nginx (container produção)"

env: ## 📋 Mostra informações do ambiente
	@echo "$(BLUE)Informações do ambiente:$(NC)"
	@echo "$(GREEN)Node.js:$(NC) $$(node --version 2>/dev/null || echo 'Não instalado')"
	@echo "$(GREEN)npm:$(NC) $$(npm --version 2>/dev/null || echo 'Não instalado')"
	@echo "$(GREEN)Docker:$(NC) $$(docker --version 2>/dev/null || echo 'Não instalado')"
	@echo "$(GREEN)Docker Compose:$(NC) $$(docker-compose --version 2>/dev/null || echo 'Não instalado')"
	@echo "$(GREEN)Sistema:$(NC) $$(uname -s)"

# ==================================================
# 🚨 COMANDOS DE EMERGENCY
# ==================================================

emergency-reset: ## 🚨 Reset completo (use apenas em emergência)
	@echo "$(RED)⚠️ ATENÇÃO: Isso irá remover TODOS os dados e containers!$(NC)"
	@read -p "Tem certeza? (yes/no): " confirm && [ "$$confirm" = "yes" ] || exit 1
	@echo "$(BLUE)Executando reset completo...$(NC)"
	-docker-compose down --volumes --remove-orphans
	-docker-compose -f docker-compose.dev.yml down --volumes --remove-orphans
	-docker stop $(DOCKER_CONTAINER_NAME) && docker rm $(DOCKER_CONTAINER_NAME)
	-docker rmi $(DOCKER_IMAGE_NAME)
	rm -rf node_modules/ dist/ localstack-data/
	@echo "$(GREEN)✅ Reset completo executado!$(NC)"
	@echo "$(YELLOW)💡 Use 'make setup-dev' para reconfigurar$(NC)"

kill-ports: ## 💀 Mata processos nas portas utilizadas
	@echo "$(BLUE)Liberando portas utilizadas...$(NC)"
	-lsof -ti:$(APP_PORT) | xargs kill -9 2>/dev/null || true
	-lsof -ti:4566 | xargs kill -9 2>/dev/null || true
	@echo "$(GREEN)✅ Portas liberadas!$(NC)"
