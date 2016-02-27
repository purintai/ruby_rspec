require 'rspec'

describe 'GridPoint' do
  before do
    @gp = GridPoint.new(1, 1)
  end

  it '生成した格子点からx座標が取得できる' do
    expect(@gp.pos_x).to eq 1
  end

  it '生成した格子点からy座標が取得できる' do
    expect(@gp.pos_y).to eq 1
  end

  it '生成した格子点から文字列表記が取得できる' do
    expect(@gp.to_s).to eq '(1, 1)'
  end

  describe '2つの格子点が同じ座標を持つか' do
    before do
      @gp = GridPoint.new(1, 1)
    end

    it '同じ座標点を持つ場合' do
      expect(@gp.at_same_point?(GridPoint.new(1, 1))).to be true
    end

    it '同じ座標点を持たない場合' do
      expect(@gp.at_same_point?(GridPoint.new(1, 2))).to be false
    end
  end

  describe '隣り合った格子点を判定' do
    before do
      @gp = GridPoint.new(1, 1)
    end

    it '同じ座標点を持つ場合' do
      expect(@gp.is_neighbor?(GridPoint.new(1, 1))).to be false
    end

    it '(x-1,y)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(0, 1))).to be true
    end

    it '(x+1,y)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(2, 1))).to be true
    end

    it '(x,y-1)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(1, 0))).to be true
    end

    it '(x,y+1)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(1, 2))).to be true
    end

    it '(x+1,y+1)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(2, 2))).to be false
    end

    it '(x+2,y)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(3, 1))).to be false
    end

    it '(x+2,y-1)の場合' do
      expect(@gp.is_neighbor?(GridPoint.new(3, 0))).to be false
    end
  end
end
