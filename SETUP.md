# 🚀 Guia de Setup Rápido - LocalStack Web

## Opção 1: Setup Automático (Recomendado)

Execute o script de setup que configura tudo automaticamente:

```bash
./setup-dev.sh
```

Este script irá:
- ✅ Verificar se todas as dependências estão instaladas
- ✅ Instalar dependências do projeto (se necessário)
- ✅ Iniciar o LocalStack via Docker
- ✅ Verificar se o LocalStack está funcionando

## Opção 2: Setup Manual

### 1. Instalar Dependências
```bash
npm install
```

### 2. Iniciar LocalStack
```bash
# Usando Docker Compose (recomendado)
docker-compose -f docker-compose.dev.yml up -d

# OU usando Docker diretamente
docker run --rm -it -p 4566:4566 localstack/localstack
```

### 3. Iniciar a Aplicação
```bash
npm run dev
```

### 4. Acessar a Aplicação
Abra seu navegador em: http://localhost:3000

## 🧪 Criando Dados de Teste

Para popular o LocalStack com dados de exemplo:

```bash
./create-sample-data.sh
```

Este script criará:
- 🪣 3 buckets S3 com arquivos de exemplo
- 📝 3 filas SQS com mensagens
- 🗃️ 2 tabelas DynamoDB com dados
- 🌊 2 streams Kinesis com records
- ⚡ 1 função Lambda de exemplo

## 🔧 Comandos Úteis

### Desenvolvimento
```bash
npm run dev          # Inicia o servidor de desenvolvimento
npm run build        # Gera build de produção
npm run preview      # Preview da build de produção
npm run lint         # Executa linting
npm run format       # Formata o código
```

### LocalStack
```bash
# Parar LocalStack
docker-compose -f docker-compose.dev.yml down

# Ver logs do LocalStack
docker-compose -f docker-compose.dev.yml logs -f

# Resetar dados do LocalStack
rm -rf localstack-data

# Verificar health do LocalStack
curl http://localhost:4566/_localstack/health
```

### Docker (Produção)
```bash
# Build da aplicação completa (Web + LocalStack)
docker-compose up --build

# Apenas build da aplicação web
docker build -t localstack-web .

# Executar aplicação web
docker run -p 3000:80 localstack-web
```

## 🔀 Diferentes Configurações

### Desenvolvimento Local
- Frontend: `http://localhost:3000`
- LocalStack: `http://localhost:4566`
- Hot reload ativado

### Produção com Docker
- Frontend: `http://localhost:3000`
- LocalStack: `http://localhost:4566` 
- Build otimizada

### Configuração Personalizada
1. Copie `.env.example` para `.env`
2. Modifique as variáveis conforme necessário
3. Reinicie a aplicação

## 🐛 Troubleshooting

### LocalStack não inicia
```bash
# Verificar se Docker está rodando
docker info

# Verificar logs de erro
docker-compose -f docker-compose.dev.yml logs

# Limpar containers
docker-compose -f docker-compose.dev.yml down --volumes
```

### Frontend não conecta com LocalStack
1. Verifique se LocalStack está rodando: `curl http://localhost:4566/_localstack/health`
2. Vá em Configurações na aplicação e verifique o endpoint
3. Verifique o console do navegador para erros de CORS

### Porta 4566 já está em uso
```bash
# Encontrar processo usando a porta
lsof -i :4566

# Parar processo se necessário
kill -9 <PID>
```

### Build falha
```bash
# Limpar cache do npm
npm cache clean --force

# Reinstalar dependências
rm -rf node_modules package-lock.json
npm install
```

## 🎯 Próximos Passos

1. **Explore a aplicação**: Navegue pelas diferentes seções (S3, SQS, DynamoDB, etc.)
2. **Teste as funcionalidades**: Crie recursos, envie dados, execute operações
3. **Use dados de exemplo**: Execute `./create-sample-data.sh` para ter dados prontos
4. **Personalize**: Modifique as configurações conforme suas necessidades
5. **Integre**: Use em seus projetos que dependem dos serviços AWS

## 🤝 Suporte

Se encontrar problemas:
1. Verifique este guia primeiro
2. Consulte o README.md principal
3. Verifique os logs do LocalStack
4. Abra uma issue no repositório

Boa codificação! 🚀
