defmodule CheckAppVersions.Mixfile do
  use Mix.Project

  def project do
    [app: :check_app_versions,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: escript,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

   def escript do
     [main_module: CheckAppVersions]
   end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [{:httpoison, "~> 0.12"}]
  end
end
