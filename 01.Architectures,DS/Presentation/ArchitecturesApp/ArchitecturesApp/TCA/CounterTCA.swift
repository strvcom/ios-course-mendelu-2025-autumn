//
//  CounterTCA.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation
import SwiftUI

// The State: A simple struct to hold the feature's data.
struct CounterState: Equatable {
    var count = 0
}

// The Action: An enum representing all possible events.
enum CounterAction: Equatable {
    case incrementButtonTapped
}

// The Environment/Dependencies (empty for this example)
struct CounterEnvironment {}

// The Reducer: A pure function that evolves the state based on an action.
// (inout CurrentState, Action, Environment) -> Void
func counterReducer(
    state: inout CounterState,
    action: CounterAction,
    environment: CounterEnvironment
) {
    print("5️⃣TCA: reducer, switch over all actions")
    switch action {
    case .incrementButtonTapped:
        print("5️⃣TCA: reducer, incrementButtonTapped")
        state.count += 1
    }
}

// The Store: An ObservableObject that manages the state and runs the reducer.
final class Store<State, Action, Environment>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: (inout State, Action, Environment) -> Void
    private let environment: Environment

    init(initialState: State, reducer: @escaping (inout State, Action, Environment) -> Void, environment: Environment) {
        self.state = initialState
        self.reducer = reducer
        self.environment = environment
    }

    func send(_ action: Action) {
        print("5️⃣TCA: store send(action) called, pass to reducer")
        self.reducer(&self.state, action, self.environment)
    }
}

// The View: Observes the store and sends actions.
struct CounterViewTCA: View {
    @StateObject private var store: Store<CounterState, CounterAction, CounterEnvironment>

    init() {
        _store = StateObject(wrappedValue: Store(
            initialState: CounterState(),
            reducer: counterReducer,
            environment: CounterEnvironment()
        ))
    }

    var body: some View {
        VStack(spacing: 30) {
            Text("\(store.state.count)")
                .font(.system(size: 80, weight: .bold))

            HStack(spacing: 20) {
                Button("Increment") {
                    print("5️⃣TCA: button tap")
                    store.send(.incrementButtonTapped)
                }
            }
        }
        .navigationTitle("TCA Pattern")
    }
}

#Preview {
    NavigationView {
        CounterViewTCA()
    }
}
