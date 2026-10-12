# Requisitos: PhotoCraft iOS (uso próprio)

## Objetivo
Executar PhotoCraft nativamente no iPad A16 (iPadOS), sem publicação na App Store, para uso pessoal. Build Rust puro (egui+wgpu) compilado para aarch64-apple-ios, empacotado via Xcode para sideload (AltStore/SideStore) ou execução direta no dispositivo.

## Requisitos funcionais
- [ ] App nativo iOS (Metal backend via wgpu)
- [ ] Interface principal PhotoCraft funcional (canvas, ferramentas básicas, camadas)
- [ ] Abrir/salvar arquivos locais (iOS Files app / file picker)
- [ ] Suporte toque/gestos (pan/zoom) adequado
- [ ] Orientação portrait/landscape
- [ ] Rodar offline (sem dependência backend)
- [ ] Suportar formatos existentes (PSD, PNG, JPG, WebP, etc via codecs)

## Requisitos não-funcionais
- [ ] Rust only (sem Tauri, Electron, Capacitor/webview)
- [ ] Seguir arquitetura existente (camadas L0-L6)
- [ ] Compilar sem `unsafe` fora de `crates/tablet` (manter política)
- [ ] Sem adicionar frameworks JS/UI
- [ ] Código com cfg apropriado p/ iOS
- [ ] Build release viável p/ device
- [ ] Tamanho aceitável (<150MB)
- [ ] Performance Metal adequada

## Restrições
- Uso pessoal, sem App Store
- macOS necessário p/ build/Xcode (Trilha B)
- Apple ID gratuito ok (sideload com limitações 7-dias; mitigar via AltStore/SideStore)
- Manter compatibilidade desktop/web existente
- Não quebrar testes existentes

## Critérios sucesso
- [ ] `cargo build --target aarch64-apple-ios-sim` sucesso
- [ ] `cargo build --target aarch64-apple-ios --release` sucesso
- [ ] App roda no Simulator iPad
- [ ] App roda no iPad A16 físico via Xcode (sideload)
- [ ] Core funcional testado (abrir imagem, navegar, interagir)
- [ ] Sem regressões desktop build check
- [ ] Estrutura spec/state atualizada
- [ ] Plano executável documentado
