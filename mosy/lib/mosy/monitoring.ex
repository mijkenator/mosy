defmodule Mosy.Monitoring do
    use Ecto.Schema
    require Logger
    import Ecto.Changeset
    import Ecto.Query

    schema "monitoring" do
        field  :host, :string
        field  :process, :string
        field  :cpu, :float
        field  :memory, :float
        field  :ioread, :integer
        field  :iowrite, :integer
        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:id, :host, :process, :cpu, :memory, :ioread, :iowrite])
        |> validate_required([:host, :process, :cpu, :memory, :ioread, :iowrite])

    end

    def get_latest() do
        query = Ecto.Query.from u in Mosy.Monitoring, select: u, 
            distinct: [desc: u.host, desc: u.process], 
            order_by: [desc: u.id]
        Mosy.Repo.all(query)
    end

    def get_os_level(%{"start" => startd, "end" => endd, "host" => host} = params) do
        query = Ecto.Query.from u in Mosy.Monitoring, select: u, 
            where: u.inserted_at >= ^startd and u.inserted_at <= ^endd and u.host == ^host,
            order_by: [desc: u.id]
        Mosy.Repo.all(query)
    end

    def get_proc_level(%{"start" => startd, "end" => endd, "host" => host, "process" => proc} = params) do
        query = Ecto.Query.from u in Mosy.Monitoring, select: u, 
            where: u.inserted_at >= ^startd and u.inserted_at <= ^endd and u.host == ^host and u.process == ^proc,
            order_by: [desc: u.id]
        Mosy.Repo.all(query)
    end
end
