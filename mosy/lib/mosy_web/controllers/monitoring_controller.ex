defmodule MosyWeb.MonitoringController do
    use MosyWeb, :controller
    alias Mosy.Monitoring


    def latest(conn, params) do
        body = %{data: Enum.map(Monitoring.get_latest(), &to_jsn/1)}
        conn
        |> put_status(200)
        |> json(body)
    end

    def oslevel(conn, params) do
        body = %{data: Enum.map(Monitoring.get_os_level(params), &to_jsn/1)}
        conn
        |> put_status(200)
        |> json(body)
    end

    def proclevel(conn, params) do
        body = %{data: Enum.map(Monitoring.get_proc_level(params), &to_jsn/1)}
        conn
        |> put_status(200)
        |> json(body)
    end

    defp to_jsn(data) do
        %{
            host: data.host,
            process: data.process,
            cpu: data.cpu,
            memory: data.memory,
            ioread: data.ioread,
            iowrite: data.iowrite
        }
    end

end
