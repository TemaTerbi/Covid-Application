//
//  ContentView.swift
//  ChartsScreen
//
//  Created by TeRb1 on 13.06.2022.
//

import Charts
import SwiftUI

struct ContentView: View {
    
    @State private var colorOfGraph: Color = .blue
    @State var enumsOfCharts: styleOfChart = .area
    
    enum styleOfChart {
        case bar,area,line
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        chartStyle(enumsOfCharts)
                        .frame(height: 400)
                        VStack(spacing: 20) {
                            Spacer()
                            Button("Сменить цвет") {
                                colorOfGraph = .random
                                updateCharts()
                            }
                            Button("Бар") {
                                enumsOfCharts = .bar
                                updateCharts()
                            }
                            
                            Button("Линия") {
                                enumsOfCharts = .line
                                updateCharts()
                            }
                            
                            Button("Залитая линия") {
                                enumsOfCharts = .area
                                updateCharts()
                            }
                        }
                    }
                }
                .navigationTitle("Статистика")
            }
            .background(Color("gray"))
        }
        .onAppear() {
            updateChartsInfo()
        }
    }
    
    //MARK: - Private Func
    private func updateChartsInfo() {
        DataService.shared.boolLoop = true
        DataService.shared.items = []
        loadResponseFromApiGetByCountry()
        DataService.shared.updateData()
        DataService.shared.getValue()
        enumsOfCharts = .area
    }
    
    private func chartStyle(_ type: styleOfChart) -> Chart<some ChartContent> {
        let items = DataService.shared.items
        return Chart(items) {item in
            switch(type) {
            case .area:
                AreaMark(
                    x: .value("День недели", item.type),
                    y: .value("Заболевших", item.values)
                )
                .foregroundStyle(colorOfGraph.gradient)
            case .bar:
                BarMark(
                    x: .value("День недели", item.type),
                    y: .value("Заболевших", item.values)
                )
                .foregroundStyle(colorOfGraph.gradient)
            case .line:
                LineMark(
                    x: .value("День недели", item.type),
                    y: .value("Заболевших", item.values)
                )
                .foregroundStyle(colorOfGraph.gradient)
            }
        }
    }
    
    private func updateCharts() {
        DataService.shared.boolLoop = true
        DataService.shared.items = []
        DataService.shared.updateData()
        DataService.shared.getValue()
    }
    
    private func loadResponseFromApiGetByCountry() {
        ApiManager.shared.getByCountry { country in
            let allCases = country.map{$0.cases}
            DataService.shared.arrayCases = allCases
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//For charts random color
extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
