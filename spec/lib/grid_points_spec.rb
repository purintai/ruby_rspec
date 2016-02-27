require 'rspec'

describe 'GridPoints' do
  context '2次元座標の場合' do
    before do
      @gp_1_0 = GridPoint.new(1, 0)
      @gp_1_1 = GridPoint.new(1, 1)
      @gp_1_2 = GridPoint.new(1, 2)
      @gp_2_0 = GridPoint.new(2, 0)
      @gp_2_1 = GridPoint.new(2, 1)
      @gp_2_2 = GridPoint.new(2, 2)
      @gp_3_0 = GridPoint.new(3, 0)
      @gp_3_1 = GridPoint.new(3, 1)
      @gp_3_2 = GridPoint.new(3, 2)
      @gp_4_1 = GridPoint.new(4, 1)
      @gp_5_1 = GridPoint.new(5, 1)


      @gp_4_4 = GridPoint.new(4, 4)
      @gp_4_5 = GridPoint.new(4, 5)
      @gp_5_4 = GridPoint.new(5, 4)
      @gp_5_5 = GridPoint.new(5, 5)
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

      it '格子点の数が9つの場合は9を返す' do
        expect((GridPoints.new(@gp_1_0, @gp_2_0, @gp_3_0,
                               @gp_1_1, @gp_2_1, @gp_3_1,
                               @gp_1_2, @gp_2_2, @gp_3_2)).count).to eq 9
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

        it '格子点集合が、連結している場合[(3,1),(1,1),(2,1),(4,1)]はtrueを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_1_2, @gp_2_1, @gp_2_2,
                                 @gp_4_4, @gp_4_5, @gp_5_4, @gp_5_5)).connected?).to be false
        end
      end
    end

    context '格子点集合が一筆書きできるか(traversable)を判定' do
      context '一筆書きができる場合' do
        it '格子点集合が、一筆書きできる場合はtrueを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_2_1)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできる場合はtrueを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_2_2, @gp_2_1)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできない場合はtrueを返す' do # □
          expect((GridPoints.new(@gp_1_1, @gp_2_1, @gp_2_0, @gp_1_0)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできない場合はtrueを返す' do # □
          expect((GridPoints.new(@gp_1_0, @gp_2_0, @gp_3_0,
                                 @gp_1_1, @gp_2_1, @gp_3_1,
                                 @gp_1_2, @gp_2_2, @gp_3_2)).traversable?).to be true
        end
      end

      context '一筆書きができない場合' do
        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_2_2)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_2_2, @gp_3_1)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_2_2, @gp_3_1, @gp_2_0)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do # ┬
          expect((GridPoints.new(@gp_1_1, @gp_2_1, @gp_3_1, @gp_2_0)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1, @gp_1_2, @gp_2_1, @gp_2_2,
                                 @gp_4_4, @gp_4_5, @gp_5_4, @gp_5_5)).traversable?).to be false
        end
      end
    end
  end

  context '3次元座標の場合' do
    before do
      @gp_1_1_1 = GridPoint.new(1, 1, 1)
      @gp_1_1_2 = GridPoint.new(1, 1, 2)
      @gp_1_1_3 = GridPoint.new(1, 1, 3)
      @gp_1_2_1 = GridPoint.new(1, 2, 1)
      @gp_1_2_2 = GridPoint.new(1, 2, 2)
      @gp_1_2_3 = GridPoint.new(1, 2, 3)
      @gp_1_3_1 = GridPoint.new(1, 3, 1)
      @gp_1_3_2 = GridPoint.new(1, 3, 2)
      @gp_1_3_3 = GridPoint.new(1, 3, 3)
      @gp_2_1_1 = GridPoint.new(2, 1, 1)
      @gp_2_1_2 = GridPoint.new(2, 1, 2)
      @gp_2_1_3 = GridPoint.new(2, 1, 3)
      @gp_2_2_1 = GridPoint.new(2, 2, 1)
      @gp_2_2_2 = GridPoint.new(2, 2, 2)
      @gp_2_2_3 = GridPoint.new(2, 2, 3)
      @gp_2_3_1 = GridPoint.new(2, 3, 1)
      @gp_2_3_2 = GridPoint.new(2, 3, 2)
      @gp_2_3_3 = GridPoint.new(2, 3, 3)
      @gp_3_1_1 = GridPoint.new(3, 1, 1)
      @gp_3_1_2 = GridPoint.new(3, 1, 2)
      @gp_3_1_3 = GridPoint.new(3, 1, 3)
      @gp_3_2_1 = GridPoint.new(3, 2, 1)
      @gp_3_2_2 = GridPoint.new(3, 2, 2)
      @gp_3_2_3 = GridPoint.new(3, 2, 3)
      @gp_3_3_1 = GridPoint.new(3, 3, 1)
      @gp_3_3_2 = GridPoint.new(3, 3, 2)
      @gp_3_3_3 = GridPoint.new(3, 3, 3)
      @gps = GridPoints.new(@gp_1_1_1, @gp_2_2_2, @gp_3_3_3)
    end

    context '格子点集合が、指定した格子点を含むかどうかを判定' do
      it '格子点集合が、指定した格子点を含む場合はtrueを返す' do
        expect(@gps.include?(@gp_2_2_2)).to be true
      end

      it '格子点集合が、指定した格子点を含まない場合はfalseを返す' do
        expect(@gps.include?(@gp_3_2_3)).to be false
      end
    end

    context '格子点集合の含む格子点の数' do
      it '格子点の数が2つの場合は2を返す' do
        expect(GridPoints.new(@gp_1_1_1, @gp_2_2_2).count).to eq 2
      end

      it '格子点の数が3つの場合は3を返す' do
        expect(GridPoints.new(@gp_1_1_1, @gp_2_2_2, @gp_1_2_2).count).to eq 3
      end

      it '格子点の数が9つの場合は9を返す' do
        expect((GridPoints.new(@gp_1_1_1, @gp_1_2_1, @gp_1_3_1,
                               @gp_1_1_2, @gp_1_2_2, @gp_1_3_2,
                               @gp_1_1_3, @gp_1_2_3, @gp_1_3_3)).count).to eq 9
      end
    end

    context '格子点集合が連結している(connected)かを判定' do
      context '格子点集合が2点の場合' do
        it '格子点集合が、連結している場合はtrueを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_1_1)).connected?).to be true
        end

        it '格子点集合が、連結していない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_1_2_2)).connected?).to be false
        end
      end

      context '格子点集合が3点の場合' do
        it '格子点集合が、連結している場合[(1,1),(2,1),(3,1)]はtrueを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_1_2_1, @gp_1_2_2)).connected?).to be true
        end

        it '格子点集合が、連結している場合[(1,1),(2,2),(2,1)]はtrueを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_1_2_2, @gp_1_2_1)).connected?).to be true
        end

        it '格子点集合が、連結していない場合[(1,1),(1,1),(3,1)]はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_1_1_1, @gp_1_3_1)).connected?).to be false
        end

        it '格子点集合が、連結していない場合[(1,1),(1,2),(3,1)]はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_1_2_1, @gp_3_1_1)).connected?).to be false
        end

        it '格子点集合が、連結していない場合[(1,1),(3,1),(1,2)]はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_3_1_1, @gp_1_2_1)).connected?).to be false
        end
      end

      context '格子点集合が4点の場合' do
        it '格子点集合が、連結している場合[(1,1),(2,1),(3,1),(4,1)]はtrueを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_1_1, @gp_3_1_1, @gp_3_2_1)).connected?).to be true
        end

        it '格子点集合が、連結している場合[(1,1),(2,1),(3,1),(5,1)]はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_1_1, @gp_3_1_1, @gp_1_3_3)).connected?).to be false
        end

        it '格子点集合が、連結している場合[(3,1),(1,1),(2,1),(4,1)]はtrueを返す' do
          expect((GridPoints.new(@gp_3_1_1, @gp_1_1_1, @gp_2_1_1, @gp_1_1_2)).connected?).to be true
        end
      end
    end

    context '格子点集合が一筆書きできるか(traversable)を判定' do
      context '一筆書きができる場合' do
        it '格子点集合が、一筆書きできる場合はtrueを返す' do
          expect((GridPoints.new(@gp_2_1_2, @gp_2_2_2, @gp_2_2_1, @gp_2_1_1)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできる場合はtrueを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_1_1, @gp_2_2_1, @gp_1_2_1)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできる場合はtrueを返す' do
          expect((GridPoints.new(@gp_2_1_3, @gp_2_1_1, @gp_2_2_1, @gp_2_1_2)).traversable?).to be true
        end

        it '格子点集合が、一筆書きできる場合はtrueを返す' do #
          expect((GridPoints.new(@gp_1_1_1, @gp_2_2_1, @gp_2_1_2,
                                 @gp_1_2_1, @gp_1_2_2, @gp_2_2_2,
                                 @gp_2_1_1)).traversable?).to be true
        end
      end

      context '一筆書きができない場合' do
        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_2_1)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_2_2, @gp_2_1_1)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_2_2, @gp_3_1_1, @gp_2_2_1)).traversable?).to be false
        end

        it '格子点集合が、一筆書きできない場合はfalseを返す' do
          expect((GridPoints.new(@gp_1_1_1, @gp_2_1_2, @gp_3_1_3, @gp_2_2_1)).traversable?).to be false
        end
      end
    end
  end
end

