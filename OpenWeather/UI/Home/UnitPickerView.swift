import SwiftUI

struct UnitPickerView: View {
    @Binding var units: TemperatureUnit

    var body: some View {
        Picker("Units", selection: $units) {
            ForEach(TemperatureUnit.allCases) { unit in
                Text(unit.label).tag(unit)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct UnitPickerView_Previews: PreviewProvider {
    static var previews: some View {
        UnitPickerView(units: .constant(.fahrenheit))
    }
}
