class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(hash)
        @id = hash[:id]
        @name = hash[:name]
        @type = hash[:type]
        @db = hash[:db]
    end

    def self.save(name, type, db)
        new_poke = Pokemon.new({ :name => name, :type => type, :db => db})
        sql = <<-SQL
            INSERT INTO pokemon ( name, type)
            VALUES( ?, ?)
        SQL
        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL
        data = db.execute(sql, id)[0]
        Pokemon.new({id: data[0], name: data[1], type: data[2], db: db})
    end
end
