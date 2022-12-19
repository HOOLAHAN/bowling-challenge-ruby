# file: lib/bowling_game.rb

class Bowling

  def initialize(io, number_of_rounds)
    @score_card = []
    @io = io
    @number_of_rounds = number_of_rounds
    @final_frame = []
  end

  def run_game
    counter = 0
    @io.puts "\nWelcome to your bowling scorecard"
    while (counter < @number_of_rounds - 1) do
      counter = counter + 1
      @io.puts "----------------------------------------\nRound #{counter}\n--------"
      self.frame
      if counter > 1 && (@score_card[counter - 2].first == 10) && (@score_card[counter - 1].first == 10) # TWO STRIKES IN A ROW
        bonus = @score_card[counter - 1][0] + @score_card[counter - 2][0]
        @score_card[counter - 2].append(bonus)
      elsif counter > 1 && (@score_card[counter - 2].first == 10) && ((@score_card[counter - 1].first != 10) && (@score_card[counter - 1].sum == 10)) # STRIKE FOLLOWED BY SPARE
        bonus = @score_card[counter - 1][0] + @score_card[counter -1][1]
        @score_card[counter - 2].append(bonus)
      elsif counter > 1 && (@score_card[counter - 2].first == 10) # STRIKE IN NORMAL PLAY
        bonus = @score_card[counter - 1][0] + @score_card[counter - 1][1]
        @score_card[counter - 2].append(bonus)
      elsif counter > 1 && (@score_card[counter - 2].sum == 10) && (@score_card[counter - 2].first != 10) # SPARE IN NORMAL PLAY
        bonus = @score_card[counter - 1][0]
        @score_card[counter - 2].append(bonus)
      end
      @io.puts "Running total: #{@score_card.flatten.inject(:+)}"   
    end
    counter = counter + 1
    @io.puts "----------------------------------------\nRound #{counter}\n--------"
    self.final_frame
    if (counter > 1) && (@score_card[-2][0] == 10) # STRIKE IN PENULTIMATE FINAL FRAME
      bonus = @score_card[-1][0] + @score_card[-1][1]
      @score_card[-2].append(bonus)
    elsif (@score_card[0].first != 10) && (@score_card[0].sum == 10) # SPARE IN FIRST FRAME OF SINGLE FRAME GAME
      bonus = @score_card[1][0]
      @score_card[0].append(bonus)
    elsif (counter == @number_of_rounds) && (@score_card[counter - 2][0] != 10) && (@score_card[counter - 2].sum == 10) #SPARE IN PENULTIMATE FRAME
      bonus = @score_card[-1][0]
      @score_card[-2].append(bonus)
    end
    @io.puts "Running total: #{@score_card.flatten.inject(:+)}"   
    self.score_card
  end
  
  def score_card
    @io.puts "----------------------------------------\nHere is your scorecard:"
    round = 0
    @score_card.each do |element|
      round = round + 1
      first_roll = element[0]
      second_roll = element[1]
      bonus = element[2]
      if element.length > 2 # NORMAL FRAMES
        @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}, bonus - #{bonus}, total - #{first_roll + second_roll + bonus}"
      else  # FINAL FRAME
        @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}, bonus - 0, total - #{first_roll + second_roll}"
      end
    end
    @io.puts "FINAL SCORE: #{@score_card.flatten.inject(:+)}"
  end

  def frame
    @frame_score = []
    first_roll_score
    second_roll_score
    @score_card << @frame_score
  end

  def first_roll_score
    while true do
      @io.puts "Please enter first roll score:"
      first_roll = @io.gets.chomp.to_i
      if first_roll == 10
        @io.puts "STRIKE!"
        break
      elsif
        first_roll < 11 && first_roll >=0
        break
      elsif first_roll > 10
        @io.puts "Invalid score: maximum 10 on first roll"
      end
    end
    @frame_score << first_roll
  end
  
  def second_roll_score
    while true do
      if @frame_score.sum == 10
        second_roll = 0
        break
      else
        @io.puts "Please enter second roll score:"
        second_roll = @io.gets.chomp.to_i
        if @frame_score.sum + second_roll == 10
          @io.puts "SPARE!"
          break
        elsif (@frame_score.sum + second_roll) < 11 && second_roll >=0
          break
        elsif (@frame_score.sum + second_roll) > 10
          @io.puts "Invalid score: maximum #{10 - @frame_score.sum} on second roll"
        end
      end
    end
    @frame_score << second_roll
  end

  def final_frame 
    while true do
      @io.puts "Please enter first roll score:"
      first_roll = @io.gets.chomp.to_i
      if first_roll == 10
        @io.puts "STRIKE!"
        @final_frame << first_roll
        final_frame_second_roll
        break
      elsif
        first_roll < 10 && first_roll >=0
        @final_frame << first_roll
        final_frame_second_roll
        break
      elsif first_roll > 10 
        @io.puts "Invalid score: maximum 10 on first roll"
      end  
    end
  end

  def final_frame_second_roll # WHEN A STRIKE IS ROLLED IN FIRST ROLL OF FINAL FRAME
    while true do 
      @io.puts "Please enter second roll score:"
      second_roll = @io.gets.chomp.to_i
      if second_roll == 10 # FINAL FRAME FIRST & SECOND ROLL ARE STRIKES 
        @io.puts "STRIKE!"
        @final_frame << second_roll
        bonus_roll
        break
      elsif (@final_frame[0] == 10) && (second_roll < 10) # FINAL FRAME FIRST ROLL STRIKE 
        @final_frame << second_roll
        bonus_roll
        break
      elsif (second_roll > 10) && (second_roll < 0) # INVALID INPUT
        @io.puts "Invalid score: maximum 10 on first roll"
      elsif (@final_frame[0] != 10) && (second_roll + @final_frame[0] == 10) # SPARE AND BONUS ROLL
        @io.puts "SPARE!"
        @final_frame << second_roll
        bonus_roll
        break
      else second_roll < 10 # FINISH GAME - NO EXTAR ROLL
        @final_frame << second_roll
        break
      end
    end
    @score_card << @final_frame
  end

  def bonus_roll # WHEN SPARE OR STRIKE IN FINAL FRAME
    while true do
      @io.puts "Please enter third roll score:"
      third_roll = @io.gets.chomp.to_i
      if @final_frame[1] + third_roll == 10
        break
      elsif ((@final_frame[1] + third_roll) > 10) && (third_roll < 0) # INVALID INPUT
        @io.puts "Invalid score: maximum #{10 - @frame_score[1]} on second roll"
      else (@final_frame[1] + third_roll) < 10 
        break  
      end
    end
    @final_frame << third_roll
  end

end

# TO RUN: 
# =====================================================================================
Bowling.new(Kernel, 10).run_game