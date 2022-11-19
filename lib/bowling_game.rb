# file: lib/bowling_game.rb

class Bowling

  def initialize(io, number_of_rounds)
    @score_card = []
    @bonus_array = []
    @io = io
    @number_of_rounds = number_of_rounds
  end

  def run_game
    counter = 0
    @io.puts "Welcome to your bowling scorecard"
    while counter < @number_of_rounds do
      counter = counter + 1
      @io.puts "Round #{counter}"
      self.frame
      if counter == @number_of_rounds && (@score_card[counter - 1].first == 10)
        @io.puts "BONUS ROUND!"
        self.frame
        bonus = @score_card[counter][0] + @score_card[counter][1]
        @score_card[counter].append(bonus)
      elsif (counter == @number_of_rounds) && (@score_card[counter - 1].first != 10) && (@score_card[counter - 1].sum == 10)
        @io.puts "BONUS ROUND!"
        self.bonus_roll_spare
        bonus = @score_card[counter][0]
        @score_card[counter].append(bonus)
      elsif counter > 1 && (@score_card[counter - 2].first == 10)
        bonus = @score_card[counter - 1][0] + @score_card[counter - 1][1]
        @score_card[counter - 1].append(bonus)
      elsif counter > 1 && (@score_card[counter - 2].sum == 10)
        bonus = @score_card[counter - 1][0]
        @score_card[counter - 1].append(bonus)
      end
      @io.puts "Running total: #{@score_card.flatten.inject(:+)}"
      end   
    self.score_card
  end

  def score_card
    @io.puts "Here is your scorecard:"
    round = 0
    @score_card.each do |element|
      round = round + 1
      first_roll = element[0]
      second_roll = element[1]
      bonus = element[2]
      if round == (@number_of_rounds + 1)
        round = 'bonus!'
        # binding.irb
        @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}, bonus - #{bonus}, total - #{first_roll + second_roll + bonus}"
      elsif element.length > 2
        @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}, bonus - #{bonus}, total - #{first_roll + second_roll + bonus}"
      else
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
    # @io.puts "Frame score: #{@score_card.last.sum}"
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
    # @io.puts "Frame score: #{@frame_score.sum}"
  end

  def bonus_roll_spare
    @bonus_frame_score = []
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
    @bonus_frame_score << first_roll
    second_roll = 0
    @bonus_frame_score << second_roll
    @score_card << @bonus_frame_score
  end

end

# Bowling.new(Kernel, 2).run_game