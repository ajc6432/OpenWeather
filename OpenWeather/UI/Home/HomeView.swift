import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    @State private var citySearchIsPresented = false
    @State private var newPlace: Place?
    @State private var units: TemperatureUnit = .fahrenheit

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.showEmptyView {
                    Text("Search to show weather forecasts here!")
                }

                VStack {
                    UnitPickerView(units: $units)

                    List {
                        ForEach(viewModel.savedPlaces) { place in
                            NavigationLink {
                                CityForecastDetailView()
                                    .environmentObject(CityForecastDetailViewModel(place: place, units: units))
                            } label: {
                                CityForecastView(units: $units)
                                    .environmentObject(CityForecastViewModel(place: place))
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.delete(at: indexSet)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("OpenWeather")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        citySearchIsPresented = true
                    } label: {
                        Image(systemName: Asset.magnifyingGlass.rawValue)
                    }
                }
            }
            .sheet(isPresented: $citySearchIsPresented) {
                CitySearchView(isSearching: $citySearchIsPresented,
                               newCity: $newPlace)
                .environmentObject(CitySearchViewModel())
            }
            .onChange(of: newPlace) { newValue in
                if let newValue = newValue {
                    viewModel.saveNewPlace(place: newValue)
                    newPlace = nil
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
