{ moduleWithSystem, ... }:
let
  module = moduleWithSystem (
    { self', ... }:
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      isDarwin = pkgs.stdenv.hostPlatform.system == "aarch64-darwin";
      defaultCommand = if isDarwin then lib.getExe pkgs.macism else "";
    in
    lib.nixvim.plugins.mkNeovimPlugin {
      name = "japanese-input";
      package = lib.mkOption {
        type = lib.types.package;
        inherit (self'.packages) default;
        description = "Package to use for japanese-input-nvim.";
      };
      settingsOptions = {
        command = lib.nixvim.defaultNullOpts.mkStr defaultCommand "Command to use for input switching.";
      };
      settingsExample = {
        key = "<leader>j";
        command = lib.literalExpression "pkgs.macism";
        japanese_ime = "com.apple.inputmethod.Kotoeri.KanaTyping.Japanese";
        english_ime = "com.apple.keylayout.ABC";
      };
      description = "Enable simpler Japanese input, primarily for MacOS and English speakers.";
      maintainers = [ lib.maintainers.skyethepinkcat ];
      extraPackages =
        with pkgs;
        lib.optionals isDarwin [
          macism
        ];
    }
  );
in
{
  flake.nixvimModules.japanese-input-nvim = module;
  flake.nixvimModules.default = module;

}
