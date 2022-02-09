// Parametros:
// quantia: valor recebido como salário
// Efeito: retorna o imposto a ser pago sobre o salário
funcao impostoSobreSalario(quantia: real) : real
var
   impostoSalario : real
inicio
   impostoSalario <- 0
   se quantia / 12 < 3000 entao
      impostoSalario <- 0
   senao
      se quantia / 12 < 5000 entao
         impostoSalario <- quantia * 0.10
      senao
         impostoSalario <- quantia * 0.20
      fimse
   fimse
   retorne impostoSalario
fimfuncao

// Parametros:
// quantia: valor recebido como prestação de serviços
// Efeito: retorna o imposto a ser pago sobre prestação de serviços
funcao impostoSobreServicos(quantia: real) : real
var
   impostoServicos : real
inicio
   impostoServicos <- 0
   se quantia > 0 entao
      impostoServicos <- quantia * 0.15
   fimse
   retorne impostoServicos
fimfuncao

// Parametros:
// quantia: valor recebido como ganho de capital
// Efeito: retorna o imposto a ser pago sobre ganhos de capital
funcao impostoSobreGC(quantia: real) : real
var
   impostoGanhoCapital : real
inicio
   impostoGanhoCapital <- 0
   se quantia > 0 entao
      impostoGanhoCapital <- quantia * 0.20
   fimse
   retorne impostoGanhoCapital
fimfuncao

// Parametros:
// salario: valor recebido como salário
// servicos: valor recebido como prestação de serviços
// gc: valor recebido como ganho de capital
// Efeito: retorna o imposto bruto total a ser pago
funcao impostoBrutoTotal(salario: real; servicos: real; gc: real) : real
inicio
   retorne salario + servicos + gc
fimfuncao

// Parametros:
// salario: valor recebido como salário
// servicos: valor recebido como prestação de serviços
// gc: valor recebido como ganho de capital
// gastosMedicos: valor gasto com despesas médicas
// gastosEducacionais: valor gasto com despesas educacionais
// Efeito: retorna o valor que o contribuinte pode abater no seu imposto
funcao abatimento(salario: real; servicos: real; gc: real; gastosMedicos: real; gastosEducacionais: real) : real
var
   ibt, abt, gastosDedutiveis, maximoDedutivel : real
inicio
   ibt <- impostoBrutoTotal(impostoSobreSalario(salario), impostoSobreServicos(servicos), impostoSobreGC(gc))
   maximoDedutivel <- ibt * 0.30
   gastosDedutiveis <- gastosMedicos + gastosEducacionais
   se gastosDedutiveis > maximodedutivel entao
      abt <- maximoDedutivel
   senao
      abt <- gastosDedutiveis
   fimse
   retorne abt
fimfuncao

Algoritmo "contribuintes"
Var
   impostoDevido, ibt, aba, isal : real
   i, contribuintes : inteiro
   salario : vetor [0..9] de real
   servico : vetor [0..9] de real
   ganhoC : vetor [0..9] de real
   gastosM : vetor [0..9] de real
   gastosE : vetor [0..9] de real
Inicio
   escreva("Quantos contribuintes você vai digitar? ")
   leia(contribuintes)
   para i de 0 ate contribuintes-1 faca
      escreval
      escreval("Digite os dados do ", (i+1), "o contribuinte: ")
      escreva("Renda anual com salário: ")
      leia(salario[i])
      escreva("Renda anual com prestação de serviço: ")
      leia(servico[i])
      escreva("Renda anual com ganho de capital: ")
      leia(ganhoC[i])
      escreva("Gastos médicos: ")
      leia(gastosM[i])
      escreva("Gastos educacionais: ")
      leia(gastosE[i])
   fimpara
   para i de 0 ate contribuintes-1 faca
      isal <- impostoSobreSalario(salario[i])
      ibt <- impostoBrutoTotal(isal, impostoSobreServicos(servico[i]), impostoSobreGC(ganhoC[i]))
      aba <- abatimento(salario[i], servico[i], ganhoC[i], gastosM[i], gastosE[i]))
      impostoDevido <- ibt - aba
      escreval
      escreval("--------------------------------------"
      escreval("Resumo do ", (i+1), "o contribuinte: ")
      escreval("Imposto bruto total: ", ibt:8:2)
      escreval("Abatimento: ", aba:8:2)
      escreval("Imposto devido: ", impostoDevido:8:2)
      escreval("--------------------------------------"
   fimpara
Fimalgoritmo