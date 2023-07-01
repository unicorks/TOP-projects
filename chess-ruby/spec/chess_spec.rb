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

    describe Pawn do
        context 'when pawn is white' do
            subject(:white_pawn) { board[1][0] }
            it 'gives appropriate valid moves in the right direction' do
                expect(white_pawn.valid_moves()).to eq [[2, 0], [3, 0]]
            end

            it 'shows sidewards capture move when valid' do
                expect(white_pawn.valid_moves([5, 0])).to eq [[6, 1]]
            end
        end

        context 'when pawn is black' do
            subject(:black_pawn) { board[6][7] }
            it 'gives appropriate valid moves in the right direction' do
                expect(black_pawn.valid_moves).to eq [[5, 7], [4, 7]]
            end

            it 'shows sidewards capture move when valid' do
                expect(black_pawn.valid_moves([2, 7])).to eq [[1, 6]]
            end
        end
    end

    describe Bishop do
        subject(:bishop) { board[0][2] }
        it 'has no valid moves at initial position' do
            expect(bishop.valid_moves).to eq []
        end

        it 'can move appropriately' do
            expect(bishop.valid_moves([2, 3])).to eq [[3, 4], [4, 5], [5, 6], [6, 7], [3, 2], [4, 1], [5, 0]]
        end
    end

    describe Rook do
        subject(:rook) { board[7][0] }
        it 'has no valid moves at initial position' do
            expect(rook.valid_moves).to eq []
        end

        it 'can move appropriately' do
            expect(rook.valid_moves([3, 3])).to eq [[4, 3], [5, 3], [2, 3], [1, 3], [3, 2], [3, 1], [3, 0], [3, 4], [3, 5], [3, 6], [3, 7]]
        end
    end

    describe Queen do
        subject(:queen) { board[0][3] }
        it 'has no valid moves at initial pos' do
            expect(queen.valid_moves).to eq []
        end

        it 'shows appropriate no of moves elsewhere' do
            expect(queen.valid_moves([3, 3])).to eq [[4, 3], [5, 3], [6, 3], [2, 3], [3, 2], [3, 1], [3, 0], [3, 4], [3, 5], [3, 6], [3, 7], [4, 4], [5, 5], [6, 6], [2, 2], [4, 2], [5, 1], [6, 0], [2, 4]]
        end
    end

    describe King do
        subject(:king) { board[0][4] }
        it 'has no valid moves at initial pos' do
            expect(king.valid_moves).to eq []
        end

        it 'shows appropriate no of moves elsewhere' do
            expect(king.valid_moves([4, 3])).to eq [[4, 4], [3, 4], [3, 3], [3, 2], [4, 2]]
        end
    end
end


describe Game do
    let(:player_1) { double(Player, name: "Saa", color: "white") }
    let(:player_2) { double(Player, name: "Da", color: "black") }
    subject(:game) {described_class.new(player_1, player_2)}

    describe '#move_placed' do
        it 'returns false if someone tries to access a piece/square that is not their own' do
            expect(game.move_placed('e5b2')).to be false
            expect(game.move_placed('h8b2')).to be false
        end

        it 'returns false if someone is attempting an invalid move' do
            expect(game.move_placed('i1c9')).to be false
            expect(game.move_placed('a2a5')).to be false
        end

        it 'returns false if desired move puts king in danger' do
            # todo
        end

        it 'places the move if it is valid and returns true' do
            expect(game.move_placed('b2b4')).to be true
        end
    end
end