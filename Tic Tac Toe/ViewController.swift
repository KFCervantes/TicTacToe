//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

import UIKit

extension String {
	func at(_ i: Int) -> Character {
		return self[index(startIndex, offsetBy: i)]
	}
	
	mutating func change_at(_ i: Int, with: Character){
		self.remove(at: index(startIndex, offsetBy: i))
		self.insert(with, at: index(startIndex, offsetBy: i))
	}
}

class ViewController: UIViewController {
	
	var board = "         "
	
	@IBOutlet weak var button_0: UIButton!
	@IBOutlet weak var button_1: UIButton!
	@IBOutlet weak var button_2: UIButton!
	@IBOutlet weak var button_3: UIButton!
	@IBOutlet weak var button_4: UIButton!
	@IBOutlet weak var button_5: UIButton!
	@IBOutlet weak var button_6: UIButton!
	@IBOutlet weak var button_7: UIButton!
	@IBOutlet weak var button_8: UIButton!
	
	@IBAction func player_move(_ sender: UIButton) {
		if !wrapper.game_over(board) {
			let x_index = sender.tag
			
			if board.at(x_index) == " " {
				let x_img = UIImage(named: "X.png")
				sender.setImage(x_img, for: .normal)
				board.change_at(x_index, with: "X")
			}
			
			if (!wrapper.game_over(board) && (wrapper.whose_turn(board) == "O")) {
				var buttons: [UIButton] = [
					button_0,
					button_1,
					button_2,
					button_3,
					button_4,
					button_5,
					button_6,
					button_7,
					button_8
				]
				let o_index = Int(wrapper.next_best_move_index(board))
				let o_img = UIImage(named: "O.png")
				buttons[o_index].setImage(o_img, for: .normal)
				board.change_at(o_index, with: "O")
			}
		}
	}

	@IBAction func reset(_ sender: UIButton) {
		if board != "         " {
			let buttons: [UIButton] = [
				button_0,
				button_1,
				button_2,
				button_3,
				button_4,
				button_5,
				button_6,
				button_7,
				button_8
			]
			
			for button in buttons {
				button.setImage(nil, for: .normal)
			}
			
			board = "         "
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

