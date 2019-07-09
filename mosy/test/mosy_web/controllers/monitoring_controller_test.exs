defmodule MosyWeb.MonitoringControllerTest do
    use MosyWeb.ConnCase
    alias Mosy.Monitoring

    
    test "monitoring controller get latest" do
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})

        conn = build_conn()
        conn = get conn, monitoring_path(conn, :latest)
        %{"data" => ret}  = json_response(conn, 200) 
        IO.puts("json resp: #{inspect(ret)}")
        assert 3 == length(ret)
    end

    test "monitoring controller get os level" do
        d1 = NaiveDateTime.utc_now
        :timer.sleep(2000)
        d01 = NaiveDateTime.utc_now
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        :timer.sleep(2000)
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        :timer.sleep(2000)
        d3 = NaiveDateTime.utc_now
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Mosy.Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        
        IO.puts("******************* MCGOL prep ok")
        conn = build_conn()
        conn = post conn, monitoring_path(conn, :oslevel), %{
            "start" => d1,
            "end"   => d3,
            "host"  => "host1"
        }
        %{"data" => ret}  = json_response(conn, 200) 
        IO.puts("******************* MCGOL json resp: #{inspect(ret)}")
        assert 2 == length(ret)

    end
    
    test "monitoring controller get process level" do
        d1 = NaiveDateTime.utc_now
        :timer.sleep(2000)
        d01 = NaiveDateTime.utc_now
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        :timer.sleep(2000)
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        :timer.sleep(2000)
        d3 = NaiveDateTime.utc_now
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Mosy.Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        conn = build_conn()
        conn = post conn, monitoring_path(conn, :proclevel), %{
            "start" => d1,
            "end"   => d3,
            "host"  => "host1",
            "process" => "oslevel1"
        }
        %{"data" => ret}  = json_response(conn, 200) 
        IO.puts("======================> MCGPL json resp: #{inspect(ret)}")
        assert 2 == length(ret)
    end

end
