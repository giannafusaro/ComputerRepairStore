class CreateArchiverForRepairs < ActiveRecord::Migration

  def up
    execute <<-SQL
      CREATE TABLE archiver (
        id INT(11),
        customer_id INT(11),
        employee_id INT(11),
        computer_id INT(11),
        description text,
        labor_cost DECIMAL(8,2),
        total_cost DECIMAL(8,2),
        created_at DATETIME,
        updated_at DATETIME,
        requested_for DATETIME,
        completed_at DATETIME,
        PRIMARY KEY(ID)
      );
    SQL

    execute <<-SQL
      CREATE PROCEDURE archiveRepairs (IN cutOffDate DATETIME)
      BEGIN
        START TRANSACTION;
          -- DECLARE EXIT HANDLER FOR SQLEXCEPTION SQLWARNING
          -- BEGIN
          --   ROLLBACK;
          -- END;
          INSERT INTO archiver (SELECT * FROM repairs WHERE updated_at < cutOffDate);
          DELETE FROM repairs WHERE updated_at < cutOffDate;
        COMMIT;
      END
    SQL
  end

  def down
    execute "DROP TABLE IF EXISTS archiver;"
    execute "DROP PROCEDURE IF EXISTS archiveRepairs;"
  end

end
