import SwiftUI

@main
struct OpenWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewModel())
        }
    }
}
