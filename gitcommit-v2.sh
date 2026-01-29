#!/bin/bash

# Configurações de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. Validação de Repositório Git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo -e "${RED}ERRO: Este diretório não é um repositório Git.${NC}"
    exit 1
fi

# Variáveis dos parâmetros
TIPO=$1
ESCOPO=$2
MENSAGEM=$3
TAG_INPUT=$4

exibir_help() {
    echo -e "${YELLOW}————————————————————————————————————————————————————————————————"
    echo -e "MODO DE USO:"
    echo -e "  ./gitcommit.sh <tipo> <escopo> <mensagem> <tag>"
    echo -e ""
    echo -e "PARÂMETROS:"
    echo -e "  1. TIPO:     feat, hotfix, chore, refactor"
    echo -e "  2. ESCOPO:   Texto curto (ex: pix, api)"
    echo -e "  3. MENSAGEM: Descrição (entre aspas)"
    echo -e "  4. TAG:      wip ou final"
    echo -e ""
    echo -e "EXEMPLO:"
    echo -e "  ./gitcommit.sh feat pix 'integração banco central' final"
    echo -e "————————————————————————————————————————————————————————————————${NC}"
}

# 2. Validação de quantidade de parâmetros
if [ $# -ne 4 ]; then
    echo -e "${RED}Erro: Quantidade de parâmetros inválida.${NC}"
    exibir_help
    exit 1
fi

# 3. Bloqueio de Branches Protegidas
BRANCH_ATUAL=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH_ATUAL" == "main" || "$BRANCH_ATUAL" == "master" || "$BRANCH_ATUAL" == "develop" || "$BRANCH_ATUAL" == release/* ]]; then
    echo -e "${RED}❌ OPERAÇÃO BLOQUEADA!${NC}"
    echo -e "Você está na branch: ${YELLOW}$BRANCH_ATUAL${NC}"
    echo -e "Não é permitido commitar diretamente em branches de estado (main, develop, release)."
    echo -e "Crie uma branch de ${GREEN}feature/${NC} ou ${GREEN}hotfix/${NC} para trabalhar."
    exit 1
fi

# 4. Validação do TIPO e TAG
case $TIPO in
    feat|hotfix|chore|refactor) ;;
    *) echo -e "${RED}Erro: Tipo '$TIPO' inválido.${NC}"; exibir_help; exit 1 ;;
esac

# 5. Validação e Formatação da TAG
TAG_LOWER=$(echo "$TAG_INPUT" | tr '[:upper:]' '[:lower:]')
if [[ "$TAG_LOWER" == "wip" ]]; then TAG_FINAL="[WIP]"
elif [[ "$TAG_LOWER" == "final" ]]; then TAG_FINAL="[FINAL]"
else echo -e "${RED}Erro: Tag inválida.${NC}"; exibir_help; exit 1; fi

# 6. Verificação de Alterações (Staging)
git add -A
if git diff --cached --quiet; then
    echo -e "${YELLOW}Nada para commitar. O diretório de trabalho está limpo.${NC}"
    exit 0
fi

# 7. Confirmação e Execução
COMMIT_FULL_MSG="$TIPO($ESCOPO): $MENSAGEM $TAG_FINAL"
echo -e "${YELLOW}Resumo: $COMMIT_FULL_MSG na branch $BRANCH_ATUAL${NC}"
read -p "Confirma o envio? (s/n): " CONFIRMACAO

if [[ "$CONFIRMACAO" == "s" || "$CONFIRMACAO" == "S" ]]; then
    git commit -m "$COMMIT_FULL_MSG"
    git push origin "$BRANCH_ATUAL"
    echo -e "${GREEN}✅ Sucesso!${NC}"
else
    echo -e "${RED}Cancelado.${NC}"
fi