{ moduleWithSystem, ... }:
{
  flake.nixvimModules.japanese-input-nvim = moduleWithSystem (
    { self', ... }:
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      isDarwin = pkgs.stdenv.hostPlatform.system == "aarch64-darwin";
    in
    lib.nixvim.plugins.mkNeovimPlugin {
      name = "japanese-input";
      package = self'.packages.default;
      settingsOptions = lib.optionalAttr {
        command = lib.nixvim.defaultNullOpts.mkString "${lib.getExe pkgs.macism}" "Command to use for input switching.";
      };
      settingsExample = {
        key = "<leader>j";
        command = lib.Expression "pkgs.macism";
        japanese_ime = "com.apple.inputmethod.Kotoeri.KanaTyping.Japanese";
        english_ime = "com.apple.keylayout.ABC";
      };
    }
  );

}
