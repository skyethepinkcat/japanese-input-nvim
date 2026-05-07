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
      package = self'.packages.default;
      settingsOptions = lib.optionalAttr isDarwin {
        command = lib.nixvim.defaultNullOpts.mkString defaultCommand "Command to use for input switching.";
      };
      settingsExample = {
        key = "<leader>j";
        command = lib.Expression "pkgs.macism";
        japanese_ime = "com.apple.inputmethod.Kotoeri.KanaTyping.Japanese";
        english_ime = "com.apple.keylayout.ABC";
      };
    }
  );
in
{
  flake.nixvimModules.japanese-input-nvim = module;
  flake.nixvimModules.default = module;

}
