# Decisões

## D001 - Trilha B (nativo)
- Decisão: Abordagem Rust nativo (aarch64-apple-ios) + Xcode app Swift (sem webview). Não usar Capacitor.
- Data: 2025-10-12
- Justificativa: Alinha com filosofia "Rust only, no webview shells" (AGENTS.md). wgpu Metal disponível.

## D002 - Adaptar apps/photocraft vs novo crate ios
- Decisão: Começar adaptando `apps/photocraft` (entrypoint existente) com cfg iOS-aware. Criar projeto Xcode em `ios/`.
- Data: 2025-10-12
- Justificativa: Menor superfície de mudança, reutiliza engine/UI existente.

## D003 - Spec-driven + monitoramento estado
- Decisão: Usar spec/ + state/ + log/ nessa pasta. Não criar em ~/.opencode.
- Data: 2025-10-12
- Justificativa: Conforme solicitado, manter escopo aqui.

## Pendente
- D004: Abordagem file picker iOS (rfd vs UIDocumentPicker bridging)
- D005: Entry point eframe iOS (run_native vs staticlib + Swift)
- D006: Bundle ID + signing strategy

## D004 - cfg iOS: tratar desktop-only como não-iOS
- Decisão: Para blocos macOS/linux/windows específicos, usar `#[cfg(not(target_os="ios"))]` quando fazem sentido p/ desktop; p/ código realmente desktop-only manter cfgs existentes. iOS não precisa deles.
- Data: 2025-10-12
- Justificativa: Evita pull de deps não usados e compila limpo p/ iOS.

## D005 - Entry point iOS
- Decisão: Começar tentando `eframe::run_native` (mesmo entrypoint) com `NativeOptions`. eframe 0.36 tem suporte iOS; se falhar compilar, criar abordagem staticlib + Swift host.
- Data: 2025-10-12
- Justificativa: Reutilizar máximo do código existente.

## D007 - Build iOS: gerar binário para sim (debug) funcional
- Decisão: Binário iOS sim (Mach-O arm64) construído com sucesso. Release device precisa de tempo maior; seguir por staticlib/Xcode para device.
- Data: 2025-10-12

## D008 - Build iOS release: levará tempo (LTO + wgpu/egui)
- Decisão: Build release device continua em background; mantemos estrutura Xcode pronta.
- Data: 2025-10-12
