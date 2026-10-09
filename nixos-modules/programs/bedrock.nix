{ inputs, ... }: {
  environment.systemPackages = [
    inputs.bedrock-on-linux.packages.x86_64-linux.default
  ];
}
