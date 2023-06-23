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

describe Knight do
    subject(:knight) { described_class.new('white') }

    describe '#valid_moves' do
        it 'gives all valid 8 moves' do
            # todo
        end

        it 'gives appropriate number of moves when some moves go out of board' do
            # todo
        end

        it 'does not quash pieces of the same color' do
            # todo
        end
    end
end