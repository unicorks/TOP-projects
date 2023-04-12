# frozen_string_literal: true

require_relative '../tictactoe'

describe Board do
    let(:player_1) { double(Player, name: "Saa", symbol: "O") }
    let(:player_2) { double(Player, name: "Da", symbol: "X") }
    subject(:game) { described_class.new(player_1, player_2) }

    # describe start_game, game_over?, place_marker
    describe "#start_game" do
        before do
            allow(game).to receive(:print)
            allow(game).to receive(:puts)
            allow(game).to receive(:place_marker).and_return "ok"
            allow(game).to receive(:game_over?).and_return false
        end

        it 'changes turn' do
            expect{ game.start_game }.to change { game.turn }.to(player_2)
        end
    end
end