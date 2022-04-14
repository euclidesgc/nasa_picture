# Descrição do projeto:

Para executar o projeto na sua máquina crie um arquivo " .env " na raiz do projeto com os seguintes dados que representam variáveis de ambiente:

```
BASE_URL='https://api.nasa.gov/planetary/apod'
NASA_API_KEY='<SUA CHAVE DE API DA NASA>'
```

>  Você pode obter essas informações no seguinte endereço: https://api.nasa.gov/
>  API Utilizada para criação deste projeto: APOD: Astronomy Picture of the Day

## O projeto foi construído em módulos e camadas:

### Módulos:
1. #### data_access
Serviços de acesso a api e base de dados local

2. #### design_system
Componentes e cores globais do app

3. #### home
Módulo principal do app dividido em 3 camadas: presentation, domain e data
**data:** Responsável por acessar os dados e passar para a camada de domain
**domain:** Contém os usecases dos app e as entidades que serão utilizadas na camada presentation
**presentation:** Interface gráfica do app, utiliza flutter_bloc para gerenciar o estado;

------------

**A camada de apresentação foi construída da seguinte forma:**

Uma página principal com seletores de data inicial e final e um campo para filtrar a lista de "imagens do dia" por data ou por título;

Página de detalhe que exibe a imagem ou o video. No campo de imagem é permitido usar o movimento de pinça para dar zoom na imagem.

Sqlite utilizado para guardar as as informações e o cached_image_network para guardar as imagens e permitir que o app seja utilizado off line;

### Packages utilizados:
| Package| Descrição|
| ------------ | ------------ |
|  dio: ^4.0.6  |  client http para acesso a api |
|sqflite: ^2.0.2|banco de dados local|
|flutter_dotenv: ^5.0.2|variáveis de ambiente para armazenamento das chaves de acesso a api da Nasa|
|flutter_bloc: ^8.0.1|Pacote para gestão de estado|
|flutter_easyloading: ^3.0.3|Exibição de uma loading amigável enquanto as informações são buscadas|
|intl: ^0.17.0|Formatação de data|
|youtube_player_flutter: ^8.0.0|Exibição de vídeos|
|cached_network_image: ^3.2.0|Cache de imagens|
|connectivity_plus: ^2.3.0|Obtém o status da conexão com a internet|


[========]

# Requisitos propostos do projeto:

# Mobile Engineer test #2

> Truth can only be found in one place: the code. <br/>
> -- Robert C. Martin

## 1. Introduction

This test is intended for candidates applying to Mobile Engineering positions at CloudWalk.

## 2. Pre-requisites

- Git
- A development environment

You are welcome to use the latests SDKs.

### 2.1. Vacancy specifics

You might be applying for Flutter, Android or iOS positions, so the project should be implemented based on the position you are applying.

## 3. Task

Build an app for one platform (Android or iOS) to show the pictures from NASA's "Astronomy Picture of the Day" website in a fashion manner.

One of the most popular websites at NASA is the Astronomy Picture of the Day. In fact, this website is one of the most popular websites across all federal agencies.

## 4. Requirements

The app must contemplate the following requirements:

- Have two screens: a list of the images and a detail screen
- The images list must display the title, date and provide a search field in the top (find by title or date)
- The detail screen must have the image and the texts: date, title and explanation
- Must work offline (will be tested with airplane mode)
- Must support multiple resolutions and sizes

Regarding the screen with the list, it would be nice to have pull-to-refresh and pagination features.

### 4.1. NASA Astronomy Picture of the Day retrieval

You must use the [NASA](https://api.nasa.gov) API. You can create a free account and use the API key generated right after signing up.

API documentation:
- https://api.nasa.gov (click Browse APIs and check APOD)

## 5. Deliverable

You are expected to submit a compacted git repository with the project through the form you received.

Note that UI/UX design won't be evaluated. You should focus on app architecture, tests and model design.

Enjoy :)

