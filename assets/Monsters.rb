require 'sqlite3'

class Monsters
  attr_reader :db, :table, :ranges

  def initialize()
    @db     = "monsters.db"
    @table  = "monsters"
    @ranges = set_ranges()
  end

  def included?(level, theme, local)
    begin
      db = SQLite3::Database.open @db
      db.results_as_hash = true
      stm = db.prepare "SELECT COUNT(name) as c FROM #{@table} WHERE #{@table}.xp BETWEEN #{@ranges[level][0]} AND #{@ranges[level][1]} AND #{@table}.#{theme} AND #{@table}.#{local}_locale"
      r = stm.execute
      res = r.to_a[0]["c"].to_i
      return (res > 0 ? true : false)
    rescue SQLite3::Exception => e
      abort e
    ensure
      stm.close if stm
      db.close if db
    end
  end # included?()

  private

  def set_ranges()
    return [
      [0, 0],
      [25, 100],
      [50, 200],
      [75, 400],
      [125, 500],
      [250, 1100],
      [300, 1400],
      [350, 1700],
      [450, 2100],
      [550, 2400],
      [600, 2800],
      [800, 3600],
      [1000, 4500],
      [1100, 5100],
      [1250, 5700],
      [1400, 6400],
      [1600, 7200],
      [2000, 8800],
      [2100, 9500],
      [2400, 10900],
      [2800, 12700]
    ]
  end # set_ranges()

end
