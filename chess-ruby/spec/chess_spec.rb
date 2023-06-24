# frozen_string_literal: true

require_relative '../lib/chess_game'

describe Board do
    subject(:board) { described_class.new() }

    describe '#initialize' do
        it 'creates instance of chess board' do
            expect(board).to be_instance_of(described_class)
        end
    end

    describe '#algebraic_to_coords' do
        it 'correctly translates algebraic chess notation to coordinates' do
            expect(board.algebraic_to_coords('a1')).to eq([0, 0])
        end
    end
end

context 'test em pieces' do
    let(:board_) { Board.new }
    let(:board) { board_.board }

    describe Knight do
        subject(:knight) { board[0][1] }

        describe '#valid_moves' do
            it 'gives all valid 8 moves' do
                expect(knight.valid_moves([4, 3])).to eq([[6, 2], [6, 4], [2, 4], [2, 2], [5, 5], [5, 1], [3, 5], [3, 1]])
            end

            it 'does not quash pieces of the same color' do
                expect(knight.valid_moves).to eq([[2, 0], [2, 2]])
            end
        end
    end
end