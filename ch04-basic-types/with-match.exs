result =
  with {:ok, file} = File.open("/private/etc/passwd"),
    content = IO.read(file, :eof),
    :ok = File.close(file),
    [_, uid, gid] <- Regex.run(~r/^_lp:.*?:(\d+):(\d+)/, content)
  do
    "Group: #{gid}, User: #{uid}"
  end

IO.puts inspect(result)
