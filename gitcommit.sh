#!/bin/bash

# Variáveis dos parâmetros
TIPO=$1
ESCOPO=$2
MENSAGEM=$3
TAG_INPUT=$4

# Configurações de cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

exibir_help() {
    echo -e "${YELLOW}————————————————————————————————————————————————————————————————"
    echo -e "MODO DE USO:"
    echo -e "  ./gitcommit.sh <tipo> <escopo> <mensagem> <tag>"
    echo -e ""
    echo -e "PARÂMETROS:"
    echo -e "  1. TIPO:     feat, hotfix, chore, refactor"
    echo -e "  2. ESCOPO:   Texto curto (ex: pix, api, db)"
    echo -e "  3. MENSAGEM: Descrição do que foi feito (entre aspas)"
    echo -e "  4. TAG:      wip ou final"
    echo -e ""
    echo -e "EXEMPLO:"
    echo -e "  ./gitcommit.sh feat pix 'integração banco central' final"
    echo -e "————————————————————————————————————————————————————————————————${NC}"
}

# 1. Validação de quantidade de parâmetros
if [ $# -ne 4 ]; then
    echo -e "${RED}Erro: Quantidade de parâmetros inválida.${NC}"
    exibir_help
    exit 1
fi

# 2. Bloqueio de Branches Protegidas
BRANCH_ATUAL=$(git rev-parse --abbrev-ref HEAD)

if [[ "$BRANCH_ATUAL" == "main" || "$BRANCH_ATUAL" == "master" || "$BRANCH_ATUAL" == "develop" || "$BRANCH_ATUAL" == release/* ]]; then
    echo -e "${RED}❌ OPERAÇÃO BLOQUEADA!${NC}"
    echo -e "Você está na branch: ${YELLOW}$BRANCH_ATUAL${NC}"
    echo -e "Não é permitido commitar diretamente em branches de estado (main, develop, release)."
    echo -e "Crie uma branch de ${GREEN}feature/${NC} ou ${GREEN}hotfix/${NC} para trabalhar."
    exit 1
fi

# 3. Validação do TIPO
case $TIPO in
    feat|hotfix|chore|refactor) ;;
    *) echo -e "${RED}Erro: Tipo '$TIPO' inválido.${NC}"; exibir_help; exit 1 ;;
esac

# 4. Validação e Formatação da TAG
TAG_LOWER=$(echo "$TAG_INPUT" | tr '[:upper:]' '[:lower:]')
if [[ "$TAG_LOWER" == "wip" ]]; then
    TAG_FINAL="[WIP]"
elif [[ "$TAG_LOWER" == "final" ]]; then
    TAG_FINAL="[FINAL]"
else
    echo -e "${RED}Erro: Tag '$TAG_INPUT' inválida.${NC}"
    exibir_help
    exit 1
fi

COMMIT_FULL_MSG="$TIPO($ESCOPO): $MENSAGEM $TAG_FINAL"

# 5. Exibir Comandos e Pedir Confirmação
echo -e "${YELLOW}Resumo da Operação:${NC}"
echo -e "  Branch:  $BRANCH_ATUAL"
echo -e "  Commit:  \"$COMMIT_FULL_MSG\""
echo ""
read -p "Deseja executar git add, commit e push? (s/n): " CONFIRMACAO

if [[ "$CONFIRMACAO" != "s" && "$CONFIRMACAO" != "S" ]]; then
    echo -e "${RED}Operação cancelada.${NC}"
    exit 0
fi

# 6. Execução
echo -e "${GREEN}🚀 Executando...${NC}"
git add -A
git commit -m "$COMMIT_FULL_MSG"
git push origin "$BRANCH_ATUAL"

echo -e "${GREEN}✅ Processo concluído com sucesso!${NC}"