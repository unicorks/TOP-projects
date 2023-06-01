# frozen_string_literal: true

require_relative '../lib/connect4'

describe Game do
    let(:player_1) { double(Player, name: "Saa", symbol: "O") }
    let(:player_2) { double(Player, name: "Da", symbol: "X") }
    subject(:game) { described_class.new(player_1, player_2) }

    
    describe '#initialize' do
        it 'creates instance of connect4 game' do
            expect(game).to be_instance_of(described_class)
        end
    end

    describe '#place_marker' do
        context 'column is empty' do
            it 'places marker at correct position' do
                game.place_marker(1)
                tmp = game.grid
                expect(tmp[0][0]).to eq('O')
            end
        end

        context 'column is partially filled' do
            it 'places marker at the correct position in the next available row' do
                game.place_marker(1)
                game.place_marker(1)
                tmp = game.grid
                expect(tmp[0][0]).to eq('O')
                expect(tmp[0][1]).to eq('O')
            end
        end
    end


    describe '#check_win' do
        let(:win_phrase) { String.new("#{player_1.name} won. Congrats!") }
        # no win, horizontal, vertical, diagonal
        it 'it does not print win phrase on simply placing marker' do
            expect { game.place_marker(3) }.not_to output(win_phrase).to_stdout
        end
        
        it 'works horizontally- prints win phrase if 4 or more of same player in row' do
            game.place_marker(1)
            game.place_marker(2)
            game.place_marker(3)
            game.place_marker(5)
            expect { game.place_marker(4) }.to output(win_phrase).to_stdout
        end

        it 'works vertically- prints win phrase if 4 in a column of same player' do
            game.place_marker(1)
            game.place_marker(1)
            game.place_marker(1)
            expect { game.place_marker(1) }.to output(win_phrase).to_stdout
        end

        # fix this later
        it 'works diagonally' do
            game.switch_turn
            4.downto(2) do |n|
                n.times { game.place_marker(n)}
            end
            game.switch_turn
            4.downto(2) do |n|
                game.place_marker(n)
            end
            expect { game.place_marker(1) }.to output(win_phrase).to_stdout
        end

        it 'works antidiagonally' do
            # todo
        end
    end
end