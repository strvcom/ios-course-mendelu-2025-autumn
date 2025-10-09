//
//  CounterRouterVIP.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

class CounterRouterVIP {
    static func assembleModule() -> some View {
        let interactor = CounterInteractorVIP()
        let presenter = CounterPresenterVIP()

        interactor.presenter = presenter

        let view = CounterViewVIP(interactor: interactor, presenter: presenter)

        return view
    }
}
