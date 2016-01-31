defmodule GameEngine.Features.Config do
	use WhiteBread.SuiteConfiguration

	suite name: "Computers play game",
        context: GameEngine.Features.ComputersPlayGameContext,
        feature_paths: ["features/computer_vs_computer/"]

    suite name: "Human versus computer game",
        context: GameEngine.Features.HumanVersusComputerGameContext,
        feature_paths: ["features/human_vs_computer/"]
end
