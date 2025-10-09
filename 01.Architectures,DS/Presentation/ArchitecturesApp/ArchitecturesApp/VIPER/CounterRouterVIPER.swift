//
//  CounterRouterVIPER.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

protocol CounterRouterProtocol: AnyObject {

}

class CounterRouterVIPER: CounterRouterProtocol {
    static func createModule() -> some View {
        let presenter = CounterPresenterVIPER()
        let view = CounterViewVIPER(presenter: presenter)
        let interactor = CounterInteractorVIPER()
        let router = CounterRouterVIPER()

        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
