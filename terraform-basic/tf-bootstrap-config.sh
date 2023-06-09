#! /bin/bash
#set -e

install_tf_supp_tools() {
  echo "=========== Supporting utility installation function =========="
  sudo apt-get update -y >/dev/null 2>&1
  sudo apt-get install -y gnupg software-properties-common >/dev/null 2>&1

  # =========== install gpg

  wget -O- https://apt.releases.hashicorp.com/gpg | \
  gpg --dearmor | \
  sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null 2>&1

  sudo gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint >/dev/null 2>&1

  # === Add hashicorp repo
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

  sudo apt update -y >/dev/null 2>&1

  echo "=== Installed supporting tools === "
}

install-terraform()
{
  sudo apt-get install terraform=1.4.6-1 >/dev/null 2>&1
}

install_aws_cli_tools()
{
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  echo "=== installed aws cli tools ==== "
}

main() {
  # == install supporting tools like docker
  install_tf_supp_tools
  install_aws_cli_tools
  install-terraform
  terraform -v
  echo "=== done with terraform installation ==="
}

main "$@"