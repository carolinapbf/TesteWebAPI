# Sobre

Neste repositório você vai encontrar 2 pastas : "API" e "WEB.

Na Pasta "API" possui 5 subpastas onde cada pasta representa um endpoint

Na Pasta "WEB" possui duas pastas onde a primeira pasta representa os testes relacionados a Pesquisa e outro com testes relacionados a criação, login e logout de usuários

Cada teste tanto APi ou WEB, gerou  3 arquivos, que representam os resultados dos testes, todos dentro da pasta resulta, que se encontra em cada subpasta.

Cada fluxo de teste possui:
* 1 arquivo com os cenarios dos testes escrito em BDD.
* 1 arquivo com a implementação dos testes chamado Resource.
* 1 pastas chamada results com os logs do teste.

# Dependencias  

* Python 3.x
* Robot Framework
    * SelleniumLibrary
    * RequestsLibary

# Como usar
No terminal vá ao local onde está localizado o arquivo com extensão .robot que você deseja testar.
Em seguida execute o comando `robot - d .\results Arquivo.robot`, onde "Arquivo" representa o nome do arquivo , o qual será testado.