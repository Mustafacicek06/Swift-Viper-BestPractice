//
//  plusMinusOne_Case_StudyTests.swift
//  plusMinusOne-Case-StudyTests
//
//  Created by MUSTACIC on 31.10.2023.
//

import XCTest
@testable import plusMinusOne_Case_Study

final class ProductPresenterTests: XCTestCase {

    private var presenter: ProductPresenter!
    private var view: MockProductVC!
    private var interactor: MockProductInteractor!
    
    override func setUp() {
        super.setUp()
        view = MockProductVC()
        interactor = MockProductInteractor()
        presenter = ProductPresenter(view: view, interactor: interactor)
    }
    
    func testViewDidLoad() {
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.invokedFetchProduct && interactor.invokedFetchSocial)
    }
    
    func testPullToRefresh() {
        presenter.pullToRefresh()
        XCTAssertTrue(interactor.invokedFetchProduct && interactor.invokedFetchSocial)
    }
    
    func testHideLoading() {
        presenter.viewDidLoad()
        XCTAssertFalse(view.invokedHideLoadingView)
    }
}
