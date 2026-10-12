{
  den.aspects.apps.development.languages.ansible = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        python3
        ansible
        ansible-lint
        ansible-language-server
      ];
    };
    zed-extensions = _: [ "ansible" ];
    zed-settings = _: [
      {
        file_types.Ansible = [
          "**.ansible.yml"
          "**.ansible.yaml"
          "**/defaults/*.yml"
          "**/defaults/*.yaml"
          "**/meta/*.yml"
          "**/meta/*.yaml"
          "**/tasks/*.yml"
          "**/tasks/*.yaml"
          "**/handlers/*.yml"
          "**/handlers/*.yaml"
          "**/group_vars/*.yml"
          "**/group_vars/*.yaml"
          "**/playbooks/*.yaml"
          "**/playbooks/*.yml"
          "**playbook*.yaml"
          "**playbook*.yml"
        ];
        lsp = {
          yaml-language-server.settings.yaml.schemas = {
            "https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json" =
              [
                "./inventory/*.yaml"
                "hosts.yml"
              ];
          };
          ansible.settings.validation = {
            enabled = true;
            lint.enabled = true;
          };
        };
        languages.Ansible.semantic_tokens = "combined";
      }
    ];
  };
}
