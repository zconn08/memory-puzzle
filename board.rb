class Board
  attr_reader :grid

  def initialize(row = 3, col = 4)
    @grid = []
    populate_grid(row, col)
  end

  def populate_grid (row, col)
    row.times do
      @grid << Array.new(col)
    end
    cards = ("A".."Z").to_a[0...(row*col / 2)] * 2
    cards.shuffle!
    row.times do |x|
      col.times do |y|
        @grid[x][y] = Card.new(cards.pop, :face_down)
      end
    end

    @grid
  end

  def render
    @grid.each { |line| p line.join }
  end

  def reveal(coor)
    @grid[coor[0]][coor[1]].reveal
  end

  def hide(coor)
    @grid[coor[0]][coor[1]].hide
  end

  def won?
    @grid.flatten.none? {|card| card.face_down?}
  end

  def valid_move?(coor)
    return false if @grid[coor[0]].nil?
    return false if @grid[coor[0]][coor[1]].nil?
    @grid[coor[0]][coor[1]].face_down?
  end

end
