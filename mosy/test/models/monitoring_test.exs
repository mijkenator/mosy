defmodule Mosy.MonitoringTest do
    use Mosy.DataCase
    alias Mosy.Monitoring
    
    @invalid_attrs %{}
    @valid_attrs %{host: "host1", cpu: 1, memory: 10, ioread: 1, iowrite: 2, process: "beam"}

    test "changeset with valid attrs" do
        changeset = Monitoring.changeset(%Monitoring{}, @valid_attrs)
        assert changeset.valid?
    end

    test "changeset with invalid attributes" do
        changeset = Monitoring.changeset(%Monitoring{}, @invalid_attrs)
        refute changeset.valid?
    end

    test "get_latest" do
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "proc1"})

        all_recs = Repo.all(Monitoring)
        #IO.puts("all recs: #{inspect(all_recs)}")
        assert 9 == length(all_recs)
        latest = Monitoring.get_latest()
        IO.puts("latest recs: #{inspect(latest)}")
        assert 3 == length(latest)
    end

    test "os_level" do
        d1 = NaiveDateTime.utc_now
        :timer.sleep(2000)
        d01 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        :timer.sleep(2000)
        _d2 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        :timer.sleep(2000)
        d3 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host2", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        Repo.insert(%Monitoring{host: "host3", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel"})
        d4 = NaiveDateTime.utc_now

        data1 = Monitoring.get_os_level(%{"start" => d1, "end" => d3, "host" => "host1"})
        IO.puts("data1: #{inspect(data1)}")
        assert 2 == length(data1)
        data2 = Monitoring.get_os_level(%{"start" => d3, "end" => d4, "host" => "host1"})
        assert 1 == length(data2)
        d5 = NaiveDateTime.utc_now
        data3 = Monitoring.get_os_level(%{"start" => d4, "end" => d5, "host" => "host1"})
        assert 0 == length(data3)
        data4 = Monitoring.get_os_level(%{"start" => d1, "end" => d01, "host" => "host1"})
        assert 0 == length(data4)

    end


    test "proc_level" do

        d1 = NaiveDateTime.utc_now
        :timer.sleep(2000)
        d01 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        :timer.sleep(2000)
        _d2 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        :timer.sleep(2000)
        d3 = NaiveDateTime.utc_now
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel1"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel2"})
        Repo.insert(%Monitoring{host: "host1", cpu: 1.0, memory: 10.0, ioread: 1, iowrite: 2, process: "oslevel3"})
        d4 = NaiveDateTime.utc_now

        data1 = Monitoring.get_proc_level(%{"start" => d1, "end" => d3, "host" => "host1", "process" => "oslevel1"})
        IO.puts("data1: #{inspect(data1)}")
        assert 2 == length(data1)
        data2 = Monitoring.get_proc_level(%{"start" => d3, "end" => d4, "host" => "host1", "process" => "oslevel1"})
        assert 1 == length(data2)
        d5 = NaiveDateTime.utc_now
        data3 = Monitoring.get_proc_level(%{"start" => d4, "end" => d5, "host" => "host1", "process" => "oslevel1"})
        assert 0 == length(data3)
        data4 = Monitoring.get_proc_level(%{"start" => d1, "end" => d01, "host" => "host1", "process" => "oslevel1"})
        assert 0 == length(data4)

    end

end
