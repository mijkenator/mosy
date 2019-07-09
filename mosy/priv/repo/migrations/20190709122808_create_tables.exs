defmodule Mosy.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table (:monitoring) do
        add :host,    :string, size: 50
        add :process, :string, size: 50
        add :cpu, :float
        add :memory, :float
        add :ioread, :integer
        add :iowrite, :integer
        timestamps()
    end

    create index(:monitoring, [:host, :process])
    create index(:monitoring, [:inserted_at])

  end
end
