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
	var player: Character = "X"
	var cpu: Character = "O"
	
	let draw_img = UIImage(named: "draw.png")
	let lose_img = UIImage(named: "lose.png")
	let highlight_img = UIImage(named: "highlight.png")
	
	@IBOutlet weak var button_0: UIButton!
	@IBOutlet weak var button_1: UIButton!
	@IBOutlet weak var button_2: UIButton!
	@IBOutlet weak var button_3: UIButton!
	@IBOutlet weak var button_4: UIButton!
	@IBOutlet weak var button_5: UIButton!
	@IBOutlet weak var button_6: UIButton!
	@IBOutlet weak var button_7: UIButton!
	@IBOutlet weak var button_8: UIButton!
	
	@IBOutlet weak var game_over_message: UIImageView!
	
	@IBOutlet weak var select_x: UIButton!
	@IBOutlet weak var select_o: UIButton!
	
	@IBAction func player_move(_ sender: UIButton) {
		if !wrapper.game_over(board) {
			let player_move_index = sender.tag
			
			if board.at(player_move_index) == " " {
				let player_char_file = String(player) + ".png"
				let player_char_img = UIImage(named: player_char_file)
				sender.setImage(player_char_img, for: .normal)
				board.change_at(player_move_index, with: player)
			}
			
			if !wrapper.game_over(board) {
				let cpu_str = String(cpu)
				
				if (wrapper.whose_turn(board) == cpu_str){
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
					let cpu_move_index = Int(wrapper.next_best_move_index(board))
					let cpu_char_file = cpu_str + ".png"
					let cpu_char_img = UIImage(named: cpu_char_file)
					buttons[cpu_move_index].setImage(cpu_char_img, for: .normal)
					board.change_at(cpu_move_index, with: cpu)
					
					if wrapper.game_over(board){
						if board.contains(" ") {
							game_over_message.image = lose_img
						}
						else {
							game_over_message.image = draw_img
						}
					}
				}
			}
			else if board.contains(" ") {
				game_over_message.image = lose_img
			}
			else {
				game_over_message.image = draw_img
			}
		}
	}
	
	@IBAction func x_reset(_ sender: UIButton) {
		sender.setBackgroundImage(highlight_img, for: .normal)
		select_o.setBackgroundImage(nil, for: .normal)
		game_over_message.image = nil

		player = "X"
		cpu = "O"
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
	
	@IBAction func o_reset(_ sender: UIButton) {
		sender.setBackgroundImage(highlight_img, for: .normal)
		select_x.setBackgroundImage(nil, for: .normal)
		game_over_message.image = nil
		
		player = "O"
		cpu = "X"
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
		if board != "         " {
			for button in buttons {
				button.setImage(nil, for: .normal)
			}
			
			board = "         "
		}
		
		let x_index = Int(wrapper.next_best_move_index(board))
		let x_img = UIImage(named: "X.png")
		buttons[x_index].setImage(x_img, for: .normal)
		board.change_at(x_index, with: "X")
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

