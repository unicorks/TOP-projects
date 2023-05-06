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
            # todo
        end
        context 'column is partially filled' do 
            # todo
        end
    end

    describe '#check_win' do
        # horizontal, vertical, diagonal and no win
    end
end