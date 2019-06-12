//
//  Nesting
//
//  Copyright (c) 2019-Present Warpdrives Team - https://github.com/warpdrives
//
//  The software is available under the Apache 2.0 license. See the LICENSE file
//  for more info.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import Foundation

private let NE_FROM_MESSAGE = "[**From Nesting**]"
private let NE_ASSERT_CHILDCONTROLLERCOUNT_ERROR = "\(NE_FROM_MESSAGE) The nested viewController needs to contain at least two childControllers, you must have the value of childControllerCount at least greater than 1"

/// Type of Assert
public enum NEAssertType: Int {
    /// The count of childController is less than 2.
    case childControllerCount
}

/// Assert of Nesting
///
/// - Parameter type:       Type of assert.
/// - Parameter value:      Generics that follow the <Comparable> protocol.
public func ne_assert<T: Comparable>(type: NEAssertType, value: T) {
    switch type {
    case .childControllerCount:
        let minValue: T = 1 as! T
        assert(value > minValue, NE_ASSERT_CHILDCONTROLLERCOUNT_ERROR)
    }
}

/// Format print output
///
/// - Parameter message:    Output text message. [e.g., "array.first"]
/// - Parameter file:       The path to the file containing this symbol.
/// - Parameter method:     Method name containing this symbol.
/// - Parameter line:       The line number where the symbol appears.
public func ne_print<T>(_ message: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line) {
    #if DEBUG
    print("\n[\((file as NSString).lastPathComponent) \(method)] - [Line \(line)] - \(message)\n")
    #endif
}
