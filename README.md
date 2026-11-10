# Wallpaper Trade

Aplicativo Android que troca automaticamente o papel de parede da tela inicial e/ou da tela de bloqueio **sempre que a tela é desligada**, usando uma coleção de imagens escolhida pelo próprio usuário.

> **Status:** projeto pessoal, em desenvolvimento.

## Funcionalidades

- Seleção de várias imagens de uma vez pela galeria (JPG/PNG; GIF ainda não é suportado).
- **Listas separadas** para a tela inicial e para a tela de bloqueio.
- Dois modos de troca: **sequencial** ou **aleatório** (no aleatório, a imagem atual não se repete em seguida).
- Escolha do destino da troca: tela inicial, tela de bloqueio ou ambas.
- **Troca automática ao desligar a tela**, por meio de um serviço em primeiro plano que escuta o evento de tela desligada.
- O serviço é **reiniciado após o boot do aparelho** e após a atualização do app.
- Botão de **troca manual**.
- **Detecção de imagens duplicadas** por hash SHA-256 (a duplicada é ignorada e o app informa quantas foram descartadas).
- Galeria com miniaturas (decodificação com redução de amostragem para economizar memória) e exclusão individual.
- Persistência das configurações e das listas com `SharedPreferences`; as imagens são copiadas para o armazenamento privado do app.
- Tentativas repetidas e *wake lock* parcial para concluir a troca mesmo com a tela desligada.
- Solicitação de isenção da otimização de bateria ao ativar a troca automática.
- **Orientação EXIF respeitada** (fotos de câmera não ficam de lado) e papel de parede recortado no centro, na proporção da tela, sem esticar a imagem.

## Tecnologias

- C# com **.NET para Android** (`net10.0-android`)
- APIs do Android: `WallpaperManager`, Foreground Service, `BroadcastReceiver`, `SharedPreferences`, `MediaStore`, `PowerManager`
- Layouts em XML

## Estrutura do projeto

| Arquivo | Responsabilidade |
|---|---|
| `MainActivity.cs` | Interface: seleção de imagens, galeria, opções de modo/destino e chave da troca automática |
| `WallpaperChangerService.cs` | Regras de negócio: listas de imagens, próximo índice (sequencial/aleatório), deduplicação, aplicação do wallpaper |
| `WallpaperMonitorService.cs` | Serviço em primeiro plano e receiver do evento de tela desligada |
| `BootReceiver.cs` | Reinicia o serviço após boot e após atualização do app |
| `AndroidManifest.xml` | Permissões e declaração do serviço |
| `Resources/layout/activity_main.xml` | Layout da tela principal |
| `ImageHelper.cs` | Leitura de imagens: orientação EXIF, miniaturas e preparo do papel de parede (recorte na proporção da tela) |

## Permissões

| Permissão | Para que serve |
|---|---|
| `SET_WALLPAPER` | Alterar o papel de parede |
| `FOREGROUND_SERVICE` / `FOREGROUND_SERVICE_SPECIAL_USE` | Manter o monitoramento da tela ativo |
| `RECEIVE_BOOT_COMPLETED` | Reativar a troca automática após reiniciar |
| `WAKE_LOCK` | Concluir a troca com a tela desligada |
| `REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` | Pedir ao usuário que o app não seja suspenso pela economia de bateria |

## Como executar

1. Instale o Visual Studio com a carga de trabalho de desenvolvimento **.NET para Android**.
2. Clone o repositório e abra `wallpaperTrade.slnx`.
3. Conecte um aparelho Android (ou use um emulador) e execute o projeto.

## Limitações conhecidas

- GIFs não são suportados nesta versão.

## Autor

**Diogo da Silva Costa** — [GitHub](https://github.com/D19go)
