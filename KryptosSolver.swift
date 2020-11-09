import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let part_one_keyword_one : String = "KRYPTOS"
        let part_one_keyword_two : String = "PALIMPSEST"
        let encrypted_part_one : String = "EMUFPHZLRFAXYUSDJKZLDKRNSHGNFIVJYQTQUXQBQVYUVLLTREVJYQTMKYRDMFD";

        var part_one_decrypted : String = KryptosSolverFunctions.Vigenere_With_Alpha_Keywords(encrypted_puzzle_part: encrypted_part_one,keyword_one: part_one_keyword_one,keyword_two: part_one_keyword_two)
            
        part_one_decrypted = part_one_decrypted.replacingOccurrences(of: "?", with: "")

        print("Part One Length:\t" + String(encrypted_part_one.count))
        print("Part One:")
        print(encrypted_part_one)

        print("Part One Decrypted:")
        print(part_one_decrypted)
        
        
        let part_two_keyword_one : String = "KRYPTOS"
        let part_two_keyword_two : String = "ABSCISSA"
        let encrypted_part_two : String = "VFPJUDEEHZWETZYVGWHKKQETGFQJNCEGGWHKK";

        var part_two_decrypted : String = KryptosSolverFunctions.Vigenere_With_Alpha_Keywords(encrypted_puzzle_part: encrypted_part_two,keyword_one: part_two_keyword_one,keyword_two: part_two_keyword_two)
            
        part_two_decrypted = part_two_decrypted.replacingOccurrences(of: "?", with: "")

        print("Part Two Length:\t" + String(part_two_decrypted.count))
        print("Part Two:")
        print(encrypted_part_two)

        print("Part Two Decrypted:")
        print(part_two_decrypted)
         
        var encrypted_part_three : String = "ENDYAHROHNLSRHEOCPTEOIBIDYSHNAIACHTNREYULDSLLSLLNOHSNOSMRWXMNETPRNGATIHNRARPESLNNELEBLPIIACAEWMTWNDITEENRAHCTENEUDRETNHAEOETFOLSEDTIWENHAEIOYTEYQHEENCTAYCREIFTBRSPAMHNEWENATAMATEGYEERLBTEEFOASFIOTUETUAEOTOARMAEERTNRTIBSEDDNIAAHTTMSTEWPIEROAGRIEWFEBAECTDDHILCEIHSITEGOEAOSDDRYDLORITRKLMLEHAGTDHARDPNEOHMGFMFEUHEECDMRIPFEIMEHNLSSTTRTVDOHW?"
        encrypted_part_three = encrypted_part_three.replacingOccurrences(of: "?", with: "")

        print("Part Three Length:\t" + String(encrypted_part_three.count))
        print("Part Three:")
        print(encrypted_part_three)

        let part_three_decrypted : String = KryptosSolverFunctions.Grid_Rotation_Solver(encrypted_puzzle_part: encrypted_part_three)
        
        print("Part Three Decrypted:")
        print(part_three_decrypted)
        
        let encrypted_part_four : String = "OBKRUOXOGHULBSOLIFBBWFLRVQQPRNGKSSOTWTQSJQSSEKZZWATJKLUDIAWINFBNYPVTTMZFPKWGDKZXTJCDIGKUHUAUEKCAR"
        
        print("Part Four Length:\t" + String(encrypted_part_four.count))
        print("Part Four:")
        print(encrypted_part_four)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
        

}
