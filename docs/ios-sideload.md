# iOS Sideload (Trilha B)

## Build sim
- Target: aarch64-apple-ios-sim
- Binário: target/aarch64-apple-ios-sim/debug/photocraft

## Build device (release)
- Target: aarch64-apple-ios
- Binário: target/aarch64-apple-ios/release/photocraft (quando finalizar)

## Xcode project
- Pasta: ios/Photocraft/
- Bundle ID: com.mferrreira.photocraft (editar se quiser)
- Para rodar no iPad: abrir no Xcode (ios/Photocraft.xcodeproj? ainda não criado .xcodeproj, mas temos arquivos; pode criar via Xcode -> File -> New -> Project -> App e linkar binário, ou gerar pbxproj)

## Sideload
1. Conectar iPad, ativar Developer Mode (Ajustes > Privacidade e Segurança > Modo Desenvolvedor)
2. Xcode -> Team: Apple ID pessoal (Free)
3. Run no device
4. No iPad: confiar certificado (Ajustes > Geral > VPN e Gerenciamento de Dispositivos)
5. Alternativa: exportar .ipa p/ AltStore/SideStore

## Atualizações
- Rebuild release, substituir binário/link no Xcode, reinstall
