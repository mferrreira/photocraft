# Riscos

## R01 - eframe mobile/touch UX
- Prob: Layout desktop pode não ser ideal p/ touch (iPad)
- Mitigação: Testar early, ajustar panels/toolbars via state/theme se necessário
- Severidade: Média

## R02 - rfd (file dialog) iOS
- Prob: rfd pode não ter picker ideal iOS; dialogs desktop
- Mitigação: Avaliar cfg ios - talvez usar native picker via bridging Swift
- Severidade: Média

## R03 - Assinatura 7-dias (free Apple ID)
- Prob: Apps free expiram ~7 dias
- Mitigação: AltStore/SideStore com refresh automático (anisette)
- Severidade: Baixa (uso próprio)

## R04 - Build size / linking
- Prob: Rust release + Metal pode pesar
- Mitigação: LTO thin já ativo, otimizar release. Esperado 30-70MB
- Severidade: Baixa

## R05 - cfg gaps desktop-only deps
- Prob: Alguns blocos podem compilar mal em ios
- Mitigação: Análise T04 + ajustes T05 incrementais
- Severidade: Média

## R06 - eframe entrypoint iOS
- Prob: run_native padrão desktop pode diferir mobile
- Mitigação: Consultar eframe 0.36 iOS; talvez staticlib + host UIKit
- Severidade: Média

## R07 - Build release device longo
- Prob: LTO + wgpu gera tempo longo (normal)
- Mitigação: build em background, logs em /tmp/ios_release_build.log
- Severidade: Baixa
