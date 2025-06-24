# LocalStack Web

Uma aplicação frontend moderna desenvolvida com **Vue.js 3** e **Vuetify 3** que fornece uma interface web intuitiva para gerenciar e visualizar recursos do LocalStack.

![LocalStack Web](https://img.shields.io/badge/Vue.js-3-green) ![Vuetify](https://img.shields.io/badge/Vuetify-3-blue) ![LocalStack](https://img.shields.io/badge/LocalStack-Compatible-orange)

## 🚀 Funcionalidades

### 📊 Dashboard Principal
- Visão geral de todos os serviços LocalStack ativos
- Status em tempo real de conectividade
- Estatísticas resumidas de cada serviço
- Ações rápidas para limpeza de recursos

### 🪣 S3 (Simple Storage Service)
- ✅ Listar todos os buckets
- ✅ Visualizar estatísticas (número de objetos, tamanho total)
- ✅ Criar novos buckets
- ✅ Deletar buckets (com limpeza automática de objetos)
- ✅ Navegar dentro dos buckets
- ✅ Upload de arquivos
- ✅ Download e exclusão de objetos
- ✅ Busca e filtros

### 📝 SQS (Simple Queue Service)
- ✅ Listar todas as filas
- ✅ Visualizar estatísticas (mensagens disponíveis, em processamento)
- ✅ Criar novas filas com configurações personalizadas
- ✅ Deletar filas
- ✅ Enviar mensagens para filas
- ✅ Receber e visualizar mensagens
- ✅ Deletar mensagens individuais
- ✅ Purgar filas completamente

### 🗃️ DynamoDB
- ✅ Listar todas as tabelas
- ✅ Visualizar estatísticas (número de itens, tamanho)
- ✅ Criar tabelas com chaves primárias configuráveis
- ✅ Deletar tabelas
- ✅ Visualizar itens da tabela
- ✅ Adicionar, editar e deletar itens (via JSON)
- ✅ Suporte para diferentes tipos de dados

### ⚡ Lambda Functions
- ✅ Listar todas as funções
- ✅ Visualizar detalhes e configurações
- ✅ Invocar funções com payload customizado
- ✅ Visualizar resultados e logs de execução
- ✅ Deletar funções
- ✅ Suporte para invocação síncrona e assíncrona

### 🌊 Kinesis Streams
- ✅ Listar todos os streams
- ✅ Visualizar detalhes e shards
- ✅ Criar novos streams
- ✅ Deletar streams
- ✅ Enviar records para streams
- ✅ Ler records de streams
- ✅ Visualizar dados decodificados

### 🎨 Interface do Usuário
- ✅ Design moderno e responsivo
- ✅ Tema claro/escuro
- ✅ Feedback visual para todas as ações
- ✅ Busca e filtros em tempo real
- ✅ Notificações de sucesso/erro
- ✅ Configuração dinâmica do endpoint LocalStack

## 🛠️ Tecnologias Utilizadas

- **Vue.js 3** - Framework frontend reativo
- **Vuetify 3** - Biblioteca de componentes Material Design
- **Vite** - Build tool e dev server
- **Pinia** - Gerenciamento de estado
- **Vue Router** - Roteamento SPA
- **AWS SDK for JavaScript** - Integração com LocalStack
- **Docker** - Containerização
- **Nginx** - Servidor web para produção

## 📋 Pré-requisitos

- Node.js 18+ 
- npm ou yarn
- Docker e Docker Compose (para execução com containers)

## 🚀 Instalação e Execução

### Opção 1: Execução Local (Desenvolvimento)

1. **Clone o repositório**
```bash
git clone <url-do-repositorio>
cd localstack-web
```

2. **Instale as dependências**
```bash
npm install
```

3. **Execute o LocalStack separadamente**
```bash
# Em um terminal separado
docker run --rm -it -p 4566:4566 localstack/localstack
```

4. **Execute a aplicação em modo desenvolvimento**
```bash
npm run dev
```

5. **Acesse a aplicação**
```
http://localhost:3000
```

### Opção 2: Execução com Docker Compose (Recomendado)

1. **Clone o repositório**
```bash
git clone <url-do-repositorio>
cd localstack-web
```

2. **Execute com Docker Compose**
```bash
docker-compose up --build
```

3. **Acesse a aplicação**
```
http://localhost:3000
```

O LocalStack estará disponível em `http://localhost:4566`

## ⚙️ Configuração

### Endpoint do LocalStack

A aplicação permite configurar dinamicamente o endpoint do LocalStack através da interface:

1. Clique no ícone de configurações na barra lateral
2. Insira o endpoint desejado (ex: `http://localhost:4566`)
3. Salve as configurações

### Variáveis de Ambiente

Você pode configurar o endpoint através de variáveis de ambiente no `docker-compose.yml`:

```yaml
environment:
  - LOCALSTACK_ENDPOINT=http://localstack:4566
```

## 🐳 Docker

### Build da Imagem
```bash
docker build -t localstack-web .
```

### Execução da Imagem
```bash
docker run -p 3000:80 localstack-web
```

## 🧪 Desenvolvimento

### Scripts Disponíveis

```bash
# Desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview da build
npm run preview

# Linting
npm run lint

# Formatação de código
npm run format
```

### Estrutura do Projeto

```
src/
├── components/          # Componentes reutilizáveis
├── views/              # Páginas/Views da aplicação
│   ├── Dashboard.vue   # Dashboard principal
│   ├── S3View.vue      # Interface S3
│   ├── SQSView.vue     # Interface SQS
│   ├── DynamoDBView.vue # Interface DynamoDB
│   ├── LambdaView.vue  # Interface Lambda
│   └── KinesisView.vue # Interface Kinesis
├── router/             # Configuração de rotas
├── stores/             # Gerenciamento de estado (Pinia)
├── App.vue            # Componente raiz
└── main.js            # Ponto de entrada
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Casos de Uso

### Para Desenvolvedores
- Visualizar rapidamente o estado dos recursos durante desenvolvimento
- Testar integrações com serviços AWS de forma local
- Limpar ambientes entre testes
- Debugar problemas com dados de teste

### Para QA/Testers
- Criar cenários de teste com dados específicos
- Verificar comportamento de aplicações em diferentes estados
- Limpar e preparar ambientes de teste
- Validar integrações com serviços AWS

### Para DevOps
- Monitorar recursos em ambientes de desenvolvimento
- Automatizar limpeza de ambientes
- Configurar dados iniciais para testes
- Verificar configurações de serviços

## 🚨 Troubleshooting

### Problema de Conectividade
- Verifique se o LocalStack está rodando na porta 4566
- Confirme se o endpoint está configurado corretamente
- Verifique se não há problemas de CORS

### Performance
- Use o modo de desenvolvimento do LocalStack para melhor performance
- Considere configurar persistence se precisar manter dados entre reinicializações

### Problemas com Docker
- Certifique-se de que o Docker está rodando
- Verifique se as portas 3000 e 4566 estão disponíveis
- Use `docker-compose logs` para debug

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 🙏 Agradecimentos

- [LocalStack](https://localstack.cloud/) - Por fornecer uma excelente ferramenta para desenvolvimento local
- [Vue.js](https://vuejs.org/) - Framework frontend incrível
- [Vuetify](https://vuetifyjs.com/) - Componentes Material Design para Vue
- [AWS SDK](https://aws.amazon.com/sdk-for-javascript/) - SDK oficial da AWS

---

⭐ Se este projeto foi útil para você, considere dar uma estrela no repositório!
