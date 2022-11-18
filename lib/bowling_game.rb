# file: lib/bowling_game.rb

class Bowling

  def initialize(io, number_of_rounds)
    @score_card = []
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
      @io.puts "Running total: #{@score_card.flatten.inject(:+)}"
    end
    self.score_card
  end

  def bonus?
    if @frame_score.include? "spare"
      bonus = @frame_score.first
      @frame_score.push(bonus)
    else
      return @frame_score
    end
  end  

  def score_card
    @io.puts "Here is your scorecard:"
    round = 0
    @score_card.each do |element|
      round = round + 1
      first_roll = element[-2]
      second_roll = element[-1]
      @io.puts "Round #{round}: first - #{first_roll}, second - #{second_roll}, total - #{first_roll + second_roll}"
    end
    @io.puts "FINAL SCORE: #{@score_card.flatten.inject(:+)}"
  end



  def frame
    @frame_score = []
    first_roll_score
    second_roll_score
    # binding.irb
    @score_card << @frame_score
    # @io.puts "Frame score: #{@score_card.last.sum}"
  end


  def first_roll_score
    # first roll
    while true do
      @io.puts "Please enter first roll score:"
      first_roll = @io.gets.chomp.to_i
      if first_roll == 10
        @io.puts "STRIKE!"
        # @frame_score << first_roll
        break
      elsif
        first_roll < 11 && first_roll >=0
        # @frame_score << first_roll
        break
      elsif first_roll > 10
        @io.puts "Invalid score: maximum 10 on first roll"
      end
    end
    @frame_score << first_roll
  end
  
  def second_roll_score
    # second roll
    while true do
      if @frame_score.sum == 10
        second_roll = 0
        break
      else
        @io.puts "Please enter second roll score:"
        second_roll = @io.gets.chomp.to_i
        if @frame_score.sum + second_roll == 10
          @io.puts "SPARE!"
          @frame_score << "spare"
          break
        elsif (@frame_score.sum + second_roll) < 11 && second_roll >=0
          # @frame_score << second_roll
          break
        elsif (@frame_score.sum + second_roll) > 10
          @io.puts "Invalid score: maximum #{10 - @frame_score.sum} on second roll"
        end
      end
    end
    
    @frame_score << second_roll
    # @io.puts "Frame score: #{@frame_score.sum}"
  end

end

# Bowling.new(Kernel, 3).run_game