require 'game_state'

describe GameState do
  it 'can be instantiated with a 2d array' do
    GameState.new([
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0]
    ])
  end

  context 'rules' do
    context 'live cell' do
      it 'with no neighbours dies' do
        state = GameState.new([
          [0, 0, 0],
          [0, 0, 1],
          [0, 0, 0]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(0)
      end

      it 'with one neighbour dies' do
        state = GameState.new([
          [0, 0, 0],
          [0, 1, 1],
          [0, 0, 0]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(0)
      end

      it 'with two neighbours lives' do
        state = GameState.new([
          [0, 0, 0],
          [0, 1, 1],
          [0, 0, 1]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(1)
      end

      it 'with three neighbours lives' do
        state = GameState.new([
          [0, 0, 1],
          [0, 1, 1],
          [0, 0, 1]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(1)
      end

      it 'with more than three neighbours dies' do
        state = GameState.new([
          [0, 1, 1],
          [0, 1, 1],
          [0, 0, 1]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(0)
      end
    end

    context 'dead cell' do
      it 'dead cell with two neighbours is still dead' do
        state = GameState.new([
          [0, 0, 1],
          [0, 0, 0],
          [0, 0, 1]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(0)
      end

      it 'dead cell with three neighbours comes alive' do
        state = GameState.new([
          [0, 0, 1],
          [0, 1, 0],
          [0, 0, 1]
        ])
        next_state = state.advance
        expect(next_state[1][2]).to eq(1)
      end
    end
  end
end
