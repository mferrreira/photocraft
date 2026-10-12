# Arquitetura: PhotoCraft iOS

## Visão geral
PhotoCraft é Rust nativo: egui+eframe+wgpu. iOS precisa compilar engine+UI p/ `aarch64-apple-ios`. Abordagem: crate `photocraft` (apps/photocraft) compila p/ iOS; UI via eframe mobile. Empacotar como lib + app Swift minimal (UIViewController hospedando eframe/wgpu).

## Componentes
- Core Rust: `crates/*` + `apps/photocraft` (entrypoint)
- Target: `aarch64-apple-ios` (device), `aarch64-apple-ios-sim` (sim)
- Backend gráfico: wgpu + Metal
- UI: egui 0.36 (touch-friendly). eframe provê integração iOS
- Input: toque + gestos (eframe lida). Pen tablet específico desktop; iOS touch ok
- File I/O: usar `rfd`? rfd tem backends; pode precisar substituir por `rfd` mobile-aware ou UIDocumentPicker via bridging. Avaliar.
- Assets: mesmos (fontes via craft-fonts opcional; app precisa incluir)

## Integração iOS
eframe suporta iOS (ver README eframe mobile). Geralmente:
- `eframe::run_native` não direto igual desktop? Ou usar `eframe::NativeOptions` + platform. Alternativa: criar `apps/photocraft-ios` (novo crate) ou adaptar `apps/photocraft` com cfg ios.
- Ou gerar static lib (`cargo rustc --crate-type staticlib`) e Swift host com `WKWebView`? NÃO - queremos nativo Rust, sem webview. eframe/wgpu nativo Metal.
- Opção: manter `apps/photocraft` e criar `ios/` com projeto Xcode que linka lib + chama entrypoint Rust (C FFI).

## Adaptações por cfg
Desktop-only evitar em iOS:
- `x11rb`, `zbus` (linux/x11/wayland) -> cfg linux only
- `muda` (macOS menu bar) -> macos only
- `objc2-*` macos specifics -> macos only  
- `winsafe`, `xcap` windows -> windows only
- `photocraft-tablet` usa X11/macOS; iOS sem tablet específico -> ok se não usado
- `rfd` file dialogs: desktop ok; iOS precisa picker nativo -> avaliar bridging

## Camadas (manter)
L0-L6 intactos. Só adaptações cfg + entrypoint iOS se necessário.

## Build
```bash
cargo build --target aarch64-apple-ios --release -p photocraft
# gerar staticlib p/ Xcode
```

## Xcode project
Mínimo:
- Target iOS app (Swift/ObjC)
- Link libphotocraft.a + system libs (Metal, QuartzCore, UIKit, etc)
- Rust entrypoint exposto via C ABI
- Info.plist (bundle id, icons, orientations)
- Signing

## Riscos arquitetura
- eframe mobile API changes (0.36 ok?)
- Touch vs mouse events mapping
- Safe area insets
- File access permissions (NSDocumentsFolder, Photos? não necessário)

## Decisão
Começar adaptando `apps/photocraft` com cfg ios-aware. Criar pasta `ios/` com Xcode project template. Evitar novo crate complexo inicial.
