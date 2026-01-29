# primeira-pipeline-cicd
primeira-pipeline-cicd


## 1. Clonando o Repositório
> O primeiro passo para o desenvolvedor ter o projeto na máquina.

```bash
# Clone o repositório da Organização
git clone https://github.com/fbso/pix-service-api.git

# Entre na pasta do projeto
cd pix-service-api
```

## 2. Sincronizando e Limpando a main
> Para garantir que sua base local está idêntica ao que está em produção.

```bash
# Muda para a main e puxa as últimas alterações
git checkout main
git fetch origin
git reset --hard origin/main
```

## 3. Criando e Publicando a develop
> (Geralmente feito apenas uma vez pelo Tech Lead ou no início do projeto).

```bash
# A partir da main, cria a develop
git checkout main
git pull origin main
git checkout -b develop

# Sobe a develop para o GitHub e define o rastreamento (-u)
git push -u origin develop
```

## 4. Criando uma Branch de Feature
> O desenvolvedor deve sempre partir da develop atualizada para criar sua tarefa.

```bash
# Garante que está na develop e atualizado
git checkout develop
git pull origin develop

# Cria a branch da funcionalidade (ex: nova API de chaves)
git checkout -b feature/pix-chaves-api
```

## 5. O Ciclo Diário (Segurança e Backup)
> Para garantir que o trabalho do dia não seja perdido (mesmo que não esteja terminado).

```bash
# Adiciona as alterações
git add .

# Cria um commit parcial (WIP = Work In Progress)
git commit -m "feat(pix): [WIP] implementando validação de chaves"

# Sobe para o GitHub na sua branch de feature (backup em nuvem)
git push origin feature/pix-chaves-api
```

## 6. Finalização e Envio para Pull Request (PR)

```bash
# 1. Garante que pegou mudanças que outros devs possam ter feito na develop
git checkout develop
git pull origin develop

# 2. Volta para a sua feature e traz as novidades da develop (Rebase ou Merge)
git checkout feature/pix-chaves-api
git merge develop

# 3. Sobe a versão final para o GitHub
git push origin feature/pix-chaves-api

# 4. AGORA: O dev deve ir ao site do GitHub e abrir o Pull Request 
# de: feature/pix-chaves-api  -->  para: develop
```

## Step Extra: O "Pulo do Gato" para a Release (O Gestor)
> Quando as 3 features do Pix estão na develop e o pacote está pronto para Homologação:

```bash
# 1. Cria a branch de release a partir da develop integrada
git checkout develop
git pull origin develop
git checkout -b release/v1.0.0-pix-automatico

# 2. Sobe para o GitHub (Isso deve disparar o Deploy para STAGING via Actions)
git push -u origin release/v1.0.0-pix-automatico
```

## Resumo do Fluxo de Comandos:

### ```clone``` -> 2. ```checkout develop``` -> 3. vcheckout -b feature/``` -> 4. ```add/commit/push (diário)``` -> 5. ```PR para develop``` -> 6. ```Criação de Release (pelo líder)```.



