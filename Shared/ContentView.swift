//
//  ContentView.swift
//  Shared
//
//  Created by Jared Davidson on 5/28/21.
//

import SwiftUI

struct ContentView: View {
    // states that our tictactoddmodel slide is real
    @StateObject var ticTacToeModel = TicTacToeModel()
    @State var gameOver : Bool = false
    
    func buttonAction(_ index : Int) {
        _ = self.ticTacToeModel.makeMove(index: index, player: .home)
        self.gameOver = self.ticTacToeModel.gameOver.1
    }
    //restart game code
    var body: some View {
        VStack {
            Text("Tickity Tac Toe")
                .bold()
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom)
                .font(.title2)
            //loop de loop to form grid for tic tac todd
            ForEach(0 ..< ticTacToeModel.squares.count / 3, content: {
                row in
                HStack {
                    ForEach(0 ..< 3, content: {
                        column in
                        let index = row * 3 + column
                        SquareView(dataSource: ticTacToeModel.squares[index], action: {self.buttonAction(index)})
                    })
                }
            })
            // game set up
        }.alert(isPresented: self.$gameOver, content: {
            Alert(title: Text("Game Over"),
                  message: Text(self.ticTacToeModel.gameOver.0 != .empty ? self.ticTacToeModel.gameOver.0 == .home ? "You Win!": "AI Wins!" : "Nobody Wins" ) , dismissButton: Alert.Button.destructive(Text("Ok"), action: {
                    self.ticTacToeModel.resetGame()
                  }))
        })
    }
}
//start over button and declares winner
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
