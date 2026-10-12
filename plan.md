# Plano de implementação: PhotoCraft no iPad (Trilha B - Nativo/Sideload)

> Objetivo: Rodar PhotoCraft no iPad A16 (uso próprio, sem App Store). Abordagem: build Rust nativo para iOS (aarch64-apple-ios) com UI egui/wgpu (Metal), empacotado em app Xcode para sideload (AltStore/SideStore) ou rodar direto no device. Seguindo filosofia do projeto (Rust nativo, sem webview).

## Estado
- Repo clonado: /Users/marcio/Projetos/photocraft_ipad (upstream: storytold/photocraft, tag v0.8.1)
- Workspace Rust (crates + apps/photocraft desktop + photocraft-cli + photocraft-web)
- Stack: egui 0.36 + eframe + wgpu, arquitetura em camadas L0-L6

## Fase 0: Fork + configuração remotes
- [ ] Criar fork no GitHub (SEU_USUARIO/photocraft)
- [ ] Adicionar remote `origin` para fork: `git remote set-url origin git@github.com:SEU_USUARIO/photocraft.git` (ou adicionar novo)
- [ ] Manter `upstream`: `git remote add upstream https://github.com/storytold/photocraft.git` (se não existir)
- [ ] Verificar remotes: `git remote -v`

## Fase 1: Ambiente e toolchain
- [ ] Verificar Rust: `rustc --version`, `cargo --version` (>= 1.95 conforme Cargo.toml)
- [ ] Instalar targets iOS: `rustup target add aarch64-apple-ios aarch64-apple-ios-sim x86_64-apple-ios-sim`
- [ ] Verificar Xcode: `xcodebuild -version` (macOS necessário p/ Trilha B)
- [ ] Verificar Developer Tools: `xcrun --version`
- [ ] Instalar deps Cargo (check): `cargo fetch`
- [ ] Rodar build rápido check: `cargo check --workspace`

## Fase 2: Análise iOS viability (egui/wgpu)
- [ ] Verificar se eframe/wgpu suportam iOS (Metal). egui 0.36 + eframe wgpu tem suporte iOS
- [ ] Avaliar se `photocraft-tablet` (X11/macOS) precisa ajustes iOS (cfg gates)
- [ ] Verificar `rfd` (file dialogs) - no mobile pode precisar UI nativo alternativo
- [ ] Avaliar `arboard` (clipboard) suporte iOS
- [ ] Checar features wgpu/eframe p/ iOS (wayland/x11 só desktop)
- [ ] Identificar adaptações necessárias (safe area, touch, orientação)

## Fase 3: Estrutura spec-driven + monitoramento estado
- [ ] Criar `spec/requirements.md` (requisitos p/ build iOS, sideload, offline)
- [ ] Criar `spec/architecture-ios.md` (abordagem: Rust static lib + Swift app shell)
- [ ] Criar `spec/tasks.md` (tasks atômicas com estado)
- [ ] Criar `state/` com arquivos: `project.json`, `progress.json`, `decisions.md`, `risks.md`
- [ ] Inicializar `/init` se aplicável (deixar estrutura pronta)

## Fase 4: Adaptações código p/ iOS (cfg)
- [ ] Identificar código desktop-only (x11rb, zbus, muda macOS menu, objc2* macos-only, winsafe). Já tem cfg bem definidos
- [ ] Adicionar cfg `target_os = "ios"` onde necessário (event handling, menus, dialogs)
- [ ] Avaliar app entrypoint (eframe native): iOS precisa ViewController/UIView via wgpu/eframe? eframe suporta iOS (mobile)
- [ ] Criar wrapper iOS (Xcode project) ou usar `cargo-mobile2`/abordagem manual (static lib + Swift)

## Fase 5: Build iOS (dev)
- [ ] Build sim: `cargo build --target aarch64-apple-ios-sim -p photocraft`
- [ ] Build device: `cargo build --target aarch64-apple-ios -p photocraft --release`
- [ ] Gerar XCFramework/static lib se necessário
- [ ] Criar projeto Xcode mínimo (app iOS, embutir lib Rust, Metal)
- [ ] Configurar Bundle ID (uso pessoal), Signing (Apple ID free)
- [ ] Rodar no simulator primeiro
- [ ] Rodar no iPad A16 físico (Developer Mode)

## Fase 6: Empacotamento + Sideload
- [ ] Build Release device otimizado
- [ ] Archive no Xcode p/ device
- [ ] Exportar .ipa (Development/Ad Hoc) p/ SideStore/AltStore
- [ ] Testar sideload no iPad
- [ ] Documentar workflow update

## Fase 7: Validação + ajustes
- [ ] Testar touch/gestos, canvas, performance Metal
- [ ] Testar orientação, safe area
- [ ] Verificar memória, bateria
- [ ] Ajustes UI p/ tela iPad (tablet layout)

## Decisões
- Usar abordagem: Rust crate compilado p/ aarch64-apple-ios + app Swift/Xcode (nativo, sem webview). Compatível com filosofia.
- Não usar Capacitor (webview). Trilha B = nativo via Rust.
- Foco MVP: build rodando, abrir arquivos, editar básico. Iterar.

## Riscos
- eframe mobile UX: pode precisar ajustes (panels, toolbars p/ touch)
- Tamanho binary WASM não aplicável, mas Rust release iOS ~20-60MB aceitável
- Assinatura Apple ID free: 7-day limit p/ apps não registrados (mitigar com AltStore/SideStore refresh)

## Próximos passos imediatos
1. Criar estrutura spec + state (Fase 3)
2. Verificar targets + toolchain (Fase 1)
3. Fazer fork remoto (Fase 0 - preciso URL do seu fork)
4. Iniciar adaptações cfg iOS

## Status (atual)
- Sim build: OK (92MB debug)
- Próximo: criar ios/ Xcode project com static lib para device/release ou usar binário sim para testes

## Notas execução
- iOS sim bin: ios/Photocraft/photocraft_sim + deps/photocraft-*. (copiado)
- Projeto SwiftUI criado: ios/Photocraft/
- Release device build rodando (pode demorar ~20-40min total). Quando terminar, o binário vai em target/aarch64-apple-ios/release/photocraft

## Para rodar no iPad (T09)
1. Abra ios/Photocraft no Xcode (File -> Open: selecionar pasta ios/Photocraft ou criar .xcodeproj)
2. Selecione target Photocraft -> Signing & Capabilities: Team = seu Apple ID
3. Bundle ID: com.mferrreira.photocraft (pode manter)
4. Conecte iPad A16, ative Developer Mode se ainda não
5. Run (Cmd+R) no device
6. No iPad: Ajustes > Geral > VPN e Gerenciamento de Dispositivos -> confiar certificado
