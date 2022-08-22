//
//  ViewController.swift
//  Loteria
//
//  Created by Sharon Lima on 11/08/22.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-<
    func >-< (total: Int, universe: Int) -> [Int] {
        var result: [Int] = []
        while result.count < total {
            let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
            if !result.contains(randomNumber) {
                result.append(randomNumber)
            }
        }
        return result.sorted()
    }

class ViewController: UIViewController {
    @IBOutlet weak var labelGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!

    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)
    }
    
    func showNumbers(for type: GameType) {
        labelGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
        case .megasena:
            game = 6>-<60
            balls.last!.isHidden = false
        case .quina:
            game = 5>-<80
            balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated() {
            balls[index].setTitle("\(game)", for: .normal)
         //  balls[index].titleLabel = UIFont(name: "Avenir Next", size: 50.0)
        }
    }
    
    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
}
