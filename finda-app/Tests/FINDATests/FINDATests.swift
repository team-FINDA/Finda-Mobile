import Testing
import OSLog
import Foundation
@testable import FINDA

let logger: Logger = Logger(subsystem: "FINDA", category: "Tests")

@Suite struct FINDATests {

    @Test func fINDA() throws {
        logger.log("running testFINDA")
        #expect(1 + 2 == 3, "basic test")
    }

    @Test func decodeType() throws {
        // load the TestData.json file from the Resources folder and decode it into a struct
        let resourceURL: URL = try #require(Bundle.module.url(forResource: "TestData", withExtension: "json"))
        let testData = try JSONDecoder().decode(TestData.self, from: Data(contentsOf: resourceURL))
        #expect(testData.testModuleName == "FINDA")
    }

}

struct TestData : Codable, Hashable {
    var testModuleName: String
}
