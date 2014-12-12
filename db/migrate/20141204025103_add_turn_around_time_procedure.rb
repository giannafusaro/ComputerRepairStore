class AddTurnAroundTimeProcedure < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE PROCEDURE avg_TurnAroundTime
      (OUT average FLOAT(4))
      BEGIN
        DECLARE sum FLOAT(4) DEFAULT 0;
        DECLARE total_count FLOAT(4) DEFAULT 0;

        CREATE TEMPORARY TABLE IF NOT EXISTS differences (
          delta FLOAT(4) NOT NULL
        );

        INSERT INTO differences (delta)
        SELECT DATEDIFF(completed_at, requested_for)
        FROM repairs
        WHERE completed_at AND requested_for IS NOT NULL;

        SELECT avg(delta) INTO average
        FROM differences;
      END
    SQL
  end

  def down
    execute <<-SQL
      DROP PROCEDURE IF EXISTS avg_TurnAroundTime;
    SQL
  end
end
