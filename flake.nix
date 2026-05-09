{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./modules/nixvim-module.nix
        # ./module.nix
        # inputs.foo.flakeModule
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          lib,
          ...
        }:
        {
          # Allows definition of system-specific attributes
          # without needing to declare the system explicitly!
          #
          # Quick rundown of the provided arguments:
          # - config is a reference to the full configuration, lazily evaluated
          # - self' is the outputs as provided here, without system. (self'.packages.default)
          # - inputs' is the input without needing to specify system (inputs'.foo.packages.bar)
          # - pkgs is an instance of nixpkgs for your specific system
          # - system is the system this configuration is for

          # This is equivalent to packages.<system>.default
          packages.default = pkgs.vimUtils.buildVimPlugin {
            name = "japanese-input-nvim";
            src = ./.;
            meta = {
              url = "https://github.com/skyethepinkcat/japanese-input-nvim";
              maintainers = [ lib.maintainers.skyethepinkcat ];
            };
          };

          devShells = {
            default = pkgs.mkShell {
              packages = with pkgs; [
                nixfmt
                nixd
                stylua
                lua-language-server
              ];

            };
          };
        };

      flake = {
        # The usual flake attributes can be defined here, including
        # system-agnostic and/or arbitrary outputs.
      };

      # Declared systems that your flake supports. These will be enumerated in perSystem
      systems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux"];
    };
}
