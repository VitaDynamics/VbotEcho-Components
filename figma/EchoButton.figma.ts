// url=https://www.figma.com/design/5XCX9pz5AVwCkxCdw9z8zQ?node-id=848-83
// source=Sources/VbotEchoComponents/EchoButton.swift
// component=EchoButton
import figma from 'figma'

const instance = figma.selectedInstance
const label = instance.getString('Label')
const loadingLabel = instance.getString('Loading label')
const role = instance.getEnum('Role', { Primary: 'primary', Secondary: 'secondary', Ghost: 'ghost' })
const context = instance.getEnum('Context', { Surface: 'surface', Media: 'media' })
const state = instance.getEnum('State', {
  Default: 'default', Pressed: 'pressed', Disabled: 'disabled', Loading: 'loading',
})

// Escape arbitrary Figma text as a Swift string literal (including interpolation).
const swiftString = (value: string) => '"' + value.replace(/\\/g, '\\\\').replace(/"/g, '\\"')
  .replace(/\r/g, '\\r').replace(/\n/g, '\\n').replace(/\t/g, '\\t').replace(/\0/g, '\\0') + '"'

export default {
  id: 'echo-button',
  imports: ['import VbotEchoComponents'],
  example: figma.code`EchoButton(${swiftString(label)}, loadingLabel: ${swiftString(loadingLabel)}, role: .${role}, context: .${context}, state: .${state}) {
    // Handle the action in your ViewModel.
}`,
  metadata: { nestable: true },
}
