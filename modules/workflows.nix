let
  checkout = [
    {
      name = "Install Node";
      run = "nix profile add nixpkgs#nodejs_latest";
    }
    { uses = "https://data.forgejo.org/actions/checkout@v6"; }
  ];
  cache = [
    {
      name = "Install Needed Packages";
      run = "nix profile add github:juspay/omnix github:juspay/cachix-push nixpkgs#cachix";
    }
    {
      name = "Setup Cachix";
      run = ''
        CACHES=(
          'henriquekh'
          'nix-community'
          'hyprland'
          'niri'
        )
        for cache in ''${CACHES[@]}; do
          cachix use $cache
        done
      '';
    }
    {
      name = "Build output";
      run = "om ci run --results=/om.json";
    }
    {
      name = "Push to cache";
      run = ''cachix-push-om-outputs -c henriquekh --subflake ROOT --prefix "''$(git rev-parse --short HEAD)" < /om.json'';
    }
  ];
in
{
  perSystem =
    { pkgs, ... }:
    let
      toAction =
        name: action:
        pkgs.runCommand name
          {
            buildInputs = with pkgs; [
              action-validator
              yj
            ];
            action = builtins.toJSON action;
            passAsFile = [ "action" ];
          }
          ''
            yj -jy < "$actionPath" > $out
            action-validator -v $out
          '';
    in
    {
      files.files = [
        {
          path_ = ".forgejo/workflows/check.yml";
          drv = toAction "fj-actions-workflow-check.yaml" {
            on = {
              push.branches = [ "main" ];
              workflow_dispatch = { };
            };
            env.CACHIX_AUTH_TOKEN = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            jobs.check = {
              runs-on = "nixos-unstable";
              steps =
                checkout
                ++ [
                  { run = "nix -Lv flake check --all-systems"; }
                ]
                ++ cache;
            };
          };
        }
        {
          path_ = ".forgejo/workflows/update.yml";
          drv = toAction "fj-actions-workflow-update.yaml" {
            on = {
              schedule = [ { cron = "15 4 * * *"; } ];
              workflow_dispatch = { };
            };
            env.CACHIX_AUTH_TOKEN = "\${{ secrets.CACHIX_AUTH_TOKEN }}";
            jobs.update = {
              runs-on = "nixos-unstable";
              steps =
                checkout
                ++ [
                  { run = "nix flake update"; }
                  { run = "git add flake.lock"; }
                  { run = "nix -Lv flake check --all-systems"; }
                ]
                ++ cache
                ++ [
                  {
                    name = "Push new flake.lock";
                    run = ''
                      git config --global user.name "flake-update[bot]"
                      git config --global user.email "<>"
                      git commit -m "Update Flake Inputs: $(date +%F)"
                      git push
                    '';
                  }
                ];
            };
          };
        }
      ];
    };
}
