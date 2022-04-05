//
//  ContentView.swift
//  PokemonList
//
//  Created by LMCM on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    var viewModel: ViewModel = ViewModel()
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                viewModel.getPokemons()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
