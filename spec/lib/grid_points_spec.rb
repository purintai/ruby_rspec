require 'rspec'

describe 'GridPoints' do
  before do
    @gp_1_1 = GridPoint.new(1, 1)
    @gp_1_2 = GridPoint.new(1, 2)
    @gp_2_1 = GridPoint.new(2, 1)
    @gp_2_2 = GridPoint.new(2, 2)
    @gp_3_1 = GridPoint.new(3, 1)
    @gp_3_2 = GridPoint.new(3, 2)
    @gp_4_1 = GridPoint.new(4, 1)
    @gp_5_1 = GridPoint.new(5, 1)
    @gps = GridPoints.new(@gp_1_1, @gp_2_2, @gp_1_2)
  end

  context '格子点集合が、指定した格子点を含むかどうかを判定' do
    it '格子点集合が、指定した格子点を含む場合はtrueを返す' do
      expect(@gps.include?(@gp_2_2)).to be true
    end

    it '格子点集合が、指定した格子点を含まない場合はfalseを返す' do
      expect(@gps.include?(@gp_3_2)).to be false
    end
  end

  context '格子点集合の含む格子点の数' do
    it '格子点の数が2つの場合は2を返す' do
      expect(GridPoints.new(@gp_1_1, @gp_2_2).count).to eq 2
    end

    it '格子点の数が3つの場合は3を返す' do
      expect(GridPoints.new(@gp_1_1, @gp_2_2, @gp_1_2).count).to eq 3
    end

    it '格子点の数が4つの場合は4を返す' do
      expect(GridPoints.new(@gp_1_1, @gp_2_2, @gp_1_2, @gp_3_2).count).to eq 4
    end

  end

  context '格子点集合が連結している(connected)かを判定' do
    context '格子点集合が2点の場合' do
      it '格子点集合が、連結している場合はtrueを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_1)).connected?).to be true
      end

      it '格子点集合が、連結していない場合はfalseを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_2)).connected?).to be false
      end
    end

    context '格子点集合が3点の場合' do
      it '格子点集合が、連結している場合[(1,1),(2,1),(3,1)]はtrueを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_1, @gp_3_1)).connected?).to be true
      end

      it '格子点集合が、連結している場合[(1,1),(2,2),(2,1)]はtrueを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_2, @gp_2_1)).connected?).to be true
      end

      it '格子点集合が、連結していない場合[(1,1),(1,1),(3,1)]はfalseを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_1_1, @gp_3_1)).connected?).to be false
      end

      it '格子点集合が、連結していない場合[(1,1),(1,2),(3,1)]はfalseを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_1_2, @gp_3_1)).connected?).to be false
      end

      it '格子点集合が、連結していない場合[(1,1),(3,1),(1,2)]はfalseを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_3_1, @gp_1_2)).connected?).to be false
      end
    end

    context '格子点集合が4点の場合' do
      it '格子点集合が、連結している場合[(1,1),(2,1),(3,1),(4,1)]はtrueを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_1, @gp_3_1, @gp_4_1)).connected?).to be true
      end

      it '格子点集合が、連結している場合[(1,1),(2,1),(3,1),(5,1)]はfalseを返す' do
        expect((GridPoints.new(@gp_1_1, @gp_2_1, @gp_3_1, @gp_5_1)).connected?).to be false
      end

      it '格子点集合が、連結している場合[(3,1),(1,1),(2,1),(4,1)]はtrueを返す' do
        expect((GridPoints.new(@gp_3_1, @gp_1_1, @gp_2_1, @gp_4_1)).connected?).to be true
      end
    end
  end
end

