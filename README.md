# TesteBancoCarrefour

## Projeto desenvolvido em Swift Nativo seguindo a arquitetura MVVM-C (Model-View-ViewModel-Coordinator). 

### Configurações para rodar o projeto

Clone este repositório no diretório de sua preferência.
Abra o projeto no Xcode.
Compile e execute o projeto.

### Features

- Apresentar uma Lista de Usuários vinda da api pública do Github "https://api.github.com/users". Exibi apenas o login e a imagem de avatar do usuário.

- Busca de Usuários filtrando por login: busque os usuários do GitHub na barra de pesquisa. A chamada é feita na api "https://api.github.com/users/nomefiltrado" .

- Lista de Repositórios Públicos de um Usuário: Além dos detalhes do usuário, o aplicativo exibe uma lista dos repositórios públicos de um usuário em específico. Isso é feito por meio da api "https://api.github.com/users/nomedeusuario/repos".

- Tratamento de erros: tratamento de erros como parseError, badURL, networkError, emptyData

- Testes Unitários: Testes unitários para viewModels e camadas de serviço do projeto. Para rodá-los basta pressionar cmd+u.
