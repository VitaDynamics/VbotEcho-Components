# VbotEcho Components

SwiftUI components mapped to the published Echo Figma library. iOS 17+ / macOS 14+.

## Swift Package

Add `https://github.com/VitaDynamics/VbotEcho-Components.git` in Xcode's Package Dependencies and select the `VbotEchoComponents` product.

```swift
import VbotEchoComponents

EchoButton(L10n.text("common.continue"), role: .primary, context: .surface,
           state: viewModel.isSubmitting ? .loading : .default) {
    viewModel.submit()
}
```

`L10n` and `viewModel` above belong to the host app, not this package. Supply already-localized strings. The default loading label uses the package's `button.loading` Chinese localization; override `loadingLabel` for app-specific copy.

## EchoButton

[Figma component](https://www.figma.com/design/5XCX9pz5AVwCkxCdw9z8zQ?node-id=848-83)

- `role`: `.primary`, `.secondary`, `.ghost`.
- `context`: `.surface`, `.media`; separately named Figma color tokens, even where values currently match.
- `state`: `.default`, `.pressed`, `.disabled`, `.loading`.
- Native presses automatically render the pressed appearance. Explicit `.pressed` also supports design previews.
- Disabled/loading do not accept input; parent `.disabled(true)` is respected.
- 52pt minimum height, 24pt horizontal padding, capsule shape, Vbot Sans Medium 16/24 at standard text size. Dynamic Type can increase height. Width fills its parent; use `.frame(width: 240)` to match the library specimen.
- Loading replaces the label; the design contains no spinner or icon.
- Package includes the existing Vbot Sans Medium resource and registers it once per process.

The component is presentational: it owns no login, upload or ViewModel logic. VCApp has NOT yet been migrated to use this package.

## Code Connect

`figma/EchoButton.figma.ts` is a parserless template that emits SwiftUI, covering all 24 combinations. `figma.config.json` points at those templates. No legacy Swift parser is used.

```sh
npm ci
npm run check
swift test
```

To publish later updates, set `FIGMA_ACCESS_TOKEN` locally with Code Connect write and file-content read scopes, then run `npm run publish:figma`. Never commit the token. GitHub integration in Figma is separate from CLI authentication.

In Figma Code Connect UI, select this repository and `Sources/VbotEchoComponents` as the component directory. Mapping source: `Sources/VbotEchoComponents/EchoButton.swift`, component: `EchoButton`, label: `SwiftUI`.

Code Connect maps design properties to usage examples; it does not automatically update production UI. After a design change, update and verify the Swift component and template together, then republish.
