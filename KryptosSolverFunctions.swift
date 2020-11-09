import Cocoa

class KryptosSolverFunctions: NSObject {

    static func Load_Dictionary_List() -> [String]
    {
        var wordList : [String] = [String]()

        do {
            let data = try String(contentsOfFile: "/usr/share/dict/words", encoding: .utf8)
            let dictionaryWords = data.components(separatedBy: .newlines)
            for word in dictionaryWords
            {
                if(word.count > 0)
                {
                    wordList.append(word.uppercased().trimmingCharacters(in: .whitespacesAndNewlines))
                }
            }
        } catch {

        }

        for word in wordList
        {
            wordList.append(String(word.reversed()))
        }

        return wordList
    }

    static func RemainingAlphabetString(keyword_one: String) -> String
    {
        var remaining_characters : String = String()

        let standard_alphabet : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

        for i in 0..<standard_alphabet.count
        {

            let standard_alphabet_index = standard_alphabet.index(standard_alphabet.startIndex, offsetBy: i)

            var in_alpha_set : Bool = false;
            for j in 0..<keyword_one.count
               {

                let keyword_one_index = keyword_one.index(keyword_one.startIndex, offsetBy: j)
                if(standard_alphabet[standard_alphabet_index] == keyword_one[keyword_one_index])
                   {
                       in_alpha_set = true;
                   }
               }

               if(in_alpha_set == false)
               {
                   remaining_characters = remaining_characters + String(standard_alphabet[standard_alphabet_index])
               }
        }

        return remaining_characters;
    }

    static func Generate_Cipher_Alphabets_From_Keywords(cipher_base_alphabet: String, keyword_one: String, keyword_two: String, keyword_start_position: Int) -> [String]
    {
        var cipher_alphabet_vector : [String] = [String]()

        for i in  0..<keyword_two.count
        {
            var new_alpha_start_position : Int = Int()

            let keyword_two_StartIndex = keyword_two.index(keyword_two.startIndex, offsetBy: i)

            for j in 0..<cipher_base_alphabet.count
            {
                let cipher_base_alphabet_StartIndex = cipher_base_alphabet.index(cipher_base_alphabet.startIndex, offsetBy: j)

                if(keyword_two[keyword_two_StartIndex] == cipher_base_alphabet[cipher_base_alphabet_StartIndex])
                {
                    new_alpha_start_position = j
                }
            }

            let new_alpha_start_char_StartIndex = cipher_base_alphabet.index(cipher_base_alphabet.startIndex, offsetBy: new_alpha_start_position)

            let new_alpha_start_char : String = String(cipher_base_alphabet[new_alpha_start_char_StartIndex])

            let cipher_keyset : String = self.ShiftAlphaSet(cipher_base_alphabet: cipher_base_alphabet, start_char: new_alpha_start_char)
            cipher_alphabet_vector.append(cipher_keyset)

        }


        return cipher_alphabet_vector
    }

    static func ShiftAlphaSet(cipher_base_alphabet: String, start_char: String) -> String
    {
        var new_alpha_set : String = String()

        let cipher_alphabet_size : Int = cipher_base_alphabet.count
        var start_position : Int = 0

        for i in 0..<cipher_base_alphabet.count
        {
            let cipher_base_alphabet_index = cipher_base_alphabet.index(cipher_base_alphabet.startIndex, offsetBy: i)

            if(start_char == String(cipher_base_alphabet[cipher_base_alphabet_index]))
            {
                start_position = i;
            }
        }

        let new_alpha_set_start_index = cipher_base_alphabet.index(cipher_base_alphabet.startIndex, offsetBy: start_position)
        let new_alpha_set_end_index = cipher_base_alphabet.index(new_alpha_set_start_index, offsetBy: (cipher_alphabet_size)-(start_position))

        let new_alpha_set_from_start_index = cipher_base_alphabet.index(cipher_base_alphabet.startIndex, offsetBy: 0)


        new_alpha_set = String(cipher_base_alphabet[new_alpha_set_start_index..<new_alpha_set_end_index]) + String(cipher_base_alphabet[new_alpha_set_from_start_index..<new_alpha_set_start_index])


        return new_alpha_set
    }

    static func Vigenere_With_Alpha_Keywords(encrypted_puzzle_part: String, keyword_one: String, keyword_two: String) -> String
    {

        let keyword_starting_position : Int = 0
        let keyword_two_length : Int = keyword_two.count

        let remaining_alphabet_characters : String = self.RemainingAlphabetString(keyword_one: keyword_one)
        let cipher_base_alphabet : String = keyword_one + remaining_alphabet_characters
        var decrypted_string : String = String()

        let cipher_alphabet_vector : [String] = self.Generate_Cipher_Alphabets_From_Keywords(cipher_base_alphabet: cipher_base_alphabet, keyword_one: keyword_one, keyword_two: keyword_two, keyword_start_position: keyword_starting_position)

        var vector_index : Int = 0

        for i in 0..<encrypted_puzzle_part.count
        {
            vector_index = (vector_index < keyword_two_length) ? vector_index : 0
            for j in  0..<cipher_alphabet_vector[vector_index].count
            {
                let encrypted_puzzle_part_startIndex = encrypted_puzzle_part.index(encrypted_puzzle_part.startIndex, offsetBy: i)

                let cipher_alphabet_vector_StartIndex = cipher_alphabet_vector[vector_index].index(cipher_alphabet_vector[vector_index].startIndex, offsetBy: j)

                if(encrypted_puzzle_part[encrypted_puzzle_part_startIndex] == cipher_alphabet_vector[vector_index][cipher_alphabet_vector_StartIndex])
                {
                    decrypted_string = decrypted_string + String(cipher_base_alphabet[cipher_alphabet_vector_StartIndex])
                }
            }
            vector_index = vector_index + 1
        }

        return decrypted_string
    }

    static func PrintMatrix(grid_matrix: [[String]]) -> String
    {
        var matrix_string : String = String()

        for j in 0..<grid_matrix.count
        {
            for k in 0..<grid_matrix[j].count
            {
               matrix_string = matrix_string + grid_matrix[j][k]
            }
        }

        return matrix_string;

    }

    static func String_To_Matrix(string_as_matrix: String, width: Int) -> [[String]]
    {
        var new_matrix : [[String]] = [[String]]()

        var new_matrix_row : [String] = [String]()
        var new_matrix_row_counter : Int = 0

        for i in 0..<string_as_matrix.count
        {
            let string_as_matrix_StartIndex = string_as_matrix.index(string_as_matrix.startIndex, offsetBy: i)

            let matrixSubString : String = String(string_as_matrix[string_as_matrix_StartIndex])
            new_matrix_row.append(matrixSubString)
            new_matrix_row_counter = new_matrix_row_counter + 1
            if(new_matrix_row_counter == width)
            {
                new_matrix.append(new_matrix_row)
                new_matrix_row.removeAll()
                new_matrix_row_counter = 0
            }
        }

        return new_matrix;
    }

    static func Matrix_To_String(matrix: [[String]]) -> String
    {
        var matrix_as_string : String = String()

        for i in 0..<matrix.count
        {
            for j in 0..<matrix[i].count
            {
                matrix_as_string = matrix_as_string + matrix[i][j]
            }
        }

        return matrix_as_string;
    }

    static func RotateMatrix(matrix: [[String]]) -> [[String]]
    {
        var rotated_matrix :  [[String]] = [[String]]()

        for j in 0..<matrix[0].count
        {
            var row_array : [String] = [String]()
            for i in 0..<matrix.count
            {
                let matrixPosition : Int = (matrix.count) - (i) - (1)
                let matrixValue : String = matrix[matrixPosition][j]
                row_array.append(matrixValue)
            }
            rotated_matrix.append(row_array)
        }

        return rotated_matrix
    }

    static func Grid_Rotation_Solver(encrypted_puzzle_part: String) -> String
    {
        let grid_width : Int = 25;

        var grid_matrix : [[String]] = [[String]]()
        var row_array : [String] = [String]()

        var column_counter : Int = 0

        for i in 0..<encrypted_puzzle_part.count
        {
            let encrypted_puzzle_part_index = encrypted_puzzle_part.index(encrypted_puzzle_part.startIndex, offsetBy: i)

            let character : String = String(encrypted_puzzle_part[encrypted_puzzle_part_index])
            row_array.append(character);
            column_counter = column_counter + 1

            if((column_counter == grid_width - 1) || (i == encrypted_puzzle_part.count-1))
            {
                column_counter = 0
                grid_matrix.append(row_array);
                row_array.removeAll();
            }
        }


        let rotated_matrix : [[String]] = self.RotateMatrix(matrix: grid_matrix)
        // PrintMatrix(rotated_matrix);

        let matrix_string : String = self.Matrix_To_String(matrix: rotated_matrix)
        var new_matrix : [[String]] = self.String_To_Matrix(string_as_matrix: matrix_string, width: 8)
        new_matrix = self.RotateMatrix(matrix: new_matrix)
        let solution : String = self.PrintMatrix(grid_matrix: new_matrix)

        return solution
    }

    static func Get_Integer_Number(alphabetSet: String, character: String) -> Int
    {

        for i in 0..<alphabetSet.count{
            let standard_alphabet_index = alphabetSet.index(alphabetSet.startIndex, offsetBy: i)
            if(String(alphabetSet[standard_alphabet_index]) == character)
            {
                return i
            }
        }

        return -1
    }


    static func Polyalphabetic_Cipher(encrypted_puzzle_part: String, keyword_one: String, keyword_two: String) -> String
    {
        var solvedPuzzle : String = String()

        var counter = 0
        for i in 0..<encrypted_puzzle_part.count
        {

            let encrypted_puzzle_part_index = encrypted_puzzle_part.index(encrypted_puzzle_part.startIndex, offsetBy: i)
            let currentLetter : String = String(encrypted_puzzle_part[encrypted_puzzle_part_index])

            solvedPuzzle = solvedPuzzle + currentLetter
            counter = (counter < keyword_one.count) ? counter + 1 : 0
        }

        print(solvedPuzzle)
        return solvedPuzzle
    }

}
