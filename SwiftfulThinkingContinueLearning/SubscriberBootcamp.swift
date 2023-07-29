//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 25/07/2023.
//

/* Create a timer, which is a publisher, in a viewmodel
 Since it is in viemodel, we need to use sink (using combine) for listen to the publish
 Timer is cancellable . . something we can cancel  at any time
 */


import SwiftUI
import Combine


class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var timer: AnyCancellable? // this work if we only have a single cancellable
    
    var cancellables = Set<AnyCancellable>() // if we have more cancellables
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    // use .sink vs .assign whenever u can
    
    
    init () {
        print("init")
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    
    func addTextFieldSubscriber() {
      print("addText")
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) //
            .map { (text) -> Bool in
                if (text.count > 3) {
                    return true
                }
                
                return false
                
            }
            //.assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
                
            })
            .store(in : &cancellables)
    }
    
    
    
    func setUpTimer () {
        //timer = Timer // if we have a single timer
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                // one way
                /*
                self?.count += 1
                
                //how to cancel our timer
                if let count = self?.count, count >= 5 {
                    self?.timer?.cancel()
                }
                */
                
                
                // second way - how profies check if self is valid
                guard let self = self else { return }
                print(self.count)
                self.count += 1
                
                /*
                if self.count >= 5 {
                    self.timer?.cancel()
                }
                */
                //multiple cancellables
                if self.count >= 12 {
                    for item in self.cancellables {
                        item.cancel()
                    }
                }
                
                
                
                
            }
            .store(in: &cancellables) // if we have multiple cancellables
    }
    
    // combining isValid and count - 2 publishers
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink {  [weak self] (isValid, count) in
                guard let self = self else { return }
                
                if isValid && count >= 5 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
                
                
                
            }
            .store(in :&cancellables)
    }
}


struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description)
            
            TextField("Type something here . . . ", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    , alignment: .trailing
                    
                )
            
            Button(action: {
                
            }, label : {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .opacity(vm.showButton ? 1.0 : 0.7)
                    .cornerRadius(15)
            })
            .disabled(!vm.showButton)
            
        }
        .padding(20)
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}

