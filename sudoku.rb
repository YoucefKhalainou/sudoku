if(ARGV.length < 1)
    puts"#{__FILE__} requires one argument: #{__FILE__} sudoko_table"
    exit
end


sudoku_table = ARGV[0]

sudoku = []
position = 0
File.foreach(sudoku_table) do |line| 
    sudoku[position] = line.chomp.split('')
    position+=1
end  

def display_sudoku(sudoku)
    line=0
    while(line < sudoku.count)
        column=0
        while(column < sudoku[line].count)
            print sudoku[line][column]
            column+=1
        end    
        line+=1
        print "\n"
    end    
end    

def init_array()
    array = []
    for value in 1..9
        array[value] = 0
    end 
    return (array)   
end

def check_line(sudoku,line)
    column = 0
    array = init_array()
    while(column < sudoku[line].count)
        value = sudoku[line][column].to_i    
        if(value > 0 && value < 10)
            array[value] += 1
            if(array[value] > 1)
                return (false)
            end
        end        
        column += 1
    end
    return (true)    
end

def check_column(sudoku,column)
    line = 0
    array = init_array()
    while(line < sudoku.count)
        value = sudoku[line][column].to_i    
        if(value > 0 && value < 10)
            array[value] += 1
            if(array[value] > 1)
                return (false)
            end
        end        
        line += 1
    end
    return (true)    
end

def check_square(sudoku,line,column)
    array = init_array()
    square_begin_line = (line/4)*4
    square_begin_column = (column/4)*4 
    while(line < square_begin_line + 3)
        while(column < square_begin_column + 3 )
            value = sudoku[line][column].to_i    
            if(value > 0 && value < 10)
                array[value] += 1
                if(array[value] > 1)
                    return (false)
                end
            end        
            column += 1
        end
        line += 1    
    end
    return (true)    
end


def solve_sudoku(sudoku)
    line=0
    while(line < sudoku.count)
        column=0
        while(column < sudoku[line].count)
            if (sudoku[line][column] == '_')
                new_value = 1
                while(new_value < 10)
                    sudoku[line][column] = new_value
                    if(check_line(sudoku,line) && check_column(sudoku,column) && check_square(sudoku,line,column))
                        sudoku = solve_sudoku(sudoku.map(&:clone))
                        if (sudoku != false)
                            return (sudoku)
                        end    
                    end
                    new_value += 1    
                end
                return (false)
            end    
            column+=1
        end
        line+=1  
    end        
    return(sudoku)
end


def check_sudoku(sudoku)
    sudoku = solve_sudoku(sudoku)
    if (sudoku == false)
        puts "Error"
    else    
        display_sudoku(sudoku)
    end    
end


check_sudoku(sudoku)
