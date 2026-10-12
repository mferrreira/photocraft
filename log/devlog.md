# Devlog

## 2025-10-12
- [x] Clonado repo upstream v0.8.1
- [x] Criado plan.md (Trilha B)
- [x] Criado spec/ (requirements, architecture-ios, tasks)
- [x] Criado state/ (project, progress, decisions, risks)
- [x] Estrutura spec-driven + monitoramento estado pronta
- [x] Rust 1.99 instalado, targets iOS adicionados (aarch64-apple-ios, aarch64-apple-ios-sim), Xcode 27 ok
- [x] Remotes configurados: origin -> fork (mferrreira/photocraft), upstream -> storytold/photocraft
- [x] Cargo deps fetch concluído
- [x] cargo check --workspace OK
- Próximo: T04 (análise iOS gaps) + T05 (cfg iOS minimal)
- [x] T04: analisado gaps iOS (desktop-only cfgs identificados)
- [x] T05: ajustes cfg iOS mínimos (wayland/x11/rfd/arboard)
- [x] T06: build iOS sim OK (photocraft bin para aarch64-apple-ios-sim)
- [x] T06: build iOS sim OK (executable em target/aarch64-apple-ios-sim/debug/photocraft)
- [x] T08: estrutura Xcode mínima criada em ios/Photocraft (SwiftUI + MTKView stub, Info.plist)
- [ ] T07/T09: release device build em andamento; gerando artefatos finais (LTO)
- [x] Build release device iniciado em background (PID 33854, log: /tmp/ios_release_build.log)
- [x] T11: docs/ios-sideload.md criado
- Estado atual: spec-driven + state atualizados; release device build em andamento
- [x] T07: build iOS device release OK (target/aarch64-apple-ios/release/photocraft, 56MB)
- Binário release copiado p/ ios/Photocraft/photocraft
- Próximo T09: abrir ios/Photocraft no Xcode, configurar Team (Apple ID), rodar no iPad. Bundle ID: com.mferrreira.photocraft
- [x] Projeto SwiftUI com MTKView criado; binário Rust (sim+release) copiado
