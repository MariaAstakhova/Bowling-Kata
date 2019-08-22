
class Bowling

    def initialize(hash_points)
        @frames = hash_points
        @score = 0
    end

    
    def strike?(frame)
        frame[0] == 10
    end

    def spare?(frame)
        frame[0] + frame[1] == 10 && frame[0] != 10
    end

    def last_frame?(frame)
        frame.length > 2
    end

    def score_from_points
        @frames.each do |frame_key,rolls_value|
            if (strike?(rolls_value) || spare?(rolls_value)) && frame_key < 10
                @score += @frames[frame_key+1][0]

                if strike?(rolls_value)
                    if (strike?(@frames[frame_key+1]))
                        @score += @frames[frame_key+2][0]
                    else
                        @score += @frames[frame_key+1][1]
                    end
                end
                  elsif last_frame?(rolls_value)
                    if strike?(rolls_value)
                        @score += (rolls_value[1] + rolls_value[2])
                    else
                        @score += (rolls_value[2])
                    end        
            end
            @score += rolls_value.sum
        end
        @score
    end

end


describe "Bowling" do

    it "tests game score is 0" do
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(0)
    end

    it "tests game score is 1" do
        hash_points = { 1 => [1,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(1)
    end

    it "returns final score" do
        hash_points = { 1 => [1,1],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(2)
    end

    it "returns final score when multiple frames have points" do 
        hash_points = { 1 => [1,1],
                        2 => [1,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(3)    
    end

    it "returns score when there is a spare" do 
        hash_points = { 1 => [9,1],
                        2 => [1,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(12)
    end

    it "returns score when there is a spare and multiple points" do 
        hash_points = { 1 => [9,1], 
                        2 => [3,1], 
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(17)
    end

    it "returns score when there are multiple spares and multiple points" do 
        hash_points = { 1 => [9,1],
                        2 => [3,1],
                        3 => [0,0],
                        4 => [9,1],
                        5 => [3,1],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(34)
    end
    
    it "returns score when there are 2 spares and multiple points" do 
        hash_points = { 1 => [9,1],
                        2 => [2,8], 
                        3 => [0,1], 
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(23)
    end

    it "returns score when there is a spare in last frame" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [5,5,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(10)
    end

    it "returns score when there is a spare in last frame and points in extra roll" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [5,5,7] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(24)
    end

    it "returns score when there is a spare in last frame and points in extra roll" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [5,5,8] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(26)
    end

    it "returns score when there is a strike" do 
        hash_points = { 1 => [0,0],
                        2 => [10], #17
                        3 => [3,4], #7
                        4 => [5,1], #6
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(30)
    end

    it "returns score when there is a strike in the second last frame" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [10],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(10)
    end

    it "returns score when there is a strike in the third to last frame" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [10],
                        9 => [3,0],
                       10 => [3,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(19)
    end

    it "returns score when there is a strike in the last frame" do 
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0, 0],
                       10 => [10, 5, 5] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(30)
    end

    it "returns score when spare with 10 in second roll" do
        hash_points = { 1 => [0,10],
                        2 => [1,5],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,0] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(17)
    end

    it "returns score when spare with 10 in second roll in last frame" do
        hash_points = { 1 => [0,0],
                        2 => [0,0],
                        3 => [0,0],
                        4 => [0,0],
                        5 => [0,0],
                        6 => [0,0],
                        7 => [0,0],
                        8 => [0,0],
                        9 => [0,0],
                       10 => [0,10,4] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(18)
    end

    xit "returns score when strike in every frame" do 
        hash_points = { 1 => [10],
                        2 => [10],
                        3 => [10],
                        4 => [10],
                        5 => [10],
                        6 => [10],
                        7 => [10],
                        8 => [10],
                        9 => [10],
                       10 => [10, 10, 10] }
        game = Bowling.new(hash_points)
        expect(game.score_from_points).to eq(300)
    end

end