defmodule CheckAppVersions do
  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    IO.puts "No arguments given"
  end

  def process(options) do
    IO.puts "Github #{options[:github]}"
    IO.puts "Live   #{options[:live]}"
    IO.puts "Test   #{options[:test]}"
    IO.puts "About to process ..."

    Dotenv.load
    { :ok, github_token } = System.get_env() |> Map.fetch("GITHUB_TOKEN")

    live_revision = revision_from_app(options[:live])
    IO.puts "Live revision = #{live_revision}"

    test_revision = revision_from_app(options[:test])
    IO.puts "Test revision = #{test_revision}"

    master_revision = "blurdy" # TODO: actually query github API

    alert_on_mismatch(:live, live_revision, master_revision)
    alert_on_mismatch(:test, test_revision, master_revision)
  end

  defp alert_on_mismatch(environment, app_revision, master_revision) do
    if app_revision != master_revision do
      IO.puts "#{environment} version does not match master"
    end
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [github: :string,
                   live: :string,
                   test: :string]
    )
    options
  end

  defp revision_from_app(app_host) do
    full_url = "#{app_host}/internal/version"
    resp = HTTPoison.get! full_url
    {:ok, revision} = resp.body |> Poison.decode! |> Map.fetch("revision")
    revision
  end

end
