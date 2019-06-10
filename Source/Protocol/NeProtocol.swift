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


import UIKit

protocol CreatNested:class{
    /**
     *  Create a low-level container based on UIScrollView.
     *
     *  @param childControllerCount The Count of childControllers in the container.
     *
     */
    func ne_creatContainerScrollView(_ childControllerCount: Int)
    
    var ne_backgroundColor:UIColor {set get}
}

public class CreatNestedProtocolModel {
    
    var ne_backgroundColor:UIColor = UIColor.red
}

extension CreatNested where Self: UIViewController {
    
    func ne_creatContainerScrollView(_ childControllerCount: Int) {
        ne_creatNestedViewController(childControllerCount)
    }

    var ne_backgroundColor: UIColor {
        get {
            return self.ne_getCurrentConfig().ne_backgroundColor
        }
        set {
//class
            self.ne_getCurrentConfig().ne_backgroundColor = newValue
// struct
//            var config = self.ne_getCurrentConfig()
//            config.ne_backgroundColor = newValue
//            NeConfig.default.ne_nestedDict[self.ne_getCurrentVCAddressPointer()] = config
//            self.ne_getCurrentConfig().ne_backgroundColor = newValue
        }
    }

   
}
