**ESCOPO DE DESENVOLVIMENTO - SISTEMA ESTOQUE**


**OBJETIVO**
Desenvolver um pequeno sistema simulando as entradas e saídas de produtos em estoque.

**META**
Entregar o sistema em 48h a partir do recebimento da comunicação.

**RESTRIÇÕES**
Não serão fornecidas informações adicionais. O que não for entendido ou o que não estiver claro o suficiente deve ser tratado com decisão própria;
Todo o sistema deve ser desenvolvido em Ruby on Rails versão 6.1, SGBD SQLite;
GEMs ou outros softwares podem ser utilizados, se necessário.

**PREMISSAS**
O sistema deve estar funcionando sem apresentar erro de processamento
Utilizar o Github como repositório;
A programação dos models, controllers e seus métodos será mais avaliado que o layout das views;
Não há necessidade de login, controles de acessos e permissões.

**MODELO**
Produto:
nome(string: 20)
LocalArmazenamento:
nome(string: 20)
Movimentacao:
produto_id: referência do cadastro do produto
local_armazenamento_id: referência do cadastro do local de armazenamento
tipo: tipo da movimentação (string: 1) [E = entrada / S = saída]
data: data da movimentação
quantidade: quantidade movimentada

**DESCRIÇÃO**
O sistema deverá possuir uma interface para realizar o “upload” de um arquivo CSV(Anexo 1);
Ao ser carregado, para cada linha:
Se não houver inconsistência deverá ser cadastrada na tabela Movimentacao;
Se a movimentação for de entrada, o sistema deverá identificar, pelo nome, se o local de armazenamento já existe. Não existindo, o sistema deverá cadastrá-lo automaticamente;
Se a movimentação for de entrada, o sistema deverá verificar, pelo nome, a existência do produto. Não existindo, deverá cadastrá-lo automaticamente;
Se a movimentação for de saída, o sistema deverá verificar se existe quantidade em estoque suficiente para o produto no local de armazenamento indicado. Não havendo saldo suficiente, o registro não deverá ser gravado e o erro deve ser anotado;
Possíveis inconsistências não devem parar o processamento. O erro deve ser anotado para ser mostrado ao final;
Ao final do processamento exibir uma listagem com quantidade total existente de cada produto em cada local de armazenamento, bem como as mensagens de inconsistências(erros);
O período válido de uma movimentação é de 01/01/2021 a 31/01/2021;
Antes de serem processadas, as movimentações devem ser ordenadas - pelo sistema e não no arquivo - de modo a terem o menor número de inconsistências possível.


**AVALIAÇÃO**
Será avaliado o funcionamento, a clareza do código, bem como as soluções encontradas para cada dificuldade apresentada.

Ao final do prazo, se o sistema ainda estiver incompleto ou apresentando erro, entregue mesmo assim, que avaliaremos o que foi feito.

**ANEXO 1**


Criar um arquivo CSV (movimentacao_de_estoque.csv) com a estrutura e dados abaixo.

**Estrutura:**

Nome do depósito, Data, Tipo de movimentação, Nome do produto, Quantidade do produto

**Movimentações:**

Depósito 1, 01/01/2021, E, Soja, 2000
Depósito 1, 01/01/2021, E, Arroz, 1000
Depósito 2, 02/01/2021, E, Milho, 7000
Depósito 3, 03/01/2021, E, Milho, 1000
Depósito 3, 04/01/2021, S, Soja, 10
Depósito 2, 01/01/2021, S, Arroz, 600
Depósito 4, 05/01/2021, S, Arroz, 10
Depósito 2, 01/01/2021, E, Arroz, 1000
Depósito 2, 01/02/2021, E, Arroz, 200
Depósito 1, 04/01/2021, E, Milho, 100
Depósito 2, 02/01/2021, E, Arroz, 500
Depósito 1, 04/01/2021, S, Arroz, 100
Depósito 1, 10/01/2021, S, Soja, 2000

**Sistema:**

Link para acesso: http://127.0.0.1:3000/home/index