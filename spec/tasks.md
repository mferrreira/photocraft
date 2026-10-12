# Tasks spec-driven (atômicas, com estado)

## T00 - Setup remoto/fork
- ID: T00
- Status: pending
- Dependências: []
- Descrição: Configurar remotes (origin -> fork, upstream). Criar fork se necessário.
- Ações:
  - Verificar remotes atuais
  - Definir URL fork (prompt usuário se necessário)
  - git remote set/add
- Critérios: `git remote -v` mostra origin(upstream?) + upstream corretos
- Arquivos: .git/config (via git)

## T01 - Verificar toolchain iOS
- ID: T01
- Status: pending
- Dependências: []
- Descrição: Verificar rustup targets, Xcode, xcrun
- Ações:
  - rustc/cargo versões
  - rustup target list --installed | grep ios
  - xcodebuild -version
- Critérios: targets presentes (aarch64-apple-ios, sims). Xcode ok.

## T02 - Criar estrutura spec/state
- ID: T02
- Status: done
- Dependências: []
- Descrição: Já criado spec/*.md, state/, log/, plan.md
- Critérios: arquivos existem

## T03 - Fetch deps + build check
- ID: T03
- Status: pending
- Dependências: [T01]
- Descrição: cargo fetch + cargo check --workspace
- Critérios: sem erros

## T04 - Analisar código iOS blockers
- ID: T04
- Status: pending
- Dependências: [T03]
- Descrição: Scan apps/photocraft, crates/ui-egui, crates/tablet p/ ios gaps
- Ações: grep cfg, deps cfg
- Saída: state/decisions.md + riscos atualizados

## T05 - Adicionar cfg iOS minimal
- ID: T05
- Status: pending
- Dependências: [T04]
- Descrição: Ajustar blocos desktop-only com target_os ios
- Critérios: compila check ios sim? (cargo check --target aarch64-apple-ios-sim -p photocraft)

## T06 - Testar build iOS sim
- ID: T06
- Status: pending
- Dependências: [T05]
- Descrição: cargo build --target aarch64-apple-ios-sim -p photocraft
- Critérios: sucesso

## T07 - Testar build iOS device release
- ID: T07
- Status: pending
- Dependências: [T06]
- Descrição: cargo build --target aarch64-apple-ios -p photocraft --release
- Critérios: sucesso

## T08 - Criar projeto Xcode ios/
- ID: T08
- Status: pending
- Dependências: [T07]
- Descrição: Criar ios/Photocraft.xcodeproj com target iOS, link lib, Swift shell
- Arquivos: ios/ (pbxproj, Info.plist, Assets, ViewController/ContentView)

## T09 - Configurar signing + device run
- ID: T09
- Status: pending
- Dependências: [T08]
- Descrição: Config Team, Bundle ID, rodar no device
- Critérios: app instala e abre

## T10 - Validar core + touch
- ID: T10
- Status: pending
- Dependências: [T09]
- Descrição: Testes manuais: abrir imagem, pan/zoom, UI responsiva
- Atualizar log + state

## T11 - Documentar workflow sideload
- ID: T11
- Status: pending
- Dependências: [T10]
- Descrição: Atualizar plan.md + criar docs/ios-sideload.md
- Critérios: docs claros
